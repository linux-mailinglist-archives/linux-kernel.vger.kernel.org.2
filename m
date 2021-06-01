Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38723978A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhFAREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFARE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:04:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44730C061574;
        Tue,  1 Jun 2021 10:02:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r11so18214389edt.13;
        Tue, 01 Jun 2021 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3OxNJ3nDyDbZGwUxl09m4aUtnkmx/1yDxmbuVxbIdWk=;
        b=gvYbSl0qGW1XtlmOXtC9Ks3vnTKxqG94lAjjCjlQC+8XRQ7575qnAcArXxOPUgQhJc
         dz7xzAbqzelzBTOdrEwYgH3xjbLa/vlXEwl4Rn8Gky8R2r04FhErrmizPeHV3IHKt+Ny
         SX6h/mCzkZeRsukAjEWt2dnkPplFM6Z2iI/0CwaqNiF7MPu6pAcosRthms0oy7PhHmqJ
         h8xizyeBOJB34a/NORsEc1dwQJqNc+3DH6QCnojmrFB40sqI8/aUQOekh9NPr5XAaMSG
         lpRHjdVwDKSchQi2tBrTu+Gi9U5xLzgBGNHs7ZREQ7PrRjS/rH7QurTF1ACCKp+8WyFi
         9WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3OxNJ3nDyDbZGwUxl09m4aUtnkmx/1yDxmbuVxbIdWk=;
        b=OkcEdxkyV8FIQ88jSZ7KqVryCIA/+KBpuijnB5d5/pZCnboRzubNXBdZaz5On0zlqU
         XLOgIgbd8mRH2kkSjiatEwko5bMZsYF0IILRnyFS9PyOvAya8ru3a7XMADqTMjIDt0dM
         QaflIy7VW7xPzctRBCpumnLamzgaat6WjmAChpbp/kDTVIKk3UrFKTyVs1z66VVN/p8k
         MYc7f3qrVuS/krpoV/O5iiwibzetDBRFwHaJCM0FASft0rjqW0Xov/DYKnTz6yvWsl3m
         Q9EBzGJun3/VyPy7x1DH5O5nsHpj05szlaOqUr9irIr9VCX2xyTTcJefzcPaSgxI263G
         pj1A==
X-Gm-Message-State: AOAM5309Pe8CRj+ft2Sw+3RdZ0cAfBgkOgi/3z77Hhbkj7VrlgzOrhty
        sRfsV5lwW/GbzmyPG5JUT2tnMoXZeaE=
X-Google-Smtp-Source: ABdhPJwM2GCAH07Ky5ohunRVfuuZojUvQY7nFnHMhRexB1n15I9bqxAUBqtUpAd0QIWXPevljs9E4g==
X-Received: by 2002:a50:eb8f:: with SMTP id y15mr26726181edr.285.1622566964923;
        Tue, 01 Jun 2021 10:02:44 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n18sm447889ejx.41.2021.06.01.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 10:02:43 -0700 (PDT)
Date:   Tue, 1 Jun 2021 19:04:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     linux@armlinux.org.uk, jonathanh@nvidia.com, gustavoars@kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ARM: tegra: Add missing MODULE_DEVICE_TABLE
Message-ID: <YLZok02iEzAlSAh3@orome.fritz.box>
References: <1620792089-16319-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JNdwpf+TO7Vc80Gv"
Content-Disposition: inline
In-Reply-To: <1620792089-16319-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JNdwpf+TO7Vc80Gv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 12:01:29PM +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/amba/tegra-ahb.c | 1 +
>  1 file changed, 1 insertion(+)

This driver cannot be built as an external module, so the device table
doesn't make sense.

Thierry

--JNdwpf+TO7Vc80Gv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC2aJMACgkQ3SOs138+
s6HK3A//aO3KeNg3EQJwAdf9uF70UFHX+vsXc7xGWnRQuDQ7fTQNAJlxC8Rfp1n4
dPiz7rSHSV71cZ3UHMqRm7rTJkGOmynRZUKFI4AxgsbKYYAwUWQCEvSqjEF9RBc1
7vpw4Hp1pY8pQNetxHMnLP4WUNMmfB+2TUYdEBtYMkri2Uy/rfL2TuorCx3YJcE7
DGj2vRKAjYReIdPb8lYbsmWogbr2FbZiFu39a+fTiX1eIkhw4WcXeTkeDV6wbXGU
4VkD26L/PACc7ksMrh/zBzO8mPBikVBeGnDuKVjk96Wx01bXCIspSUgUbAcgnwPB
KmC4J4DuW7tO0ZgF/ufcil8UjQtum8VWxdfFYVuMBz5Ru4XSN0h2PNzCazovdopE
/l7/Ep1qKHaHceLomuioVTj1C07mG1+AsBNbDqW8relaowuk2QZeFH9f5yq3zFH1
puvLzz3+CJx8jBKy2smKcDcAreTSISc/zzYpoT7YHLrGlp/9TRJseeLuH34OR6JB
9IZSHI0eF6S6wm5+bkisx+X/SjamUHIyCIAz1vSBDbWIlSj3VUFU2pmSB84+U4c/
JoVgsjpw5ELUBxagUrKKrKH3Cj0JUlRRUtieCFeAkgqHIhRKoYZ1M0uMz7Z81gWD
yVelgldfTfVyvWROLDt/mmYmVVHp0yo0MI7cmRxpiRWVsxtU0hc=
=lrEM
-----END PGP SIGNATURE-----

--JNdwpf+TO7Vc80Gv--
