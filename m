Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20AC3F2BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbhHTMXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237882AbhHTMXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:23:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0878460F45;
        Fri, 20 Aug 2021 12:22:25 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mH3XT-006BUP-26; Fri, 20 Aug 2021 13:22:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/apple-aic: fix irq_disable from within irq handlers
Date:   Fri, 20 Aug 2021 13:22:18 +0100
Message-Id: <162946212617.2128248.7705849006178271820.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812100942.17206-1-sven@svenpeter.dev>
References: <20210812100942.17206-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: marcan@marcan.st, sven@svenpeter.dev, will@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 12:09:42 +0200, Sven Peter wrote:
> When disable_irq_nosync for an interrupt is called from within its
> interrupt handler, this interrupt is only marked as disabled with the
> intention to mask it when it triggers again.
> The AIC hardware however automatically masks the interrupt when it is read.
> aic_irq_eoi then unmasks it again if it's not disabled *and* not masked.
> This results in a state mismatch between the hardware state and the
> state kept in irq_data: The hardware interrupt is masked but
> IRQD_IRQ_MASKED is not set. Any further calls to unmask_irq will directly
> return and the interrupt can never be enabled again.
> 
> [...]

Applied to irq/misc-5.15, thanks!

[1/1] irqchip/apple-aic: fix irq_disable from within irq handlers
      commit: 0fb038ba08dba0a5e937b79a67ed9c21ab5b59c5

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


