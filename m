Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE5391345
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhEZJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:04:19 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38497 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhEZJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:04:16 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id ECC54C0014;
        Wed, 26 May 2021 09:02:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>, boris.brezillon@bootlin.com,
        linus.walleij@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] mtd: partitions: redboot: fix style issues
Date:   Wed, 26 May 2021 11:02:43 +0200
Message-Id: <20210526090243.180569-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210520114851.1274609-2-clabbe@baylibre.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'eb1765c40530ccc8690b9dad88cec6aaa6bfb498'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-05-20 at 11:48:51 UTC, Corentin Labbe wrote:
> This patch fixes easy checkpatch issues.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
