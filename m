Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7AC3EEE8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbhHQOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhHQOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:33:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61D0C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:32:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v4so21816446wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a37LCbVEkNxLKUrYD0zRKJGy9j+UVYaYLWEsO/NBiXQ=;
        b=NeIYr1pKXPoG5o3f40D1sNzE8tVddFcN3DPtoRB/F+cSSqqKb21KhrPOHea9FEEYfQ
         w0cp4CdJxBT5mheHc/OGoFcfxKwTKbywWLwLQFC4A4Pu/SpZalVO/wb02OqxtEGtYt1K
         D2hkfidA2v3dkflycmyc8Y1j3UkOlD7dun8zwxCc8bufUbHn811Bzc4YXJ5mF/PXuwII
         AHq268dAliBz+EZuDesHPNgRI46/UJqzW25bjE4YtW254YdVdZkuHu9u5Mhn/t1vvB6L
         yyXpgPoDzFBMTf/o7nkN3vu/UGPrvyZZD7++QREUGfL9VhZhqZvQR1DWK3FBn+qRj6v1
         JfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a37LCbVEkNxLKUrYD0zRKJGy9j+UVYaYLWEsO/NBiXQ=;
        b=JbnBsiUo7phvjyOf0LeATwRdY6WWNxhkQXBMEmZa97BekomnVItA+8xmDA7XpD/dm5
         /hRQIywJ9pdJU3SPqNRHJKgcyTX4GdQ04+Mhl3JoSOiwqhn3tm4V+Z2DOP1zG22uPGXC
         xQIBVQr9vQ9X/vvHTryBwedFxG0yPHEqxE90AlqNONYnEWgR3X1H0bs+aEymmKWi3Jjz
         WsMQMMkSfTmVWGJLLGnbIVC8JsqxRHk4I5qAzJEOhKZ1SiHp7X0DPHM1FiLiC2X4FijS
         /IWSnEe1eXhc00JbB3h0QVMiEHamIaSUyN85FA9MptTSXOGga5HzEIdQAJmxNddK5uIS
         ytMQ==
X-Gm-Message-State: AOAM533EZVLaQv19yEHahX1jm1F5NcpHw8s+AFsxe9w2vkqdWbhvhfes
        Ig/Ja1o5r+itCTVEbFKgQiY=
X-Google-Smtp-Source: ABdhPJzhxm4IRorxYwCLy29WhrONlMfGRbkXn0aM3UPc/WkBX7x/rwzGhQmxbzsopi/vnePOf6B18g==
X-Received: by 2002:a05:6000:12c1:: with SMTP id l1mr4595842wrx.293.1629210748535;
        Tue, 17 Aug 2021 07:32:28 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id e10sm2601096wrt.82.2021.08.17.07.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 07:32:27 -0700 (PDT)
Date:   Tue, 17 Aug 2021 16:32:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] driver core: platform: Remove
 platform_device_add_properties()
Message-ID: <YRvIeqDsj0dHC46r@orome.fritz.box>
References: <20210817102449.39994-1-heikki.krogerus@linux.intel.com>
 <20210817102449.39994-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QUbHIBi7MbB/4ZWW"
Content-Disposition: inline
In-Reply-To: <20210817102449.39994-3-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QUbHIBi7MbB/4ZWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 17, 2021 at 01:24:49PM +0300, Heikki Krogerus wrote:
> There are no more users for it. The last place where it's
> called is in platform_device_register_full(). Replacing that
> call with device_create_managed_software_node() and
> removing the function.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/platform.c         | 20 ++------------------
>  include/linux/platform_device.h |  2 --
>  2 files changed, 2 insertions(+), 20 deletions(-)

Indeed, no other users, and looks correct, too =3D):

Reviewed-by: Thierry Reding <treding@nvidia.com>

--QUbHIBi7MbB/4ZWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEbyHkACgkQ3SOs138+
s6H/AxAAuGua2VABMRq/2pmhhzblE0JdmbE/10sRo28TmEZAvue42wnuVpRKO31o
TMXDvL0LM0XsFVWo1jm+T1YhhSHzhzKguQFa45t4mcGiKTMyqZ75/SYtOW57Fb7r
Gav1fn4JpNtR2+6AbDlbWT31tt7vGtOkDovlpxGQiBUILzJ5c+JU0/DfnoNR+Zny
O6pdiJ6S/5ODGVpe3OraXozAXOm3tuOmVfy00X6y1i33DLKCiyVgb6w6Ggms3nAo
NY4wtCVTuL04sJQf2rFL/3yIiD8CizV3yvf+c0OReuWO8nupZUEK9+rB29ANHxok
t2x5rybq7vRDwKRGX5ER88lCP/wYkjuMq+qnXzl8ujJJ5GOOFs0QrgwUtPKwKSLY
8TmS4AKASX50HxlMQu260OqiCcM+mWJBGa0xPqEIo98dvQfTxjmvj1ITRUcQrF5k
MxD531OrmzuC4qPW8j10YnTsPkguQaljXfnzLI9aqFHhZBKNkhU/GAjAqGLI48su
MVsIpvPhMORzjNsOba7C7xhNTaEXbnpKq+220E62D9kifErO0VYPyQIjmg7rUKxN
/Fjj4uVmnXDLOGblYuMK3b8nKihPNdQdL5pGfpgBBcXF3SGAZ6T160L8svXEB4NU
p2G7DQNd0f1QtWbm7gwLIPbKE6b8vXhL4y1y7h+tCThZgaTgY7s=
=piGF
-----END PGP SIGNATURE-----

--QUbHIBi7MbB/4ZWW--
