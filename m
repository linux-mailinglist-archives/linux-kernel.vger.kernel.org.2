Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E6308084
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhA1V0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:26:35 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54257 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhA1V0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:26:21 -0500
X-Originating-IP: 86.210.203.150
Received: from localhost.localdomain (lfbn-tou-1-972-150.w86-210.abo.wanadoo.fr [86.210.203.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D751040003;
        Thu, 28 Jan 2021 21:25:34 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH] mtd: parser_imagetag: fix error codes in bcm963xx_parse_imagetag_partitions()
Date:   Thu, 28 Jan 2021 22:25:34 +0100
Message-Id: <20210128212534.2242-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YBKFtNaFHGYBj+u4@mwanda>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 12ba8f8ce29fdd277f3100052eddc1afd2f5ea3f
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-28 at 09:36:52 UTC, Dan Carpenter wrote:
> If the kstrtouint() calls fail, then this should return a negative
> error code but it currently returns success.
> 
> Fixes: dd84cb022b31 ("mtd: bcm63xxpart: move imagetag parsing to its own parser")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
