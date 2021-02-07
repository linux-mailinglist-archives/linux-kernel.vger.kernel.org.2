Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3504312859
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 00:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhBGX3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 18:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhBGX2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 18:28:33 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C264EC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 15:27:52 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id v3so9245137qtw.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 15:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=u7G/hFOAnHbS4sYv+AEKOoZxVRfU3Rzrd0mY9zx+N9I=;
        b=V5PqZJ+jJ+LwqgEBUuqUXH/UAqX9a1Sd527G0+++w69uzEviEg+if9Jya9YeRWbs3u
         ZQAB94N1C54R1fc29DLrAaTQZShCWZ2fNH09kmYUAX4ycINJ8Ni5MpyTNGND8YfEduLc
         9WReRfz3AhaxuUHDCJzi4ym1NYVKuUY0fekl9z30mEGpGNdMQ9NX44BvLNmdsJvA52RF
         5dY3gIW/iTYHfyxeNhp2ohS/rEe7+dfs1pZdA02He4G13Iyag3sg7ZYEp/oXDIexb4vu
         HadxGo1URcWCBhrfx41TiEySq4cXf5NVUIenyyK/s0IbOTWUyGBrYyTKGSLraKUYCwVM
         urkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=u7G/hFOAnHbS4sYv+AEKOoZxVRfU3Rzrd0mY9zx+N9I=;
        b=ZumLb7Ce1DVN8A3AMULAK0wF04jgc/9KllkwoWRGm+YDKv/EPDvK/RcweJQet1o0qU
         DLTtK9jgnTaCeX8EmIhUH/N0uIOD1ipsH552yxT5cQsyCJeKEO1jIRxKwIDfXCniLNRU
         KPNZ81F4JMK8jQeA8FIvaxA82zJ4aff2UP9F3AHUOtyLDx6soSoZq/SavROeDoEK9dpm
         OHCCefEwZ5TkCzov4O+eh39k2e1bhT0clTSIlD3TVr/FqfeDzExO3zfNxYQSXGPm1cne
         juyFBifSjQeVJiDtgWnTGBezHJ3NUaPQ1g2FdeBzBl50H2nhCqGq0i9mq3O2Y+5nhmFf
         OMCg==
X-Gm-Message-State: AOAM531iuZvaznUXluYiK0OED+v3HlLdv5mEuF2nuGpynfMIDnkhD0Td
        Z14r6ohgqwKjpal9sVWVgiw=
X-Google-Smtp-Source: ABdhPJzwSz6kJ2CYDZOKvNxoAEBMUAd4fTdEtZa6VjRv3yFBdpk+zx3QoVt0TuymUx8chHGd6DTiSA==
X-Received: by 2002:ac8:5c44:: with SMTP id j4mr13363315qtj.124.1612740472082;
        Sun, 07 Feb 2021 15:27:52 -0800 (PST)
Received: from OpenSuse ([156.146.36.180])
        by smtp.gmail.com with ESMTPSA id r44sm13520853qtb.28.2021.02.07.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 15:27:51 -0800 (PST)
Date:   Mon, 8 Feb 2021 04:57:45 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kyle Huey <me@kylehuey.com>, linux-kernel@vger.kernel.org
Subject: Re: [Linux v5.11-rc7] x86: entry: Leftover of _TIF_SINGLESTEP define?
Message-ID: <YCB3cd/XjYnoOBxE@OpenSuse>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>, Kyle Huey <me@kylehuey.com>,
        linux-kernel@vger.kernel.org
References: <CA+icZUUhzpmoD_XrHtnFUGSpXHrVOTnVG9Q_Tek8oA8isHZe=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5GI/9lfadYPWd2hK"
Content-Disposition: inline
In-Reply-To: <CA+icZUUhzpmoD_XrHtnFUGSpXHrVOTnVG9Q_Tek8oA8isHZe=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5GI/9lfadYPWd2hK
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 00:08 Mon 08 Feb 2021, Sedat Dilek wrote:
>Hi,
>
>congrats to Linux v5.11-rc7.
>
>after commit 6342adcaa683 ("entry: Ensure trap after single-step on
>system call return"):
>
>$ git grep '\_TIF_SINGLESTEP' arch/x86/
>arch/x86/include/asm/thread_info.h:#define _TIF_SINGLESTEP
> (1 << TIF_SINGLESTEP)
>
Does it failed the build???

Just curious??

>Is this a leftover and can be removed (now)?
>
>Thanks.
>
>Regards,
>- Sedat -
>
>[1] https://marc.info/?l=linux-kernel&m=161273724611262&w=2
>[2] https://git.kernel.org/linus/6342adcaa683

--5GI/9lfadYPWd2hK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAgd3AACgkQsjqdtxFL
KRWSdggA2+Pm1AGeBFLwT2e4oT0yjC3aKGGN2ElV6OT7AM3S++R3+qind/21Lewr
IYVuWRTWdayEmnvp7nIUQbquKPXBiuYJ7cHWzpD5jNcd6ejD9C3FaeGTvsGE8XYx
J80LTSjDtztfAOcUZ/NCHGT7E/drbIbxqYhN3ZmznUMT9SDmikit1xlFd7IUWoyO
W95UWLdOPD+96RlckM9vUa44pGx1jmKXFTFqOr5ex27aRvcWGXqJkabKbLxeiQF/
fwry6CymQjthoxOzB1XD/PI/PqJfy8sD6yUize3aTqnO2Vg+4CrjJqFG35g669AR
+yC/HjdaYwbzrqP41s7V7FDhN1eIuw==
=G7ru
-----END PGP SIGNATURE-----

--5GI/9lfadYPWd2hK--
