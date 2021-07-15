Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50F3CAF81
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhGOXG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:06:28 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60775 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOXG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:06:26 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3373C60005;
        Thu, 15 Jul 2021 23:03:30 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>, miquel.raynal@bootlin.com,
        richard@nod.at, robh+dt@kernel.org, vigneshr@ti.com,
        linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2] dt_bindings: mtd: partitions: redboot: convert to YAML
Date:   Fri, 16 Jul 2021 01:03:29 +0200
Message-Id: <20210715230329.146042-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210628191440.2823024-1-clabbe@baylibre.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ff44b90b325dcd585cdba6ded6c9c52ea8ddead0'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-28 at 19:14:40 UTC, Corentin Labbe wrote:
> Converts mtd/partitions/redboot-fis.txt to YAML.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
