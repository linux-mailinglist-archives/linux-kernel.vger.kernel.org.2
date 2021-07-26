Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91F3D6541
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbhGZQc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240189AbhGZQcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:32:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0849460F58;
        Mon, 26 Jul 2021 17:12:48 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1m849m-0018M9-8Z; Mon, 26 Jul 2021 18:12:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 1/7] irqchip: Switch to bitmap_zalloc()
Date:   Mon, 26 Jul 2021 18:12:35 +0100
Message-Id: <162731953698.1433151.6928251625851345687.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618151657.65305-1-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, andrew@lunn.ch, tsahee@annapurnalabs.com, sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com, atenart@kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 18:16:51 +0300, Andy Shevchenko wrote:
> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.

Applied to irq/irqchip-next, thanks!

[1/7] irqchip: Switch to bitmap_zalloc()
      commit: 4cad4da0795e9c03973d5456945394aee75bdf0f
[2/7] irqchip/alpine-msi: Switch to bitmap_zalloc()
      commit: 3f1808f63f0458762403549b3d975ef6e971b6e0
[3/7] irqchip/gic-v2m: Switch to bitmap_zalloc()
      commit: 81d3c9e7b43e9426e67a5df66d51a5f2bfce0362
[4/7] irqchip/gic-v3: Switch to bitmap_zalloc()
      commit: ff5fe8867a5feaf90b1cb9b766f3de3a1caf9f33
[5/7] irqchip/ls-scfg-msi: Switch to devm_bitmap_zalloc()
      commit: 43a1965fc5ae911c83a49ad793677aa6ba0e18e2
[6/7] irqchip/mvebu-gicp: Switch to devm_bitmap_zalloc()
      commit: 3db3969f5375fe0a43c03cb4b55ed643585b140d
[7/7] irqchip/mvebu-odmi: Switch to bitmap_zalloc()
      commit: c980983daebf10633c922998bade3a7fd74f1fc1

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


