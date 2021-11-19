Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4445768A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhKSSl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:41:56 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33345 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhKSSlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:41:55 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 834581C0007;
        Fri, 19 Nov 2021 18:38:52 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Cai Huoqing <caihuoqing@baidu.com>, miquel.raynal@bootlin.com
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: denali: Add the dependency on HAS_IOMEM
Date:   Fri, 19 Nov 2021 19:38:52 +0100
Message-Id: <20211119183852.1402966-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211109134758.417-1-caihuoqing@baidu.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8495c7eb9dbed872b5498270e661a6cec4c019da'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-09 at 13:47:58 UTC, Cai Huoqing wrote:
> The helper function devm_platform_ioremap_resource_xxx()
> needs HAS_IOMEM enabled, so add the dependency on HAS_IOMEM.
> 
> Fixes: 5f14a8ca1b49 ("mtd: rawnand: denali: Make use of the helper function devm_platform_ioremap_resource_byname()")
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
