Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A732AA48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835558AbhCBTRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:17:47 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:46179 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839621AbhCBQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:34 -0500
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id CE2EA3B470D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:34:41 +0000 (UTC)
X-Originating-IP: 86.206.8.148
Received: from xps13.stephanxp.local (lfbn-tou-1-491-148.w86-206.abo.wanadoo.fr [86.206.8.148])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 94CF71BF208;
        Tue,  2 Mar 2021 16:32:13 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        f.fainelli@gmail.com, Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nand: brcmnand: fix OOB R/W with Hamming ECC
Date:   Tue,  2 Mar 2021 17:32:12 +0100
Message-Id: <20210302163212.23060-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210224080210.23686-1-noltari@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 095b4dabff2a929cefd330110c5c578956213188
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-24 at 08:02:10 UTC, =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= wrote:
> Hamming ECC doesn't cover the OOB data, so reading or writing OOB shall
> always be done without ECC enabled.
> This is a problem when adding JFFS2 cleanmarkers to erased blocks. If JFFS2
> clenmarkers are added to the OOB with ECC enabled, OOB bytes will be changed
> from ff ff ff to 00 00 00, reporting incorrect ECC errors.
> 
> Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Acked-by: Brian Norris <computersforpeace@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
