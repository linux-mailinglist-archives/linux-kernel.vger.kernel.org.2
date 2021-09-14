Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B36940B60A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhINRkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:40:52 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:51849 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhINRku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:40:50 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A8EC8200005;
        Tue, 14 Sep 2021 17:39:29 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Stefan Agner <stefan@agner.ch>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: vf610: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 14 Sep 2021 19:39:28 +0200
Message-Id: <20210914173928.301381-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210901074245.9583-1-caihuoqing@baidu.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2d77b08eaf0b2f269512c200c441bb1cda59d978'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-01 at 07:42:44 UTC, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> Acked-by: Stefan Agner <stefan@agner.ch>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
