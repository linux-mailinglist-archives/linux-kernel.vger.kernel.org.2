Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29133AE22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhCOI7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:59:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36512 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229649AbhCOI7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:59:03 -0400
X-UUID: 82d7528d58eb468f880f50929af6b1df-20210315
X-UUID: 82d7528d58eb468f880f50929af6b1df-20210315
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 726664109; Mon, 15 Mar 2021 16:58:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Mar 2021 16:58:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Mar 2021 16:58:57 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <daniel@0x0f.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <daniel@thingy.jp>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] irqchip/irq-mst: Support polarity configuration
Date:   Mon, 15 Mar 2021 16:58:55 +0800
Message-ID: <20210315085855.23730-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAFr9PXmwp5FQP8dOZed0siz76qj4Lo-ytt=nt+1GR5qAFtEr9g@mail.gmail.com>
References: <CAFr9PXmwp5FQP8dOZed0siz76qj4Lo-ytt=nt+1GR5qAFtEr9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5007523079440117CCE27AD2F0035B5726B867D344927A1A117F87F9928E1A362000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

> On Fri, 12 Mar 2021 at 01:11, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> > Why irq could accept either?
> 
> As the irq intc has no way to clear it's triggered state (no eoi) it
> must just pass the signal through instead of latching it?
> Otherwise it would latch once and never again right? That's what I
> really didn't understand.
> If it just passes the signal through and maybe inverts it then the GIC
> can use edge or level I think.

Yes, but if we accidentally loss a irq and the interrupt is edge triggered which is
latch to level by mst-intc, we will miss all the follow irqs because the driver
didn't reset the interrupt status.
Actually, I'm not sure if it's possible.
But even if it's not, I think use level for parent GIC can better match
the hardware signal processing.

> 
> > So maybe we don't need to do extra work to check the type for an fiq or irq controller?
> 
> I think without the eoi callback for the fiq it would only ever fire
> once. I don't think doing the same eoi callback for the irq intc hurts
> anything but it wouldn't do anything either from what I can tell.

The reason why I don't do the same eoi callback for irq intc is that
it's not ont spec.
And some of MTK TV SoC use it for certain debug function which
may cause unexpected result.

> 
> > And I will update the patch as following:
> 
> I think maybe Marc or someone else that knows better than I do should
> comment on what needs to happen.
> My input is just that the fiq controller seems to trigger on an edge,
> holds it's signal to the GIC high until eoi happens and then only
> triggers again on an edge.
> I guess it doesn't matter if it's an edge or level if that's how it
> works but you'd only get one interrupt out of it per edge even if
> configured as a level interrupt.
> 
> The main thing I didn't want was filtering out edge interrupts
> entirely as that breaks using edge interrupts with gpios i.e. using
> gpiomon.
> With the changes to set the polarity it can now detect rising or
> falling edge gpio events. :)

Thanks for your feedback and I will send patch v4 which includes the
change I proposed in this thread.

