Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D132744E0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 04:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhKLDm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 22:42:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:46459 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhKLDmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 22:42:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="220275686"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="220275686"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 19:39:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="492814669"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.168.164]) ([10.249.168.164])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 19:39:34 -0800
Subject: Re: [kbuild-all] Re: arch/nds32/kernel/vdso/gettimeofday.c:246:13:
 error: no previous prototype for '__vdso_gettimeofday'
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202111091310.etMHozC9-lkp@intel.com>
 <20211109184613.0a9aa3c9@canb.auug.org.au>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <248e58b4-f6fa-58a6-2da4-4ececc209cf3@intel.com>
Date:   Fri, 12 Nov 2021 11:39:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211109184613.0a9aa3c9@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2021 3:46 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 9 Nov 2021 13:17:19 +0800 kernel test robot <lkp@intel.com> wrote:
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   d2f38a3c6507b2520101f9a3807ed98f1bdc545a
>> commit: 20fbb11fe4ea99e02d77824613f1438bea456683 don't make the syscall checking produce errors from warnings
>> date:   9 weeks ago
> 
> Its very unlikely to be that commit (since all it does it turn some
> errors into warnings):
> 

Hi Stephen,

Thanks for the feedback, we'll ignore the commit in the CI system.

Best Regards,
Rong Chen

> commit 20fbb11fe4ea99e02d77824613f1438bea456683
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Mon Sep 6 15:47:02 2021 +1000
> 
>      don't make the syscall checking produce errors from warnings
>      
>      Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>      Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index b7609958ee36..fd9777f63f14 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -266,4 +266,4 @@ syscall_list() {
>   }
>   
>   (ignore_list && syscall_list $(dirname $0)/../arch/x86/entry/syscalls/syscall_32.tbl) | \
> -$* -E -x c - > /dev/null
> +$* -Wno-error -E -x c - > /dev/null
> 
> 
> When did this start failing?  That commit has been in Linus' tree for 9
> weeks ...
> 
> 
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
