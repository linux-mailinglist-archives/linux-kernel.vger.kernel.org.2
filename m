Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396B93B36F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhFXT2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:28:17 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:33317 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFXT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:28:15 -0400
Received: by mail-io1-f53.google.com with SMTP id a6so9721998ioe.0;
        Thu, 24 Jun 2021 12:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NoZyl7I2VPKHg0pgvo0YIUYxnuiUr9WM9SkizCiTx20=;
        b=Ee3iCRMUzs4P+jq4zYO7JMgLe3ueKL4FcLfIy0iV8w3k7sU+ewJ5WWYMUTLUNPkmgs
         ag8KESqJvaCxXIthCF78UTkCw/OUZSocVPyQKg+4CVcFJBzMAYwMs2Fx7YN+V0WtTJTg
         er/D6FyPKUfQrnKeMYP9yn9RQFB1w/GJKXpZbJi7Fj6kgIBxW7NNpEs/U/oCCGxU7xuS
         2ofa9TY3pSfYLcenvfV3EEya20GewqWgiX5CSBHwQnAxFTRYymo1tlkw1qz7CPK10HxG
         o5tpTbgG73ce2PSUzOhRuh6IbWDJ2U75YHD5Aw0/q5Wa8GwRwjcbjSiZ9tYUSxlkSFxJ
         cc1g==
X-Gm-Message-State: AOAM530hfkFUYopGhDoNC8cvuPS2FUPuvKNp8k6GsfVwjAzfpCokpQnm
        O2Kidofhk2GcTTJIVN9iTg==
X-Google-Smtp-Source: ABdhPJzKsufdMFQ+g2G0z/mqJGLryywRwswrkQweoArzJGVUVEOJFEtTLx5vrHidP41PyLW6PeLHgQ==
X-Received: by 2002:a02:1988:: with SMTP id b130mr6098925jab.44.1624562756222;
        Thu, 24 Jun 2021 12:25:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e14sm2243361ilc.47.2021.06.24.12.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:25:55 -0700 (PDT)
Received: (nullmailer pid 1845973 invoked by uid 1000);
        Thu, 24 Jun 2021 19:25:51 -0000
Date:   Thu, 24 Jun 2021 13:25:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, yong.wu@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, maoguang.meng@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: mediatek: convert mtk jpeg
 decoder/encoder to yaml
Message-ID: <20210624192551.GA1845918@robh.at.kernel.org>
References: <20210612031853.3115482-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612031853.3115482-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 11:18:51 +0800, Hsin-Yi Wang wrote:
> Convert mediatek jpeg decoder and encoder bindings to yaml.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../bindings/media/mediatek-jpeg-decoder.txt  | 38 --------
>  .../bindings/media/mediatek-jpeg-decoder.yaml | 89 +++++++++++++++++++
>  .../bindings/media/mediatek-jpeg-encoder.txt  | 35 --------
>  .../bindings/media/mediatek-jpeg-encoder.yaml | 80 +++++++++++++++++
>  4 files changed, 169 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
