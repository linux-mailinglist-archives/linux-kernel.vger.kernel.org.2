Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035723474A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhCXJ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232217AbhCXJ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616578123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIa5MTTbbF2h5i82NLwRCE2FeeKGdQ6mEyVMr3p46EA=;
        b=E3qsDSqadghYwVdxI2X57bKjwpat6JPxPbdldw6M0FETnwwTf26cThVwyQ6o6+LKYbZbIH
        Akrhe9mZJmvuJYDOUlve3lY/lSSlPmjta9vvxHsE76GuEU92o014ctK6lwNRkLHep93lLG
        g5Q6oySE7jIHC91LkGEMYbbmTO47yS0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Gcx75zl2PwWiEtTkgVVUcg-1; Wed, 24 Mar 2021 05:28:40 -0400
X-MC-Unique: Gcx75zl2PwWiEtTkgVVUcg-1
Received: by mail-wr1-f71.google.com with SMTP id b6so794498wrq.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIa5MTTbbF2h5i82NLwRCE2FeeKGdQ6mEyVMr3p46EA=;
        b=uQRVzf1QMynzaAbtHBRT7O7HuJCOqWwICA96P0xNGuWqTViGswkdVFLdyCj3dH2lNm
         ztJuxL/Hv2TeALN6h4LOdJfZf3WEbEHcuh0UWrElOiEH6O8D50ONpclSRVV68OP/4BXP
         2ZPNaDCwddTl00ZuwmcUmp/Q96fuwx7AiU0oaFyBdZRHxn+vKS1+ToXtufFvBzI9iq3W
         OtEzVwtpj2eFX7cSWTF0csBvTSmEOju+6h9iq4dZLs57+1la/WsmtCA6Q534AW/Dqt9e
         tmTKKPpsnEnuAi23ktDvmbffVTMZ+Hwz+ZwyxHJ0Y7D4HmIBbJ3GTOpwMVeuh357BL93
         LsJg==
X-Gm-Message-State: AOAM530DBUY566LPqDeE0QhnhY+brlQJi88iPyy0flNb1rnTckCZyS0a
        josO/oeqXYI/pZF32IawUrT9l/UbylrXLGMA4KNhwKi3Xo/8By5kp2GwhVzEhtdaFJTSahhtThg
        r7hCax26dp5NVWaUukpwexEUc
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr1961712wmo.8.1616578119255;
        Wed, 24 Mar 2021 02:28:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYbWDW+MGBZ81vAKerZL7OP61pFoC017ZeK3TIAR0+ikJWUeuGMb3jeM4vhALe/X4IJ8Y3dA==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr1961690wmo.8.1616578119072;
        Wed, 24 Mar 2021 02:28:39 -0700 (PDT)
Received: from localhost ([151.66.54.126])
        by smtp.gmail.com with ESMTPSA id e17sm2493386wra.65.2021.03.24.02.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 02:28:38 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:28:35 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 6/6] mvneta: recycle buffers
Message-ID: <YFsGQx6XMbYRtBOR@lore-desk>
References: <20210322170301.26017-1-mcroce@linux.microsoft.com>
 <20210322170301.26017-7-mcroce@linux.microsoft.com>
 <20210323160611.28ddc712@carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PFe7S71U15D4cqrp"
Content-Disposition: inline
In-Reply-To: <20210323160611.28ddc712@carbon>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PFe7S71U15D4cqrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethern=
et/marvell/mvneta.c
> > index a635cf84608a..8b3250394703 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -2332,7 +2332,7 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, str=
uct mvneta_rx_queue *rxq,
> >  	if (!skb)
> >  		return ERR_PTR(-ENOMEM);
> > =20
> > -	page_pool_release_page(rxq->page_pool, virt_to_page(xdp->data));
> > +	skb_mark_for_recycle(skb, virt_to_page(xdp->data), &xdp->rxq->mem);
> > =20
> >  	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> >  	skb_put(skb, xdp->data_end - xdp->data);
> > @@ -2344,7 +2344,7 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, str=
uct mvneta_rx_queue *rxq,
> >  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> >  				skb_frag_page(frag), skb_frag_off(frag),
> >  				skb_frag_size(frag), PAGE_SIZE);
> > -		page_pool_release_page(rxq->page_pool, skb_frag_page(frag));
> > +		skb_mark_for_recycle(skb, skb_frag_page(frag), &xdp->rxq->mem);
> >  	}
> > =20
> >  	return skb;
>=20
> This cause skb_mark_for_recycle() to set 'skb->pp_recycle=3D1' multiple
> times, for the same SKB.  (copy-pasted function below signature to help
> reviewers).
>=20
> This makes me question if we need an API for setting this per page
> fragment?
> Or if the API skb_mark_for_recycle() need to walk the page fragments in
> the SKB and set the info stored in the page for each?

Considering just performances, I guess it is better open-code here since the
driver already performs a loop over fragments to build the skb, but I guess
this approach is quite risky and I would prefer to have a single utility
routine to take care of linear area + fragments. What do you think?

Regards,
Lorenzo

>=20
>=20
> --=20
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>=20

--PFe7S71U15D4cqrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYFsGQAAKCRA6cBh0uS2t
rFgiAP0c8Q5ppxzpPYMYk5waAY9QN9APUtx2G3i42vTAQpux1wEAsok6G5Kdb/ww
bYEkrUU4/iizc56IifIQQ8iY05slpgk=
=h2Ta
-----END PGP SIGNATURE-----

--PFe7S71U15D4cqrp--

