Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD234E2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhC3IOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:14:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42798 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231370AbhC3IOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:14:20 -0400
X-UUID: 30b0eb7514ec41389a1557a0acfc5cc1-20210330
X-UUID: 30b0eb7514ec41389a1557a0acfc5cc1-20210330
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1259450712; Tue, 30 Mar 2021 16:14:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Mar 2021 16:14:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 16:14:17 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <will@kernel.org>
CC:     <akpm@linux-foundation.org>, <andreyknvl@gmail.com>,
        <catalin.marinas@arm.com>, <dvyukov@google.com>,
        <glider@google.com>, <gustavoars@kernel.org>,
        <kasan-dev@googlegroups.com>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@roeck-us.net>,
        <maz@kernel.org>, <rppt@kernel.org>, <ryabinin.a.a@gmail.com>,
        <tyhicks@linux.microsoft.com>, <yj.chiang@mediatek.com>,
        <lecopzer@gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: Kconfig: select KASAN_VMALLOC if KANSAN_GENERIC is enabled
Date:   Tue, 30 Mar 2021 16:14:17 +0800
Message-ID: <20210330081417.22011-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210329125449.GA3805@willie-the-truck>
References: <20210329125449.GA3805@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 24, 2021 at 12:05:22PM +0800, Lecopzer Chen wrote:
> > Before this patch, someone who wants to use VMAP_STACK when
> > KASAN_GENERIC enabled must explicitly select KASAN_VMALLOC.
> > 
> > From Will's suggestion [1]:
> >   > I would _really_ like to move to VMAP stack unconditionally, and
> >   > that would effectively force KASAN_VMALLOC to be set if KASAN is in use
> > 
> > Because VMAP_STACK now depends on either HW_TAGS or KASAN_VMALLOC if
> > KASAN enabled, in order to make VMAP_STACK selected unconditionally,
> > we bind KANSAN_GENERIC and KASAN_VMALLOC together.
> > 
> > Note that SW_TAGS supports neither VMAP_STACK nor KASAN_VMALLOC now,
> > so this is the first step to make VMAP_STACK selected unconditionally.
> 
> Do you know if anybody is working on this? It's really unfortunate that
> we can't move exclusively to VMAP_STACK just because of SW_TAGS KASAN.
> 
> That said, what is there to do? As things stand, won't kernel stack
> addresses end up using KASAN_TAG_KERNEL?


Hi Andrey,

Do you or any KASAN developers have already had any plan for this?



thanks,
Lecopzer
