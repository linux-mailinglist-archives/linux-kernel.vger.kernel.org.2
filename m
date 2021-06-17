Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7145E3ABDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhFQV2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:28:53 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:36780 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhFQV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:28:52 -0400
Received: by mail-io1-f46.google.com with SMTP id s19so4764699ioc.3;
        Thu, 17 Jun 2021 14:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WRkbRg9Bf/LCif0asWJibTLvFQ8qESLyCcw61Dt7ZUI=;
        b=PtAuGTxAqQ8Aqjf0zJBT7FZxVR9JokISEjcyk5YgWnVwr+BnxmvVjyZBd2Fz3qyAd+
         rqyssWCqD4pSHWoepaoz3nzdaOXcbQf5yK6aA3TM6+9Le7pAfM21HeWMXhse1fB8kh9R
         Xt3voQcWJ6+88yKV4tZH63WS1eYT9EAdVd0CHj4bhfcG+dyaBtWwXPM1Hi1+jt4NfWFe
         H9iquSC3zZqG1axXyeVqs5ftqhBMCqV0GDcpM/Eakn8IKXDtQgITy5tWUxX0IXkOXRAt
         YxvNMs6y3OV37FXj3xuNR5uyMT1Ak9E5ORb2EGJjHNOMxPp6yXUH2W2gIA2P360YwyMy
         s8Nw==
X-Gm-Message-State: AOAM5336bzuuSyopsRqARnkiLdnLqtl96r9Z8fKttN8VruE6eHeXwJ7G
        QkF1nGCAjtEM9Xv+Zz9XQUN8BlFy4A==
X-Google-Smtp-Source: ABdhPJz2qR9tCm9/RgsjEGUFcsdmjgfskMAzB3MZ0zAiG+SDMl2EubL2S4imr4UV7CvSdcCsKP3zNg==
X-Received: by 2002:a05:6638:168d:: with SMTP id f13mr242927jat.124.1623965203489;
        Thu, 17 Jun 2021 14:26:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n2sm3559875iod.54.2021.06.17.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:26:42 -0700 (PDT)
Received: (nullmailer pid 3336119 invoked by uid 1000);
        Thu, 17 Jun 2021 21:26:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     mripard@kernel.org, robh+dt@kernel.org,
        linux-sunxi@lists.linux.dev, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        broonie@kernel.org, wens@csie.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20210617131005.2416-1-fengzheng923@gmail.com>
References: <20210617131005.2416-1-fengzheng923@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Thu, 17 Jun 2021 15:26:24 -0600
Message-Id: <1623965184.555815.3336118.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 21:10:05 +0800, Ban Tao wrote:
> DT binding documentation for this new ASoC driver.
> 
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> ---
>  .../sound/allwinner,sun50i-h6-dmic.yaml       | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.example.dt.yaml: dmic@5095000: #sound-dai-cells:0:0: 0 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1493498

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

