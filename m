Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093183310CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCHOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:30:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49547 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229899AbhCHOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:30:16 -0500
X-UUID: c11648237da4410b8d16389ad7ef6373-20210308
X-UUID: c11648237da4410b8d16389ad7ef6373-20210308
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 680947260; Mon, 08 Mar 2021 22:30:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 22:30:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 22:30:12 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <daniel@0x0f.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <daniel@thingy.jp>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] irqchip/irq-mst: Support polarity configuration
Date:   Mon, 8 Mar 2021 22:30:11 +0800
Message-ID: <20210308143011.24538-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAFr9PXmiR9Wo9HxhRLj-k6+O5qu-uLSTCvQRqW-Yqgkk8YK-Tw@mail.gmail.com>
References: <CAFr9PXmiR9Wo9HxhRLj-k6+O5qu-uLSTCvQRqW-Yqgkk8YK-Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>


>On Mon, 8 Mar 2021 at 15:05, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>> +static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
>	> +{
>> +       if (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_LEVEL_HIGH)
>> +               return -EINVAL;
>> +
>
>Does this mean we can't do rising or falling edge interrupts?

Yes, the interrupt of mst-intc is either level high or level low.
Actually the input signal can be pulse, but it will be converted to level
by the latch in mst-intc.
