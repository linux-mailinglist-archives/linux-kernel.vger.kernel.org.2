Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F542EEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbhJOKfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:35:14 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45981 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhJOKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:35:04 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5DA9A240007;
        Fri, 15 Oct 2021 10:32:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 5/8] Revert "mtd: rawnand: sharpsl: Fix external use of SW Hamming ECC helper"
Date:   Fri, 15 Oct 2021 12:32:55 +0200
Message-Id: <20211015103255.950159-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928221507.199198-6-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1d5f55634c92f3b4f01ed6b390ca2ffe3461250c'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-28 at 22:15:04 UTC, Miquel Raynal wrote:
> This reverts commit 46fcb57e6b7283533ebf8ba17a6bd30fa88bdc9f.
> 
> Before the introduction of the ECC framework infrastructure, many
> drivers used the ->calculate/correct() Hamming helpers directly. The
> point of this framework was to avoid this kind of hackish calls and use a
> proper and generic API but it is true that in certain cases, drivers
> still need to use these helpers in order to do ECC computations on
> behalf of their limited hardware.
> 
> Right after the introduction of the ECC engine core introduction, it was
> spotted that it was not possible to use the shiny rawnand software ECC
> helpers so easily because an ECC engine object should have been
> allocated and initialized first. While this works well in most cases,
> for these drivers just leveraging the power of a single helper in
> conjunction with some pretty old and limited hardware, it did not fit.
> 
> The idea back then was to declare intermediate helpers which would make
> use of the exported software ECC engine bare functions while keeping the
> rawnand layer compatibility. As there was already functions with the
> rawnand_sw_hamming_ prefix it was decided to declare new local helpers
> for this purpose in each driver needing one.
> 
> Besides being far from optimal, this design choice was blamed by Linus
> when he pulled the "fixes" pull request [1] so that is why now it is
> time to clean this mess up.
> 
> The implementation of the rawnand_ecc_sw_* helpers has now been enhanced
> to support both cases, when the ECC object is instantiated and when it is
> not. This way, we can still use the existing and exported rawnand
> helpers while avoiding the need for each driver to declare its own
> helper, thus this fix from [2] can now be safely reverted.
> 
> [1] https://lore.kernel.org/lkml/CAHk-=wh_ZHF685Fni8V9is17mj=pFisUaZ_0=gq6nbK+ZcyQmg@mail.gmail.com/
> [2] https://lore.kernel.org/linux-mtd/20210413161840.345208-1-miquel.raynal@bootlin.com
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next.

Miquel
