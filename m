Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C6F3ED159
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhHPJz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 05:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhHPJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 05:55:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F8AC061764;
        Mon, 16 Aug 2021 02:54:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h13so22756211wrp.1;
        Mon, 16 Aug 2021 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lCtwN1/Tc6AEDBE9eRczuSHPTW+enb9LWBSg2kwIFhY=;
        b=Mf3YQRamX9s+sXTFIdOG7jDUc/s+1ZxNKTI+YC5bJO8vvn5K2/tvU6nyX5ojwrlkyM
         Aog6xm+y2goyW+kQx/0mbUEY3KQpYq6U6cQQ5KdIx+TFfTMo+vIVJjiymmpxGsfaQjU4
         aKlCMt/MZpO89RXC5dGLA0vzjTpT6YqMLTv7jMMQWhhadYP0NzezdJqth9dkAsRIuiyq
         DBwYoq7f40qMiCyAtEDHpFcyBzQ4m9LHCLfokBuh2Vn2zCLfxnyPtY6Drwbll88dahRX
         rXEW+psxZTwt8OMEZeygYTg/M80hLUlpVndPrdboma49N+6DNIZbqSSKtX8A8yoYGkGB
         0zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCtwN1/Tc6AEDBE9eRczuSHPTW+enb9LWBSg2kwIFhY=;
        b=ssru+U7UDhr9HrIV//+OokrffGRGeGrf7EerOK5Te2kh3cEGWsntxtzuX6dR9s5eez
         TFhKb5KVr9mU4wzU/tOrrKfY8Y7C5AQ0Tw6t5Z8PlvgNVE8irB0QLMHddzD3844jOkA8
         urxzNr4tPHEnZHtHHRuVdpSVxfW7u+ZjFAEPlswHGPoKn2VT8b9p9weCXIDb9ALEgxcg
         Yz/1jSzKOB3hRvK4FfdnzA5K8dgc7/7EQoeDGGZnTqYnN0a7lgu4spWxYgJN2GsNSnk8
         Eih9OxIMShmEK6ZFmpPBfaM3l/Ub2en/JKrxZmMt7Hh4Zg17dzxDBSh588cXlAVWkHRb
         kA3g==
X-Gm-Message-State: AOAM532KAm/ancnsxt/lbHVuYTKThJ2NHDpMQPI7GramoEu91TegJrhg
        tvLpc0joBTsCxfDon01uV68=
X-Google-Smtp-Source: ABdhPJxEBkLsdoiB4/f/6VyMSZEXgGP+mDXXiwj3zbRY5rPxacUVx/03TGH5byc572g+lwuM0/loKA==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr17928711wrq.204.1629107694713;
        Mon, 16 Aug 2021 02:54:54 -0700 (PDT)
Received: from localhost (pd9e51807.dip0.t-ipconnect.de. [217.229.24.7])
        by smtp.gmail.com with ESMTPSA id k17sm10742242wmj.0.2021.08.16.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:54:53 -0700 (PDT)
Date:   Mon, 16 Aug 2021 11:54:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jawoslav Kysela <perex@perex.cz>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>
Subject: Re: [PATCH 2/2] ASoC: tegra30: i2s: Use of_device_get_match_data
Message-ID: <YRo17IKkGYEBUCoe@orome.fritz.box>
References: <cover.1628971397.git.aakashhemadri123@gmail.com>
 <f4e632e0023d90c43b2b927e752585142a9d9c26.1628971397.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L8F5rI6YsatuZvBz"
Content-Disposition: inline
In-Reply-To: <f4e632e0023d90c43b2b927e752585142a9d9c26.1628971397.git.aakashhemadri123@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L8F5rI6YsatuZvBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 15, 2021 at 01:42:19AM +0530, Aakash Hemadri wrote:
> Prefer `of_device_get_match_data` over `of_match_device`
>=20
> Retrieve OF match data using `of_device_get_match_data`, this is cleaner
> and better expresses intent.
>=20
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  sound/soc/tegra/tegra30_i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--L8F5rI6YsatuZvBz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEaNewACgkQ3SOs138+
s6FvUg/+Le8sG7K2DpxH02WiNGwIgYIcgcVqtfbXAP9ATobiDSpjt+ts9oIyA4om
Ztin1Ulmb0GMbDqKcL+A4JmCAmI64mNuF8xWoySoBwyAm/D3TgGYFEpPOcAK3WrR
OTFs8L6MOmi9cq1gnMwXmskz6Hc3yfO+7Fw8o4h1cfPXk4AZVCo18N2wsCCCs6F6
wy5mqQF83B/pTofjdKebUEc8wj+JNq4TIgzsGH5oU5Tf32OpEc1KvKfHvwJ4E1T3
o/n9aNIFy4GrLPVzvKndo/COXm30IEKBjEypnoKEyadm4TwTK6O6jAYrMcJmhHOa
TpblQXEl22hFWeBURaqW1g6IDvvdsR0tOcjWjDI39RTX3LoGcPkEezJd3RPrbkNC
u1djqnemvCpLKiaXCeFqaogw/XG/vWwLt6VUergSs6Vstip5GFPtdXO6+dyUYlKK
Via50ScSCl+G9hxJbJNxglZx4smMcaQdzHvt6VjuUJ3bqGvVkF4ab8Mzqq3SQfvQ
ngcPoahwY2Zf8DldMFfEnMSQ5psj2ClZq0ve04JWsc5Y+nMizLhp0LSvWN7TDCuB
VLTI+xxIQj80imx2ONq44YSx+3dbwf8P2mNaKhFS1viw75KwO4yMcf5z18VX2Nil
fSvXqTmwemWy2GF8YhWDL7GN3MFpCLiwi7vQ1/8dgDT4VG6d5U8=
=5EZb
-----END PGP SIGNATURE-----

--L8F5rI6YsatuZvBz--
