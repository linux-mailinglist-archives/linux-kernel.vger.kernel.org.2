Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65D23A2FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhFJPry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:47:54 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37633 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhFJPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:47:02 -0400
Received: by mail-oi1-f175.google.com with SMTP id h9so2584463oih.4;
        Thu, 10 Jun 2021 08:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jqSSo5ZxW4cngaVZ8vIXakfFOsb0Nrxx/7Baa6wZNU=;
        b=Bsjag18bqlWCXg4+phbuvd1w9hJbKiLHucIEiRZJbODnJjfKWGDQbsAsChUIFX00Mp
         0lLuGtFyF+ih0VeTJ0r1TQU9GE3Dmz8GnH+tvPTLBe2t5A29wFSzuF6mlW4apB0aDan+
         0p8f8te+GMS9SfNmHnLzS3LXjFLuVzZviWjGmH6gzUgm18jJDsH8b72MmgoekF1ko0i5
         bT3ZuT1sIA8cYo3t9wpLQgViuiM5ZqBHiLwTnYgnnL2pbx6CcybjpvIYVQ6gF2CmFpVz
         YXlcOamx1cEIjTZXIfpfgcTJaxG7mLL8QYrgLS9gIeXrrMtacCBmPSO3739Mhj3Yq/5e
         PnDA==
X-Gm-Message-State: AOAM530qjrQz/bEH8kiS39bCBt1sy1JU7fsVPokVKKgk0je/hWjlN9QR
        t+5waSMTXu9/NOUa+pOC3w==
X-Google-Smtp-Source: ABdhPJzurAKnW/5A8ES4UdO/j4opb5V8dick44tOpPDgqwIp4RTe7SZTvh+JcSB8rzhoffnoqjPwww==
X-Received: by 2002:a05:6808:7c5:: with SMTP id f5mr3770143oij.111.1623339905754;
        Thu, 10 Jun 2021 08:45:05 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id f7sm589309oot.36.2021.06.10.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:45:04 -0700 (PDT)
Received: (nullmailer pid 1863145 invoked by uid 1000);
        Thu, 10 Jun 2021 15:44:56 -0000
Date:   Thu, 10 Jun 2021 10:44:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        helmut.grohne@intenta.de,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Goud <sgoud@xilinx.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v23 09/18] dt-binding: memory: pl353-smc: Convert to yaml
Message-ID: <20210610154456.GA1863070@robh.at.kernel.org>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
 <20210610082040.2075611-10-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610082040.2075611-10-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 10:20:31 +0200, Miquel Raynal wrote:
> Convert this binding file to yaml schema.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../memory-controllers/arm,pl353-smc.yaml     | 131 ++++++++++++++++++
>  .../bindings/memory-controllers/pl353-smc.txt |  45 ------
>  2 files changed, 131 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
