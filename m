Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A213A4618
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhFKQFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:05:22 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:43567 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhFKQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:04:25 -0400
Received: by mail-lf1-f45.google.com with SMTP id x24so3655576lfr.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cTgYop9NFZ0qyAjdKFalLsNoJbK6hVndemtwl7l5Ok=;
        b=JI+g1YiYzhV06je+UJHtI4hG3GnxkuzxgymgJDwaeWA6WGD2qXUyRj1NOBlwnKuyTd
         NaPkND+luK7G0qt+yz8ypcgXRq7rKjgstB/RCNkCODwAPj1YApFLufh5S0QBvekiKtX5
         97Nw+Lmo2DmelofysTIDQKdXUYR22ffH2MAzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cTgYop9NFZ0qyAjdKFalLsNoJbK6hVndemtwl7l5Ok=;
        b=jt3Dca7Y85thvWFMlXpAa4X6xrL4Y6/rsuHdfKw9WPnFhlR3Ef75ZH5kSIwoFdduLM
         j0Tor0aTEZ6Elhd7hZMG0xlOlpdKA6r5uhyRN4Tco38e2XqYxdJgHhnY8pDxEy7EuKr7
         fu5mKY5JajbLvrPuvLkzPAKsJv5K5jvdm89QK6iqo6SeCeFCBk5E29XspZ0mV39LuDlr
         ejUDK9TIDSHR7FHAPv3MX+EgUm+LF1NYu0uCj9mOssEdnMnszVQQrZFesBx7igswT8cD
         77kRYrhN3OVHlElBsTmR/szVmjcuTlA1n2Zkgt0Gv8q4r9aCBDHAuFExsHTXwS/+QsMl
         Fw8A==
X-Gm-Message-State: AOAM533HDG/wK2bhAt3QywUzSs8Yl9zQCLvj95spLaJogueWErOuppU2
        0/Q/tcTLht5VhsGb/45srwO1BlrobnKQ30pQgow=
X-Google-Smtp-Source: ABdhPJwqASJnpOH31QKwgK/uAjJnqeLGw0yc7X0GoRGX8kWfbRYXg4dipAjxSJtDgnPcV6vOsyT5fw==
X-Received: by 2002:a19:c753:: with SMTP id x80mr3092931lff.586.1623427285660;
        Fri, 11 Jun 2021 09:01:25 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id u8sm624875lfq.226.2021.06.11.09.01.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 09:01:23 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id j2so9267341lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:01:22 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr2952000lfc.201.1623427281920;
 Fri, 11 Jun 2021 09:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local> <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com> <20210611062153.GA30906@lst.de>
In-Reply-To: <20210611062153.GA30906@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jun 2021 09:01:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh70m5dYtJcoc3TQtJSp0+AHTuXZM=raBXQVW9CJKG5ng@mail.gmail.com>
Message-ID: <CAHk-=wh70m5dYtJcoc3TQtJSp0+AHTuXZM=raBXQVW9CJKG5ng@mail.gmail.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb) stable/for-linus-5.12)
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Hartmann <lukas@mntmn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:21 PM Christoph Hellwig <hch@lst.de> wrote:
>
> FYI, there has been a patch on the list that should have fixed this
> for about a month:
>
> https://lore.kernel.org/linux-iommu/20210510091816.GA2084@lst.de/T/#m0d0df6490350a08dcc24c9086c8edc165b402d6f

Honestly, that patch is all kinds of strange.

This expression:

    tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
        swiotlb_align_offset(dev, orig_addr);

makes no sense to me. Maybe it happens to work, but I think it does so
by mistake rather than by design.

What my patch used was:

    unsigned long offset = (tlb_addr - mem->start) & (IO_TLB_SIZE - 1);

which actually pairs with - and makes sense with - the index calculation:

    int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;

so that offset truly is the offset within that index. Look at how that
'index' calculation calculates the high bits of the difference, and
the 'offset' calculation now literally is the low bits of the same
thing that got dropped on the floor by the 'index' calculation?

So those two calculations actually make sense. The
swiotlb_align_offset() one doesn't.

It's possible that that swiotlb_align_offset() function ends up giving
the right answer just almost by mistake (because of how tlb_addr and
orig_addr end up being related - the swiotlb_align_offset() expression
might just end up being the same thing - I didn't look deeper), but
even if the result is the same, it's not _sensible_ code,

It's also possible that the swiotlb_align_offset() function ends up
giving the right answer very much by design and because of how
orig_addr works - because maybe the remapping is doing odd things and
using that swiotlb_align_offset() function in ways that make the
*obvious* and natural offset calculation not actually work.

So it's at least in theory possible that my "natural offset"
calculation that matches how the index is calculated doesn't actually
work. But that means that the swiotlb remapping is doing some really
odd things, and then I think the patch would need a lot more
commentary on exactly what those very odd things are.

            Linus
