Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944EC315BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhBJBNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:13:10 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:39449 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbhBIWYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:24:43 -0500
Received: by mail-yb1-f169.google.com with SMTP id k4so15158ybp.6;
        Tue, 09 Feb 2021 14:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4U2uo28DRfOOEdpoc6H5T9KDb4rD1DuSo0Z2cCk8Ngo=;
        b=ZbjcXwSnHCY3x7DtOcn4W8wN03eeeuJ4wC3QFLCUkd/wNHevwwuf9MCfPZ5mVGSCRR
         GpdmF5SGV2AVUZnHm2MT8sUbaupiA+8SL0YVZ9MH8DP+6zIm8/FIk8ylAUyrJaCRHNv+
         /dehdHjX68i3Lrib1PuEvXXzH4CqFVlZDvQMGb4oP4GooYcliDOf5hc9mZXMVbhCq1b8
         +/o7MMqVs3T5MXRpugVx1ikVMmonOQH0G8QeWjKdfqjxTkFHlNw/FJSsxflIv5EPQ1ZI
         VmX1QwFyBeszXFv8qgq41UBILD3wXKHuDbtcqjmJ0V1k4Ctg38apMdqjeoqv+g1Qlb0g
         fDYg==
X-Gm-Message-State: AOAM531uUVU+BKmoqZFknIueDSaUOLVKmvUpj+sU3qbuLQBFZOIXAPcB
        bQkyB3O7y04avaDtV11qlJ3LnTe0PA==
X-Google-Smtp-Source: ABdhPJwK6Bl9ku5ULbeXp9zDuv2tIt2fil758aM4hsnB7Lgz/dOTAg9MRqdE7CT1mVJDPeE9XQlSAQ==
X-Received: by 2002:a05:6830:113:: with SMTP id i19mr801004otp.219.1612905799863;
        Tue, 09 Feb 2021 13:23:19 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m10sm4610725oim.42.2021.02.09.13.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:23:18 -0800 (PST)
Received: (nullmailer pid 214374 invoked by uid 1000);
        Tue, 09 Feb 2021 21:23:17 -0000
Date:   Tue, 9 Feb 2021 15:23:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: Convert to DT schema format
Message-ID: <20210209212317.GA214117@robh.at.kernel.org>
References: <20210202175340.3902494-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202175340.3902494-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Feb 2021 11:53:39 -0600, Rob Herring wrote:
> Convert the SPI-NOR binding to DT schema format. Like other memory chips,
> the compatible strings are a mess with vendor prefixes not being used
> consistently and some compatibles not documented. The resulting schema
> passes on 'compatible' checks for most in tree users with the exception
> of some oddballs.
> 
> I dropped the 'm25p.*-nonjedec' compatible strings as these don't appear
> to be used anywhere.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.txt |  91 ----------------
>  .../bindings/mtd/jedec,spi-nor.yaml           | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> 

Applied, thanks!
