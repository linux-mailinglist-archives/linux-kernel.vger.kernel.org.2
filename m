Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14B6305C12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhA0Mvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:51:36 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:43605 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbhA0MtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:49:07 -0500
Received: from localhost.localdomain (lfbn-tou-1-972-150.w86-210.abo.wanadoo.fr [86.210.203.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id CB80A200007;
        Wed, 27 Jan 2021 12:48:22 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        martin.blumenstingl@googlemail.com
Cc:     kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: Fix an error handling path in 'ebu_dma_start()'
Date:   Wed, 27 Jan 2021 13:48:22 +0100
Message-Id: <20210127124822.13987-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210124073955.728797-1-christophe.jaillet@wanadoo.fr>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 65e4cbbd7cd15aef78e332a67bc748674b203570
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-01-24 at 07:39:55 UTC, Christophe JAILLET wrote:
> If 'dmaengine_prep_slave_single()' fails, we must undo a previous
> 'dma_map_single()' call, as already done in all the other error handling
> paths of this function.
> 
> Fixes: 0b1039f016e8 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
