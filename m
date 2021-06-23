Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134F43B1B57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFWNmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:42:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55668 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFWNmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:42:54 -0400
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lw37H-0001rM-12; Wed, 23 Jun 2021 15:40:31 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>, wens@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add sdmmc_ext for RK3328
Date:   Wed, 23 Jun 2021 15:40:30 +0200
Message-ID: <6327455.haC6HkEk0m@diego>
In-Reply-To: <CAGb2v67K-BRhQ_a1yXtdPCX8T30FJPLojueJ2cvpXmGUskOLjA@mail.gmail.com>
References: <20210623120001.164920-1-knaerzche@gmail.com> <CAGb2v67K-BRhQ_a1yXtdPCX8T30FJPLojueJ2cvpXmGUskOLjA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 23. Juni 2021, 15:11:12 CEST schrieb Chen-Yu Tsai:
> On Wed, Jun 23, 2021 at 8:00 PM Alex Bee <knaerzche@gmail.com> wrote:
> >
> > RK3328 SoC has a fourth mmc controller called SDMMC_EXT. Some
> > boards have sdio wifi connected to it. In order to use it
> > one would have to add the pinctrls from sdmmc0ext group which
> > is done on board level.
> >
> > While at that also add the reset controls for the other mmc
> > controllers.
> 
> I recommend splitting this part into a separate patch, and
> adding an appropriate "Fixes" tag to it.

I'm with you on that. Adding the resets to the existing controllers
should be a separate patch.

Heiko


