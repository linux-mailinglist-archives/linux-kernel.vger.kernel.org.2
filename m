Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A1356C23
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352196AbhDGMcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352193AbhDGMcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:32:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10B860FEE;
        Wed,  7 Apr 2021 12:31:59 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lU7Lh-0064PJ-TT; Wed, 07 Apr 2021 13:31:58 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] irqchip/gic-v3: fix OF_BAD_ADDR error handling
Date:   Wed,  7 Apr 2021 13:31:54 +0100
Message-Id: <161779861852.1095473.3028175861742245454.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210323131842.2773094-1-arnd@kernel.org>
References: <20210323131842.2773094-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ndesaulniers@google.com, nathan@kernel.org, tglx@linutronix.de, arnd@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 14:18:35 +0100, Arnd Bergmann wrote:
> When building with extra warnings enabled, clang points out a
> mistake in the error handling:
> 
> drivers/irqchip/irq-gic-v3-mbi.c:306:21: error: result of comparison of constant 18446744073709551615 with expression of type 'phys_addr_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>                 if (mbi_phys_base == OF_BAD_ADDR) {
> 
> Truncate the constant to the same type as the variable it gets compared
> to, to shut make the check work and void the warning.

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/gic-v3: fix OF_BAD_ADDR error handling
      commit: 8e13d96670a4c050d4883e6743a9e9858e5cfe10

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


