Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6383AD625
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhFRXvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhFRXvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:51:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6001AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:49:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x73so8921501pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1LjPznQ/uIsBDTfnzklraJ3U4KjBtmygs7CsvfkuOpE=;
        b=DOvQjNeS+IMvZE3V2rm/bsTOIE2+ElVWYpXBZFcbc3+qR4DzP1GrEt9yKpj0PRQqM5
         QK21+zJTSoN1Btb1LpXsZEUBLD482NwV90tCJzDecrk9yRXIR7/iS40hHtUX6HWl3Caq
         KqA7e5DTfGdu/IRPBaotih4QTz2Uw9/rrROpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1LjPznQ/uIsBDTfnzklraJ3U4KjBtmygs7CsvfkuOpE=;
        b=a1nM1YqCUO1Pd6PhSYDVwzCAB8c6qOvGdCQ8ldo3Fj6JOJeSwFP24ezemBAgZ3V5ZW
         B5IyoGVGFy8+b8gj7+7PRGtOlDNo97NW4wZiOSxXDAqFKo1yEbtl0Ebw9O6iWsDEh1Td
         D8rkyxVK8GqKQh7K8DoiNyVeDck0QPADHsxdKo1YacuqPjt9kxaivG8WkODeGzHG64xO
         Z8cU0/RR7zWJAUK0vik1Gg5bsol2YHFN34qckg+/k/boB4tcTIfJLFqfH2Er0/YPJDUd
         wpvy6HIo9JPfd8A+LVhexOXSOS9pve0Wm7lua0K7k7XuSde9AegjfPxRff+eCTsJmX4Q
         kr1w==
X-Gm-Message-State: AOAM531v2Gy7DR6tDK+JVcdIGchq37zYbSOG7UZAwIsMj+WgL+N546KE
        M2El/fHELoGFnfNuqKCwq+7L+A==
X-Google-Smtp-Source: ABdhPJwZim075DfvinUYZnIyBpgJHTRdBHlySZ9Lv5z4lp07rXwavP5/Oq5awRv5qpMc/S7ulDSg/Q==
X-Received: by 2002:a63:d47:: with SMTP id 7mr12346532pgn.339.1624060177005;
        Fri, 18 Jun 2021 16:49:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b1sm472127pjk.51.2021.06.18.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 16:49:36 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:49:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org,
        Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: nx: Fix memcpy() over-reading in nonce
Message-ID: <202106181648.0C5FA93@keescook>
References: <20210616203459.1248036-1-keescook@chromium.org>
 <87zgvpqb00.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgvpqb00.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 04:08:15PM +1000, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > Fix typo in memcpy() where size should be CTR_RFC3686_NONCE_SIZE.
> >
> > Fixes: 030f4e968741 ("crypto: nx - Fix reentrancy bugs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks.
> 
> > ---
> >  drivers/crypto/nx/nx-aes-ctr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/crypto/nx/nx-aes-ctr.c b/drivers/crypto/nx/nx-aes-ctr.c
> > index 13f518802343..6120e350ff71 100644
> > --- a/drivers/crypto/nx/nx-aes-ctr.c
> > +++ b/drivers/crypto/nx/nx-aes-ctr.c
> > @@ -118,7 +118,7 @@ static int ctr3686_aes_nx_crypt(struct skcipher_request *req)
> >  	struct nx_crypto_ctx *nx_ctx = crypto_skcipher_ctx(tfm);
> >  	u8 iv[16];
> >  
> > -	memcpy(iv, nx_ctx->priv.ctr.nonce, CTR_RFC3686_IV_SIZE);
> > +	memcpy(iv, nx_ctx->priv.ctr.nonce, CTR_RFC3686_NONCE_SIZE);
> >  	memcpy(iv + CTR_RFC3686_NONCE_SIZE, req->iv, CTR_RFC3686_IV_SIZE);
> >  	iv[12] = iv[13] = iv[14] = 0;
> >  	iv[15] = 1;
> 
> Where IV_SIZE is 8 and NONCE_SIZE is 4.
> 
> And iv is 16 bytes, so it's not a buffer overflow.
> 
> But priv.ctr.nonce is 4 bytes, and at the end of the struct, so it reads
> 4 bytes past the end of the nx_crypto_ctx, which is not good.
> 
> But then immediately overwrites whatever it read with req->iv.
> 
> So seems pretty harmless in practice?

Right -- there's no damage done, but future memcpy() FORTIFY work alerts
on this, so I'm going through cleaning all of these up. :)

-- 
Kees Cook
