Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18913336A75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 04:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhCKDNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 22:13:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47862 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229813AbhCKDMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 22:12:50 -0500
X-UUID: 097cc62d2c2843ae90ebdfca6ba06e71-20210311
X-UUID: 097cc62d2c2843ae90ebdfca6ba06e71-20210311
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1897031880; Thu, 11 Mar 2021 11:12:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 11 Mar 2021 11:12:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Mar 2021 11:12:44 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <daniel@0x0f.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <daniel@thingy.jp>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] irqchip/irq-mst: Support polarity configuration
Date:   Thu, 11 Mar 2021 11:12:42 +0800
Message-ID: <20210311031242.24232-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAFr9PX=dz1kt_BphpWr250asLiHFQNeBgNPhuPje==hzkcHWhg@mail.gmail.com>
References: <CAFr9PX=dz1kt_BphpWr250asLiHFQNeBgNPhuPje==hzkcHWhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

>On Mon, 8 Mar 2021 at 23:30, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>> From: Daniel Palmer <daniel@0x0f.com>
>> >On Mon, 8 Mar 2021 at 15:05, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>> >> +static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
>> >       > +{
>> >> +       if (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_LEVEL_HIGH)
>> >> +               return -EINVAL;
>> >> +
>> >
>> >Does this mean we can't do rising or falling edge interrupts?
>>
>> Yes, the interrupt of mst-intc is either level high or level low.
>> Actually the input signal can be pulse, but it will be converted to level
>> by the latch in mst-intc.
>
>Are the GPIO connected interrupts meant to be configured as level
>interrupts then?
>For the MStar MSC313(e) there are 4 (that I know of) GPIO lines that
>are wired into the mst-intc that requires EOI.
>Until this patch with those lines configured as a rising edge a single
>interrupt came each time the GPIO was pulled up as far as I remember.
>
>I'm probably misunderstanding but a level interrupt doesn't seem to
>make sense for a GPIO as it can't be serviced to clear the interrupt.


As I understand it, there are 2 types of mst-intc, one we need do EOI
operation(fiq) and the other we don't(irq).
For a fiq controller, the input edge signal will be convert to level and
keep the interrupt status until we do EOI operation.
That means if a rising edge input if trigger the ouput line will keep high
until we clear the interrupt status.

And I think you're right, make these kind of interrupts edge may make more sense.
So I will modify the patch as following:

 static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
 {
-       if (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_LEVEL_HIGH)
-               return -EINVAL;
-
-       if (type == IRQ_TYPE_LEVEL_LOW) {
+       if (type == IRQ_TYPE_EDGE_FALLING) {
+               mst_set_irq(data, INTC_REV_POLARITY);
+               type = IRQ_TYPE_EDGE_RISING;
+       } else if (type == IRQ_TYPE_LEVEL_LOW) {
                mst_set_irq(data, INTC_REV_POLARITY);
                type = IRQ_TYPE_LEVEL_HIGH;
        }
