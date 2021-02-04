Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2AC30EC6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBDGWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:22:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39581 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232217AbhBDGWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:22:24 -0500
X-UUID: a5e46f1b9dd743058e3dbf72b12b937c-20210204
X-UUID: a5e46f1b9dd743058e3dbf72b12b937c-20210204
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 661632920; Thu, 04 Feb 2021 14:21:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Feb 2021 14:21:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Feb 2021 14:21:38 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <ardb@kernel.org>
CC:     <akpm@linux-foundation.org>, <andreyknvl@google.com>,
        <aryabinin@virtuozzo.com>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <dan.j.williams@intel.com>,
        <dvyukov@google.com>, <glider@google.com>, <gustavoars@kernel.org>,
        <kasan-dev@googlegroups.com>, <lecopzer.chen@mediatek.com>,
        <lecopzer@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux@roeck-us.net>, <robin.murphy@arm.com>, <rppt@kernel.org>,
        <tyhicks@linux.microsoft.com>, <vincenzo.frascino@arm.com>,
        <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2 1/4] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
Date:   Thu, 4 Feb 2021 14:21:28 +0800
Message-ID: <20210204062128.27692-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAMj1kXEMOeCZTvNqPPk-uL5iA7hx7SFPwkq3Oz3yYefn=tVnPQ@mail.gmail.com>
References: <CAMj1kXEMOeCZTvNqPPk-uL5iA7hx7SFPwkq3Oz3yYefn=tVnPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 9 Jan 2021 at 11:33, Lecopzer Chen <lecopzer@gmail.com> wrote:
> >
> > Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > ("kasan: support backing vmalloc space with real shadow memory")
> >
> > Like how the MODULES_VADDR does now, just not to early populate
> > the VMALLOC_START between VMALLOC_END.
> > similarly, the kernel code mapping is now in the VMALLOC area and
> > should keep these area populated.
> >
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> 
> 
> This commit log text is a bit hard to follow. You are saying that the
> vmalloc region is *not* backed with zero shadow or any default mapping
> at all, right, and everything gets allocated on demand, just like is
> the case for modules?

It's much more like:

before:

MODULE_VADDR: no mapping, no zoreo shadow at init
VMALLOC_VADDR: backed with zero shadow at init

after:

MODULE_VADDR: no mapping, no zoreo shadow at init
VMALLOC_VADDR: no mapping, no zoreo shadow at init

So it should be both "not backed with zero shadow" and
"not any mapping and everything gets allocated on demand".

And the "not backed with zero shadow" is like a subset of "not any mapping ...".


Is that being more clear if the commit revises to:

----------------------
Like how the MODULES_VADDR does now, just not to early populate
the VMALLOC_START between VMALLOC_END.

Before:

MODULE_VADDR: no mapping, no zoreo shadow at init
VMALLOC_VADDR: backed with zero shadow at init

After:

VMALLOC_VADDR: no mapping, no zoreo shadow at init

Thus the mapping will get allocate on demand by the core function
of KASAN vmalloc.

similarly, the kernel code mapping is now in the VMALLOC area and
should keep these area populated.
--------------------

Or would you have any suggestion?


Thanks a lot for your review!

BRs,
Lecopzer

