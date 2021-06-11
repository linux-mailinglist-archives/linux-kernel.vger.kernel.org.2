Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BA53A48C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFKSkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhFKSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:40:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:37:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l2so7064361wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rnZWAf3zftgs+AZXG9XT6FgnZNCWCgTE8L/kQWMxZ0c=;
        b=g9/sqmAqrN1CuUG2Agh9EYLX0AETdCPpJYN2lNRAKBslW4d7Apa2CmE4AXGGYJDZnL
         3R3aN8m2Sf1cWlxdugw2nvxEy/y+SQy2hgWIk/WPF8WDDT8llPho7Z1wW8a5XHPbnRlB
         PFLsDMWh+e1h6mvqNxcRC8zI1+tvzYRNonQ6nMovdpyD7kdSGHs1gKK/fBh+5G606bXq
         cHPDo3ktvA99c1AvvJsOgxNQl1LBgo1oB+sBuGUJQ+t8IdOe1E0hML0aka90ZfGMbKqu
         r81quKAxvklMCBYbWiMqBrFeDdYKXjV5HP/U+DNagqY1nbkYbfwxTgeTv5uNR5F0gKOV
         hpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rnZWAf3zftgs+AZXG9XT6FgnZNCWCgTE8L/kQWMxZ0c=;
        b=eNBKqqXNq+47e0pDtWTYkR2/ovev298NSel+5TiCSrmFsJQJtbjng0yRfZB2PFQYIA
         UlP61raDBnTqPS21sSX0QNhcggcuci3qYhLasWSS3CJuOS9GWVDUkFILdNCwxitdxK+y
         fixeZ2PDe29Mdu1ziziLoNkLNJslGAjuqZwt1+yTQKm1td12hjOnyq1krbTzNhbi+Fq8
         W2uVmWbpuz8iKNV4GxXk3pOFKv8shcMSKDX631bB4H2kYn4Av0CyvT6bHtA9dx2xRquX
         5MXw91gTk1OUNzT0WCSD5l0wuTFHfpc9+UiGErfrU9XljM60i4Wj8hbcH454w57kSmRm
         vDuw==
X-Gm-Message-State: AOAM530nNcR9Wjdx4efI4VmXibKRohwW8KlKhi5fyqIdssWgdy0+6PEk
        RMlMCu/Vcrkifx0kKGv2p/w=
X-Google-Smtp-Source: ABdhPJxEPGh/yCCgwOHJLz0WRwTBYfYJXJlPjKtgF3b7DpXNUwsJczEdvfGcZ2Iid7HCVtZA9QlcPw==
X-Received: by 2002:adf:f842:: with SMTP id d2mr5548335wrq.52.1623436674535;
        Fri, 11 Jun 2021 11:37:54 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id h9sm13686374wmm.33.2021.06.11.11.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 11:37:54 -0700 (PDT)
Subject: Re: [PATCH v3 23/23] x86/vdso/selftest: Add a test for unmapping vDSO
To:     Shuah Khan <skhan@linuxfoundation.org>,
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
        Shuah Khan <shuah@kernel.org>
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-24-dima@arista.com>
 <b2bc14c1-ecbd-e626-208a-885b6dde4e1a@linuxfoundation.org>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <696c19f6-8606-0981-dc74-a8541ebddcc0@gmail.com>
Date:   Fri, 11 Jun 2021 19:37:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b2bc14c1-ecbd-e626-208a-885b6dde4e1a@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 7:21 PM, Shuah Khan wrote:
> On 6/11/21 12:02 PM, Dmitry Safonov wrote:
>> Output for landing on x86:
>>> [root@localhost ~]# ./test_munmap_vdso_64
>>>     AT_SYSINFO_EHDR is 0x7fffead9f000
>>> [NOTE]    unmapping vDSO: [0x7fffead9f000, 0x7fffeada0000]
>>> [NOTE]    vDSO partial move failed, will try with bigger size
>>> [NOTE]    unmapping vDSO: [0x7fffead9f000, 0x7fffeada1000]
>>> [OK]
>>> [root@localhost ~]# ./test_munmap_vdso_32
>>>     AT_SYSINFO_EHDR is 0xf7eef000
>>> [NOTE]    unmapping vDSO: [0xf7eef000, 0xf7ef0000]
>>> [NOTE]    vDSO partial move failed, will try with bigger size
>>> [NOTE]    unmapping vDSO: [0xf7eef000, 0xf7ef1000]
>>> [OK]
>>
>> The test also can check force_sigsegv(SIGSEGV) in do_fast_syscall_32():
>>> [root@localhost ~]# ./test_munmap_vdso_32 sysenter
>>> [NOTE]    Using sysenter after munmap
>>>     AT_SYSINFO_EHDR is 0xf7efe000
>>> [NOTE]    unmapping vDSO: [0xf7efe000, 0xf7eff000]
>>> [NOTE]    vDSO partial move failed, will try with bigger size
>>> [NOTE]    unmapping vDSO: [0xf7efe000, 0xf7f00000]
>>> [OK]    32-bit process gets segfault on fast syscall with unmapped vDSO
>>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>   tools/testing/selftests/x86/.gitignore        |   1 +
>>   tools/testing/selftests/x86/Makefile          |  11 +-
>>   .../testing/selftests/x86/test_munmap_vdso.c  | 151 ++++++++++++++++++
>>   3 files changed, 158 insertions(+), 5 deletions(-)
>>   create mode 100644 tools/testing/selftests/x86/test_munmap_vdso.c
>>
> 
> I can take this through kselftest tree for 5.14 - are there any
> dependencies on x86 tree, I should be aware of?

The test should work without other patches from the set.
So I guess, it's good to go by it's own.

The only note I can make here is that without previous patches this part
of the commit message is not exactly precise:
> The test also can check force_sigsegv(SIGSEGV) in
> do_fast_syscall_32()

I will still crash, but not by the kernel enforcement, rather with
landing on the area where vdso was previously mapped.

Thanks,
            Dmitry
