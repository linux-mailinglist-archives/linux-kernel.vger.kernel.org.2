Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1302E445F0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 05:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhKEEOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 00:14:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44848 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229884AbhKEEOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 00:14:45 -0400
X-UUID: 9c2cbe9fa3dd4117bb2ca022e041268b-20211105
X-UUID: 9c2cbe9fa3dd4117bb2ca022e041268b-20211105
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 105411032; Fri, 05 Nov 2021 12:11:56 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Nov 2021 12:11:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Nov 2021 12:11:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 5 Nov 2021 12:11:55 +0800
Message-ID: <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code
 from machine driver
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <tiwai@suse.com>, <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yc.hung@mediatek.com>, <daniel.baluta@nxp.com>
Date:   Fri, 5 Nov 2021 12:11:55 +0800
In-Reply-To: <YYP+l7tMofYoB+aC@sirena.org.uk>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
         <20211103100040.11933-4-trevor.wu@mediatek.com>
         <YYP+l7tMofYoB+aC@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-04 at 15:39 +0000, Mark Brown wrote:
> On Wed, Nov 03, 2021 at 06:00:39PM +0800, Trevor Wu wrote:
> > Because we will add DSP support, an new machine driver for the same
> > board is required. BE and codec configuration will use the same
> > code
> > when machine driver is designed for the same board.
> 
> I don't follow why the DSP support requires a new driver?  Shouldn't
> all
> systems with the DSP present be using it?

We need to keep the solution without DSP, so we can replace DSP
solution with non-DSP when it's required. But when we introduce SOF for
DSP control, there will be more routes in machine driver and device
tree usage is different from the original. So it's hard to share the
same driver for these two solutions.

Thanks,
Trevor

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

