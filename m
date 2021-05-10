Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1091537850C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhEJK6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:58:19 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54377 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhEJKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:45:23 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B9A176000B;
        Mon, 10 May 2021 10:44:15 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/5] nvmem: core: allow specifying of_node
Date:   Mon, 10 May 2021 12:44:15 +0200
Message-Id: <20210510104415.11332-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210424110608.15748-2-michael@walle.cc>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1333a6779501f4cc662ff5c8b36b0a22f3a7ddc6'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-04-24 at 11:06:04 UTC, Michael Walle wrote:
> Until now, the of_node of the parent device is used. Some devices
> provide more than just the nvmem provider. To avoid name space clashes,
> add a way to allow specifying the nvmem cells in subnodes. Consider the
> following example:
> 
>     flash@0 {
>         compatible = "jedec,spi-nor";
> 
>         partitions {
>             compatible = "fixed-partitions";
>             #address-cells = <1>;
>             #size-cells = <1>;
> 
>             partition@0 {
>                 reg = <0x000000 0x010000>;
>             };
>         };
> 
>         otp {
>             compatible = "user-otp";
>             #address-cells = <1>;
>             #size-cells = <1>;
> 
>             serial-number@0 {
>                 reg = <0x0 0x8>;
>             };
>         };
>     };
> 
> There the nvmem provider might be the MTD partition or the OTP region of
> the flash.
> 
> Add a new config->of_node parameter, which if set, will be used instead
> of the parent's of_node.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
