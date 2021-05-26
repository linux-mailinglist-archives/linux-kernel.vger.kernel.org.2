Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8B391267
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhEZIeR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 May 2021 04:34:17 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51727 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhEZIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:34:16 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CE013FF80D;
        Wed, 26 May 2021 08:32:41 +0000 (UTC)
Date:   Wed, 26 May 2021 10:32:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     patrice.chotard@foss.st.com, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: [PATCH v5 0/3] MTD: spinand: Add spi_mem_poll_status() support
Message-ID: <20210526103240.1c71002c@xps13>
In-Reply-To: <20210519191836.GH4224@sirena.org.uk>
References: <20210518162754.15940-1-patrice.chotard@foss.st.com>
        <20210519191836.GH4224@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Mark Brown <broonie@kernel.org> wrote on Wed, 19 May 2021 20:18:36
+0100:

> On Tue, May 18, 2021 at 06:27:51PM +0200, patrice.chotard@foss.st.com wrote:
> > From: Patrice Chotard <patrice.chotard@foss.st.com>
> > 
> > This series adds support for the spi_mem_poll_status() spinand
> > interface.
> > Some QSPI controllers allows to poll automatically memory 
> > status during operations (erase, read or write). This allows to 
> > offload the CPU for this task.
> > STM32 QSPI is supporting this feature, driver update are also
> > part of this series.  
> 
> The SPI bits look good to me - should we merge via MTD or SPI?

I don't expect any conflicts with the current changes in MTD, I just
acked the SPI-NAND patch, you may take it through SPI.

Thanks,
Miquèl
