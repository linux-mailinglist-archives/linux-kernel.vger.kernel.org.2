Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF145B1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 03:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbhKXCIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 21:08:07 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:37146 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229970AbhKXCIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 21:08:05 -0500
X-UUID: 43838bdb7aa04f47a8dc4f13c4c8d86b-20211124
X-UUID: 43838bdb7aa04f47a8dc4f13c4c8d86b-20211124
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 373928317; Wed, 24 Nov 2021 10:04:53 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 24 Nov 2021 10:04:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Nov
 2021 10:04:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Nov 2021 10:04:52 +0800
Message-ID: <739993f6910516fe0d451b2c7f56afa94438cab7.camel@mediatek.com>
Subject: Re: [PATCH] arm64: update compiler option for PAC
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chinwen Chang =?UTF-8?Q?=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?= 
        <chinwen.chang@mediatek.com>,
        Nicholas Tang =?UTF-8?Q?=28=E9=84=AD=E7=A7=A6=E8=BC=9D=29?= 
        <nicholas.tang@mediatek.com>, <James.Hsu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>, <kuan-ying.lee@mediatek.com>
Date:   Wed, 24 Nov 2021 10:04:51 +0800
In-Reply-To: <20211123121055.GD37253@lakrids.cambridge.arm.com>
References: <20211115031810.29701-1-Kuan-Ying.Lee@mediatek.com>
         <20211116101147.GB9851@willie-the-truck>
         <20211123121055.GD37253@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-23 at 20:10 +0800, Mark Rutland wrote:
> On Tue, Nov 16, 2021 at 10:11:47AM +0000, Will Deacon wrote:
> > On Mon, Nov 15, 2021 at 11:18:08AM +0800, Kuan-Ying Lee wrote:
> > > We pass -mbranch-protection=pac-ret+leaf to support PAC
> > > when we use GCC 9 or later.
> > > 
> > > Before GCC 9, we pass -msign-return-address=all to support
> > > PAC.
> > > 
> > > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> > > ---
> > >  Documentation/arm64/pointer-authentication.rst | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/arm64/pointer-authentication.rst
> > > b/Documentation/arm64/pointer-authentication.rst
> > > index f127666ea3a8..055d08b0d42d 100644
> > > --- a/Documentation/arm64/pointer-authentication.rst
> > > +++ b/Documentation/arm64/pointer-authentication.rst
> > > @@ -54,8 +54,10 @@ virtual address size configured by the kernel.
> > > For example, with a
> > >  virtual address size of 48, the PAC is 7 bits wide.
> > >  
> > >  Recent versions of GCC can compile code with APIAKey-based
> > > return
> > > -address protection when passed the -msign-return-address option.
> > > This
> > > -uses instructions in the HINT space (unless -march=armv8.3-a or
> > > higher
> > > +address protection when passed compiler option as following.
> > > +Pass -msign-return-address when we use GCC 7, 8.
> > > +Pass -mbranch-protection when we use GCC 9 or later.
> > > +This uses instructions in the HINT space (unless -march=armv8.3-
> > > a or higher
> > >  is also passed), and such code can run on systems without the
> > > pointer
> > >  authentication extension.
> > 
> > I think I'd be more inclined to delete this paragraph altogether.
> > It doesn't
> > really document anything to do with the kernel, and trying to
> > document the
> > behaviour of "recent" versions of GCC is futile.
> 
> Agreed. I think the only thing we might want to mention is that we
> rely
> on the compiler to use the HINT space instructions (PACIASP and
> AUTIASP)
> so that a kernel built with pointer authentication support works on
> HW
> without the feature.
> 
> So replacing that paragraph with something like:
> 
> > When ARM64_PTR_AUTH_KERNEL is selected the kernel will be compiled
> > with HINT space pointer authentication instructions protecting
> > function returns. Kernels built with this option will work on
> > hardware with or without pointer authentication support.
> 
> ... would make sense to me.

Hi,

Thanks you both for suggestions.
I will rewrite this paragraph in v2.

Thanks,
Kuan-Ying Lee

> 
> Thanks,
> Mark.

