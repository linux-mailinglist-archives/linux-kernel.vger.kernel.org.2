Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B897843189D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJRMQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:16:07 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44004 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhJRMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:16:06 -0400
Received: by mail-oi1-f181.google.com with SMTP id o4so24021645oia.10;
        Mon, 18 Oct 2021 05:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=o3tDIMhbFnjnaWFNKY8OECJ7Mjc3HAYXOLncYD0rywA=;
        b=o7hJkwPv6G++9HRhIkpG2yoS+LW2Ji/0Y3eUUccL7D0VefcDPRJaUEEV8ZpskqIcix
         GkQywUZTZvzf1k9NKuexTiNUq2I8cFKS7y+LacPurym5ExgluHLy8eA3yx3gkDLR33ey
         D4Kxx9PeNs91fgucG/+CytfyKBUVj/OE4DRVz8Qo8Viv7HOMNtr0qURz6H2KpRQZii5N
         hH/AU0qSobgzT+BJVPQhXZA7+1A5BwXDRQdmnryONYFTvxFLqEAGxgiQG3SAiS0BS9iy
         2k6y7GRUGBQilTH5/UoIjWowOu/hY9RHsb6CLXLoo33bzxAaeujqMHensWhbPeI4oUm4
         BnJA==
X-Gm-Message-State: AOAM531iIs068tN9+dr+RUL4YuKCrcabUj9E0j5nBSWPxASG6hdUifDt
        5Rh3bWo8tfGhDNqJIlqzPw==
X-Google-Smtp-Source: ABdhPJxV7uU4axirSj0liNe2NLPhByiv9fWa6hEbSEpOSjIoe+pp9Fhp6hojMfVWh0viqHFC56vw7A==
X-Received: by 2002:aca:a94c:: with SMTP id s73mr28462897oie.93.1634559234829;
        Mon, 18 Oct 2021 05:13:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s5sm1828281ois.55.2021.10.18.05.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 05:13:54 -0700 (PDT)
Received: (nullmailer pid 2074238 invoked by uid 1000);
        Mon, 18 Oct 2021 12:13:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <1634521033-17003-8-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634521033-17003-1-git-send-email-hayashi.kunihiko@socionext.com> <1634521033-17003-8-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 7/8] dt-bindings: phy: uniphier-ahci: Add bindings for Pro4 SoC
Date:   Mon, 18 Oct 2021 07:13:53 -0500
Message-Id: <1634559233.449347.2074237.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 10:37:12 +0900, Kunihiko Hayashi wrote:
> Update AHCI-PHY binding document for UniPhier Pro4 SoC. Pro4 AHCI-PHY
> needs to control additional reset lines, "pm", "tx", and "rx" and
> additional I/O clock line "gio".
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/phy/socionext,uniphier-ahci-phy.yaml    | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml:35:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml:50:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml:56:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1542355

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

