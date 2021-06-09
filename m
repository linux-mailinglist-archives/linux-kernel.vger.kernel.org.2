Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD403A15D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhFINn5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 09:43:57 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40901 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhFINn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:43:56 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DBDBB1BF215;
        Wed,  9 Jun 2021 13:41:55 +0000 (UTC)
Date:   Wed, 9 Jun 2021 15:41:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v22 15/18] MAINTAINERS: Add PL353 SMC entry
Message-ID: <20210609154154.54aa5f06@xps13>
In-Reply-To: <f04b06fc-72f9-8f90-343d-e4826a3bf4d7@canonical.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
        <20210609080112.1753221-16-miquel.raynal@bootlin.com>
        <f04b06fc-72f9-8f90-343d-e4826a3bf4d7@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Wed, 9
Jun 2021 15:23:11 +0200:

> On 09/06/2021 10:01, Miquel Raynal wrote:
> > Add Naga from Xilinx and myself responsible of this driver.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >   
> 
> Memory controller bits look good to me, except few things in bindings. I
> can take them up to this patch, for which I would need also Ack from
> Naga Sureshkumar Relli confirming he will co-maintain this code.

Sure. I would also expect Rob to Ack the yaml conversion possibly.

I am waiting for your feedback on a couple of questions and then I will
respin the series.

> I assume the NAND driver depends on this, so I can prepare a stable tag
> with the memory controller part, if needed.

Absolutely, that would be great.

Thanks,
Miquèl
