Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7239125F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhEZIdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:33:24 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:46299 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhEZIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:33:22 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0DB5710000C;
        Wed, 26 May 2021 08:31:47 +0000 (UTC)
Date:   Wed, 26 May 2021 10:31:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <patrice.chotard@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
Subject: Re: [PATCH v5 2/3] mtd: spinand: use the spi-mem poll status APIs
Message-ID: <20210526103146.5fcd8247@xps13>
In-Reply-To: <20210518162754.15940-3-patrice.chotard@foss.st.com>
References: <20210518162754.15940-1-patrice.chotard@foss.st.com>
        <20210518162754.15940-3-patrice.chotard@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


<patrice.chotard@foss.st.com> wrote on Tue, 18 May 2021 18:27:53 +0200:

> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Make use of spi-mem poll status APIs to let advanced controllers
> optimize wait operations.
> This should also fix the high CPU usage for system that don't have
> a dedicated STATUS poll block logic.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

