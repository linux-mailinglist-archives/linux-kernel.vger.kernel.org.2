Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8D3A4912
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhFKTE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:04:27 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49875 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhFKTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:04:21 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id BE1A940003;
        Fri, 11 Jun 2021 19:02:19 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>, miquel.raynal@bootlin.com,
        mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: Re: [PATCH V4] mtd: rawnand: qcom: avoid writing to obsolete register
Date:   Fri, 11 Jun 2021 21:02:19 +0200
Message-Id: <20210611190219.226202-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <1623134916-562-1-git-send-email-mdalam@codeaurora.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bfab74c029c6f1c0c63d89ed0a6cc8e3e30522d7'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-06-08 at 06:48:36 UTC, Md Sadre Alam wrote:
> QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
> Avoid writing this register if QPIC version is V2.0 or newer.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
