Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FDC3B92A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhGAOFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:05:35 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:40702 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhGAOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:05:33 -0400
Received: by mail-io1-f42.google.com with SMTP id l5so7618248iok.7;
        Thu, 01 Jul 2021 07:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=UcGsYoboToTMhhq99sLHVgR7kDyS6L2KqvCfhnRDDM0=;
        b=W9AvaaMS8dJlqzBNf7oQ7reXgnv3T83WQOtdNjRgX57HgNZxi3ItpOIZccAItTAgQ1
         qe8A5Zdxshqi2e6zGmZkU/E1ajH40RIko+siiKLA9lQx/kkJqVWTLMrSrHtFKpPmJw0W
         pyQ9R6rKwHMsDJXGIFKm0VXGhutVuTDqyG3Q5MTufDg4fZnPB7B95EC5HzuK7n2+BVAJ
         y+T6k1pxiBvKxcU7BiDlt+AMiii13WWrLMwmWs1TNcBCtH8shGnGNU6EYmmy6IWN/oW1
         wgzONHbYAOT7G5YFRGcRkp/T3yaouLpxl5YpUgmSJDxE7sqGTOpBmqQ00fuQI0eKn533
         s/wg==
X-Gm-Message-State: AOAM530UTHj+zNe89LR0nJlzcVwDrqhHXd4STD3SqayjaelO85kmlbpF
        cbTUWKHh451ROyPJwrlpLsbhShhrKw==
X-Google-Smtp-Source: ABdhPJxJk5BSMp+3ZujDe2uG20xKYmB9NoQEedsUGUAOdURlUY0ojNyY+yn9NBjzeaJ+CB+8MsHFvQ==
X-Received: by 2002:a02:380c:: with SMTP id b12mr64155jaa.98.1625148180433;
        Thu, 01 Jul 2021 07:03:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s9sm32255ilt.44.2021.07.01.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:02:59 -0700 (PDT)
Received: (nullmailer pid 2278700 invoked by uid 1000);
        Thu, 01 Jul 2021 14:02:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Lin <axel.lin@ingics.com>, devicetree@vger.kernel.org,
        mauro.chehab@huawei.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
In-Reply-To: <8d871e2ccc544d11959c16d8312dbf03dd01b1c8.1624962269.git.mchehab+huawei@kernel.org>
References: <cover.1624962269.git.mchehab+huawei@kernel.org> <8d871e2ccc544d11959c16d8312dbf03dd01b1c8.1624962269.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v10 3/5] mfd: hi6421-spmi-pmic: move driver from staging
Date:   Thu, 01 Jul 2021 08:02:43 -0600
Message-Id: <1625148163.537612.2278699.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 12:31:29 +0200, Mauro Carvalho Chehab wrote:
> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 134 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  16 +++
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/hi6421-spmi-pmic.c                |  66 +++++++++
>  drivers/staging/Kconfig                       |   2 -
>  drivers/staging/Makefile                      |   1 -
>  drivers/staging/hikey9xx/Kconfig              |  19 ---
>  drivers/staging/hikey9xx/Makefile             |   3 -
>  drivers/staging/hikey9xx/TODO                 |   5 -
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   |  66 ---------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 134 ------------------
>  12 files changed, 224 insertions(+), 230 deletions(-)
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

See https://patchwork.ozlabs.org/patch/1498291

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

