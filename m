Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2235679F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349921AbhDGJGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:06:49 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48157 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349909AbhDGJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:06:45 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CC587E0013;
        Wed,  7 Apr 2021 09:06:33 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, han.xu@nxp.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: gpmi: Fix a double free in gpmi_nand_init
Date:   Wed,  7 Apr 2021 11:06:33 +0200
Message-Id: <20210407090633.45393-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210403060905.5251-1-lyl2019@mail.ustc.edu.cn>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'076de75de1e53160e9b099f75872c1f9adf41a0b'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-04-03 at 06:09:05 UTC, Lv Yunlong wrote:
> If the callee gpmi_alloc_dma_buffer() failed to alloc memory for
> this->raw_buffer, gpmi_free_dma_buffer() will be called to free
> this->auxiliary_virt. But this->auxiliary_virt is still a non-NULL
> and valid ptr.
> 
> Then gpmi_alloc_dma_buffer() returns err and gpmi_free_dma_buffer()
> is called again to free this->auxiliary_virt in err_out. This causes
> a double free.
> 
> As gpmi_free_dma_buffer() has already called in gpmi_alloc_dma_buffer's
> error path, so it should return err directly instead of releasing the dma
> buffer again.
> 
> Fixes: 4d02423e9afe6 ("mtd: nand: gpmi: Fix gpmi_nand_init() error path")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
