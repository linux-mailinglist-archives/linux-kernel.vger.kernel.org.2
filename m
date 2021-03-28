Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4E34BD78
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhC1ROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 13:14:31 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41745 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhC1RO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 13:14:28 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 83C1760006;
        Sun, 28 Mar 2021 17:14:23 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zou Wei <zou_wei@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, heiko@sntech.de
Cc:     yifeng.zhao@rock-chips.com, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mtd: rawnand: rockchip: Use flexible-array member instead of zero-length array
Date:   Sun, 28 Mar 2021 19:14:22 +0200
Message-Id: <20210328171422.7386-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210323131137.45552-1-zou_wei@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5c8a620ab22b05eae7e480cb83ff599047b8aff4'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-23 at 13:11:37 UTC, Zou Wei wrote:
> Suppresses the following coccinelle warning:
> 
> drivers/mtd/nand/raw/rockchip-nand-controller.c:162:4-8: WARNING use flexible-array member instead
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
