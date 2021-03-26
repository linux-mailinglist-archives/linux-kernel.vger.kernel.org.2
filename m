Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628F0349FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhCZCYb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Mar 2021 22:24:31 -0400
Received: from mail-m2452.qiye.163.com ([220.194.24.52]:55568 "EHLO
        mail-m2452.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhCZCYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:24:23 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 22:24:23 EDT
Received: from [192.168.203.71] (unknown [117.48.120.186])
        by mail-m2452.qiye.163.com (Hmail) with ESMTPA id 18FA64CC8FA;
        Fri, 26 Mar 2021 10:14:35 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
From:   sibingsong <owen.si@ucloud.cn>
In-Reply-To: <CAAYoRsX-WJFEJQVve=fmZqh37uYSX5v5EAFsy=hBRc=V4GCG9g@mail.gmail.com>
Date:   Fri, 26 Mar 2021 10:14:34 +0800
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Christian Kastner <ckk@debian.org>,
        Kurt Garloff <kurt@garloff.de>, Chen Yu <yu.c.chen@intel.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        erwanaliasr1@gmail.com, Len Brown <lenb@kernel.org>,
        rjw@rjwysocki.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        youling 257 <youling257@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <57D29045-C7F6-458C-A397-CC43E4C86729@ucloud.cn>
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com>
 <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop>
 <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
 <20210312134114.GA21436@chenyu-desktop>
 <CAOzgRdYZM53OC-7DwnmKr3WBOAkKmqstvvs36cMVTOQUZ8qrUg@mail.gmail.com>
 <CAAYoRsX-WJFEJQVve=fmZqh37uYSX5v5EAFsy=hBRc=V4GCG9g@mail.gmail.com>
To:     Doug Smythies <dsmythies@telus.net>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSUI3V1ktWUFJV1kPCR
        oVCBIfWUFZSU1LGBlPShlKSBpNVkpNSk1MSU9DTE5PSUhVGRETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6KSo5Lz04KRIzAxhLMygq
        EjxPCz5VSlVKTUpNTElPQ0xOTU5JVTMWGhIXVRQMHhVVCBI7DhgXFA4fVRgVRVlXWRILWUFZSkpM
        VU9DVUpJS1VKQ01ZV1kIAVlBTUtMTDcG
X-HM-Tid: 0a786c4fd8608c11kuqt18fa64cc8fa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It works for me on Zen2.

> 2021年3月24日 下午10:44，Doug Smythies <dsmythies@telus.net> 写道：
> 
> Just resending to previously missed people who should also test this.
> (See other e-mail: Re: turbostat: Fix Pkg Power on Zen)
> 
> On Sat, Mar 13, 2021 at 5:49 AM youling 257 <youling257@gmail.com> wrote:
>> 
>> test this patch, turbostat can work.
>> 
>> 2021-03-12 21:41 GMT+08:00, Chen Yu <yu.c.chen@intel.com>:
>>> Hi Youling, Bas, and Bingsong,
>>> On Wed, Mar 10, 2021 at 04:03:31PM -0800, Doug Smythies wrote:
>>>> Hi Yu,
>>>> 
>>>> I am just resending your e-mail, adjusting the "To:" list to
>>>> include the 3 others that have submitted similar patches.
>>>> 
>>>> ... Doug
>>>> 
>>> Could you please help check if the following combined patch works?
>>> 
>>> Thanks,
>>> Chenyu
>>> 
>>> 
>>> From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00 2001
>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Date: Fri, 12 Mar 2021 21:27:40 +0800
>>> Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs
>>> 
>>> It was reported that on Zen+ system turbostat started exiting,
>>> which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
>>> offset_to_idx wasn't returning a non-negative index.
>>> 
>>> This patch combined the modification from Bingsong Si and
>>> Bas Nieuwenhuizen and addd the MSR to the index system as alternative for
>>> MSR_PKG_ENERGY_STATUS.
>>> 
>>> Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL
>>> display")
>>> Reported-by: youling257 <youling257@gmail.com>
>>> Co-developed-by: Bingsong Si <owen.si@ucloud.cn>
>>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>> ---
>>> tools/power/x86/turbostat/turbostat.c | 8 ++++++--
>>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/tools/power/x86/turbostat/turbostat.c
>>> b/tools/power/x86/turbostat/turbostat.c
>>> index a7c4f0772e53..a7c965734fdf 100644
>>> --- a/tools/power/x86/turbostat/turbostat.c
>>> +++ b/tools/power/x86/turbostat/turbostat.c
>>> @@ -297,7 +297,10 @@ int idx_to_offset(int idx)
>>> 
>>>      switch (idx) {
>>>      case IDX_PKG_ENERGY:
>>> -             offset = MSR_PKG_ENERGY_STATUS;
>>> +             if (do_rapl & RAPL_AMD_F17H)
>>> +                     offset = MSR_PKG_ENERGY_STAT;
>>> +             else
>>> +                     offset = MSR_PKG_ENERGY_STATUS;
>>>              break;
>>>      case IDX_DRAM_ENERGY:
>>>              offset = MSR_DRAM_ENERGY_STATUS;
>>> @@ -326,6 +329,7 @@ int offset_to_idx(int offset)
>>> 
>>>      switch (offset) {
>>>      case MSR_PKG_ENERGY_STATUS:
>>> +     case MSR_PKG_ENERGY_STAT:
>>>              idx = IDX_PKG_ENERGY;
>>>              break;
>>>      case MSR_DRAM_ENERGY_STATUS:
>>> @@ -353,7 +357,7 @@ int idx_valid(int idx)
>>> {
>>>      switch (idx) {
>>>      case IDX_PKG_ENERGY:
>>> -             return do_rapl & RAPL_PKG;
>>> +             return do_rapl & (RAPL_PKG | RAPL_AMD_F17H);
>>>      case IDX_DRAM_ENERGY:
>>>              return do_rapl & RAPL_DRAM;
>>>      case IDX_PP0_ENERGY:
>>> --
>>> 2.25.1
>>> 
>>> 
> 

