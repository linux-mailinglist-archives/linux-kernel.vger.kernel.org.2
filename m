Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B899343E42F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhJ1Ouc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:50:32 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhJ1Oua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:50:30 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Ml72g-1n5EIo2mrc-00lR53; Thu, 28 Oct 2021 16:48:02 +0200
Received: by mail-wr1-f49.google.com with SMTP id e4so10642958wrc.7;
        Thu, 28 Oct 2021 07:48:02 -0700 (PDT)
X-Gm-Message-State: AOAM533FlXZ3cpidNE7tV202LPdx9Uyx1v7qkpNghj9reyyi3nRCCVkZ
        Jrk5AftocWmNzUTAHJRE0XBS/NIZ5Cy2zqNxHBY=
X-Google-Smtp-Source: ABdhPJz7TRI3T5WUNkBtx1I3opK6zK4wMD5un05K06gP0B+1Z0NV/fjKsDEnFxUnUXMMXOynp8+ZrPiu5cPB4r2Ft0g=
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr6176696wrq.411.1635432482378;
 Thu, 28 Oct 2021 07:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-7-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-7-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:47:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2JMQvh7RcNaVB9nu0B+1dCHjhJj+aVR0YsfcFrSfFH-A@mail.gmail.com>
Message-ID: <CAK8P3a2JMQvh7RcNaVB9nu0B+1dCHjhJj+aVR0YsfcFrSfFH-A@mail.gmail.com>
Subject: Re: [PATCH 06/13] arm: ixp4xx: remove dead configs CPU_IXP43X and CPU_IXP46X
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PyjS1CKPZFVDqvzxXJknyV0QBicCoewk3XKjRqkqph7nHTjoJPK
 h5iKUYqPAwSsJzdJUUbg3rw8CQldpFAoXf8A9zm42uYUCFDtQ9+c8HD1IdPAHlsli3Bnwf6
 IPpHqPHjPW62OVTv9YbJcwdT12pWc0HA6BnalFz8ZHFAdiJNXpzMYRyWMqjh/7Uz1gjxfRV
 FZ2TCPP1KC3NAGvX678dA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gvpRCAh4F/8=:d8A+er7F3nlzmQYWfn6T+W
 6TKCqrSLTH22LbwADY80lLQnghHQ8XjYXmvcfERpQoTOr+k92VYV47+XLyC5OMfwKiAhtOjGe
 Tdh6+HKz6UkVTjZZrn3VQX4FlXg71cbgk4iK+cmTYrXgczyLBjIgTRRBdtlUwnFZb+/o7mLpO
 hYkbuF7K86jqRV1JMf+bwEOdoADhXKCi+HpC8OyLiDaJQ7+qjIK5Hce3wPmjEl/Tc9UNippGW
 ySDc140BH9jvhSkEdd9+A5LpJP+2INpkBU7j1TVmW0YKSnbNpXfPTdTzqfcMqZtkmavPwTdmw
 q+A4u6CIm2Y5SlOALPbNlKYtC0TpH78WM1K8jK08tq7OS8dxpW0i63Q6r3uFFpw9ijH3th0fF
 qwxqisltA8We/jykY9O1tgXhVXDh+bdy4Pucy4udS5YdHs5GW3o0tNl8RGWZmS8Zl8SuJCKkH
 9JnGQ/XiFYLEzHQpIebAcT3aY04k0OuavyicYgtvuwvRNgjb6x7ZL390e0D6dQTxMKtB8V7DH
 8su12oy+GniIIeRFzK0Wm/Q1GkrN8gOjhEMXSGiJrrYIYmX6WUbOQdtLN0sm0cIPoouG12ak1
 nGLDxjt7DDE/O/kno79Nae4WHHaspIIAWvYloyAZGviUJoyt2IfONzifa39EtqmmVBncUkcwt
 2i2eEX/vh1iYyG/w6ovrBQlsg8YNV6aMnWNUqWBcAaGBVoDsFe9TodoqEBVgOHQMwjK4rDckJ
 L3/ksxHI1k+BKr2aU2T35aTnJFe0ft1MR9Ytwc6/rxIsSB4gOzgqMIPOfhNsAyV/GIPkXnHdl
 9nfK87jsy+Wgs7yRdP7Gg2Iv12/YfpwEcMxKkNPJ/XOL1Em6pkQsFSihMO8O+aju6+6IV3dqD
 wfaYbJWHlcELSg1ERPTU7RCemKWskDzXjAJO5f7mISuY9A1m4vxomLGjsy2QUEJw/dGibC0J/
 7NHfZbk00Zw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 73d04ca5f4ac ("ARM: ixp4xx: Delete Intel reference design
> boardfiles") removes the definition of the configs MACH_IXDP465 and
> MACH_KIXRP435, but misses to remove the configs CPU_IXP43X and CPU_IXP46X
> that depend on those removed configs, and hence are dead now.
>
> Fortunately, ./scripts/checkkconfigsymbols.py warns:
>
> MACH_IXDP465
> Referencing files: arch/arm/mach-ixp4xx/Kconfig
>
> MACH_KIXRP435
> Referencing files: arch/arm/mach-ixp4xx/Kconfig
>
> Remove the dead configs CPU_IXP43X and CPU_IXP46X.
>
> A further quick grep for the name of those two symbols did not show any
> use of the two config symbols; so, there are no further clean-up activities
> beyond this config removal needed.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
