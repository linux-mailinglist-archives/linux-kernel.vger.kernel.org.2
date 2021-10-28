Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CAB43E404
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhJ1Oos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:44:48 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhJ1Ooq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:44:46 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MpUlO-1n0oqb2zvA-00pqiF; Thu, 28 Oct 2021 16:42:17 +0200
Received: by mail-wm1-f46.google.com with SMTP id b71so5280119wmd.0;
        Thu, 28 Oct 2021 07:42:17 -0700 (PDT)
X-Gm-Message-State: AOAM530hdB1UavH2d6Z6XLxjrMbnJZvQrT6UV7Y2BvCZg989E+N10JsK
        3Wzb16ytB8eAM9IERImatZX+EeIplNghVQkYvLA=
X-Google-Smtp-Source: ABdhPJx9cbVaNwx+3GHbcHnQXOpN9heQ4JmpWp0Hw9nZ+0Vz+KISvn385FCbSquLcG8jLThOtn8bEBSn4MBwQAn7pDA=
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr1292581wmb.1.1635432137333;
 Thu, 28 Oct 2021 07:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-4-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-4-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:42:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3+-J6XbUmzWs7ATN7z53GomZSj6vq3n5R709=iL45RrA@mail.gmail.com>
Message-ID: <CAK8P3a3+-J6XbUmzWs7ATN7z53GomZSj6vq3n5R709=iL45RrA@mail.gmail.com>
Subject: Re: [PATCH 03/13] arm: Kconfig.debug: drop reference to removed ARCH_MSM
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
X-Provags-ID: V03:K1:wCBMx+HBENwdEVNanSmQ9zpMu8pE+lD9RbEYFLss8aQbl7kLZt6
 a2wk9JodzAGTmpCdw7XQqFKBSjbKWWKtvXQmuMfWTBZUgAGMkl/OAqI/jKwEGUz9J8yLSAi
 tYweqNWMrzWHDb6IChmphJJu6bIdy7kZg9aBy6Wc5a1Bqgz74mQ71b64riFnB17iLpmlWEq
 KZQaheLfjKv5w3bjutYxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mgt+1CsVrGA=:5/F8zFWhHeHQlVaesv4adb
 DxyvCbf0PRMcVwa8Ygyu80p/e5lmqgjNz2QkAkkTYm1Iv3a1v05l6NkvsRK188/+QB3mR66eK
 KvEKly4aOLtokb2Qhb4yH428Ymde9mCq5WJTgma3wMuVNSc8pHYLBvc/tsD3KlerZ2DT3JiEV
 I0tPQKLgsU7SnyuRjTNmzdaTwaC6i4rxZeQSMpUjW22BCmJunt4ZEIdWbM5DJYH04MaQppYnI
 sfQ4uZaRPkjj6qhPERN1K0NwPGMVWv+zfif4l80DOH+mF61By449gpB5rBDcFP7FFR1niOH2t
 8w47gBRDqs8xQ96hBuapzcDzk+5K5yPCyA/P4F/WLakWUhXuxXuGwXyfo02dXLc+cVvuyy2rA
 Q6aGczwxkBOfzP07QqvFA/i65uXN4yiHgvNNngkE/uIUayXcX92ev0VUs9X8jzW9LohWEzblq
 xD5N1KIJFCaJl573/3NusfPiEqBzs1ARuWzfEpoG5fr4nq8dfnGuEOp+a6QRQCVXfjaGiq5lA
 ICTU3At2QC9YUwxvju7LuJmgPp8gx8cx0Zj0YElzX3nsIn2ivMPgy8Y3NWtIEjBuNzTuSMKit
 vHGThSzhZ3COJFBOIYmRNrMLJx4joyMc+WIPc/7dHmHHkhfFteOVouIu7c5ulIXDWD5YNxogq
 TqynImbd6tCYJGvrTr7FibpIzZpZDKQyPK4be0DtiXbCEe6wWirHEUNqanETy37Z/CpcCDTt4
 Cp5CG+oJVHgyiQpgt58VsTx3iGtLV53YqXtmPh05wYQkziS8MU1hKMtzxo9RdMrdbBhGA1z9a
 5aMEpYzXLFZ5EFU5umCzVYObWUMaPFUAL7gluxYp1dzIA4IFTE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit c0c89fafa289 ("ARM: Remove mach-msm and associated ARM architecture
> code") removes the definition of the config ARCH_MSM. Since then, the
> reference to ARCH_MSM in the dependencies of UNCOMPRESS_INCLUDE in
> Kconfig.debug is dead.
>
> Fortunately, ./scripts/checkkconfigsymbols.py warns:
>
> ARCH_MSM
> Referencing files: arch/arm/Kconfig.debug
>
> Drop the dependency on this removed config.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/arm/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 83484564b1d9..87aa6e92ee6e 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1886,7 +1886,7 @@ config DEBUG_UNCOMPRESS
>
>  config UNCOMPRESS_INCLUDE
>         string
> -       default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
> +       default "debug/uncompress.h" if ARCH_MULTIPLATFORM || \
>                                         PLAT_SAMSUNG || ARM_SINGLE_ARMV7M

The PLAT_SAMSUNG reference is also misplaced here, I think you just want
ARCH_S3C24XX instead, since the other samsung ones already require
ARCH_MULTIPLATFORM.

        Arnd
