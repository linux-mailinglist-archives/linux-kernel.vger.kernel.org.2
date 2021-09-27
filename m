Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3104E419240
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhI0KfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:35:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40066 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233787AbhI0Ke7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:34:59 -0400
X-UUID: 98fe2ad69e914c89ae096200ea39a7dc-20210927
X-UUID: 98fe2ad69e914c89ae096200ea39a7dc-20210927
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1472071810; Mon, 27 Sep 2021 18:33:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Sep 2021 18:33:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Sep 2021 18:33:16 +0800
Message-ID: <03494ad08689e43358d554bbc48936118a63fd45.camel@mediatek.com>
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8195: add machine driver with
 mt6359, rt1011 and rt5682
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <aaronyu@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 27 Sep 2021 18:33:16 +0800
In-Reply-To: <c34d03ff-f349-724e-0dcf-7893f3622cd9@linux.intel.com>
References: <20210910104405.11420-1-trevor.wu@mediatek.com>
         <20210910104405.11420-2-trevor.wu@mediatek.com>
         <10fc49fa-9791-0225-365d-e3074680596c@linux.intel.com>
         <4d703c5f7cf27ddc8b9886b111ffeeba0c4aa08b.camel@mediatek.com>
         <1d7fe7455a054819daf05d41ab3658afdc1caced.camel@mediatek.com>
         <c34d03ff-f349-724e-0dcf-7893f3622cd9@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-24 at 09:46 -0500, Pierre-Louis Bossart wrote:
> > > > > +/* Module information */
> > > > > +MODULE_DESCRIPTION("MT8195-MT6359-RT1011-RT5682 ALSA SoC
> > > > > machine
> > > > > driver");
> > > > > +MODULE_AUTHOR("Trevor Wu <trevor.wu@mediatek.com>");
> > > > > +MODULE_LICENSE("GPL v2");
> > > > 
> > > > "GPL" is enough
> > > > 
> > > 
> > > I see many projects use GPL v2 here, and all mediatek projects
> > > use
> > > GPL
> > > v2, too.
> > > I'm not sure which one is better.
> > > Do I need to modify this?
> 
> See
> 
https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/license-rules.html?highlight=module_license*id1__;Iw!!CTRNKA9wMg0ARbw!0xwqsodizM7jFI4lwpT7_h2bk6xHtdNb32YDo2lneZ9u-cs5hAqqdqTci89qK8FwLg$
>  
> 
> Loadable kernel modules also require a MODULE_LICENSE() tag. This tag
> is
> neither a replacement for proper source code license information
> (SPDX-License-Identifier) nor in any way relevant for expressing or
> determining the exact license under which the source code of the
> module
> is provided.
> 
> “GPL”
> 
> Module is licensed under GPL version 2. This does not express any
> distinction between GPL-2.0-only or GPL-2.0-or-later. The exact
> license
> information can only be determined via the license information in the
> corresponding source files.
> 
> “GPL v2”
> 
> Same as “GPL”. It exists for historic reasons.
> 
> So "GPL v2" is not incorrect but for new contributions you might as
> well
> use the recommended tag.


Got it.
Thanks for your detailed explanation.
I will correct it in V2.

Trevor

