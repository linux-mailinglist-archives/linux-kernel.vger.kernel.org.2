Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7599C4336A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhJSNHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:07:13 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC343C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:05:00 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so1856334otb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ajEhiZu8sdnzA3D+QyFwiSVeRq1/0ZFz6G1ykAePus=;
        b=ehdkqv0aEnLexGDvcX1MwhetXLhs2b1DnZeEHNFYbZWKd1YDw2jV/2FsBd3jUaKT1j
         LOGfZV3iVjteKR5JHoB3XRhuwloYGrhJTjWq4WwvPW4v/wSEdCJ11tmxbuS2usFPpiSE
         dDvFxikkI+uMo5ZzkBLD4T1BH1dtSmpe8o82XB+6grOcifAjQNIErkt+nQRpa+Y5fG3q
         J1M6+JKj+iQHNlNuVfcuTWkMxa8m3XWF2qb6A7q98ldk9ytGa2IvoFbNaajPSyu23xY7
         CspdEk5EV1c1pOQ+8+T/Vqw5iPDBg2ieVvynNvU+LH9cXoLmBdZ08tepLW7GITQjC9Qa
         OQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4ajEhiZu8sdnzA3D+QyFwiSVeRq1/0ZFz6G1ykAePus=;
        b=jaP/Fjt18v8uXGVEOAAelndxAK/x4xNb+tIkIJIjRdN18N8Nn4T+Oo30VwVko3d318
         2suH8ZVmFnyI8URdHqMXeKVT36rKS1YLtrZYYir7bjGj7ffdnzAPij5+uc10uK11A/2Z
         GvwkhfAA0pmNr8il6Gv1bGFDauQBjfBRQGN2c7D08PqHBTzBaoiznYYDaId6vND0Oo52
         poLwXJCFVyi4Jei8j1McdmsoGY24L13sRbUZ0DujfmWTfeu9AuHm4dI9r65t5zfwjyih
         7krKEtQSbO2Yv76gH9heZ+FG2qL9cK3cRzRVVxGx4xKNgB6UX84a9UKAzJcETH9hve58
         Smig==
X-Gm-Message-State: AOAM533qm3QG0ae64nmggrVaC8PklBmXSn0s83fAQoaNfus+KhQCxigU
        qqpfDlK/SPZn/pnlrDcotTGD3A==
X-Google-Smtp-Source: ABdhPJwXqTvwbTQHuUz6gJlZnzQAwib+0zR9p+SRK3AhzyjBcG3mGp9iQbFIoNScm/6k0pJOFQKaCQ==
X-Received: by 2002:a9d:12f4:: with SMTP id g107mr4968322otg.77.1634648700240;
        Tue, 19 Oct 2021 06:05:00 -0700 (PDT)
Received: from winterfell.papolivre.org (winterfell.papolivre.org. [2600:3c00::f03c:91ff:fe69:3960])
        by smtp.gmail.com with ESMTPSA id h17sm1465168otm.69.2021.10.19.06.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:04:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14d:7224:863b:8aab:99a1:213e:7f96])
        by winterfell.papolivre.org (Postfix) with ESMTPSA id 2362E1C2F41;
        Tue, 19 Oct 2021 10:04:57 -0300 (-03)
Date:   Tue, 19 Oct 2021 10:04:55 -0300
From:   Antonio Terceiro <antonio.terceiro@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH 5.14 000/151] 5.14.14-rc1 review
Message-ID: <YW7Cd7c8ycqditff@linaro.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>, Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20211018132340.682786018@linuxfoundation.org>
 <CA+G9fYtLTmosatvO8VBe-RDjEHEvY01P=Fw5mvRvwbxL31ahOA@mail.gmail.com>
 <YW5iBGg4VKP6ZL+O@kroah.com>
 <CA+G9fYv3mpZMZjoarc6=WNNzrer+xFX_diqVKMy1VFV=xhKpTg@mail.gmail.com>
 <YW5qHvEHtkxCwOBh@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pGcdEnaB5gTxgpS7"
Content-Disposition: inline
In-Reply-To: <YW5qHvEHtkxCwOBh@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pGcdEnaB5gTxgpS7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 19, 2021 at 08:47:58AM +0200, Greg Kroah-Hartman wrote:
> Ah much better, I had an older version of tuxmake here.
>=20
> Now it fails with an expected permission problem:
> Error: writing blob: adding layer with blob "sha256:10348114f214e2f07f30f=
a82aaa743c1750b2a9025cc8bec19f3f4f2b087a96d": Error processing tar file(exi=
t status 1): potentially insufficient UIDs or GIDs available in user namesp=
ace (requested 0:42 for /etc/gshadow): Check /etc/subuid and /etc/subgid: l=
chown /etc/gshadow: invalid argument
> E: Runtime preparation failed: failed to pull remote image docker.io/tuxm=
ake/arm64_gcc-11
>=20
> Note, I will not run kernel builds or random containers downloaded from
> the internet as root, sorry :)

Note that podman does *not* run as root by default=B9, and that's why
tuxbuild recommends it instead of docker. What it does need, is the
ability to create an unprivileged user namespace. This includes:

- having the `kernel.unprivileged_userns_clone` sysctl set to 1

- having enough UIDs and GIDs in the /etc/sub*id mappings, which is the
  error message you got is complaining about. Just having the following
  lines should be enough:

  $ grep -H terceiro /etc/sub*id
  /etc/subgid:terceiro:100000:65536
  /etc/subuid:terceiro:100000:65536

  On Debian, those are added by default when you created an user
  account. I'm not sure about other systems.

=B9 by default in a podman container you are root from the POV of the
  container, but uid 0 in the container is actually mapped to your regular
  UID on the host system.

--pGcdEnaB5gTxgpS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEst7mYDbECCn80PEM/A2xu81GC94FAmFuwnQACgkQ/A2xu81G
C95+Bw/6AvPUXXfFUqHc6A6p71A/pVpQ+GDaesc5PzAKcZn82sqA7ilvQbO/Vv2/
puB48VUZx+ykOcwQzSl3KJ4gOzlacDSP+psl6kJZdPZGVSaLurKMCLHDGgps1G/U
EAiqRuczL2bs+lTlIT9+yTXIu98xpVlZfxA11lAt6dCbbq5e/Da+zqLfyBFgXd1l
JxgK2FXyq4FYXoCkiWyoHnOAZM5v3HAQX0FPGk1WBpIplOAWomBPjQ3AFiWGW71P
Y0Np7l5RBiy+Rzab90EFhmKF+Z0K1t9NJRg2gqs7ffqW7cwCMMzhyoK4WQ957rEG
2ztwkAiTY1T51Ff06DyzHGQxNdCGPJpG3tyjul0H23Cn2TwPxn6cvSJQKh023auk
EPUT3GuYmcb73kmKDTT6PsgYZYF1xlDtHUoniWY/DtXUvIcthskmRHuYTdRbxIdM
Pr9MzxYMgSmSgVQ0XU3dYvbI+HMgEY1ZKyHhmu1ezDt69Bxez2li9qWfBT6A/zJO
jS6Z74LCCCglKKDPpAy2hjDf1/krTSG/RpZ7vt3b5m1hZr2vvekygJP5qLRlxtPF
R3NK3qFDE2Tm/BMIILTloJ3g/8Kam7oXmRr2aqrPw2kFJNJvuJQL4vG9ZkAdDTUP
znkAIu815pWAjYJX4c/Shqg4wWKEv7owJHXGNCiwXNGxEK4bg2I=
=7vLn
-----END PGP SIGNATURE-----

--pGcdEnaB5gTxgpS7--
