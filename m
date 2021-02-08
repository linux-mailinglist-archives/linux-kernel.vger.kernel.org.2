Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79894313690
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 16:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhBHPMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 10:12:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhBHPD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:03:29 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166F264E29;
        Mon,  8 Feb 2021 15:02:25 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l983S-00CoV5-QY; Mon, 08 Feb 2021 15:02:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Feb 2021 15:02:22 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Ajay Patil <pajay@qti.qualcomm.com>, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 00/23] arm64: Early CPU feature override, and
 applications to VHE, BTI and PAuth
In-Reply-To: <20210208143248.GA25934@willie-the-truck>
References: <20210208095732.3267263-1-maz@kernel.org>
 <20210208143248.GA25934@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <240a0245f75d8368a4d90a5e6740dc7d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, psodagud@codeaurora.org, sramana@codeaurora.org, catalin.marinas@arm.com, marcan@marcan.st, linux-kernel@vger.kernel.org, ardb@kernel.org, pajay@qti.qualcomm.com, kernel-team@android.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2021-02-08 14:32, Will Deacon wrote:
> Hi Marc,
> 
> On Mon, Feb 08, 2021 at 09:57:09AM +0000, Marc Zyngier wrote:
>> It recently came to light that there is a need to be able to override
>> some CPU features very early on, before the kernel is fully up and
>> running. The reasons for this range from specific feature support
>> (such as using Protected KVM on VHE HW, which is the main motivation
>> for this work) to errata workaround (a feature is broken on a CPU and
>> needs to be turned off, or rather not enabled).
>> 
>> This series tries to offer a limited framework for this kind of
>> problems, by allowing a set of options to be passed on the
>> command-line and altering the feature set that the cpufeature
>> subsystem exposes to the rest of the kernel. Note that this doesn't
>> change anything for code that directly uses the CPU ID registers.
> 
> I applied this locally, but I'm seeing consistent boot failure under 
> QEMU when
> KASAN is enabled. I tried sprinkling some __no_sanitize_address 
> annotations
> around (see below) but it didn't help. The culprit appears to be
> early_fdt_map(), but looking a bit more closely, I'm really nervous 
> about the
> way we call into C functions from __primary_switched. Remember -- this 
> code
> runs _twice_ when KASLR is active: before and after the randomization. 
> This
> also means that any memory writes the first time around can be lost due 
> to
> the D-cache invalidation when (re-)creating the kernel page-tables.

Well, we already call into C functions with KASLR, and nothing explodes
with that, so I must be doing something else wrong.

I do have cache maintenance for the writes to the shadow registers, so 
that
part should be fine. But I think I'm missing some cache maintenance 
around
the FDT base itself, and I wonder what happens when we go around the 
loop.

I'll chase this down now.

Thanks for the heads up.

         M.
-- 
Jazz is not dead. It just smells funny...
