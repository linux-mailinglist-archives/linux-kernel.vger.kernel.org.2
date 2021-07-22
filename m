Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F3D3D2D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhGVTak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhGVTai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626984673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQiDBKKD741DQtVrx05XHx6TnZPGQkq3WyPqWgsemgI=;
        b=UgWJ7u7JY3eZsNvzVA2B/FtXvpJVF7FJCs8U8TODR/MO7TnCr0GuVAHyYGgRfGZEqe1F3o
        eMoArk/ZUAEGt4boFLRfx8bhoySqYvmjbZEA3KzdVDfvJYnLkzJDHSVSo/VBUvdljqmMRA
        xyVkD3ohk0eRBRpcwpQhfZrqS18Z0dI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-CK2ZxWbwPKOb0N4Ke7Q4Bg-1; Thu, 22 Jul 2021 16:11:11 -0400
X-MC-Unique: CK2ZxWbwPKOb0N4Ke7Q4Bg-1
Received: by mail-il1-f200.google.com with SMTP id o8-20020a92c6880000b0290214927ba4d8so4187212ilg.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQiDBKKD741DQtVrx05XHx6TnZPGQkq3WyPqWgsemgI=;
        b=litNtTRyuJUz7vlf06IneD+YTsXgLemFnBCiWIt8ZuQ6J35/jEX5cVwN2HEgCULoKx
         2+glY3E7b1g4kNfPvMoZBTBtnrkz//QHs5OF0dMP55t+HjJu2/felDfcwU0vsmJOU2tX
         Pbzp4PeIXm0Z3Jy/mYjfxfhrWZ6rUZNzALU7cVWBajdfMzpAHwae/wqKPq8k3uAi+npg
         D15575A0DFYJb6CY8YuegmjU86TK284mAx/8R0CKq/vXDcsphXg6L8Xd0N/ALo5wZPe7
         3Xkobg0iyf+aeBEhO23lzEgEsT7tc2gQR7DFZRjVOwGsGs/BtrITCy4MJxhU2lztw5hi
         ZAFA==
X-Gm-Message-State: AOAM531s+4cIAyPCdMdNwzqsTQ+gCZJUiTO8dFdRTexoScLT1yUSkiLF
        8z+kXTpcXuaa0VbvPg8wlKhgs+exVZ7gEKG72vkcRTNTcMKgQg0G+XMhn0D1IjNnj5cCFWI8BaJ
        KUfpJnLnzm928oOj5Fl3S0ynQ
X-Received: by 2002:a5d:89d6:: with SMTP id a22mr1111580iot.178.1626984671238;
        Thu, 22 Jul 2021 13:11:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJFAwPs+9TaQkgJnqjWfck0s69NuWgcN/6K4dwXO71x1EdNm8aK86jdgf3quWKyPITk0/jbg==
X-Received: by 2002:a5d:89d6:: with SMTP id a22mr1111572iot.178.1626984671066;
        Thu, 22 Jul 2021 13:11:11 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id r1sm14629137ilt.37.2021.07.22.13.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 13:11:10 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:11:05 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/3] sched, x86, arm64: PREEMPT_RT, FPU and preemption
Message-ID: <20210722201105.kcja2ndxv7rtsrbi@halaneylaptop>
References: <20210722175157.1367122-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722175157.1367122-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 06:51:54PM +0100, Valentin Schneider wrote:
> Hi folks,
> 
> This stems from some more v5.13-rt1 breakage on arm64. This time per-CPU access
> safety isn't sufficient, we really need to keep preemption disabled.
> 
> In a happy accident I stumbled on
> 
>   cba08c5dc6dc ("x86/fpu: Make kernel FPU protection RT friendly")
> 
> so I packaged what was done there into some common helpers and plastered them
> over the problematic areas.
> 
> Cheers,
> Valentin
> 
> Valentin Schneider (3):
>   sched/preempt: Introduce preempt_{enable, disable}_bh()
>   x86/fpu: Make FPU protection reuse common helper
>   arm64/fpsimd: Fix FPSIMD context handling vs PREEMPT_RT
> 
>  arch/arm64/kernel/fpsimd.c     |  6 ++++--
>  arch/x86/include/asm/fpu/api.h | 19 ++-----------------
>  include/linux/bottom_half.h    | 26 ++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 19 deletions(-)
> 
> --
> 2.25.1
> 

I'm an outsider on all of this, but this series makes sense and looks
good to me.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

