Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0070D38E0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhEXFmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:42:40 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:36819 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhEXFmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:42:39 -0400
Received: by mail-lj1-f180.google.com with SMTP id 131so31965861ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent;
        bh=QO8hFqcu07P1ynRMf85RSJSWW7+2VpiK/m3w1T1JHwU=;
        b=avxDaYN9JSX6gbPPQrDKMyfDlYPMQNWB+0Fy3JH0iIh1O0kje1+BaJh8K1N/ZJf+Db
         2ClnTq6IsYv6+AaoMSlVzzmze9+ZCPDCgScDTho6OYgKxhle9YWKd7Fek16tz2rwOc/m
         ylOP/rXQ/z+Y0OzrqguBgyBb7yhLAv8mCyHTkFfCn87xikDhrreOAY+2Av2Ye0+u1I4l
         m2Bg9iBI+TJNUFkj04LQLosKhtxBGweRBTSWu2MIxsmiH75Svcpkospf03hh1MamSDB0
         Qn7Wanlb2/R6Zd7nk3zJxNEY9AhMQ3VkngJrs8voR0SX9kQZeJaCwN6ozYZS/T+1Z3ZN
         28/Q==
X-Gm-Message-State: AOAM532XBrvEuQKW7HTL5j8TMsMy4+JUO2LeZfa906XHVttp4wESfDgt
        Iq5iQ/yYGbLJhaOgUjmdgc8=
X-Google-Smtp-Source: ABdhPJxJXzwdA/S33XPHO0fffaJihirxWhMPF05rjLvhII+1Bf7wREvGcdXb474yFPCKyNFkmIhiJw==
X-Received: by 2002:a2e:9b97:: with SMTP id z23mr15655579lji.359.1621834869864;
        Sun, 23 May 2021 22:41:09 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id t20sm1623286lji.53.2021.05.23.22.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 22:41:09 -0700 (PDT)
Message-ID: <4189cb2094b4fe43e351eb1d80ca6c4cb1ac08ed.camel@fi.rohmeurope.com>
Subject: Re: [PATCH 1/2] regulator: bd70528: Fix off-by-one for buck123
 .n_voltages setting
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
In-Reply-To: <20210523071045.2168904-1-axel.lin@ingics.com>
References: <20210523071045.2168904-1-axel.lin@ingics.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Z/tvXtdc/nBXr/Xk8oWz"
MIME-Version: 1.0
Date:   Mon, 24 May 2021 08:41:06 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z/tvXtdc/nBXr/Xk8oWz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Axel,

On Sun, 2021-05-23 at 15:10 +0800, Axel Lin wrote:
> The valid selectors for bd70528 bucks are 0 ~ 0xf, so the .n_voltages
> should be 16 (0x10). Use 0x10 to make it consistent with
> BD70528_LDO_VOLTS.
> Also remove redundant defines for BD70528_BUCK_VOLTS.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> I think this fix does not need "Fixes" tag because in original code
> the
> .n_voltage is greater than correct one. The latest selector is not
> valid
> in the linear range setting anyway.
>  include/linux/mfd/rohm-bd70528.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/include/linux/mfd/rohm-bd70528.h
> b/include/linux/mfd/rohm-bd70528.h
> index a57af878fd0c..4a5966475a35 100644
> --- a/include/linux/mfd/rohm-bd70528.h
> +++ b/include/linux/mfd/rohm-bd70528.h
> @@ -26,9 +26,7 @@ struct bd70528_data {
>  	struct mutex rtc_timer_lock;
>  };
> =20
> -#define BD70528_BUCK_VOLTS 17
> -#define BD70528_BUCK_VOLTS 17
> -#define BD70528_BUCK_VOLTS 17
> +#define BD70528_BUCK_VOLTS 0x10

Thank you for fixing this. There really is only 16 valid voltage
settings as you pointed out. Regarding changing the define to hex - I
would prefer seeing the amount in decimal as it is easier to
understand. (I do understand bit-patterns better when in HEX - but
"real world" values like voltages, currents or amounts are easier (for
me) to understand when in decimals)


Best Regards
	Matti Vaittinen

--
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland
SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~

Simon says - in Latin please.
"non cogito me" dixit Rene Descarte, deinde evanescavit

(Thanks for the translation Simon)


--=-Z/tvXtdc/nBXr/Xk8oWz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCrO+4ACgkQeFA3/03a
ocUNzgf/WzIbFrWfqNJSWU3lwmiK+oTqb1gEzPyfcQre72MJlXMyuO8KuV71Z9dJ
jWpID+U/0/WWzmJXOwY00NKhLcUFxsC7kzOCkfd9oCQtiDL1yxGtcEn+1hVkcUTL
08PZ4TWB8K69AyPqM8URtACy7/Yi3b3j4cNj99uVgzbQO71PyMpTXQx4nQsT2eSr
0GNLotITY4KCLBmLN0PsForXF6yrKf3v5BcvGM0mc6cKmGPeHzQzJtCEKQDO7IQk
k2tMZL5wZJ8ftWdMkcJ3di7zNQ+gstSETO12KbI7nxY2wcnyXBiLZAS+BVscZ7s5
eTq+YsBxsLErFrU7lNiHxPZWZ0yURw==
=03ou
-----END PGP SIGNATURE-----

--=-Z/tvXtdc/nBXr/Xk8oWz--

