Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0307B3A48CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFKSqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:46:06 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B36C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:43:54 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f10so17696345iok.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=89YbtnYp3CTbdx7WFuHLffVHeST+bi2GoTRYgn51r6o=;
        b=JL4XPk8kq+klwoWT72ELvYRk0BzVr+EWaQLkBJeno6z/1R67K2Z/iqWuoDduNlDHvR
         WvwgBF1Dyx5l8fJg9izwBa2twDvI00BTmUe8F7VuhQNM40htPqaMCxocDTgeHV2nE+P2
         gMVz6zyT7TpjAUc++g4eRg8Svx6Ki7dYJ2LOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=89YbtnYp3CTbdx7WFuHLffVHeST+bi2GoTRYgn51r6o=;
        b=Ni0MW3IWzxi7IHYp1HvrdACQXiNNi33pdqneBnAo0DPvYRMnee7lPT0H3zVZO6wna9
         /lKY8DcY3+12MbavmEQDZuWwdrOR8VhbTdbEu9fXLYE8ELlnc66p1vy5w+5Vou1K2G6u
         E7qyFciS8bKu9npZjyby/Is12ltCv8FcplQRMCLU2IIJDn7meI8LjH0m1xlBHXGk7bcX
         5eidqv9UlRq/xd41CuDX8qiABCnUlbkHyWhrudC6CVRtlZW/fM4hHD+e0obIVrY8/QwT
         oumBsGoIiowgJFaLiA+fkeqLqcfKj36NRkD7FTHiXwD8zKpH23SHvES22FjK4DyacfnD
         3+QQ==
X-Gm-Message-State: AOAM530bfdLB//X8TGUFO9WBaWGxvPLjTx/ksEJI1YqfWkvFJz5OyWn+
        AYmSIYm2yzNxbTNzdPjj7jnUEw==
X-Google-Smtp-Source: ABdhPJx8EBXsiMsVDhBACTD1gc8prCR5AU2n9CtRdtthBAzBrA7XqzJ8RPdfuzsDdbapGOcRNHX1tQ==
X-Received: by 2002:a5d:9e03:: with SMTP id h3mr4219993ioh.36.1623437033372;
        Fri, 11 Jun 2021 11:43:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c22sm3841996ioz.24.2021.06.11.11.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 11:43:53 -0700 (PDT)
Subject: Re: [PATCH v3 23/23] x86/vdso/selftest: Add a test for unmapping vDSO
To:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-24-dima@arista.com>
 <b2bc14c1-ecbd-e626-208a-885b6dde4e1a@linuxfoundation.org>
 <696c19f6-8606-0981-dc74-a8541ebddcc0@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dec726a9-25d5-491a-5ff1-72fe81a7f88f@linuxfoundation.org>
Date:   Fri, 11 Jun 2021 12:43:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <696c19f6-8606-0981-dc74-a8541ebddcc0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 12:37 PM, Dmitry Safonov wrote:
> On 6/11/21 7:21 PM, Shuah Khan wrote:
>> On 6/11/21 12:02 PM, Dmitry Safonov wrote:
>>> Output for landing on x86:
>>>> [root@localhost ~]# ./test_munmap_vdso_64
>>>>      AT_SYSINFO_EHDR is 0x7fffead9f000
>>>> [NOTE]    unmapping vDSO: [0x7fffead9f000, 0x7fffeada0000]
>>>> [NOTE]    vDSO partial move failed, will try with bigger size
>>>> [NOTE]    unmapping vDSO: [0x7fffead9f000, 0x7fffeada1000]
>>>> [OK]
>>>> [root@localhost ~]# ./test_munmap_vdso_32
>>>>      AT_SYSINFO_EHDR is 0xf7eef000
>>>> [NOTE]    unmapping vDSO: [0xf7eef000, 0xf7ef0000]
>>>> [NOTE]    vDSO partial move failed, will try with bigger size
>>>> [NOTE]    unmapping vDSO: [0xf7eef000, 0xf7ef1000]
>>>> [OK]
>>>
>>> The test also can check force_sigsegv(SIGSEGV) in do_fast_syscall_32():
>>>> [root@localhost ~]# ./test_munmap_vdso_32 sysenter
>>>> [NOTE]    Using sysenter after munmap
>>>>      AT_SYSINFO_EHDR is 0xf7efe000
>>>> [NOTE]    unmapping vDSO: [0xf7efe000, 0xf7eff000]
>>>> [NOTE]    vDSO partial move failed, will try with bigger size
>>>> [NOTE]    unmapping vDSO: [0xf7efe000, 0xf7f00000]
>>>> [OK]    32-bit process gets segfault on fast syscall with unmapped vDSO
>>>
>>> Cc: Shuah Khan <shuah@kernel.org>
>>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>>> ---
>>>    tools/testing/selftests/x86/.gitignore        |   1 +
>>>    tools/testing/selftests/x86/Makefile          |  11 +-
>>>    .../testing/selftests/x86/test_munmap_vdso.c  | 151 ++++++++++++++++++
>>>    3 files changed, 158 insertions(+), 5 deletions(-)
>>>    create mode 100644 tools/testing/selftests/x86/test_munmap_vdso.c
>>>
>>
>> I can take this through kselftest tree for 5.14 - are there any
>> dependencies on x86 tree, I should be aware of?
> 
> The test should work without other patches from the set.
> So I guess, it's good to go by it's own.
> 
> The only note I can make here is that without previous patches this part
> of the commit message is not exactly precise:
>> The test also can check force_sigsegv(SIGSEGV) in
>> do_fast_syscall_32()
> 
> I will still crash, but not by the kernel enforcement, rather with
> landing on the area where vdso was previously mapped.
> 

Playing it safe, here is my Ack for it to go through x86 tree

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
