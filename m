Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E761443E3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhJ1Okz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:40:55 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhJ1Okx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:40:53 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MA88C-1mUX1P080A-00BcYV; Thu, 28 Oct 2021 16:38:25 +0200
Received: by mail-wr1-f50.google.com with SMTP id k7so10559064wrd.13;
        Thu, 28 Oct 2021 07:38:24 -0700 (PDT)
X-Gm-Message-State: AOAM533vvxQR5o1K9AjRyMkyFcjVZRiq2jFTPhjA14O8+1aGitlMlb0V
        diAQGoNkoDwDozjELNwxDZjuOB1eBJB40DRA940=
X-Google-Smtp-Source: ABdhPJwEbUzPqw6Qes7yfw3ZhWk6B9QYudD6+r+R+eUXO5VRnI6SKME4aCzk7a7O2pmBiO0ccl6r5d8I2rAIgWwZUKE=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr6346128wrq.428.1635431904641;
 Thu, 28 Oct 2021 07:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-2-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-2-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:38:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2UmTj2imJWdeLHX0TTV36Hk-Xx5c3j8cPe+Gk33-3Tyw@mail.gmail.com>
Message-ID: <CAK8P3a2UmTj2imJWdeLHX0TTV36Hk-Xx5c3j8cPe+Gk33-3Tyw@mail.gmail.com>
Subject: Re: [PATCH 01/13] arm: debug: remove obsolete debug code for DEBUG_ZTE_ZX
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
X-Provags-ID: V03:K1:+vD+Y6ubku5brdTPb5fPvEtLJo4kBMb1i2zNycj4s7DNYnL05ZX
 EMe9TPElIpVSx9nuQ0X0hpS9LmAeAiA/uEi7VzaXD0rcnOc3o//tRqrbeVL4zM+gu0DSrgU
 6nDl5kohOVpXUr2hsfQiRA8WyCBUa/MdlpnK6C6SUJX+/McR9XeME3z2noeix18MijVpjhx
 68rH8YZhQUt+ZcmL50cfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3/atB2SDEQg=:ge8U0HhAxX2zPKM0zKaSRr
 XRGCPFJOACAhmHRnl+MGa/XDzuZdBXvIjPLwDR/bPtWXhgn/I+qfftRLl5d4fl/Y3yrLlHyT5
 0L6hBzi1JH8hqaZBHoetQZfkUAj+YMTP+AGwJfGMWA5PVqhW+d+Og+qHz7uTzCVoh/AQ0/zdK
 WXSiLtSpuqwnkywgnWzy9ymwG7H0NdhmoZikk1FFKPwsjrVBN3z9Ob+epqOy52HGL1HXD4B5G
 C3Awh/FRcVLz8KaZhvRsxG8/viFuSyBizny6FwldNYTfAwRCKzR8wxs9tzE7hbn7Jgvq6vpjb
 v+mTEFEZS29wUJ3Iru5dFFFZjpomeLxRUpBj1T2RInIvDYFgnPEcKV5MuUdjDwFeNG71Rcfnx
 dVqoyksuZXKlYHTo8OfCnZUPAf6/ga4Ras2KwxVsrOEomSl4qO574Heov0qPod+sCaC9woySK
 BcXK5gwZEdMHVy9OtxiTpi1ihNtSYY9Xln6X2ZXVezgvWMB6th4KpRWS6X+4t/5j81llq410Y
 zjcZH3uhdHiw/NxU19IGvobLRbNgcGgcsxR0EWrzdynDg8kfmN8sbAzxTBhjKZb3+YseQvVVz
 kwhqOo2G+w1JPsV63TE1ThzVPCPdTWOaOj+t2X/WfMLVLDyVrSF14bdsE6QLS5YBNWkEWImvO
 pEhW90IZ75Y/28dfabbfCenQv+gz9kr6U4Hwh7MNYugepkXr8SoqtNv4qrnZbxhYPysF5A486
 iUUDvhdYEe5LOdlkJJJz1b/eJUgEjrotkLIyDbJgLJOl2iDZSIFmKwk3darHWMXv4UOS+tGHz
 +pNzFkD8+Kv+sjBKLKfbELfqpxvqErpGLVJ5pfnGoQNOQN75o0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 89d4f98ae90d ("ARM: remove zte zx platform") removes the config
> DEBUG_ZTE_ZX. Hence, since then, the "ifdef CONFIG_DEBUG_ZTE_ZX" in
> ./arch/arm/include/debug/pl01x.S is dead code.
>
> Fortunately, ./scripts/checkkconfigsymbols.py detects this and warns:
>
> DEBUG_ZTE_ZX
> Referencing files: arch/arm/include/debug/pl01x.S
>
> So, remove the obsolete ifdef CONFIG_DEBUG_ZTE_ZX.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I see another copy of these constants in drivers/tty/serial/amba-pl011.c,
which we should probably clean up as well.

          Arnd
