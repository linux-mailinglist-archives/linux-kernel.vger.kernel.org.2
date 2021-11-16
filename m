Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A6A4534AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhKPOyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbhKPOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:53:25 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1DC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:50:27 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso20364582otr.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NxyFu/3OE/xscQqfHxJ4PMs5P4TiZ+CEJVXTXfFtHQM=;
        b=DA0su479bjgAL/qOGKPO8N0sqPDn1tMDykD/YukrWvtPAqv0sL+i7qbrldYTlrzNcc
         Ld97pN4ajabe9p/Szo0urqErBLqoGu67wOGdpsiBmwsk7hj8VyWjv0itFLnnC5ymbvk+
         KpbLjOPABgAkqYjS4tc23IMgYYkEnOWoGM4u5FntpUkB2jdWeuAt3TBj9ouz8pGmOVNC
         oWZ2QOVLjTRmnwbRqK1xbQs4QQRLsv053aduM81Fiyj4vX4o1ygfPfO/RrZGFViqo/IO
         C5K+x486rm1vcIy16bIQuy+PaEFnc3M1rC+tfsfItyAOxcRkIdPYhiWjJ9jsFIaCyY8Y
         L1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NxyFu/3OE/xscQqfHxJ4PMs5P4TiZ+CEJVXTXfFtHQM=;
        b=CYUxn8MM5KZ5CShB9wTBjZOhBNXusAZf8A7v4MErqkOqnO1ohDwZClSMl37d4y5g17
         AH6z6xSd7cu/5SfLQt+GBXnLY2pBYFoLbV1BzEbR1SwTBVADKEzSGbYEZgtZ6OyAUhZh
         1TtJQelcYZSYc3z5RdOW/h+75CJbmnP6dhBIv02LeqJjHCvjWq4lopM6dPMriQO6Rx3L
         g7rHx7DqUGQitANinJgswdH2D+fn3wvTinQrCLj01eFyRhjk4BQSd9kvdB6UDIWBYwgM
         67ryyavPgQIimb++MkU6ivl4F2uUd9QmoAusAAsTROPuTivdGeKgbFSeGm3yEEhwxmcg
         7gFw==
X-Gm-Message-State: AOAM532UW92BdYKAvY9NE383EF0HE5C/Zb2Okg77gOizpJOXEWw7mvJD
        idYeCt5y8HdvXy3uEp+BK4Ut/7kOJJI=
X-Google-Smtp-Source: ABdhPJwxjarxhDWk355ATaEqGxx5VoBiNtBLCdXS7s6dj7EcsythGDdMYkjJMINR5NwUWgzyHUbSsg==
X-Received: by 2002:a05:6830:4414:: with SMTP id q20mr6737739otv.14.1637074226307;
        Tue, 16 Nov 2021 06:50:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a13sm3899650oiy.9.2021.11.16.06.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 06:50:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
 <87a6i4miwu.fsf@mpe.ellerman.id.au>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.16-rc1
Message-ID: <f806d901-8291-96e1-a100-e187d781f2ca@roeck-us.net>
Date:   Tue, 16 Nov 2021 06:50:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87a6i4miwu.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 3:36 AM, Michael Ellerman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
>> On 11/14/21 9:21 PM, Linus Torvalds wrote:
>>> On Sun, Nov 14, 2021 at 8:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> With gcc 5.4, mips:mapta_defconfig
>>>> mips-linux-gcc.br_real: error: unrecognized command line option ‘-Wimplicit-fallthrough=5’
>>>
>>> This (and the gcc-6.x ones for sh4eb/sparc/xtensa) are already fixed
>>> in my tree. They're all "old gcc didn't support that flag" things with
>>> a trivial one-liner fix.
>>>
>>> I was hoping you didn't have older gcc versions, but you clearly do ;^p
>>>
>>
>> Top of tree is a bit better:
>>
>> Build results:
>> 	total: 153 pass: 141 fail: 12
>> Failed builds:
>> 	arm:allmodconfig
>> 	arm64:allmodconfig
>> 	csky:defconfig
>> 	csky:allmodconfig
>> 	mips:allmodconfig
>> 	parisc:allmodconfig
>> 	powerpc:allmodconfig
>> 	powerpc:ppc6xx_defconfig
>> 	riscv32:allmodconfig
>> 	riscv:allmodconfig
>> 	s390:allmodconfig
>> 	sparc64:allmodconfig
>> Qemu test results:
>> 	total: 482 pass: 476 fail: 6
>> Failed tests:
>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,ne2k_pci:initrd
>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,pcnet:ide:rootfs
>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000:sdhci:mmc:rootfs
>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000e:nvme:rootfs
>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,virtio-net:scsi[DC395]:rootfs
> 
> 
> My qemu mac99 test is passing, but I guess your tests are enabling more
> devices or something to trigger that breakage?
> 
>> powerpc:allmodconfig
>>
>> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
>> fs/ntfs/aops.c:1311:1: error: the frame size of 2240 bytes is larger than 2048 bytes
>>
>> Bisect points to commit f22969a6604 ("powerpc/64s: Default to 64K pages for
>> 64 bit book3s"), and reverting that commit does fix the problem.
>> The problem is
>> 	ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
>>
>> I don't see the problem in next-20211115, but I don't immediately see how it was fixed there.
> 
> I still see it in next.
> 
> I don't know what to do about it though. The NTFS folks presumably don't
> want to rewrite their code to avoid a warning on powerpc, we have no
> real interest in NTFS, and definitely no expertise in the NTFS code. We
> don't want to revert the 64K change, and even if we did the warning
> would still be there for other 64K page configs.
> 
> I guess we need to bump CONFIG_FRAME_WARN a bit when 64K pages is
> enabled? But even that is a bit gross because the stack size doesn't
> increase based on the page size.
> 

It does for ntfs, actually. locked_nis is allocated on the stack. With a
page size of 64k, the array has 128 entries. Since it is a pointer, that
alone makes it 1k. If you don't care about NTFS support, best I could
suggest would be to make ntfs dependent on something like
	!PPC_PAGE_SHIFT || PPC_PAGE_SHIFT < 16
ppc supports 256k page size as well, so that code is always vulnerable to
stack size overflows, and presumably you don't want to set the frame size
limit to 6k in that case.

>> powerpc:ppc6xx_defconfig
>>
>> arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c: In function 'mcu_remove':
>> arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c:189:13: error: unused variable 'ret'
>>
>> Caused by commit 5d354dc35ebb ("powerpc/83xx/mpc8349emitx: Make mcu_gpiochip_remove()
>> return void"). Still seen in -next.
> 
> I have a fix queued for that, will hit -next tomorrow.
> 
>> powerpc:qemu_ppc64_book3s_defconfig:
>>
>> arch/powerpc/mm/slice.c: In function ‘slice_get_unmapped_area’:
>> arch/powerpc/mm/slice.c:639:1: error: the frame size of 1056 bytes is larger than 1024 bytes
>>
>> Bisect again points to commit f22969a6604 ("powerpc/64s: Default to 64K pages
>> for 64 bit book3s"), and reverting that commit does fix the problem.
> 
> I'm not sure what qemu_ppc64_book3s_defconfig is, it's not an upstream
> defconfig, and I couldn't quite see how it's generated in your scripts.
> 
> But if it's a 64-bit config it should be using 2048 bytes, from
> lib/Kconfig.debug:
> 
> config FRAME_WARN
> 	int "Warn for stack frames larger than"
> 	range 0 8192
> 	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
> 	default 1536 if (!64BIT && (PARISC || XTENSA))
> 	default 1024 if (!64BIT && !PARISC)
> 	default 2048 if 64BIT
>

Ah, my fault there. It is a fixed configuration. I need to update that.
Sorry for the noise.

Guenter
