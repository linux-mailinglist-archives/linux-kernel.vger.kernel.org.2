Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25DE336FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhCKKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:19:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232220AbhCKKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615457948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=200UXYj/wYNSp8eb71pTmk8LoOGFt2KqMD5rhkdZoUU=;
        b=VNrHgaoP5LfP0aR5tZSWvH5KQeaFkmv6BMdBWy7woaibDGtyWgRcV3rHHXmkPRpDsDs9rA
        DMW1TMvXJ7thTZm/5aDqiQ5Ii+EYPp58AXotaePi0OtcLssh5ChYJsh1oyNU96gnrHs0pm
        hGnai+McG/fTtoikFTN/DDhkmfPtcaw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-ZCuPJZZyPXuWsX1m_LGqUQ-1; Thu, 11 Mar 2021 05:19:07 -0500
X-MC-Unique: ZCuPJZZyPXuWsX1m_LGqUQ-1
Received: by mail-ej1-f72.google.com with SMTP id bg7so2470171ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=200UXYj/wYNSp8eb71pTmk8LoOGFt2KqMD5rhkdZoUU=;
        b=gLywCAR6TnOg/kzSBQ+iev/c+hHliE/JhSXdyhUIBK2GRNtGPtd7LEh9b0Fumb0F8G
         /p6DPzHubWE71CytBHnY58OtIOKwY8gmsM41BEnrrCsKLSSKo8iFul7QVBbTfeuAm8Qg
         xC6wyigaI13NNQOl+e/2UuI4T2qUFAWhZjcM51GnxTcr51Mm1bOIEQGz6zhmzfUm5ZEZ
         4q+pNnOec2gRmtyYp1r2s0jxtxIoH42E4GpYovpQCVRaqMMNKpUQKEpYRUJRwsfuY0R6
         mBVAr/YeEFTUaqsa8ebSQvNdewk3ovv+Ikw5i2YmYmvJ+ZyS0MI9w41FlTUFSzMbeuzU
         upzg==
X-Gm-Message-State: AOAM530VFroH6YeRffK2dra+j7Y+wXJfQiZEDYkN9qw+HI43h7DUDojP
        UBgV7q/s94YacQScZ+JZTvLV9wSMhYrhhbt5uQxZWqwbMdj+S3NL+GYhvasiKMcCPyCjwNlNUI0
        n8wOm3NLdbXpfUE/WBMZmUbENky+MZOX9o3j8rgwAQoFHwFxobL9cHT6X7ESTMX/xOTSh+r1BwH
        VI
X-Received: by 2002:a17:906:3496:: with SMTP id g22mr2440672ejb.143.1615457945970;
        Thu, 11 Mar 2021 02:19:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/Yn50sckavE4olPol6LC0ON2iut/3B5GnfmGXl2looI9ozGdafWZDYEIIH7woohaFQZBA1A==
X-Received: by 2002:a17:906:3496:: with SMTP id g22mr2440651ejb.143.1615457945805;
        Thu, 11 Mar 2021 02:19:05 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q10sm992748eds.67.2021.03.11.02.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 02:19:05 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] x86/apic: Avoid cm->allocated going negative in
 irq_matrix
In-Reply-To: <20210219113101.967508-1-vkuznets@redhat.com>
References: <20210219113101.967508-1-vkuznets@redhat.com>
Date:   Thu, 11 Mar 2021 11:19:04 +0100
Message-ID: <87ft129enb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> I discovered that CPU0 offlining/onlining works only once:
>
>      # echo 0 > /sys/devices/system/cpu/cpu0/online
>      # echo 1 > /sys/devices/system/cpu/cpu0/online
>      # echo 0 > /sys/devices/system/cpu/cpu0/online
>      -bash: echo: write error: No space left on device
>     
>     with the following in dmesg:
>     
>      [ ... ] CPU 0 has 4294967295 vectors, 589 available. Cannot disable CPU
>
> And the problem seems to be that irq_matrix_assign()/irq_matrix_free() calls
> for PIC_CASCADE_IR are unbalanced, making cm->allocated go negative.
>
> RFC as I didn't quite get why we're making an exception for PIC_CASCADE_IR in
> the first place. Surely it is special, but for the sake of consistency we'd
> better not treat it as such. Or maybe I just misunderstood everything.
>

If the RFC part is the only thing which scares everyone off I'm ready to
drop it and pretend that I'm confident with the change)

> Vitaly Kuznetsov (2):
>   x86/apic: Do not make an exception for PIC_CASCADE_IR when marking
>     legacy irqs in irq_matrix
>   genirq/matrix: WARN_ON_ONCE() when cm->allocated/m->total_allocated go
>     negative
>
>  arch/x86/kernel/apic/vector.c |  3 +--
>  kernel/irq/matrix.c           | 11 +++++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)

-- 
Vitaly

