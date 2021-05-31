Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DBC395A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhEaMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEaMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:32:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8AAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:31:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lz27so16397845ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=apQhzHHb6cq/tQrXfrCjOavNRGA9VVg8O2tLgHtTuSE=;
        b=ukzuY/b+sboJSrIlN0awX1wsip8aLXHwJarOHQv4+hfV1RT/bTl5RTjdJT4ypSy2C/
         VEFuzOm+Ltp+gRyKmnxuyZPVF9bDtQT7lL5LpkSNd5m1QVdgEGNRgK4UoIhsazG9C4ob
         a368o/ON9tCVUrS/l78MqESV4lyIqSK4YMgKQ2njsFBr9IYIsa5GY6XZe0KBh1Sg1wYT
         GUJO5txR1SIcsGyu//gGXt6XkUEvwTaQU/M36qwG+CqcLNk68XN4/MGLpPeNeufOwe9k
         3UtnhhDTuJydddyQ+eSZlJ2M40WNRSz3uBXFu8/CzNlDgme+fP8GQLChifaOJ+VxLRcl
         jCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=apQhzHHb6cq/tQrXfrCjOavNRGA9VVg8O2tLgHtTuSE=;
        b=HTS5x+kF1lYSivwxwi7Qjm8m6bDLQIaEblJZW6xSBIimZYIcwAOuZWvb9nMeWQNzFd
         9Pmqg6b02XRVvkPcERdr1QSBlpcvrrSo8pvYWMNAMtrKYQiO72mEv8+1pgQII8t361JF
         ebScxpedj26stvvN4JMGw1/VAM5frZQdvPtQ/bGLPaEGHIfxL42p8WwY+3JfmOVrYwX5
         ri8INFq65sSAdFNrJx/D/ph9kG9TtBSSvbnJTliJ+3DjqxZOO2qqNapaywCC8uSl9LQj
         92dZ3JuBzt/67bfVfjf+PiyRy2iqn3zQpU74Es90KVp4ncbCmKjKNV+Oa+zHh5w6/HEe
         l6gg==
X-Gm-Message-State: AOAM532QAgpo2Xicp64l1lYsRjc5Eh6jkQetHioX26pZOVk1LkAkLnhK
        fZ4wVKwskfDm29aPCz0MXnNWNg==
X-Google-Smtp-Source: ABdhPJwv5PDwfpSBLpSXPLEx2DdQtY9FVGqR/eWQWkSeIzLDkDlpL4/Y3azHH8g470LXUuJZ6ZnOhw==
X-Received: by 2002:a17:907:1c13:: with SMTP id nc19mr6715333ejc.168.1622464266166;
        Mon, 31 May 2021 05:31:06 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id v7sm3792687edx.38.2021.05.31.05.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 05:31:05 -0700 (PDT)
Subject: Re: [PATCH v2 04/33] locking/atomic: microblaze: use asm-generic
 exclusively
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        will@kernel.org, boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, gerg@linux-m68k.org, green.hu@gmail.com,
        guoren@kernel.org, ink@jurassic.park.msu.ru,
        James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
        jonas@southpole.se, ley.foon.tan@intel.com, linux@armlinux.org.uk,
        mattst88@gmail.com, mpe@ellerman.id.au, nickhu@andestech.com,
        palmerdabbelt@google.com, paulus@samba.org,
        paul.walmsley@sifive.com, rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
References: <20210525140232.53872-1-mark.rutland@arm.com>
 <20210525140232.53872-5-mark.rutland@arm.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <3b12930b-3ef6-a62b-fc79-2160ad86691a@monstr.eu>
Date:   Mon, 31 May 2021 14:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525140232.53872-5-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/21 4:02 PM, Mark Rutland wrote:
> Microblaze provides its own implementation of atomic_dec_if_positive(),
> but nothing else. For a while now, the conditional inc/dec ops have been
> optional, and the core code will provide generic implementations using
> the code templates in scripts/atomic/fallbacks/.
> 
> For simplicity, and for consistency with the other conditional atomic
> ops, let's drop the microblaze implementation of
> atomic_dec_if_positive(), and use the generic implementation.
> 
> With that, we can also drop the local asm/atomic.h and asm/cmpxchg.h
> headers, as asm-generic/atomic.h is mandatory-y, and we can pull in
> asm-generic/cmpxchg.h via generic-y. This matches what nios2 and nds32
> do today.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

It is fine based on current code status. I didn't have a time to push
implementation for SMP which will require different handling.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

