Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6F3A490C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhFKTEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:04:04 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33807 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhFKTD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:03:58 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 4ED7F1BF207;
        Fri, 11 Jun 2021 19:01:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Subject: Re: [PATCH v23 17/18] dt-bindings: mtd: pl353-nand: Describe this hardware controller
Date:   Fri, 11 Jun 2021 21:01:52 +0200
Message-Id: <20210611190152.226068-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610082040.2075611-18-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'0af8d462cc6f4eaef7069389c57c0b4a8ba2ef21'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-06-10 at 08:20:39 UTC, Miquel Raynal wrote:
> Add a yaml description of this NAND controller which is described as a
> subnode of the SMC bus.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next.

Miquel
