Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88627356C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbhDGMb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235368AbhDGMb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:31:26 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E378611EE;
        Wed,  7 Apr 2021 12:31:17 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lU7L1-0064O4-3w; Wed, 07 Apr 2021 13:31:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>, devicetree@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 00/10] Initial support for Nuvoton WPCM450 BMC SoC
Date:   Wed,  7 Apr 2021 13:31:12 +0100
Message-Id: <161779861852.1095473.15662659062108361949.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
References: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tmaimon77@gmail.com, devicetree@vger.kernel.org, joel@jms.id.au
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 14:09:11 +0200, Jonathan Neuschäfer wrote:
> This series adds basic support for the Nuvoton WPCM450 BMC SoC. It's an older
> SoC but still commonly found on eBay, mostly in Supermicro X9 server boards.
> 
> Third-party documentation is available at: https://github.com/neuschaefer/wpcm450/wiki
> 
> Patches 1-4 add devicetree bindings for the WPCM450 SoC and its various parts.
> Patches 5-7 add arch and driver support. Patches 8 and 9 add a devicetree for
> the SoC and a board based on it. Patch 10 finally updates the MAINTAINERS file.
> 
> [...]

Applied to irq/irqchip-next, thanks!

[03/10] dt-bindings: interrupt-controller: Add nuvoton, wpcm450-aic
        commit: 7c18715546203a09f859dac2fe3ea8aceec5f235
[06/10] irqchip: Add driver for WPCM450 interrupt controller
        commit: fead4dd496631707549f414b4059afb86ea8fb80

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


