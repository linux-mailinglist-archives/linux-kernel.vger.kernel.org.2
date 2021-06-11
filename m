Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337653A488D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhFKSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFKSX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:23:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF40FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:21:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q7so32177780iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G+hM0J8B0xO3RkZcMXx52bB5cX2VJMtel9kbl7c+k8c=;
        b=H9pCsggHB/aqY8yJGWBmlW26q4TbZMEpBqRjR/ISsbS5FEjLGWbSuTyQRqfcIj1f7J
         kCKT+mTPRYN5AvsU2l0y8ZVR0ngjU7En2AwjtvcEriwYMVz2eyuOemiAiyNA80DdbseB
         SS2blyBJnrZhalB1NhjsI4l0C1wXb2IKFuIsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G+hM0J8B0xO3RkZcMXx52bB5cX2VJMtel9kbl7c+k8c=;
        b=JCvmhGnsELzcbDcpZ9xT68XftaiqJuaOeb2RjFXz8uc/rm5C+Gk784juOskxDVGbge
         h6xrEefQLKkL/JKxvcQjtN9FWhMWWVqzLhY21pspOAasdZ6W9i4pmQwlqmWn892XCU5h
         TBde2g0uZ4t3qcR8xzxfK6MnN/Hos4l/LqsX3KaOL4SbFQkfmPhpPWnmdfnJBeN3ejqJ
         ZGvtN0VMhDV6tIpm3KXU2zjJDIE9Md56Q82Zrr0LjkTYydAdptENmgEGxEqdGTGUW8tu
         1ic9LinS/GuaD+2UW93dxlSwUwqYif9IPwqq//OZRMNtFNor5QS9ma+M1MeTdfx3xljK
         pziQ==
X-Gm-Message-State: AOAM531GDgUbnf7nE0z/qgAHI1kbQiPi7zadT+Zwr8aAVYmQO+ujeT2m
        nXMr2L2HEyNnK7Y73ESJac+3Sg==
X-Google-Smtp-Source: ABdhPJzMzN/eIn0mVViok/UFlT/6VsYCQCJoS6Zrx0TUM6q5VRaymcSCQdJaHLp9sfybWuK7sqdWdQ==
X-Received: by 2002:a6b:a10:: with SMTP id z16mr4230768ioi.70.1623435702242;
        Fri, 11 Jun 2021 11:21:42 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m7sm3625123ild.49.2021.06.11.11.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 11:21:41 -0700 (PDT)
Subject: Re: [PATCH v3 23/23] x86/vdso/selftest: Add a test for unmapping vDSO
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b2bc14c1-ecbd-e626-208a-885b6dde4e1a@linuxfoundation.org>
Date:   Fri, 11 Jun 2021 12:21:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611180242.711399-24-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 12:02 PM, Dmitry Safonov wrote:
> Output for landing on x86:
>> [root@localhost ~]# ./test_munmap_vdso_64
>> 	AT_SYSINFO_EHDR is 0x7fffead9f000
>> [NOTE]	unmapping vDSO: [0x7fffead9f000, 0x7fffeada0000]
>> [NOTE]	vDSO partial move failed, will try with bigger size
>> [NOTE]	unmapping vDSO: [0x7fffead9f000, 0x7fffeada1000]
>> [OK]
>> [root@localhost ~]# ./test_munmap_vdso_32
>> 	AT_SYSINFO_EHDR is 0xf7eef000
>> [NOTE]	unmapping vDSO: [0xf7eef000, 0xf7ef0000]
>> [NOTE]	vDSO partial move failed, will try with bigger size
>> [NOTE]	unmapping vDSO: [0xf7eef000, 0xf7ef1000]
>> [OK]
> 
> The test also can check force_sigsegv(SIGSEGV) in do_fast_syscall_32():
>> [root@localhost ~]# ./test_munmap_vdso_32 sysenter
>> [NOTE]	Using sysenter after munmap
>> 	AT_SYSINFO_EHDR is 0xf7efe000
>> [NOTE]	unmapping vDSO: [0xf7efe000, 0xf7eff000]
>> [NOTE]	vDSO partial move failed, will try with bigger size
>> [NOTE]	unmapping vDSO: [0xf7efe000, 0xf7f00000]
>> [OK]	32-bit process gets segfault on fast syscall with unmapped vDSO
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   tools/testing/selftests/x86/.gitignore        |   1 +
>   tools/testing/selftests/x86/Makefile          |  11 +-
>   .../testing/selftests/x86/test_munmap_vdso.c  | 151 ++++++++++++++++++
>   3 files changed, 158 insertions(+), 5 deletions(-)
>   create mode 100644 tools/testing/selftests/x86/test_munmap_vdso.c
> 

I can take this through kselftest tree for 5.14 - are there any
dependencies on x86 tree, I should be aware of?

thanks,
-- Shuah

