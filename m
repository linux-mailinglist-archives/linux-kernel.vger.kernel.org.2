Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2983E447CFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhKHJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:43:43 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56132 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236838AbhKHJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:43:42 -0500
X-UUID: d313024215cb41fc999a422a7d299fe0-20211108
X-UUID: d313024215cb41fc999a422a7d299fe0-20211108
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 753959213; Mon, 08 Nov 2021 17:40:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 8 Nov 2021 17:40:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 8 Nov 2021 17:40:52 +0800
Message-ID: <4e876c89ee58cd1408511a34573005e3df359cd0.camel@mediatek.com>
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code
 from machine driver
From:   YC Hung <yc.hung@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     Trevor Wu <trevor.wu@mediatek.com>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <daniel.baluta@nxp.com>, <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 8 Nov 2021 17:40:52 +0800
In-Reply-To: <YYVez/V9ocCXhYmg@sirena.org.uk>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
         <20211103100040.11933-4-trevor.wu@mediatek.com>
         <YYP+l7tMofYoB+aC@sirena.org.uk>
         <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
         <YYVQC7KLZx8oxdXT@sirena.org.uk>
         <e404d241-0685-643b-4b9d-d85bb8783385@linux.intel.com>
         <YYVez/V9ocCXhYmg@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

I am YC Hung from Mediatek. Let me show our block diagram as the link
below for the sound card which support SOF.

https://user-images.githubusercontent.com/62316/132476344-923dfe3a-5305-43e5-9fc8-c63d9ab2c58f.png
In this sound card, there are two components , one is SOF based
component and another is non-SOF based component(called Normal in the
block).
We want to reuse some BEs of Normal which can control Mediatek Audio
Front End hardware power, clock , and DAI module and still keep some
FEs(e.g. DPTX) then we can use it on the same sound card.
Therefore, we use late_probe callback function
"mt8195_mt6359_rt1019_rt5682_card_late_probe" to add route path from
SOF widget to non-SOF BEs.
For two patches https://github.com/thesofproject/linux/pull/3217 and 
https://github.com/thesofproject/linux/pull/3236, we want to keep FEs
of non-SOF components and can reuse them. Please let me know if I am
not clear enough.Thanks.

On Fri, 2021-11-05 at 16:41 +0000, Mark Brown wrote:
> On Fri, Nov 05, 2021 at 11:16:05AM -0500, Pierre-Louis Bossart wrote:
> > On 11/5/21 10:38 AM, Mark Brown wrote:
> > > We shouldn't be requiring people to load completely different
> > > drivers
> > > based on software configuration, what if a system wants to bypass
> > > the
> > > DSP in some but not all configurations?  Can we not just have
> > > controls
> > > allowing users to route round the DSP where appropriate?
> > It was my understanding the card relies on separate components
> > - a SOF-based component to provide support for DSP-managed
> > interfaces
> > - a 'non-SOF' component for 'regular' interfaces not handled by the
> > DSP.
> > this was the basis for the changes discussed in
> > https://github.com/thesofproject/linux/pull/3217 and
> > https://github.com/thesofproject/linux/pull/3236
> 
> So it's actually supposed to end up as two different cards which
> can't
> possibly be interlinked?  That doesn't seem to add up entirely given
> that there's stuff being moved out of the current card, and I thought
> these systems had a fairly comprehensive audio muxing capability.
> Trevor, could you be a bit more specific about what's actually going
> on
> here physically please?
> 
> > But indeed if the same interface can be managed by the DSP or not,
> > depending on software choices it's a different problem altogether.
> > We've looked into this recently, if the choice to involve the DSP
> > or not
> > is at the interface level, it might be better to have both
> > components
> > expose different DAIs for the same interface, with some sort of
> > run-time
> > mutual exclusion, so that all possible/allowed permutations are
> > allowed.
> 
> Yes, if the interface can optionally be completely hidden by the DSP
> that's adding another layer of complication.
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

