Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EAB3491D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhCYMXl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Mar 2021 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhCYMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:23:18 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Mar 2021 05:23:18 PDT
Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A7EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 05:23:18 -0700 (PDT)
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id 764D71392B;
        Thu, 25 Mar 2021 13:13:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by cc-smtpin2.netcologne.de (Postfix) with ESMTP id 661811207B;
        Thu, 25 Mar 2021 13:13:12 +0100 (CET)
Received: from [78.34.170.195] (helo=cc-smtpin2.netcologne.de)
        by localhost with ESMTP (eXpurgate 4.19.0)
        (envelope-from <kurt@garloff.de>)
        id 605c7e58-36b0-7f0000012729-7f0000019960-1
        for <multiple-recipients>; Thu, 25 Mar 2021 13:13:12 +0100
Received: from nas2.garloff.de (xdsl-78-34-170-195.nc.de [78.34.170.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA;
        Thu, 25 Mar 2021 13:12:54 +0100 (CET)
Received: from [192.168.155.24] (ap4.garloff.de [192.168.155.15])
        by nas2.garloff.de (Postfix) with ESMTPSA id A0907B3B1317;
        Thu, 25 Mar 2021 13:12:52 +0100 (CET)
To:     Doug Smythies <dsmythies@telus.net>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Christian Kastner <ckk@debian.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Bingsong Si <owen.si@ucloud.cn>, erwanaliasr1@gmail.com,
        Len Brown <lenb@kernel.org>, rjw@rjwysocki.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        youling 257 <youling257@gmail.com>
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com>
 <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop>
 <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
 <20210312134114.GA21436@chenyu-desktop>
 <CAOzgRdYZM53OC-7DwnmKr3WBOAkKmqstvvs36cMVTOQUZ8qrUg@mail.gmail.com>
 <CAAYoRsX-WJFEJQVve=fmZqh37uYSX5v5EAFsy=hBRc=V4GCG9g@mail.gmail.com>
From:   Kurt Garloff <kurt@garloff.de>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
Message-ID: <54d08f41-b6ba-83e5-bd7b-b9897f2f2a2c@garloff.de>
Date:   Thu, 25 Mar 2021 13:12:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAYoRsX-WJFEJQVve=fmZqh37uYSX5v5EAFsy=hBRc=V4GCG9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Am 24.03.21 um 15:44 schrieb Doug Smythies:
> Just resending to previously missed people who should also test this.
> (See other e-mail: Re: turbostat: Fix Pkg Power on Zen)
>
> On Sat, Mar 13, 2021 at 5:49 AM youling 257 <youling257@gmail.com> wrote:
>> test this patch, turbostat can work.
>>
>> 2021-03-12 21:41 GMT+08:00, Chen Yu <yu.c.chen@intel.com>:
>>> [...]
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
>>>  tools/power/x86/turbostat/turbostat.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/power/x86/turbostat/turbostat.c
>>> b/tools/power/x86/turbostat/turbostat.c
>>> index a7c4f0772e53..a7c965734fdf 100644
>>> --- a/tools/power/x86/turbostat/turbostat.c
>>> +++ b/tools/power/x86/turbostat/turbostat.c
>>> @@ -297,7 +297,10 @@ int idx_to_offset(int idx)
>>>
>>>       switch (idx) {
>>>       case IDX_PKG_ENERGY:
>>> -             offset = MSR_PKG_ENERGY_STATUS;
>>> +             if (do_rapl & RAPL_AMD_F17H)
>>> +                     offset = MSR_PKG_ENERGY_STAT;
>>> +             else
>>> +                     offset = MSR_PKG_ENERGY_STATUS;
>>>               break;
>>>       case IDX_DRAM_ENERGY:
>>>               offset = MSR_DRAM_ENERGY_STATUS;
>>> @@ -326,6 +329,7 @@ int offset_to_idx(int offset)
>>>
>>>       switch (offset) {
>>>       case MSR_PKG_ENERGY_STATUS:
>>> +     case MSR_PKG_ENERGY_STAT:
>>>               idx = IDX_PKG_ENERGY;
>>>               break;
>>>       case MSR_DRAM_ENERGY_STATUS:
>>> @@ -353,7 +357,7 @@ int idx_valid(int idx)
>>>  {
>>>       switch (idx) {
>>>       case IDX_PKG_ENERGY:
>>> -             return do_rapl & RAPL_PKG;
>>> +             return do_rapl & (RAPL_PKG | RAPL_AMD_F17H);
>>>       case IDX_DRAM_ENERGY:
>>>               return do_rapl & RAPL_DRAM;
>>>       case IDX_PP0_ENERGY:
>>> --
>>> 2.25.1
Unsurprisingly, the patch from Bas works for me as well.
(Tested on a Zen 3 and an embedded Zen.)

Tested-by: Kurt Garloff <kurt@garloff.de>
Signed-off-by: Kurt Garloff <kurt@garloff.de>

Thanks,

-- 
Kurt Garloff <kurt@garloff.de>, Cologne, Germany


