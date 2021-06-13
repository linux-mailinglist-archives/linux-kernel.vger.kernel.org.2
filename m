Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BA3A5177
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 02:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFMA1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 20:27:07 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:42874 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFMA1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 20:27:05 -0400
Received: by mail-pf1-f174.google.com with SMTP id s14so7618687pfd.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=RXT+8x314xSg/qjd5fCq8QVd9NxiQV34XUsXxK9d4mI=;
        b=fy4xzbpxEif9cjWESCVpB24ftJFC11FSHjybOolw4wIhf3BjMuKWCoTH3xoMdlP3G8
         ZoRdGtYiLJcieQOI0B4So8iP+jHH5wPr2FkS9gBvqW1mdTltM1gwYQ9zBHo0awQmVvlC
         li23Fl7ZJtxOog5Xkq15hPZfmYcokiGDMUbxxDGdeNA2UTj2pj0HsJf4XMIJAzzB0H/+
         BXZXr6FXdSBhluW4LFjE0zO1wEeLuCHN1uxSuicB0FzmTxZJP4caU78PEtrX38LsqYiA
         L+25MIHVbFrSGFROEov+/6/tgqoOkJ4XUsCmN4qeWSdOW7dBB6LXm6y20OQxn/vVlcNg
         V5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RXT+8x314xSg/qjd5fCq8QVd9NxiQV34XUsXxK9d4mI=;
        b=n8nZJdQf9FCfCskUCYVloczGzZ0sfYRvP2IxZ5nbwEISZyuAgVqeA83mZyuY7GqCwo
         BwKc5HupN9hN/lelzztSuSNjPaPaNZ9cp1DsYevJ36rFlMGUCyJ5cZnceq0FWBVJ/bb2
         aPVk7pi7qUoduL0I484hHUIevi0W70F0ulybm6N2bQHmdGbbQiLd6m7wlG3Idh9lcJk/
         eU99/AS6EpM8j2bf0N1Dgo9O++Qn+P65hkxyDm2VBlTTBxBdUhBWold6diJUHvnQv8ew
         PzY2wsRrgA/739zepwTMvNb7CEImZG+fQ7UXvW1BsLylC6WVG0WFLbvY2iUfgdVwFS9X
         alkw==
X-Gm-Message-State: AOAM533Tx3QqBDKJ9MswwSBOQ5e62n8dAmbxx6xWVG2PRzhOj7z+gSm7
        eUoowEBLFn5UlCNBupa7WrShjA==
X-Google-Smtp-Source: ABdhPJz/JYl3ijdhu3ZIRn+LxZXHWdRI1iDoCU6VkYWp2irfhE5KLCD5Lu/IpLQ56OYsbmB937x6nw==
X-Received: by 2002:a63:1d61:: with SMTP id d33mr10500807pgm.331.1623543831659;
        Sat, 12 Jun 2021 17:23:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h28sm8568227pfr.10.2021.06.12.17.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 17:23:51 -0700 (PDT)
Date:   Sat, 12 Jun 2021 17:23:51 -0700 (PDT)
X-Google-Original-Date: Sat, 12 Jun 2021 17:23:35 PDT (-0700)
Subject:     Re: [PATCH v4 1/4] riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
In-Reply-To: <CANBLGcy3HrnmrweSpnDZViVstoWJYh4sCBoaX_24AsgWd=Q9XA@mail.gmail.com>
CC:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, jszhang@kernel.org,
        Christoph Hellwig <hch@infradead.org>, zong.li@sifive.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     emil.renner.berthing@gmail.com
Message-ID: <mhng-dfabeabd-e6df-4035-a9d0-c16269390120@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 16:23:03 PDT (-0700), emil.renner.berthing@gmail.com wrote:
> On Fri, 4 Jun 2021 at 13:51, Alexandre Ghiti <alex@ghiti.fr> wrote:
>>
>> Make the physical RAM base address available for all kernels, not only
>> XIP kernels as it will allow to simplify address conversions macros.
>
> Am I just reading it wrong or won't this patch make it so that the same kernel
> can't run on two chips with physical ram starting at different addresses?

IIUC we were in that position, at least without relocatable kernels.  
Maybe I'm misunderstanding this, though?

>
> /Emil
>
>> ---
>>  arch/riscv/Kconfig | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index b58596b141fc..3d8e7e4bb45c 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -493,13 +493,8 @@ config STACKPROTECTOR_PER_TASK
>>         def_bool y
>>         depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
>>
>> -config PHYS_RAM_BASE_FIXED
>> -       bool "Explicitly specified physical RAM address"
>> -       default n
>> -
>>  config PHYS_RAM_BASE
>>         hex "Platform Physical RAM address"
>> -       depends on PHYS_RAM_BASE_FIXED
>>         default "0x80000000"
>>         help
>>           This is the physical address of RAM in the system. It has to be
>> @@ -512,7 +507,6 @@ config XIP_KERNEL
>>         # This prevents XIP from being enabled by all{yes,mod}config, which
>>         # fail to build since XIP doesn't support large kernels.
>>         depends on !COMPILE_TEST
>> -       select PHYS_RAM_BASE_FIXED
>>         help
>>           Execute-In-Place allows the kernel to run from non-volatile storage
>>           directly addressable by the CPU, such as NOR flash. This saves RAM
>> --
>> 2.30.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
