Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7F3C9299
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhGNU4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:56:37 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:45684 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhGNU4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:56:36 -0400
Received: by mail-il1-f173.google.com with SMTP id b6so2926896iln.12;
        Wed, 14 Jul 2021 13:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jr13OOnV/5xQJZmAAzLknLpGGMlSu87JqZcDrYUOYUI=;
        b=pwZ+8kDL/wgb60OE7EbchY97oju8jCJ6cX01JunJ7kSHxNIVjicceJldp4zA5T9GT0
         jL1PNfRCMAdypRCjthU5DhQF1ZjmYUHsPbAgl5j704paH+CzXgtuftj3HCX/m0cL6NQD
         2QK7ufISo47JqEsLWaPI8u++oWKSVQQphZHKz0u+IKXF19HdnpjUzr9H1U5NmI4fEpej
         h7gcob7i+TR7nDHPxQGLCxVSkbA4v03iS7OMmqsZu9tzKzPS35t4U5iHY/tkVXL0tc99
         SwPGOBg1aj9w21/5GEz0AJBTNk96J/TT7+IF+PDG6f/Eva64bPsj6wZESa7ej9sBD2XI
         0Y1g==
X-Gm-Message-State: AOAM533eRFEZLLjE6PHvOnvVtEWkFHuUOKwNm55nqOtGUeWLF6QHKp2Z
        UMhcAGZFtIfAlgMDIYHeXw==
X-Google-Smtp-Source: ABdhPJz56d6TGksTBsE+Egmj4caxPDuY0YSu77IZ0tPX1ExSHNPhuqc/BGv3+2ro0VauAnkfNAH/6Q==
X-Received: by 2002:a92:d98c:: with SMTP id r12mr8512532iln.304.1626296024209;
        Wed, 14 Jul 2021 13:53:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x1sm1752660ioa.54.2021.07.14.13.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:53:43 -0700 (PDT)
Received: (nullmailer pid 3503450 invoked by uid 1000);
        Wed, 14 Jul 2021 20:53:42 -0000
Date:   Wed, 14 Jul 2021 14:53:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, richard@nod.at, miquel.raynal@bootlin.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2] dt_bindings: mtd: partitions: redboot: convert to YAML
Message-ID: <20210714205342.GA3503393@robh.at.kernel.org>
References: <20210628191440.2823024-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628191440.2823024-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 19:14:40 +0000, Corentin Labbe wrote:
> Converts mtd/partitions/redboot-fis.txt to YAML.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - fixed yamllint errors
> - removed @0 from flash
> 
>  .../bindings/mtd/partitions/redboot-fis.txt   | 27 ------------
>  .../bindings/mtd/partitions/redboot-fis.yaml  | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
