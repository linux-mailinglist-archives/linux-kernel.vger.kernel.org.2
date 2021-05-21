Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA638BB70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhEUBSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:18:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:7826 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236106AbhEUBSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:18:09 -0400
IronPort-SDR: uld/+0IcC8+8SmsZgMI2ge9uSk9ImWiiaVZOUrJFn3gbnltIWI3uKW4tMX/XIzNeglkSm6EHOT
 F3bZd+isfSPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="286912549"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286912549"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 18:16:47 -0700
IronPort-SDR: kT0dl8QXMYpMO4bmZ5wKL3yaMljJoy3BE5IJ3y3CNyxIx+8vF1l+aoc4diSy/lxpKUSubHPnpR
 AAyFymdK6lLQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474287141"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.5.220]) ([10.238.5.220])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 18:16:45 -0700
Subject: Re: [LKP] [ext4] 05c2c00f37: aim7.jobs-per-min -11.8% regression
To:     Jan Kara <jack@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210227120804.GB22871@xsang-OptiPlex-9020>
 <a8947cee-11f5-8d59-a3ff-1c516276592e@linux.intel.com>
 <20210520095119.GA18952@quack2.suse.cz>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <e9f776c4-1ade-42a6-54c4-7fe3442e2392@linux.intel.com>
Date:   Fri, 21 May 2021 09:16:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520095119.GA18952@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 5/20/2021 5:51 PM, Jan Kara wrote:
> Hello!
> 
> On Thu 20-05-21 15:13:20, Xing Zhengjun wrote:
>>
>>       Do you have time to look at this? The regression still existed in the
>> latest Linux mainline v5.13-rc2.
> 
> Thanks for verification and for the ping! I had a look into this and I
> think the regression is caused by the changes in orphan handling. The load
> runs multiple tasks all creating and deleting files. This generally
> contends on the orphan locking with fast storage (which is your case
> because you use ramdisk as a backing store AFAICT). And the changes I did
> move superblock checksum computation under the orphan lock so the lock hold
> times are now higher.
> 
> Sadly it is not easy to move checksum update from under the orphan lock and
> maintain checksum consistency since the checksum has to be recomputed
> consistently with the changes of superblock state. But I have one idea how
> we could maybe improve the situation. Can you check whether attached patch
> recovers the regression? Because that's about how good it could get when we
> are more careful when writing out superblock.
> 
> 								Honza
> 

I apply the patch based on v5.13-rc2 and test, it can not recover the 
regression and the regression became more serious(-45.7%).

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/disk/md/fs/test/load/cpufreq_governor/ucode:
 
lkp-csl-2sp9/aim7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/4BRD_12G/RAID1/ext4/creat-clo/1000/performance/0x5003006

commit:
   4392fbc4bab57db3760f0fb61258cb7089b37665
   05c2c00f3769abb9e323fcaca70d2de0b48af7ba
   v5.13-rc2
   2a1eb1a2fc08daaaf76a5aa8ffa355b5a5013d86    (the test patch)

4392fbc4bab57db3 05c2c00f3769abb9e323fcaca70                   v5.13-rc2 
2a1eb1a2fc08daaaf76a5aa8ffa
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
          |                \
      13342           -11.8%      11771 ±  2%     -14.2%      11450 
       -45.7%       7240 ±  3%  aim7.jobs-per-min



-- 
Zhengjun Xing
