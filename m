Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD83D390D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhGWK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:27:12 -0400
Received: from foss.arm.com ([217.140.110.172]:44520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhGWK1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:27:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8765C106F;
        Fri, 23 Jul 2021 04:07:44 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D96A3F694;
        Fri, 23 Jul 2021 04:07:42 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 3/3] arm64/fpsimd: Fix FPSIMD context handling vs PREEMPT_RT
In-Reply-To: <20210722183210.GF5258@sirena.org.uk>
References: <20210722175157.1367122-1-valentin.schneider@arm.com> <20210722175157.1367122-4-valentin.schneider@arm.com> <20210722183210.GF5258@sirena.org.uk>
Date:   Fri, 23 Jul 2021 12:07:35 +0100
Message-ID: <875yx1mgp4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/21 19:32, Mark Brown wrote:
> On Thu, Jul 22, 2021 at 06:51:57PM +0100, Valentin Schneider wrote:
>> Running v5.13-rt1 on my arm64 Juno board triggers:
>
> Acked-by: Mark Brown <broonie@kernel.org>
>

Thanks!

>> [   11.337654] WARNING: CPU: 4 PID: 1 at arch/arm64/kernel/fpsimd.c:296 task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 1))
>> [   11.337692] Modules linked in:
>> [   11.337705] CPU: 4 PID: 1 Comm: init Not tainted 5.13.0-rt1 #52
>> [   11.337719] Hardware name: ARM Juno development board (r0) (DT)
>> [   11.337727] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
>> [   11.337740] pc : task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 1))
>> [   11.337755] lr : task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 3))
>> [   11.337769] sp : ffff800012f4bdd0
>> [   11.337775] x29: ffff800012f4bdd0 x28: ffff000800160000 x27: 0000000000000000
>> [   11.337797] x26: 0000000000000000 x25: 0000000000000000 x24: ffff0008001606f0
>> [   11.337816] x23: ffff000800160000 x22: ffff000800160700 x21: ffff000800160000
>
> For readability it's probably better to not include the entire register
> contents here - the backtrace ends up about as large as the actual
> changelog, a good chunk of which is just the register contents.

Noted.
