Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D377E38B7CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhETTsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:48:31 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39708 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhETTs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:48:29 -0400
Received: by mail-ot1-f47.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so15930925otc.6;
        Thu, 20 May 2021 12:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2cqJ9Lm92bfvueGLR5tvGXUavON1VXTGmNbJD+CtptU=;
        b=DK+kFudcJ5Ytynkg0LJ+YbRO0sfCmN7XlbR+5NFohJiiLScR164x8XGDgzpqjlj/ML
         V7S0XZVLi6qLXSEkQCYylpJAw3nRr6KWhmyVssaO6Evt6ZNjdzf/FHBdlarI+MEVTbmB
         nlUSxRtfaNX+tYLxK6JzKHS53z8FgPiJHeFiJge3eCdBAQTKAoCMEkjEfLdIOQsmlOtJ
         fXVYwAhypGb2IOdIrFFhtj9vLmYErFza2HTnz42fL1q04HeF65Z0QkLZXhYJjZHyTfQu
         50LxS+qj1VzI5tGxRtoNVFHNu+gjzdZZLYNjIIc5dh4UFoQq/osJTBFH7q1U6lu4vdLV
         pUBg==
X-Gm-Message-State: AOAM531pPzsjVxj9TQht5Wu6PPHKZZRWDdghO/yiu57yslele8ianVlf
        50OlguZznYaKyj0E4PJLoQ==
X-Google-Smtp-Source: ABdhPJzJjXyZ1VC2/9pFKedH1RRswHevC8vq2DoHe1NWhWt/JyAMDE2wOWuwF6XbpLZQiR1evfVvpw==
X-Received: by 2002:a9d:5e0a:: with SMTP id d10mr5097616oti.44.1621540027673;
        Thu, 20 May 2021 12:47:07 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r83sm714200oih.48.2021.05.20.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:47:06 -0700 (PDT)
Received: (nullmailer pid 1823977 invoked by uid 1000);
        Thu, 20 May 2021 19:47:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org, richard@nod.at,
        linus.walleij@linaro.org, miquel.raynal@bootlin.com,
        linux-mtd@lists.infradead.org, robh+dt@kernel.org, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210520115732.1276569-1-clabbe@baylibre.com>
References: <20210520115732.1276569-1-clabbe@baylibre.com>
Subject: Re: [PATCH] dt_bindings: mtd: partitions: redboot: convert to YAML
Date:   Thu, 20 May 2021 14:47:05 -0500
Message-Id: <1621540025.698388.1823976.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 11:57:32 +0000, Corentin Labbe wrote:
> Converts mtd/partitions/redboot-fis.txt to YAML.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../bindings/mtd/partitions/redboot-fis.txt   | 27 ------------
>  .../bindings/mtd/partitions/redboot-fis.yaml  | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mtd/partitions/redboot-fis.example.dts:19.17-24.11: Warning (unit_address_vs_reg): /example-0/flash@0: node has a unit name, but no reg or ranges property

See https://patchwork.ozlabs.org/patch/1481605

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

