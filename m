Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B103C45B19B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 03:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhKXCD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 21:03:59 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:57342 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229675AbhKXCD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 21:03:58 -0500
X-UUID: 232f9541005f4ef69e9d870df16a0b23-20211124
X-UUID: 232f9541005f4ef69e9d870df16a0b23-20211124
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 940110250; Wed, 24 Nov 2021 10:00:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Nov 2021 10:00:45 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Nov 2021 10:00:45 +0800
Message-ID: <3de431c5711c0f6475f54e89c3de601e1279752a.camel@mediatek.com>
Subject: Re: [PATCH] kmemleak: fix kmemleak false positive report with HW
 tag-based kasan enable
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Andrey Konovalov <andreyknvl@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chinwen Chang =?UTF-8?Q?=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?= 
        <chinwen.chang@mediatek.com>,
        Nicholas Tang =?UTF-8?Q?=28=E9=84=AD=E7=A7=A6=E8=BC=9D=29?= 
        <nicholas.tang@mediatek.com>,
        Yee Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BB=BA=E8=AA=BC=29?= 
        <Yee.Lee@mediatek.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>, <james.hsu@mediatek.com>,
        <kuan-ying.lee@mediatek.com>
Date:   Wed, 24 Nov 2021 10:00:45 +0800
In-Reply-To: <20211119144359.b70d2fde7631bd14cd9652e3@linux-foundation.org>
References: <20211118054426.4123-1-Kuan-Ying.Lee@mediatek.com>
         <754511d9a0368065768cc3ad8037184d62c3fbd1.camel@mediatek.com>
         <CA+fCnZddknY6XLychkAUkf9eYvEW4z9Oyr8cZb2QfBMDkJ23zg@mail.gmail.com>
         <c5cfd0c41dee93cd923762a6e0d61baea52cec8d.camel@mediatek.com>
         <20211119144359.b70d2fde7631bd14cd9652e3@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-11-20 at 06:43 +0800, Andrew Morton wrote:
> On Fri, 19 Nov 2021 23:12:55 +0800 Kuan-Ying Lee <
> Kuan-Ying.Lee@mediatek.com> wrote:
> 
> > > > > Call sequence:
> > > > > ptr = kmalloc(size, GFP_KERNEL);
> > > > > page = virt_to_page(ptr);
> > > > > kfree(page_address(page));
> > > > > ptr = kmalloc(size, GFP_KERNEL);
> > > 
> > > How is this call sequence valid? page_address returns the address
> > > of
> > > the start of the page, while kmalloced object could have been
> > > located
> > > in the middle of it.
> > 
> > Thanks for pointing out. I miss the offset.
> > 
> > It should be listed as below.
> > 
> > ptr = kmalloc(size, GFP_KERNEL);
> > page = virt_to_page(ptr);
> > offset = offset_in_page(ptr);
> > kfree(page_address(page) + offset);
> > ptr = kmalloc(size, GFP_KERNEL);
> 
> I updated the changelog to reflect this.

Thanks for updating changelog. :)

