Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60C53B38D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhFXVha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:37:30 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:44909 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhFXVh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:37:29 -0400
Received: by mail-io1-f50.google.com with SMTP id h2so10082676iob.11;
        Thu, 24 Jun 2021 14:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ssSkZmcRFIuWVzrZF3p+ms6WDNX9rtUCDy4iiIHPjac=;
        b=MLLkPwQcV0ScRzqdfeZXQuOFXVzPliBdA0T9lFh+I83GFbOq1SBe5n8Wzsi6bWmzQf
         uqwOfdcSGEy/9o6A5R0bcMu3KU641eMdvNWUJmDtA4oS2cXNs3I/VvxNcUuP7iESeLey
         otxLJnbdSztRRgaTTqoZb1dAVT2QTwaIr4u/s9fGayG/oi1tL1DY+o8+QjKEJ/miJ0WM
         MJjibESDXM87JWicLqg9rS1FsC5WS1k5+A8cE906tUfRpk32zCoAEZA6Ky/BPeeTtcWo
         B8fbdcu+1+V1OKR+BvfXtJLcBzkm+riMWRqpUDN+rBKD+pEp6+rUweb2ZqkM0aqcz543
         UuIw==
X-Gm-Message-State: AOAM532WiO2v825F2i5y+HzI2nffAHk9yp+HWLAvJgn7TGDXJx1/LqfE
        wc9NdRiJ1c08TTtSb2Eimg==
X-Google-Smtp-Source: ABdhPJxLG5mS/R5Kp70cqPpAfemerqR8JG+XdsktURkXgw56B3TqFTUh2d7/TUWZeX6qNuzTikAyeA==
X-Received: by 2002:a05:6638:3048:: with SMTP id u8mr6388166jak.91.1624570508746;
        Thu, 24 Jun 2021 14:35:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m13sm1985143iob.35.2021.06.24.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:35:06 -0700 (PDT)
Received: (nullmailer pid 2025804 invoked by uid 1000);
        Thu, 24 Jun 2021 21:35:03 -0000
Date:   Thu, 24 Jun 2021 15:35:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, lgirdwood@gmail.com,
        jernej.skrabec@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, robh+dt@kernel.org
Subject: Re: [PATCH v3 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings
 for DMIC controller
Message-ID: <20210624213503.GA2025774@robh.at.kernel.org>
References: <20210618060644.2830-1-fengzheng923@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618060644.2830-1-fengzheng923@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 14:06:44 +0800, Ban Tao wrote:
> DT binding documentation for this new ASoC driver.
> 
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> 
> ---
> v1->v2:
> 1.Fix some build errors.
> ---
> v2->v3:
> 1.Fix some build errors.
> ---
>  .../sound/allwinner,sun50i-h6-dmic.yaml       | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
