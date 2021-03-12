Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CB338E86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhCLNP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:15:26 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54584 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhCLNOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:14:53 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKhcM-0006Jj-Rw; Sat, 13 Mar 2021 00:14:16 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Mar 2021 00:14:14 +1100
Date:   Sat, 13 Mar 2021 00:14:14 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     Matt Mackall <mpm@selenic.com>, Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] hwrng: bcm2835: add reset support
Message-ID: <20210312131414.GK31502@gondor.apana.org.au>
References: <20210305070132.2986-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305070132.2986-1-noltari@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 08:01:29AM +0100, �lvaro Fern�ndez Rojas wrote:
> Some devices may need to perform a reset before using the RNG, such as the
> BCM6368.
> 
> v6: fix dt-bindings documentation, add patch makings clocks mandatory for
>  BCM6368.
> v5: remove reset_control_rearm() and apply on latest herbert/cryptodev-2.6.git.
> v4: fix documentation, add reset_control_rearm().
> v3: make resets required if brcm,bcm6368-rng.
> v2: document reset support.
> 
> �lvaro Fern�ndez Rojas (3):
>   dt-bindings: rng: bcm2835: add clock constraints
>   dt-bindings: rng: bcm2835: document reset support
>   hwrng: bcm2835: add reset support
> 
>  .../devicetree/bindings/rng/brcm,bcm2835.yaml | 21 +++++++++++++++++++
>  drivers/char/hw_random/bcm2835-rng.c          | 10 +++++++++
>  2 files changed, 31 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
