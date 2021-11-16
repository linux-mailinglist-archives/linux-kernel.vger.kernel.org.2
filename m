Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97191452E19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhKPJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:37:17 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:42090 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233267AbhKPJgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:36:53 -0500
X-UUID: 04329e55bd3541b3b2a8b663cb736d41-20211116
X-UUID: 04329e55bd3541b3b2a8b663cb736d41-20211116
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1937280426; Tue, 16 Nov 2021 17:33:49 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 16 Nov 2021 17:33:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Nov
 2021 17:33:48 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Nov 2021 17:33:48 +0800
Message-ID: <f915d1090abf2b6d188ce27068919a181828e463.camel@mediatek.com>
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code
 from machine driver
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     YC Hung <yc.hung@mediatek.com>, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-mediatek@lists.infradead.org>,
        <matthias.bgg@gmail.com>, <daniel.baluta@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 16 Nov 2021 17:33:48 +0800
In-Reply-To: <4e876c89ee58cd1408511a34573005e3df359cd0.camel@mediatek.com>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
         <20211103100040.11933-4-trevor.wu@mediatek.com>
         <YYP+l7tMofYoB+aC@sirena.org.uk>
         <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
         <YYVQC7KLZx8oxdXT@sirena.org.uk>
         <e404d241-0685-643b-4b9d-d85bb8783385@linux.intel.com>
         <YYVez/V9ocCXhYmg@sirena.org.uk>
         <4e876c89ee58cd1408511a34573005e3df359cd0.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-08 at 17:40 +0800, YC Hung wrote:
> Hi Mark,
> 
> I am YC Hung from Mediatek. Let me show our block diagram as the link
> below for the sound card which support SOF.
> 
> 
https://user-images.githubusercontent.com/62316/132476344-923dfe3a-5305-43e5-9fc8-c63d9ab2c58f.png
> In this sound card, there are two components , one is SOF based
> component and another is non-SOF based component(called Normal in the
> block).
> We want to reuse some BEs of Normal which can control Mediatek Audio
> Front End hardware power, clock , and DAI module and still keep some
> FEs(e.g. DPTX) then we can use it on the same sound card.
> Therefore, we use late_probe callback function
> "mt8195_mt6359_rt1019_rt5682_card_late_probe" to add route path from
> SOF widget to non-SOF BEs.
> For two patches https://github.com/thesofproject/linux/pull/3217 and 
> https://github.com/thesofproject/linux/pull/3236, we want to keep FEs
> of non-SOF components and can reuse them. Please let me know if I am
> not clear enough.Thanks.
> 
> On Fri, 2021-11-05 at 16:41 +0000, Mark Brown wrote:
> > On Fri, Nov 05, 2021 at 11:16:05AM -0500, Pierre-Louis Bossart
> > wrote:
> > > On 11/5/21 10:38 AM, Mark Brown wrote:
> > > > We shouldn't be requiring people to load completely different
> > > > drivers
> > > > based on software configuration, what if a system wants to
> > > > bypass
> > > > the
> > > > DSP in some but not all configurations?  Can we not just have
> > > > controls
> > > > allowing users to route round the DSP where appropriate?
> > > 
> > > It was my understanding the card relies on separate components
> > > - a SOF-based component to provide support for DSP-managed
> > > interfaces
> > > - a 'non-SOF' component for 'regular' interfaces not handled by
> > > the
> > > DSP.
> > > this was the basis for the changes discussed in
> > > https://github.com/thesofproject/linux/pull/3217 and
> > > https://github.com/thesofproject/linux/pull/3236
> > 
> > So it's actually supposed to end up as two different cards which
> > can't
> > possibly be interlinked?  That doesn't seem to add up entirely
> > given
> > that there's stuff being moved out of the current card, and I
> > thought
> > these systems had a fairly comprehensive audio muxing capability.
> > Trevor, could you be a bit more specific about what's actually
> > going
> > on
> > here physically please?+++++++++
> > 

Hi Mark,

Is the reply from YC clear? Any suggestion would be appreciated. If you
need more information, please let us know. 

Additionally, it was my understanding you suggested that DSP routes
should be configurable in some ways, and we should not just add a new
driver for SOF in case we need to support some other interface
combinations in the future. If I'm wrong, please kindly correct me.

Thanks,
Trevor


