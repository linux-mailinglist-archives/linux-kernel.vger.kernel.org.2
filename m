Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38A3B328D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhFXP3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:29:19 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:44995 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhFXP3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:29:18 -0400
Received: by mail-io1-f54.google.com with SMTP id h2so8685031iob.11;
        Thu, 24 Jun 2021 08:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Lpd5za3dZjGLZkNK8IONDaXRQC0MpG6W9WKoTOpJEic=;
        b=c8+z0hYyNafCRk6VH3Bbw52CC/Pjy0w63b9rtTFDvUr/8v3NAo7xjijexCboyV7MKk
         EtkILEqhyVQ3iQAo8fS4gzyo1mc2GT8iPC1CwSwGoYMVzRqwHNIVu5dfCWj0NqD63HqN
         2g7MR6gjDO71Ng22SayLyu+CQSjPn1JxKnz+uClquReJIugl+0PIyaIZSw6ntplfUkX8
         PeStBauwpmu76bFockbkin2bto2KqVPLlgkQ5RiCcwhK9coFYF3BuqyaZEXBnnJ2DOrE
         xf60jBNvZRENLCqEFpyXQ43QEf/rvjDb1LEAty5CV4qXdZzqNlwmV8g95yJW8/blS3CM
         mOWw==
X-Gm-Message-State: AOAM533fQ046n3cweNlfer+sqGLW+HWiAH5TkaCgncPd//EXb2OLuJA5
        mPgRV2J/f/Zd1hgTh7xP1A==
X-Google-Smtp-Source: ABdhPJzNvu/L2aSmJ8pUz8GEkVdEXFN/A4t8nbnJmWO27uA5Fk9oHVl3KzTts6kq5N/hOHu6M5y6ow==
X-Received: by 2002:a02:600b:: with SMTP id i11mr5319850jac.86.1624548418226;
        Thu, 24 Jun 2021 08:26:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r6sm1398859ioh.27.2021.06.24.08.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 08:26:57 -0700 (PDT)
Received: (nullmailer pid 1393286 invoked by uid 1000);
        Thu, 24 Jun 2021 15:26:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linuxarm@huawei.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mauro.chehab@huawei.com, Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev
In-Reply-To: <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624525118.git.mchehab+huawei@kernel.org>
References: <cover.1624525118.git.mchehab+huawei@kernel.org> <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624525118.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH RESEND v6 6/8] mfd: hi6421-spmi-pmic: move driver from staging
Date:   Thu, 24 Jun 2021 09:26:48 -0600
Message-Id: <1624548408.771970.1393285.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 11:01:10 +0200, Mauro Carvalho Chehab wrote:
> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 134 ++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  16 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/hi6421-spmi-pmic.c                | 316 ++++++++++++++++++
>  drivers/staging/Kconfig                       |   2 -
>  drivers/staging/Makefile                      |   1 -
>  drivers/staging/hikey9xx/Kconfig              |  19 --
>  drivers/staging/hikey9xx/Makefile             |   3 -
>  drivers/staging/hikey9xx/TODO                 |   5 -
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 316 ------------------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 134 --------
>  12 files changed, 474 insertions(+), 480 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
>  create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/Kconfig
>  delete mode 100644 drivers/staging/hikey9xx/Makefile
>  delete mode 100644 drivers/staging/hikey9xx/TODO
>  delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.example.dt.yaml:0:0: /example-0/pmic@0: failed to match any schema with compatible: ['hisilicon,hi6421-spmi']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1496456

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

