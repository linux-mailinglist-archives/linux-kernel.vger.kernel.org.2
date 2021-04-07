Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5856356C28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352211AbhDGMce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352209AbhDGMcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:32:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D63B60FEE;
        Wed,  7 Apr 2021 12:32:23 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lU7M5-0064QE-Oo; Wed, 07 Apr 2021 13:32:21 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Thomas Gleixner <tglx@linutronix.de>, yj.chiang@mediatek.com
Subject: Re: [PATCH v4] irqchip/irq-mst: Support polarity configuration
Date:   Wed,  7 Apr 2021 13:32:18 +0100
Message-Id: <161779861853.1095473.5298722515366645691.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210315131848.31840-1-mark-pk.tsai@mediatek.com>
References: <20210315131848.31840-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: mark-pk.tsai@mediatek.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, daniel@thingy.jp, tglx@linutronix.de, yj.chiang@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 21:18:48 +0800, Mark-PK Tsai wrote:
> Support irq polarity configuration and save and restore the config
> when system suspend and resume.

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/irq-mst: Support polarity configuration
      commit: ea4aeaa5c88906eb3ca3d7d3d17a45605d2dd0de

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


