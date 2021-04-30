Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB537016A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhD3TpU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Apr 2021 15:45:20 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50763 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhD3TpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:45:19 -0400
X-Originating-IP: 92.184.110.200
Received: from xps13 (pop.92-184-110-200.mobile.abo.orange.fr [92.184.110.200])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C60AEC0004;
        Fri, 30 Apr 2021 19:44:26 +0000 (UTC)
Date:   Fri, 30 Apr 2021 21:44:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove unused Sigma Designs Tango bindings
Message-ID: <20210430214424.1987dc0b@xps13>
In-Reply-To: <20210430153225.3366000-1-robh@kernel.org>
References: <20210430153225.3366000-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Fri, 30 Apr 2021 10:32:25 -0500:

> The Sigma Designs Tango support has been removed, but 2 binding docs
> for NAND and PCIe were missed. Remove them.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

For the NAND binding doc:
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
