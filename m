Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF55326DEC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 17:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhB0Qk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 11:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhB0Qiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 11:38:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE0F364E56;
        Sat, 27 Feb 2021 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614443883;
        bh=1anu053GguZ3XCbvS5ygkoPLcj3znMShlaNgpC+E1y0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jDImAwgbBb0G2bLtf4mpNrG0bqB59IVjn/Yow8DMSA7XYboWNu5rgW6Klarla5vXg
         QfgcSjaoUhXFpv0EQ3b4UtIopuXsHvmnOhUH6KdpS+1Q954foaFnO2SffCUP5tCAjG
         pcBl8et3YvtLUnbyFPNwHpqaltKvU+Ilvzp3kMpVqWRPCqaouSW5rFEMWqhDcVsTjU
         wpshqd/F69k0l9leXDz+AcjW29vr9nrqSymDnuFwygWXplT0tlB+stG/xuozu65aNj
         DK/iAmYWSqo+Y3ojx5d/HfEaLZK/j96CBE9fA3B186Wjdp6FmbDSqGIc9hiCyzD+Bv
         sEwHTXWDuj7Bg==
Received: by mail-ed1-f53.google.com with SMTP id h10so14806962edl.6;
        Sat, 27 Feb 2021 08:38:02 -0800 (PST)
X-Gm-Message-State: AOAM531lmRTH+LPFrzuOwWZL1bQ8j8RQkEc3hhYLGUpYTgYI9ZAcr1Gz
        VZ7Tk+UnTiJIJbxh5WnMFxbj/9AHLj96Ds35M7Y=
X-Google-Smtp-Source: ABdhPJwn27tq6U86eyjNIIhtXjQ36wkwUTAo3xCFwCoCjKkSb8GZMEYA6snPnwlD5dg7TXKUYDdpn2U1z7mIUp+QDVE=
X-Received: by 2002:a05:6402:3d8:: with SMTP id t24mr8768323edw.298.1614443881380;
 Sat, 27 Feb 2021 08:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20200826162954.28636-1-krzk@kernel.org> <20200904082804.GB1214@gondor.apana.org.au>
In-Reply-To: <20200904082804.GB1214@gondor.apana.org.au>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 27 Feb 2021 17:37:49 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfktQY_T0UpsZaGv-gUpyWmfrWVbB1yENEBtcJkZv2WKA@mail.gmail.com>
Message-ID: <CAJKOXPfktQY_T0UpsZaGv-gUpyWmfrWVbB1yENEBtcJkZv2WKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: sa2ul - Hide pointer and fix
 -Wpointer-to-int-cast in dev_dbg()
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sept 2020 at 10:28, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, Aug 26, 2020 at 06:29:52PM +0200, Krzysztof Kozlowski wrote:
> > Pointers should not be printed because they might leak important
> > information about address space layout.  Use %p to hash the value.  This
> > also fixes compilation warnings on 32-bit architecture:
> >
> >     drivers/crypto/sa2ul.c:1486:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/crypto/sa2ul.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> All applied.  Thanks.

Hi Herbert,

I think this patch was lost, although you replied that the entire set
is applied.

Can you pick it up?

Best regards,
Krzysztof
