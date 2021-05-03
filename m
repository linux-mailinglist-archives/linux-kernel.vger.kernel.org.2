Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5AB37202C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhECTOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:14:24 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:35787 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECTOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:14:24 -0400
Received: by mail-oo1-f51.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so1481274ook.2;
        Mon, 03 May 2021 12:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7s2s3tZyx18X3VDJlxOD0a+TrV9NROQWA6AkJr999dQ=;
        b=XuDvh5yGDOfBffqm6T7l6dE3q+6VIarXb6z1uLgESkCwrKoFVIQdtbHxYygq1Fan8E
         jO4E84av1kB5VPk8qPQZsMinAoMRZaGTuqYmFzZqLojx2ATTYHRV/S1ATm54wyDJJjpe
         naxsSx+m4pP9O0STOATSvkJ9fqk3MZ39Mjdnfx++8Bxc1jedw+pv9Y8JnhcTbAVsydBT
         bIkzGkga/zMmfbw6VNE0cNPMk8Zk7MyChhEJfFh+0Kk1ykCxQZs9a5H2w69PcNKAMabC
         cFPDKjpjeM6cglNMhxWb+boxmyMvr8gbHvwemkHfbUJRBcb8TbevwlHCvUb3h7VMH+o5
         U73A==
X-Gm-Message-State: AOAM532f5g4mFK0C7yukywrU9M/KmTJBbtkIunhDnXTfoVel7FTGub8H
        TYHUZuoQNWn6xEcqVDhgTg==
X-Google-Smtp-Source: ABdhPJx9zckXB40q2eEyzx/Iii8u8yS0K5EmIsdw4+W9UMZwzyxXxwkseWanm1WmkCA3MIFaTCgx/w==
X-Received: by 2002:a4a:250e:: with SMTP id g14mr16614016ooa.31.1620069209180;
        Mon, 03 May 2021 12:13:29 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z9sm146478oos.16.2021.05.03.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:13:28 -0700 (PDT)
Received: (nullmailer pid 2217569 invoked by uid 1000);
        Mon, 03 May 2021 19:13:27 -0000
Date:   Mon, 3 May 2021 14:13:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH V2] dt-bindings: arm: firmware: Convert linaro, optee-tz
 to json schema
Message-ID: <20210503191327.GA2217487@robh.at.kernel.org>
References: <20210426164008.20000-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426164008.20000-1-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 11:40:08 -0500, Nishanth Menon wrote:
> Convert linaro,optee-tz to json schema format for better documentation
> and error checks.
> 
> NOTE: This change does introduce a stricter naming convention for
> optee nodes.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Changes since v1:
> * Dropped un-necessary quotes around compatible
> * Converted the method to enum, updated description as well
> * Updated commit message to drop the 'checkpatch warning'
> 
> V1: https://lore.kernel.org/linux-arm-kernel/20210416222518.15801-1-nm@ti.com/
> 
>  .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ----------
>  .../arm/firmware/linaro,optee-tz.yaml         | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> 

Applied, thanks!
