Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD434B11F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCZVOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:14:43 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:45916 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhCZVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:14:18 -0400
Received: by mail-il1-f179.google.com with SMTP id w2so5701655ilj.12;
        Fri, 26 Mar 2021 14:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p5p8NGReQEBGHa/zB+g9T8XDzJGvpG2p40Wi1X/7yZc=;
        b=Osy3Zf7PpdjwSySgjb+iOAxWpgBG9HE6agLaKCFnMM0olocGJce1ZSbBPIYg1qyXZb
         6GCVmycNmTihJRyNspyBX/53m/6aWhSG0dmVsmU3Ts8SAcOO/KYbuQlpXtFJZrCONg5/
         P0cVdiKZWMDKgSGBGE4GDYWQPQkQvS2z4VGmnyQHfjHHckLbn+MzxESDt/yVpXTZD3q6
         Adxx6JDTr9tl2ctQMEofFve0tqvU10EzPkVHu7YEI4KR2YebWyM6iUitSgWYRAmL+0mM
         1zKDWYF03Z6SUqLKP1zy+ZbCroXim1y+QAb4fnjzHrNwotHngbTDirDiTlU3yGpfdpxg
         V55Q==
X-Gm-Message-State: AOAM531vgMFBYpeNNQ3zDEZjInq7TwOzCIWUPOqLY981fJmekFbJQzJq
        8ilpOdY0VGV4iT4ajq4eZU9wRyIsKw==
X-Google-Smtp-Source: ABdhPJxKyA7A2t6fNdltfGVqtSFmhB2VlJjmuIaVmZOryPpucEWapXabBay+wuooGHaBDd0+8v/sUQ==
X-Received: by 2002:a05:6e02:1541:: with SMTP id j1mr930938ilu.301.1616793257820;
        Fri, 26 Mar 2021 14:14:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w9sm4953775iox.20.2021.03.26.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 14:14:17 -0700 (PDT)
Received: (nullmailer pid 3871506 invoked by uid 1000);
        Fri, 26 Mar 2021 21:14:16 -0000
Date:   Fri, 26 Mar 2021 15:14:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5 (RESEND) 3/7] spmi: hisi-spmi-controller: move driver
 from staging
Message-ID: <20210326211416.GA3867921@robh.at.kernel.org>
References: <cover.1616695231.git.mchehab+huawei@kernel.org>
 <697f26c380dc2c22c07bedc63a0eab8c9325fccc.1616695231.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697f26c380dc2c22c07bedc63a0eab8c9325fccc.1616695231.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 07:05:35PM +0100, Mauro Carvalho Chehab wrote:
> The Hisilicon 6421v600 SPMI driver is ready for mainstream.
> 
> So, move it from staging.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../spmi/hisilicon,hisi-spmi-controller.yaml  |  71 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/spmi/Kconfig                          |   9 +
>  drivers/spmi/Makefile                         |   1 +
>  drivers/spmi/hisi-spmi-controller.c           | 367 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  11 -
>  drivers/staging/hikey9xx/Makefile             |   1 -
>  .../staging/hikey9xx/hisi-spmi-controller.c   | 367 ------------------
>  .../hisilicon,hisi-spmi-controller.yaml       |  71 ----
>  9 files changed, 455 insertions(+), 450 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
>  create mode 100644 drivers/spmi/hisi-spmi-controller.c
>  delete mode 100644 drivers/staging/hikey9xx/hisi-spmi-controller.c
>  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
> new file mode 100644
> index 000000000000..6b755039a74c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spmi/hisilicon,hisi-spmi-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon SPMI controller
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +description: |
> +  The HiSilicon SPMI BUS controller is found on some Kirin-based designs.
> +  It is a MIPI System Power Management (SPMI) controller.
> +
> +  The PMIC part is provided by
> +  drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.

Out of date at the end of this series.

Glad to see the person fixing all of these forgets too. ;)

Rob
