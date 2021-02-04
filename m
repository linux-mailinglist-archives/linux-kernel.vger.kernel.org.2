Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCBF30F6FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbhBDP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:58:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237671AbhBDP5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:57:13 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7F0764F4D;
        Thu,  4 Feb 2021 15:56:32 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l7gze-00C2bj-KI; Thu, 04 Feb 2021 15:56:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        linux-kernel@vger.kernel.org, Bert Vermeulen <bert@biot.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 0/2] Realtek RTL838x/RTL839x interrupt controller driver
Date:   Thu,  4 Feb 2021 15:56:27 +0000
Message-Id: <161245417429.1472579.8336169597303326540.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122204224.509124-1-bert@biot.com>
References: <20210122204224.509124-1-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, mail@birger-koblitz.de, devicetree@vger.kernel.org, john@phrozen.org, linux-kernel@vger.kernel.org, bert@biot.com, robh+dt@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 21:42:22 +0100, Bert Vermeulen wrote:
> v4:
> - Disable cascaded interrupts before mapping, not after.
> - Set chained handlers as interrupt mappings are read, instead of beforehand.
> - Removed timer interrupt clear.
> 
> v3:
> - Fixed syntax and maxItems problems in DT bindings.
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/2] dt-bindings: interrupt-controller: Add Realtek RTL838x/RTL839x support
      commit: 4a2b92a5d3519fc2c1edda4d4aa0e05bff41e8de
[2/2] irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller
      commit: 9f3a0f34b84ad1b9a8f2bdae44b66f16685b2143

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


