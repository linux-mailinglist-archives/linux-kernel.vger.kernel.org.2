Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9436E43C3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhJ0H2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:28:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:3663 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhJ0H2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:28:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="293557040"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="293557040"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 00:26:26 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="497739575"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.238.3.248]) ([10.238.3.248])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 00:26:24 -0700
Subject: Re: [kbuild-all] Re: vmlinux.o: warning: objtool:
 do_machine_check()+0x5fa: call to memset() leaves .noinstr.text section
To:     Borislav Petkov <bp@suse.de>, kernel test robot <lkp@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202110261614.Bt8EM6Nj-lkp@intel.com> <YXe7AnMmiWXk36NC@zn.tnic>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <f7962977-52a1-b18f-7485-9d2247de5703@intel.com>
Date:   Wed, 27 Oct 2021 15:26:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YXe7AnMmiWXk36NC@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2021 4:23 PM, Borislav Petkov wrote:
> Hi,
> 
> On Tue, Oct 26, 2021 at 04:16:21PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
>> commit: 7bb39313cd6239e7eb95198950a02b4ad2a08316 x86/mce: Make mce_timed_out() identify holdout CPUs
>> date:   10 months ago
>> config: x86_64-buildonly-randconfig-r006-20211022 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7bb39313cd6239e7eb95198950a02b4ad2a08316
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 7bb39313cd6239e7eb95198950a02b4ad2a08316
>>          # save the attached .config to linux build tree
>>          mkdir build_dir
>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to memset() leaves .noinstr.text section
> 
> if you have the technical capability to ignore all noinstr warnings
> coming from the mce code, please do so.
> 
> I have a patchset to address that but more important work preempts me
> constantly from cleaning it up and sending it out properly. ;-\
> 

Hi Borislav,

Thanks for the feedback, We have ignored these warnings from mce.

Best Regards,
Rong Chen
