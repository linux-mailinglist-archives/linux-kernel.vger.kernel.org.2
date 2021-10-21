Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A528C435D69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJUI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhJUI6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:58:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D8A160EFE;
        Thu, 21 Oct 2021 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634806544;
        bh=sGHVGWnjzjFvR3hjiYX7d2YdANy/k/ZCokiW+Te13L4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GhU+jNx6bYr0Blfq7/IqvJUC+7Je8ExsYbsmu220w/ahCCsqt0Jumv1XHGnvren4r
         uVigVFJxzRqa5xsAs3IZIDG++5G8cKEdgJn9oU6Pq6UgEifUZaUbqJ7AFCELD4iKCU
         upPhoO7C97kIsyjkI19hDMgBl8bKW+nHpI5vHIpgH3CkFClK7nHfEc4sgtiVFezWJY
         uZuLPEy6sRyYPu55zbwYXHVaOL7+Vcaq3vlCealgf4MdYsDNT/Xeu0cjtS511qXMIB
         /cYeuBtb/d6qXVUeSyx4OjzlM79NpTTUhlolFp1n0Hrt4B7Phmo5hcpeQLcIHAFkx9
         fZAVq1qOirSWw==
Date:   Thu, 21 Oct 2021 09:55:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, yee.lee@mediatek.com,
        nicholas.tang@mediatek.com, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] kasan: add kasan mode messages when kasan init
Message-ID: <20211021085538.GB15622@willie-the-truck>
References: <20211020094850.4113-1-Kuan-Ying.Lee@mediatek.com>
 <CANpmjNMk-2pfBjD3ak9hto+xAFExuG+Pc-_vQRa6DSS=9-=WUg@mail.gmail.com>
 <20211020152909.2ea34f8f0c0d70d8b245b234@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020152909.2ea34f8f0c0d70d8b245b234@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 03:29:09PM -0700, Andrew Morton wrote:
> On Wed, 20 Oct 2021 11:58:26 +0200 Marco Elver <elver@google.com> wrote:
> 
> > On Wed, 20 Oct 2021 at 11:48, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
> > >
> > > There are multiple kasan modes. It makes sense that we add some messages
> > > to know which kasan mode is when booting up. see [1].
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=212195 [1]
> > > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> > 
> > Reviewed-by: Marco Elver <elver@google.com>
> > 
> > Thank you.
> > 
> > Because this is rebased on the changes in the arm64 tree, and also
> > touches arch/arm64, it probably has to go through the arm64 tree.
> 
> That would be OK, as long as it doesn't also have dependencies on
> pending changes elsewhere in the -mm tree.
> 
> To solve both potential problems, I've queued it in -mm's
> post-linux-next section, so it gets sent to Linus after both -mm and
> arm have merged up.

Works for me -- I'll ignore this patch then.

Will
