Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6143E3A9E55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhFPO7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:59:41 -0400
Received: from foss.arm.com ([217.140.110.172]:39482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234294AbhFPO7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:59:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6E431B;
        Wed, 16 Jun 2021 07:57:34 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE8E3F719;
        Wed, 16 Jun 2021 07:57:32 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:57:15 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <mripard@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 01/19] dt-bindings: mfd: axp20x: Add AXP305
 compatible (plus optional IRQ)
Message-ID: <20210616155715.7d8347c5@slackpad.fritz.box>
In-Reply-To: <20210615233345.GA1627887@robh.at.kernel.org>
References: <20210615110636.23403-1-andre.przywara@arm.com>
        <20210615110636.23403-2-andre.przywara@arm.com>
        <20210615233345.GA1627887@robh.at.kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 17:33:45 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, 15 Jun 2021 12:06:18 +0100, Andre Przywara wrote:
> > The AXP305 PMIC used on many boards with the H616 SoC seems to be fully
> > compatible to the AXP805 PMIC, so add the proper chain of compatible
> > strings.
> > 
> > Also at least on one board (Orangepi Zero2) there is no interrupt line
> > connected to the CPU, so make the "interrupts" property optional.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >   
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Argh, sorry, I was still wondering whether I should try the YAML
conversion, so didn't apply your tag right away - and then missed it
when I decided to postpone this. Plus I actually fixed some blunder
(copy&paste typo in the compatible), and I mostly drop tags upon
changes.

Cheers,
Andre
