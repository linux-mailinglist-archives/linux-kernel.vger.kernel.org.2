Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E948371E37
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhECRPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:15:46 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45747 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhECRNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:13:53 -0400
Received: by mail-ot1-f41.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so5699366otf.12;
        Mon, 03 May 2021 10:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PrYZjc9ZeAaylfGZNHsPJJqtE6OP3ubmNVC/kS3BNiE=;
        b=Naft84R3lcrY9gvrRulE4NDFm7qsLYoR4eluezQUMTF77a7XVrUREsbx0DeQnH1Usk
         5GD0bojrKBkU/Y6o80gvd/tufTfe8fDAjVs40riyeQypW5V8gcb8ENff7rAT7L6VWDoc
         l8eDlfYWZi9AoAFAMVS7xDudNJ4jou98FXx3JnJEjiMXovzvojzphO44g4Pf7hqBdqie
         Z9e/g5pwP7g1IoRTMoMNnbEkrA0Dw2bU2oCk4TVBpo4l+w9cu8ilrOJ2f7B1EHR4ZVaV
         asat4xyRuBKY+u/RpbmsruTVqW9v1UfoCKCSz9KzPDpb+dBU4ZzvzZtiee6g8faIo+CF
         JZqQ==
X-Gm-Message-State: AOAM531T04vTTLYJCP/tz6PJdWD9FiCKfXuWkF/fI9UwaRLFYUNkIRUE
        Fwk3kADjSbvSs7YNEd0oIw==
X-Google-Smtp-Source: ABdhPJxH3dRPJChZ0Za5RQASFcgUFBTFgzRgh2UbjxoGII4egCMhCBnEZJdwXGEhqjqxib3XnQ+nyA==
X-Received: by 2002:a9d:425:: with SMTP id 34mr15825076otc.25.1620061979847;
        Mon, 03 May 2021 10:12:59 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q24sm104460otg.81.2021.05.03.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:12:59 -0700 (PDT)
Received: (nullmailer pid 2028023 invoked by uid 1000);
        Mon, 03 May 2021 17:12:58 -0000
Date:   Mon, 3 May 2021 12:12:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: mtd: spi-nor: add otp property
Message-ID: <20210503171258.GA2027968@robh.at.kernel.org>
References: <20210424110608.15748-1-michael@walle.cc>
 <20210424110608.15748-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424110608.15748-5-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Apr 2021 13:06:07 +0200, Michael Walle wrote:
> SPI-NOR flashes may have OTP regions and have a nvmem binding. This
> binding is described in mtd.yaml.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v1:
>  - none
> 
> Changes since RFC:
>  - new patch
> 
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
