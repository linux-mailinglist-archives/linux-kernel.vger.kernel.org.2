Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217633EAB66
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhHLT6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhHLT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:58:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3CBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:58:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z20so15617878lfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vlJqqfcdLLwPZcg4ot94LAiGieMmOlu7Safv+RWN6eI=;
        b=lQLxO4XpOpmbiymUYoDPFDFIF6eqobdQfw3CiUZm5mOYdSGXVM21Ro2QlrJDLiCNvy
         NPexXA0/Cq0DUHSHQN2yozrrvaxaP/jeaCtxHhXAeKIr/epahe+xMeo28PEon7VTA2vs
         Uek7JhFpyG73IDYoCC1pzvXm/YEHS3i0y21ZGI8rCY4UNdZme78lokh0QKQ7z1VgT2Xe
         lKcz0nRiUFhsog+TvuOM+k7cvFWGvbpM+WDsyFbCn6+RWOpRl+eXPQhvu7boDIVBnLWL
         BJRNQQTzoMjcbrfMkF3XNJHcK9VxE0b+P2e2+dtwTqsY1aP2LouFfD8WxXhFGschM9oX
         ZW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vlJqqfcdLLwPZcg4ot94LAiGieMmOlu7Safv+RWN6eI=;
        b=ehXneUWYKzTy+X/YzRH6vGKio2UuDy/WTc0fDoMgL6Gxc8LmPlhCqUSQJ7zUvI3HSW
         M5+XijJOMwfzMG+kK04x/7igEAoIwSkCCEIQ9Wa68Ju3XjqtOfD0cX0hv1sVgosrV2b/
         AHB6AqJWFvWDutGqnSpr8sHiWQOitzAaYjDjJCZjp91lILkm+x6eQ0EFlf98o0tg84fH
         fEmGSXWxKNfG1YH7oamZuSGB50DboIJopNYGDb388Rb63Z3pD9wchojMQEPtH78p6C17
         k10+uJ/5+rIunLP1tuyYatbpw6IMrW4b231WgKc4iAg/7pKphGZZfWsBkgq55EUSsTya
         xZsg==
X-Gm-Message-State: AOAM532QVEoVeYzDxfW9UzQtUmTn3zhgC0ZD9HNlf29etmRuth1JlQhu
        QUOZmPdHVSKe0gTyshi5BrU8LwogJagC8w==
X-Google-Smtp-Source: ABdhPJwV7gGm/JgIR69OGefUtKx/Ryuv7Lr5cuPcNKPTReYIFu9DezX09tKUTZM4xsUc/kK9Gx7CXw==
X-Received: by 2002:a19:4f45:: with SMTP id a5mr3619655lfk.190.1628798288228;
        Thu, 12 Aug 2021 12:58:08 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id e17sm417997lji.38.2021.08.12.12.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 12:58:07 -0700 (PDT)
Subject: Re: [PATCH 4/5] arm64: Warn on booting at EL2 with HVC disabled
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
References: <20210812190213.2601506-1-maz@kernel.org>
 <20210812190213.2601506-5-maz@kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <c13ee5ca-84e2-6615-375f-9e7e7f6b490f@gmail.com>
Date:   Thu, 12 Aug 2021 21:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210812190213.2601506-5-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.2021 21:02, Marc Zyngier wrote:
> Now that we are able to paper over the gigantic stupidity that
> booting at EL2 with SCR_EL3.HCE==0 is, let's taint WARN_TAINT()
> when detecting this situation.
> 
> Yes, this is *LOUD*.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Tested-by: Rafał Miłecki <rafal@milecki.pl>

This replaces:
CPU: All CPU(s) started at EL1

with:
------------[ cut here ]------------
CPU: CPUs downgraded to EL1, HVC disabled
WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/smp.c:429 smp_cpus_done+0xac/0xe8
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc5-g86fc10657896 #41
Hardware name: Asus GT-AC5300 (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
pc : smp_cpus_done+0xac/0xe8
lr : smp_cpus_done+0xac/0xe8
sp : ffffffc01002be00
x29: ffffffc01002be00 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: ffffffc010ab4000 x22: 0000000000000000 x21: 0000000000000000
x20: ffffffc0107b7e74 x19: ffffffc010a78000 x18: 0000000000000001
x17: ffffffc010a9ee40 x16: 0000000000000000 x15: 000042496b0a18f2
x14: fffffffffffc0f87 x13: 0000000000000039 x12: ffffff80010b03b0
x11: 00000000ffffffea x10: ffffffc010a5eb50 x9 : 0000000000000001
x8 : 0000000000000001 x7 : 0000000000017fe8 x6 : c0000000ffffefff
x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 00000000ffffffff x1 : a8d68d1fd96fdc00 x0 : 0000000000000000
Call trace:
  smp_cpus_done+0xac/0xe8
  smp_init+0x68/0x78
  kernel_init_freeable+0xd0/0x214
  kernel_init+0x24/0x120
  ret_from_fork+0x10/0x18
---[ end trace a7d4af835e9d6e6b ]---


BEFORE:

smp: Bringing up secondary CPUs ...
Detected VIPT I-cache on CPU1
CPU1: Booted secondary processor 0x0000000001 [0x420f1000]
Detected VIPT I-cache on CPU2
CPU2: Booted secondary processor 0x0000000002 [0x420f1000]
Detected VIPT I-cache on CPU3
CPU3: Booted secondary processor 0x0000000003 [0x420f1000]
smp: Brought up 1 node, 4 CPUs
SMP: Total of 4 processors activated.
CPU features: detected: 32-bit EL0 Support
CPU features: detected: 32-bit EL1 Support
CPU features: detected: CRC32 instructions
CPU: All CPU(s) started at EL1


AFTER:

smp: Bringing up secondary CPUs ...
Detected VIPT I-cache on CPU1
CPU1: Booted secondary processor 0x0000000001 [0x420f1000]
Detected VIPT I-cache on CPU2
CPU2: Booted secondary processor 0x0000000002 [0x420f1000]
Detected VIPT I-cache on CPU3
CPU3: Booted secondary processor 0x0000000003 [0x420f1000]
smp: Brought up 1 node, 4 CPUs
SMP: Total of 4 processors activated.
CPU features: detected: 32-bit EL0 Support
CPU features: detected: 32-bit EL1 Support
CPU features: detected: CRC32 instructions
------------[ cut here ]------------
CPU: CPUs downgraded to EL1, HVC disabled
WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/smp.c:429 smp_cpus_done+0xac/0xe8
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc5-g86fc10657896 #41
Hardware name: Asus GT-AC5300 (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
pc : smp_cpus_done+0xac/0xe8
lr : smp_cpus_done+0xac/0xe8
sp : ffffffc01002be00
x29: ffffffc01002be00 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: ffffffc010ab4000 x22: 0000000000000000 x21: 0000000000000000
x20: ffffffc0107b7e74 x19: ffffffc010a78000 x18: 0000000000000001
x17: ffffffc010a9ee40 x16: 0000000000000000 x15: 000042496b0a18f2
x14: fffffffffffc0f87 x13: 0000000000000039 x12: ffffff80010b03b0
x11: 00000000ffffffea x10: ffffffc010a5eb50 x9 : 0000000000000001
x8 : 0000000000000001 x7 : 0000000000017fe8 x6 : c0000000ffffefff
x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 00000000ffffffff x1 : a8d68d1fd96fdc00 x0 : 0000000000000000
Call trace:
  smp_cpus_done+0xac/0xe8
  smp_init+0x68/0x78
  kernel_init_freeable+0xd0/0x214
  kernel_init+0x24/0x120
  ret_from_fork+0x10/0x18
---[ end trace a7d4af835e9d6e6b ]---
