Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C87932AA40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581741AbhCBTRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:17:11 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35917 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839647AbhCBQhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:37 -0500
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id D26983B24FF
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:34:57 +0000 (UTC)
X-Originating-IP: 86.206.8.148
Received: from xps13.stephanxp.local (lfbn-tou-1-491-148.w86-206.abo.wanadoo.fr [86.206.8.148])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7E0BA1BF20D;
        Tue,  2 Mar 2021 16:32:37 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>, miquel.raynal@bootlin.com,
        mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: Re: [PATCH 1/5] mtd: rawnand: qcom: Convert nandc to chip in Read/Write helper
Date:   Tue,  2 Mar 2021 17:32:37 +0100
Message-Id: <20210302163237.23331-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614109141-7531-1-git-send-email-mdalam@codeaurora.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 7eff256102bd515a0f9e2c9c2a06b6d8b4ee1125
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-23 at 19:38:57 UTC, Md Sadre Alam wrote:
> This change will convert nandc to chip in Read/Write helper, this
> change is needed because if we wnated to access number of steps
> in Read/Write helper then we need to get the chip->ecc.steps,
> currentlly its not possible.After this change we can directly
> acces chip->ecc.steps in Read/Write helper.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
