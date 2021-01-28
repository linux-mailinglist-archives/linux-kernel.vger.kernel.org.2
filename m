Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF92307210
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhA1IxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:53:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42848 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231639AbhA1Iw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:52:56 -0500
X-UUID: 57b2bc63e7094583a534d65b5d68bc02-20210128
X-UUID: 57b2bc63e7094583a534d65b5d68bc02-20210128
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 449940059; Thu, 28 Jan 2021 16:53:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 16:53:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 16:53:36 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <will@kernel.org>
CC:     <akpm@linux-foundation.org>, <andreyknvl@google.com>,
        <ardb@kernel.org>, <aryabinin@virtuozzo.com>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <dan.j.williams@intel.com>,
        <dvyukov@google.com>, <glider@google.com>, <gustavoars@kernel.org>,
        <kasan-dev@googlegroups.com>, <lecopzer.chen@mediatek.com>,
        <lecopzer@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux@roeck-us.net>, <robin.murphy@arm.com>, <rppt@kernel.org>,
        <tyhicks@linux.microsoft.com>, <vincenzo.frascino@arm.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2 4/4] arm64: kaslr: support randomized module area with KASAN_VMALLOC
Date:   Thu, 28 Jan 2021 16:53:26 +0800
Message-ID: <20210128085326.22553-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210127230413.GA1016@willie-the-truck>
References: <20210127230413.GA1016@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> On Sat, Jan 09, 2021 at 06:32:52PM +0800, Lecopzer Chen wrote:
> > After KASAN_VMALLOC works in arm64, we can randomize module region
> > into vmalloc area now.
> > 
> > Test:
> > 	VMALLOC area ffffffc010000000 fffffffdf0000000
> > 
> > 	before the patch:
> > 		module_alloc_base/end ffffffc008b80000 ffffffc010000000
> > 	after the patch:
> > 		module_alloc_base/end ffffffdcf4bed000 ffffffc010000000
> > 
> > 	And the function that insmod some modules is fine.
> > 
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
> >  arch/arm64/kernel/kaslr.c  | 18 ++++++++++--------
> >  arch/arm64/kernel/module.c | 16 +++++++++-------
> >  2 files changed, 19 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> > index 1c74c45b9494..a2858058e724 100644
> > --- a/arch/arm64/kernel/kaslr.c
> > +++ b/arch/arm64/kernel/kaslr.c
> > @@ -161,15 +161,17 @@ u64 __init kaslr_early_init(u64 dt_phys)
> >  	/* use the top 16 bits to randomize the linear region */
> >  	memstart_offset_seed = seed >> 48;
> >  
> > -	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> > -	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > +	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
> > +	    (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> 
> CONFIG_KASAN_VMALLOC depends on CONFIG_KASAN_GENERIC so why is this
> necessary?
> 
> Will

CONFIG_KASAN_VMALLOC=y means CONFIG_KASAN_GENERIC=y
but CONFIG_KASAN_GENERIC=y doesn't means CONFIG_KASAN_VMALLOC=y

So this if-condition allows only KASAN rather than
KASAN + KASAN_VMALLOC enabled.

Please correct me if I'm wrong.

thanks,
Lecopzer


 


