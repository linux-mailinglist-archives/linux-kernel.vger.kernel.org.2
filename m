Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40738367536
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343574AbhDUWhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:37:04 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:40528 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhDUWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:37:03 -0400
Received: by mail-oi1-f175.google.com with SMTP id u16so26640234oiu.7;
        Wed, 21 Apr 2021 15:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g4Lpm6ghFZ2Fk+ppBGhSC5AKie9fH6GCZAqWDABbCSA=;
        b=iLSB4gvB8xc3wHAsNWKEmyjsHQDtw1VZuKpAf9CY2ddB1dmjEF2Yw3NfVgjGCCJWyV
         VgEgwRCSyEJ3lcWD+35nIe41hmIJda6mhQUIUOe9slnfs5TrHgWN2m2cMPC+Onn/h8uD
         wRa7Ft23GcD4IQvvbt2VLgTFDxhKnL9jWU/70vm6depFd+YcM5ZpSp4aVeykC7N44tz4
         jI3I6+coW8cKoRMHCdggZl/JR0sZUT/E7kSImRX6Y6gslfY1VvJgxFzyJVgIF8AYwshX
         KM31pXNnpAKCMeYEpshXqr881nSHr0GPi3o6TPGcVaapv6tCABH9FscC3hHA9idwe13R
         q+5A==
X-Gm-Message-State: AOAM532eRnq7LK1WBx7LR7wbZnjitKPJLmAtO8hpisC9ZBblGuiVll8W
        Qdl/dzFQGPeFwcWmOF7hBg==
X-Google-Smtp-Source: ABdhPJyS8gLXGDJLvxK5P6uC8O0/Y9gKRHm8YJptYiwvw2zpbEOEYkcwVJRtnZsW6ulqWquFL0a0ag==
X-Received: by 2002:aca:7558:: with SMTP id q85mr179674oic.160.1619044589149;
        Wed, 21 Apr 2021 15:36:29 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w2sm202592oov.23.2021.04.21.15.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:36:28 -0700 (PDT)
Received: (nullmailer pid 1740043 invoked by uid 1000);
        Wed, 21 Apr 2021 22:36:27 -0000
Date:   Wed, 21 Apr 2021 17:36:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 3/4] dt-bindings: soc: ti: Convert ti, sci-pm-domain to
 json schema
Message-ID: <20210421223627.GA1740013@robh.at.kernel.org>
References: <20210416063721.20538-1-nm@ti.com>
 <20210416063721.20538-4-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416063721.20538-4-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 01:37:20 -0500, Nishanth Menon wrote:
> Convert the ti,sci-pm-domain to json schema for better checks and
> documentation.
> 
> Differences being:
>  - Drop consumer example as they are documented in the corresponding
>    bindings themselves.
>  - Drop phandle description for reset consumer or cell definition as it
>    is redundant.
> 
> NOTE: we do have false positive checkpatch warning with this patch:
> "DT binding docs and includes should be a separate patch"
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/soc/ti/sci-pm-domain.txt         | 65 -------------------
>  .../bindings/soc/ti/sci-pm-domain.yaml        | 59 +++++++++++++++++
>  2 files changed, 59 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
