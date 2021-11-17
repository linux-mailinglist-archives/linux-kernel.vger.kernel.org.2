Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954BA4540A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhKQGJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhKQGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:09:21 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144F0C061570;
        Tue, 16 Nov 2021 22:06:23 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id m17so1273823qvx.8;
        Tue, 16 Nov 2021 22:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exxQZeTlLjwyYOEXvP2J7ckZPmIHzoNG3ykObH7i1Jg=;
        b=Xa5f5PaU6GwK+axztDEsAzgk22vSmE794lLj4cFjYWA/uhyo3wOod3NyMQUuDvuN3j
         RjeoTU1HsdGxqm1LlfItecJJ9wBftlAUgQohX9WD01hsqldml9/5T9l7sCi+I94N2jl9
         GKca4147Fl74hQzyY/UGIRKGDkAbjLIUEGRRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exxQZeTlLjwyYOEXvP2J7ckZPmIHzoNG3ykObH7i1Jg=;
        b=u4VaBF8z/LXpJiSIBE5kDlpuWntbwKQggsHM36wLCQQEe17VXjTFVRxyyL4Tv0Xlyx
         6V4ODMOr69H20bsRioDVwuofq+n0+7j8FZExFZXHv2g5w811VZ6vT13TTR9STAoR+Br4
         0zC9PQXfElVjO2VrnMYt5lG7zIrLOBukxikgvXjtxkrzRPx0Uch7fsf4dak8QLG5ECCV
         DN/ouKSBZu5yPnMFPbflFBSUcWdCJQO04BjaA1JOlVhwo2j/7AxUdqwUq72BsAjM6GK7
         vmK1SzvZ69y591OxguuZ02U/BpEZx4kwUsYU4fKn+0+LgdzGlsVFJSgt3KvN0YzV38nB
         WeVw==
X-Gm-Message-State: AOAM533u1PD7cyvFAqepS//iImlEHMgRkzBTe10nIqLtvIb2627isHnr
        igYKSWPGJ7mo+oU8uzmsgwJP6Pw31K11a7Hga/E=
X-Google-Smtp-Source: ABdhPJyy+O6dLRTx7HA3aDStqUGjsNbJahcCfn9Mfvr+JYEnDxr5XxCFJ999s+LaaSrJJJfMSMqhU+u5CKh8Spk7Ztk=
X-Received: by 2002:a0c:eb90:: with SMTP id x16mr52902167qvo.41.1637129182078;
 Tue, 16 Nov 2021 22:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20211117054518.3555-1-tommy_huang@aspeedtech.com>
In-Reply-To: <20211117054518.3555-1-tommy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 17 Nov 2021 06:06:10 +0000
Message-ID: <CACPK8XdUHZBAwcwT96Su+Fa_nenYSa75vCNpskh864Cvx04y8Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add Aspeed AST2600 soc display support
To:     tommy-huang <tommy_huang@aspeedtech.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 at 05:45, tommy-huang <tommy_huang@aspeedtech.com> wrote:
>
> v3:
>   Refine the patch for clear separate purpose.
>   Skip to send devicetree patch

Thanks Tommy. A few things:

 - Set up your authorship in git:

 git config --global user.name "Tommy Haung"

- The "Add AST2600 chip support" patch is the same as the one I sent,
you can put mine back in your series now

- We should add a device tree bindings document

Can you confirm you tested these changes on both the ast2500 and the
ast2600? How did you test?

Cheers,

Joel


>
> v2:
>   Remove some unnecessary patch.
>   Refine for reviwer request.
>
> v1:
>   First add patch.
>
> Joel Stanley (2):
>   ARM: dts: aspeed: Add GFX node to AST2600
>   ARM: dts: aspeed: ast2600-evb: Enable GFX device
>
> tommy-huang (2):
>   drm/aspeed: Update INTR_STS handling
>   drm/aspeed: Add AST2600 chip support
>
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi         | 11 +++++++++++
>  drivers/gpu/drm/aspeed/aspeed_gfx.h      |  1 +
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 15 ++++++++++++++-
>  4 files changed, 44 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>
