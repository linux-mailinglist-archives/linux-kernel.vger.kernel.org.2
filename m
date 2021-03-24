Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8213482FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbhCXUiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238022AbhCXUiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:38:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33602619FF;
        Wed, 24 Mar 2021 20:38:07 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, marcan@marcan.st, james.morse@arm.com,
        maz@kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 0/6] arm64: Support FIQ controller registration
Date:   Wed, 24 Mar 2021 20:38:05 +0000
Message-Id: <161661824615.1255.171177700809172747.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210315115629.57191-1-mark.rutland@arm.com>
References: <20210315115629.57191-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 11:56:23 +0000, Mark Rutland wrote:
> Hector's M1 support series [1] shows that some platforms have critical
> interrupts wired to FIQ, and to support these platforms we need to support
> handling FIQ exceptions. Other contemporary platforms don't use FIQ (since e.g.
> this is usually routed to EL3), and as we never expect to take an FIQ, we have
> the FIQ vector cause a panic.
> 
> Since the use of FIQ is a platform integration detail (which can differ across
> bare-metal and virtualized environments), we need be able to explicitly opt-in
> to handling FIQs while retaining the existing behaviour otherwise. This series
> adds a new set_handle_fiq() hook so that the FIQ controller can do so, and
> where no controller is registered the default handler will panic(). For
> consistency the set_handle_irq() code is made to do the same.
> 
> [...]

Applied to arm64 (for-next/fiq), thanks!

[1/6] genirq: Allow architectures to override set_handle_irq() fallback
      https://git.kernel.org/arm64/c/b0b8b689d78c
[2/6] arm64: don't use GENERIC_IRQ_MULTI_HANDLER
      https://git.kernel.org/arm64/c/338a743640e9
[3/6] arm64: irq: rework root IRQ handler registration
      https://git.kernel.org/arm64/c/8ff443cebffa
[4/6] arm64: entry: factor irq triage logic into macros
      https://git.kernel.org/arm64/c/9eb563cdabe1
[5/6] arm64: Always keep DAIF.[IF] in sync
      https://git.kernel.org/arm64/c/f0098155d337
[6/6] arm64: irq: allow FIQs to be handled
      https://git.kernel.org/arm64/c/3889ba70102e

-- 
Catalin

