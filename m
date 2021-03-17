Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0627433F56B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhCQQZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhCQQZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:25:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C119C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:25:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w8so1403142pjf.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8ZVDRngx7SfOHOksYEtUxmnvVwRwyIdjJ9TXCeErI0=;
        b=vKJV7Zr2kO1BbXKDI4W1yjK3GY0tGe5TJ7VcEi+BHFVjD6lAQZlcwrWzvzIriTUqsw
         RN24cMy2wS1V2+sWbgoH+Z/UcJNQhJR5EsJ07mcWyWQ0fPRFlTRJUSG8jba/D394CuX0
         V3VowweoXBfnnkW/PAAhbuuRI/U5a4wKmVo5svH3GXnijgYRDJblDfxT9ZRjEDVjXK54
         OMKxWShbm/YwQ7GK8BUVrh9yyZf9nlWRRzqlchzshHuN/zZmMvatS1Jag7dmwdxO8xCi
         FtYv8fw14opDuhzBq//Y1/CSywkOuCKAQXJcavOzGp+1cOGcdj6ldKh95SDh0o7nGQ3U
         +u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8ZVDRngx7SfOHOksYEtUxmnvVwRwyIdjJ9TXCeErI0=;
        b=rct2zn5TL93j4jdV7k+y8FWlRvrXKwYJlmDrCY64UcsX59ZJofk9ePwfWiOFnlRkDy
         EBU+/FriDh34jTSqfaTUE70fA1J1N9xeBBZ23/LhT6D8PaGM0y7MrkZbYmJvw1FfjTKv
         ypOoasebdxSrs8xMfxXHdlZgN0VM8pSAn54pwx8CX70q1nNG1wzN1A8RYCJmSOXUSthz
         9agX/yYsOrfLYq2dUt0QmUfuSq6cGnvhKnmv13AEPvKOjpVFdNKFB5W0EEQOemhWfn20
         5IuwPbHKxQB5c/2/Tmx0VvGVCp+IYNu/LMaKYEYYDzwGYo16f2taPDpKFLslPyKwJ83a
         Cz/A==
X-Gm-Message-State: AOAM530XL0I+Zri1XjvDntjX1i+rZyclBl01d4wMXWtkY56xg3nxejdM
        MY4xwvhNH5c24KjsHR1U2D9/N0rr5qNqMCEI
X-Google-Smtp-Source: ABdhPJzn+X0lUmMP3xjGdhzRR/GqWE9lHN7gXgNMa/Jja6A78fZAVsrellf1eHvVgOiS2JkYuKRG5w==
X-Received: by 2002:ad4:5ce7:: with SMTP id iv7mr5503229qvb.7.1615994363393;
        Wed, 17 Mar 2021 08:19:23 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l186sm17703862qke.92.2021.03.17.08.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 08:19:22 -0700 (PDT)
Subject: Re: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
 <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bebcaffc-d485-912d-0c42-c0781f9c7603@toxicpanda.com>
Date:   Wed, 17 Mar 2021 11:19:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 10:50 PM, Kai-Heng Feng wrote:
> Hi,
> 
> On Wed, Mar 17, 2021 at 10:17 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> This reverts commit d60cd06331a3566d3305b3c7b566e79edf4e2095.
>>
>> This patch causes a panic when rebooting my Dell Poweredge r440.  I do
>> not have the full panic log as it's lost at that stage of the reboot and
>> I do not have a serial console.  Reverting this patch makes my system
>> able to reboot again.
> 
> But this patch also helps many HP laptops, so maybe we should figure
> out what's going on on Poweredge r440.
> Does it also panic on shutdown?
> 

Sure I'll test whatever to get it fixed, but I just wasted 3 days bisecting and 
lost a weekend of performance testing on btrfs because of this regression, so 
until you figure out how it broke it needs to be reverted so people don't have 
to figure out why reboot suddenly isn't working.

Running "halt" has the same effect with and without your patch, it gets to 
"system halted" and just sits there without powering off.  Not entirely sure why 
that is, but there's no panic.

The panic itself is lost, but I see there's an NMI and I have the RIP

(gdb) list *('mwait_idle_with_hints.constprop.0'+0x4b)
0xffffffff816dabdb is in mwait_idle_with_hints 
(./arch/x86/include/asm/current.h:15).
10
11	DECLARE_PER_CPU(struct task_struct *, current_task);
12
13	static __always_inline struct task_struct *get_current(void)
14	{
15		return this_cpu_read_stable(current_task);
16	}
17
18	#define current get_current()
19

<mwait_idle_with_hints.constprop.0>:    jmp    0xffffffff936dac02 
<mwait_idle_with_hints.constprop.0+0x72>
<mwait_idle_with_hints.constprop.0+0x2>:        nopl   (%rax)
<mwait_idle_with_hints.constprop.0+0x5>:        jmp    0xffffffff936dabac 
<mwait_idle_with_hints.constprop.0+0x1c>
<mwait_idle_with_hints.constprop.0+0x7>:        nopl   (%rax)
<mwait_idle_with_hints.constprop.0+0xa>:        mfence
<mwait_idle_with_hints.constprop.0+0xd>:        mov    %gs:0x17bc0,%rax
<mwait_idle_with_hints.constprop.0+0x16>:       clflush (%rax)
<mwait_idle_with_hints.constprop.0+0x19>:       mfence
<mwait_idle_with_hints.constprop.0+0x1c>:       xor    %edx,%edx
<mwait_idle_with_hints.constprop.0+0x1e>:       mov    %rdx,%rcx
<mwait_idle_with_hints.constprop.0+0x21>:       mov    %gs:0x17bc0,%rax
<mwait_idle_with_hints.constprop.0+0x2a>:       monitor %rax,%rcx,%rdx
<mwait_idle_with_hints.constprop.0+0x2d>:       mov    (%rax),%rax
<mwait_idle_with_hints.constprop.0+0x30>:       test   $0x8,%al
<mwait_idle_with_hints.constprop.0+0x32>:       jne    0xffffffff936dabdb 
<mwait_idle_with_hints.constprop.0+0x4b>
<mwait_idle_with_hints.constprop.0+0x34>:       jmpq   0xffffffff936dabd0 
<mwait_idle_with_hints.constprop.0+0x40>
<mwait_idle_with_hints.constprop.0+0x39>:       verw   0x9f9fec(%rip)        # 
0xffffffff940d4bbc
<mwait_idle_with_hints.constprop.0+0x40>:       mov    $0x1,%ecx
<mwait_idle_with_hints.constprop.0+0x45>:       mov    %rdi,%rax
<mwait_idle_with_hints.constprop.0+0x48>:       mwait  %rax,%rcx
<mwait_idle_with_hints.constprop.0+0x4b>:       mov    %gs:0x17bc0,%rax
<mwait_idle_with_hints.constprop.0+0x54>:       lock andb $0xdf,0x2(%rax)
<mwait_idle_with_hints.constprop.0+0x59>:       lock addl $0x0,-0x4(%rsp)
<mwait_idle_with_hints.constprop.0+0x5f>:       mov    (%rax),%rax
<mwait_idle_with_hints.constprop.0+0x62>:       test   $0x8,%al
<mwait_idle_with_hints.constprop.0+0x64>:       je     0xffffffff936dac01 
<mwait_idle_with_hints.constprop.0+0x71>
<mwait_idle_with_hints.constprop.0+0x66>:       andl 
$0x7fffffff,%gs:0x6c93cf7f(%rip)        # 0x17b80
<mwait_idle_with_hints.constprop.0+0x71>:       retq
<mwait_idle_with_hints.constprop.0+0x72>:       mov    %gs:0x17bc0,%rax
<mwait_idle_with_hints.constprop.0+0x7b>:       lock orb $0x20,0x2(%rax)
<mwait_idle_with_hints.constprop.0+0x80>:       mov    (%rax),%rax
<mwait_idle_with_hints.constprop.0+0x83>:       test   $0x8,%al
<mwait_idle_with_hints.constprop.0+0x85>:       jne    0xffffffff936dabdb 
<mwait_idle_with_hints.constprop.0+0x4b>
<mwait_idle_with_hints.constprop.0+0x87>:       jmpq   0xffffffff936dab95 
<mwait_idle_with_hints.constprop.0+0x5>
<mwait_idle_with_hints.constprop.0+0x8c>:       nopl   0x0(%rax)

0x4b is after the mwait, which means we're panicing in the 
current_clr_polling(), where we do clear_thread_flag(TIF_POLLING_NRFLAG).  Thanks,

Josef
