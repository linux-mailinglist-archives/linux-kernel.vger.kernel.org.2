Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE3B4129A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbhIUABF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 20:01:05 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41516 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbhITX7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:59:02 -0400
Received: by mail-ot1-f49.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso18992163ota.8;
        Mon, 20 Sep 2021 16:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27FPWfQ3xHskA0+KKGpEItqvWnJm7YpWtLApCe/IIEw=;
        b=Rm2OS/AyGCb4j7vNFPuEcXXgM7jxLLckoKlElrcGdvueOd/W3cXNo65BvAbDTDrUkp
         sdb7BpzCKlJY+jxWftOCEarItWbwSHc6RDRWGoq/OYR9+bLrQezwM4AE8gFDAYC723rM
         7TtHCURax3fN8u6Aqtbj4LRZYoVrSu3PAEmevIvzEGpSrTnqRaR4/cmAoR9g2Yct6sTO
         uPXXOC/e71rndGdbbOWJYJ+x/vgRwE4BqzCDg+mF5uxTZM8VygrP8cxr14HRz/p1FTT9
         ykO4r/Pxp8Jc8+bAJgbkB+UiJHXCchQVw5jvvjWCTsUtc9WrPLSF2+4tDaj0XOGBKvbA
         mofg==
X-Gm-Message-State: AOAM530IMmLeJxCwhSMlNEKKU/rBqnUUffGDt/wWKti3p3z8ljMGaA7b
        yi1JEV8qvV3Yn6WrLGpN/A==
X-Google-Smtp-Source: ABdhPJwH1+emzRzbD1Bt/8Y858uJ63SylbkiAwBXBK0v0HNJg8rphZaH6+hhSCA0wMbfVImO+bLvKQ==
X-Received: by 2002:a9d:6206:: with SMTP id g6mr8049570otj.62.1632182255103;
        Mon, 20 Sep 2021 16:57:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 9sm183706oir.10.2021.09.20.16.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:57:34 -0700 (PDT)
Received: (nullmailer pid 1071008 invoked by uid 1000);
        Mon, 20 Sep 2021 23:57:33 -0000
Date:   Mon, 20 Sep 2021 18:57:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     mparab@cadence.com, devicetree@vger.kernel.org,
        a-govindraju@ti.com, linux-phy@lists.infradead.org,
        vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, kishon@ti.com, robh+dt@kernel.org,
        lokeshvutla@ti.com
Subject: Re: [PATCH v2 04/15] dt-bindings: phy: cadence-sierra: Add binding
 to specify SSC mode
Message-ID: <YUkf7SsrR7fw76y9@robh.at.kernel.org>
References: <20210908122930.10224-1-sjakhade@cadence.com>
 <20210908122930.10224-5-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908122930.10224-5-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 14:29:19 +0200, Swapnil Jakhade wrote:
> Add binding to specify Spread Spectrum Clocking mode used.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-sierra.yaml      | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
