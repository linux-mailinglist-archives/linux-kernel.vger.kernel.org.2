Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18CF3F7F50
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 02:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhHZAdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 20:33:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:52390 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhHZAdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 20:33:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="217358695"
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="217358695"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 17:32:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="527544344"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 17:32:44 -0700
Subject: Re: [kbuild-all] Re: [smfrench-smb3-kernel:pr/65 143/143]
 fs/ksmbd/smb2pdu.c:5640:6: warning: variable 'user_ns' is used uninitialized
 whenever 'if' condition is true
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
References: <202108251550.SXFHPzdJ-lkp@intel.com>
 <20210825082037.iuy5gndi4n2uyep7@wittgenstein>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <14249f7e-4ca3-c980-38ef-826c3381cb04@intel.com>
Date:   Thu, 26 Aug 2021 08:32:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825082037.iuy5gndi4n2uyep7@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/21 4:20 PM, Christian Brauner wrote:
> On Wed, Aug 25, 2021 at 03:14:01PM +0800, kernel test robot wrote:
>> tree:   git://github.com/smfrench/smb3-kernel.git pr/65
>> head:   4b499755e1024f97e75411920a404b357af6e153
>> commit: 4b499755e1024f97e75411920a404b357af6e153 [143/143] ksmbd: fix lookup on idmapped mounts
>> config: hexagon-randconfig-r041-20210824 (attached as .config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d26000e4cc2bc65e207a84fa26cb6e374d60aa12)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/smfrench/smb3-kernel/commit/4b499755e1024f97e75411920a404b357af6e153
>>          git remote add smfrench-smb3-kernel git://github.com/smfrench/smb3-kernel.git
>>          git fetch --no-tags smfrench-smb3-kernel pr/65
>>          git checkout 4b499755e1024f97e75411920a404b357af6e153
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
> Thanks for the report but this is outdated and requires a patch that
> sits in David Sterba's for-next tree. So this is safe to ignore.
> Feels like this probably should only go to the authors, kbuild-all and
> clang-built-linux lists similar to what the intel built bot does.
> Otherwise this generates a lot of unneeded noise. Just my 2 cents.
>
> Christian

Hi Christian,

Thanks for the advice, we'll send the reports to the tree's owner (Steve 
French) next time.

Best Regards,
Rong Chen
