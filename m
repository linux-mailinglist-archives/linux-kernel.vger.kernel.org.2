Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E06043E427
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhJ1OuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:50:00 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43041 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhJ1Ot7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:49:59 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MmlbE-1n6tGe3k8M-00jpfv; Thu, 28 Oct 2021 16:47:30 +0200
Received: by mail-wr1-f50.google.com with SMTP id m22so10753953wrb.0;
        Thu, 28 Oct 2021 07:47:30 -0700 (PDT)
X-Gm-Message-State: AOAM532L5BzT1nRIzFfCsonxIbJTAtgbok4UedA0cn70T3fe24SN4cKh
        WLzo7JTVg8fq1SJUEtGJ71Ruf77aqxue/abVhmc=
X-Google-Smtp-Source: ABdhPJyoVAkAAk4AI83BWc3dKhVnjPD+OR+iyHl9JwP/4ZYST1PD7Ic/FVFx5Kh4Wx0twMESb211U/sUQga85d1YsLc=
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr6283991wrb.336.1635432450567;
 Thu, 28 Oct 2021 07:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-6-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-6-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:47:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2GGbik3r5BCKE2ZCkpFyzv8Q54z_iV84ZJ+kNXYUTMzw@mail.gmail.com>
Message-ID: <CAK8P3a2GGbik3r5BCKE2ZCkpFyzv8Q54z_iV84ZJ+kNXYUTMzw@mail.gmail.com>
Subject: Re: [PATCH 05/13] arm: davinci: remove reference to obsolete BLK_DEV_PALMCHIP_BK3710
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
X-Provags-ID: V03:K1:3m1lLvU3vzv1GtjEpgBZPacc98UpRSke3w41itPj5yzap87g7Bp
 Ll7fJo4uXy7TnI6RNIy77970E5bd6CgPK/wj6bIAjHqn71OuKzrOCjV6L6bM2JEXuNmuugA
 cehGupZvrRpvw+f9aLRJGdwWX7ZgCmh/tlOb94NBI4iwdgmA5mZOgrrXShIFUO7B+Pxz3dI
 blF6dxBB0GVbda1eFBcLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h8vRDikS+tE=:YgnZ6PlCpsRxjoZ1eiypNx
 uRfcyEfWBT8sPWHkJU2BrNtk+biaxHbomes48xSoiHaoaJ9bYlTl4L03tTv6pjaays39hGCvh
 B+NP4+g4w4mgRULhiEnP1/ZDD3P3pzHeADD18dAkPv4BbR09Sjs7FVDetecfZMHUPRgHOVRkx
 vzwWCdYa24xmcm8GsvFlY2FVkXgEW+E9vhYEp1WQsOhhTjAQFfVLVrqCdGmZYMPVfKLIR2vY7
 zp6iTwNK5ptQx2pC5Kvv/bUbycjLVsCltEe/nX6mK5NlgUiS5VBwKp3PUR9iTiyXtVNszuMJq
 0FJIIehRh6c1YMOyX5Wh+/pDx60gOBVPBdXOPsKB8b9A5doaJkyTxXkts7znNTnKhjPpqqoZi
 JsTB9xzfYspFXCQZcNB/SSrbHXwhFoPh+ENR9+uHyHCJQ00Pn2ZpneLjegW5X1+mTy7IvOhBS
 kj1kFXXPv4510w0d5T+DAsg+FEPBbcKU0p0c9DBXoxuhzCu486gxmjRF2wS0gO1NinlBgVfjf
 viVhRXxXvqPMrD2ahILqmVdSif1Fja3sXYrmZsdrBoOcMOpYpQIdqoPhc9RGJhiFVt8uVmrkh
 n4WpXybKm4MDKqhuVBmf4VU/4gURPqdGtgTUjP3ICpf6x7Eb/RZR9WbcYNNfq9y8cSbPInObB
 gs9w+OHj4J6UQVOMFr9hp/2S4f7kGFOWDN3RXBO0lAaIKJKgyvjCnYQbMn2HXCTMbpjBqg479
 Klx/zfOF7cpIvJ8ljBQwWd3Sh1PoBeG4dOLSplfotefH0hktTN17iybtPzmDbxq/U6oamCQ51
 /FJBFRNgjmxLFn4Oj5c0NBUFpaxuNSTDc3anmcZmCflLREuQrs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit b7fb14d3ac63 ("ide: remove the legacy ide driver") removes the
> definition of the config BLK_DEV_PALMCHIP_BK3710.
>
> So, remove the obsolete references in the mach-davinci architecture.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
