Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D932AA49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835568AbhCBTRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:17:53 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:52801 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351511AbhCBQln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:41:43 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 52DAF3A8720
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:35:51 +0000 (UTC)
Received: from xps13.stephanxp.local (lfbn-tou-1-491-148.w86-206.abo.wanadoo.fr [86.206.8.148])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A71ED200012;
        Tue,  2 Mar 2021 16:33:07 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, boris.brezillon@collabora.com,
        manivannan.sadhasivam@linaro.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Update register macro name for 0x2c offset
Date:   Tue,  2 Mar 2021 17:33:07 +0100
Message-Id: <20210302163307.23653-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1612037236-7954-1-git-send-email-mdalam@codeaurora.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: f95add6ff80490872464817653378b8d2c06d692
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-01-30 at 20:07:16 UTC, Md Sadre Alam wrote:
> This change will remove unused register name macro NAND_DEV1_ECC_CFG.
> Since this register was only available in QPIC version 1.4.20 ipq40xx
> and it was not used. In QPIC version 1.5 on wards this register got
> removed.In QPIC version 2.0 0x2c offset is updated with register
> NAND_AUTO_STATUS_EN So adding this register macro NAND_AUTO_STATUS_EN
> with offset 0x2c.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
