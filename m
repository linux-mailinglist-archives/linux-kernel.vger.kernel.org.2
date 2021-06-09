Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299483A0C68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhFIG3I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 02:29:08 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40883 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhFIG3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:29:07 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C7F1E20007;
        Wed,  9 Jun 2021 06:27:10 +0000 (UTC)
Date:   Wed, 9 Jun 2021 08:27:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mtd: Convert mtd-physmap to DT schema
Message-ID: <20210609082709.1aad6b81@xps13>
In-Reply-To: <20210607193500.3085920-1-robh@kernel.org>
References: <20210607193500.3085920-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Mon,  7 Jun 2021 14:35:00 -0500:

> Convert the mtd-physmap binding to DT schema format. The arm-versatile,
> cypress,hyperflash and intel,ixp4xx-flash are all just an additional
> compatible string, so they are all merged into the main schema.
> 
> There doesn't appear to be any users nor support for 'vendor-id' and
> 'device-id', so these have been dropped.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
