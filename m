Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C863A682C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhFNNmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:42:02 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:36630 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhFNNl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:41:57 -0400
Received: by mail-io1-f45.google.com with SMTP id s19so29885317ioc.3;
        Mon, 14 Jun 2021 06:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=UQo+V/Q8ujvQ1+LtWpa/t6KpgRcbSaC4jLowXnhsXv8=;
        b=i9F+SrFn6dLlnXIIYihPzE4v8Vxnc6prvUIDbhXXiKgRPxG1ksJHm7bs6CWbqJWj0D
         0uUQIahyjC1geyimoWz2l5+QWeVLUkZg0LwTfDjC5MMPKmDBAU8uktuU4GUdyFut9Zmt
         zfiL7RwQ4vIFFONCc8XG8dQ4ZoPwBtam+2bVukiiEalMICOmBKZqr8mgviDXvj5PFJ6Z
         AnhR3yXqE8O/RGoRbi0UG+4KNnDujaTSTWPOwcl0Ur55kgGHACmhysQy57IwwDoA4x4i
         a4QzPp1+WUc4YRY1v+3E4f3pBTva5XU9Wsck0MD/NzqIJ2Ulys8/xvY38k+KKxfUnib1
         s+gA==
X-Gm-Message-State: AOAM533r+julw3DeteQnyUl3GkN1edR1jwZZkDAOFnlR38UdPsQIVdyQ
        yB8aRn5zyc+B76wMg37DCSHL2fmIMg==
X-Google-Smtp-Source: ABdhPJwClHKqYg1uOG84hcQcUsrnUnI87mNovKnSC2hVdKLbd4HUa3QFwYc04l6xz7mEXwDGqNywZg==
X-Received: by 2002:a02:6944:: with SMTP id e65mr16771387jac.31.1623677993634;
        Mon, 14 Jun 2021 06:39:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z8sm8677395ilq.30.2021.06.14.06.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:39:52 -0700 (PDT)
Received: (nullmailer pid 630753 invoked by uid 1000);
        Mon, 14 Jun 2021 13:39:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        devicetree@vger.kernel.org, petre.minciunescu@analog.com
In-Reply-To: <20210614070718.78041-3-alexandru.tachici@analog.com>
References: <20210614070718.78041-1-alexandru.tachici@analog.com> <20210614070718.78041-3-alexandru.tachici@analog.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: clock: ad9545: Add documentation
Date:   Mon, 14 Jun 2021 07:39:48 -0600
Message-Id: <1623677988.146956.630752.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 10:07:18 +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add dt bindings for ad9545.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../devicetree/bindings/clock/clk-ad9545.yaml | 556 ++++++++++++++++++
>  include/dt-bindings/clock/ad9545.h            |  69 +++
>  2 files changed, 625 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/clk-ad9545.yaml
>  create mode 100644 include/dt-bindings/clock/ad9545.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:115:10: [warning] wrong indentation: expected 8 but found 9 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:118:10: [warning] wrong indentation: expected 8 but found 9 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:153:10: [warning] wrong indentation: expected 8 but found 9 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:156:10: [warning] wrong indentation: expected 8 but found 9 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:280:10: [warning] wrong indentation: expected 8 but found 9 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:283:10: [warning] wrong indentation: expected 8 but found 9 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:298:14: [warning] wrong indentation: expected 12 but found 13 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:301:14: [warning] wrong indentation: expected 12 but found 13 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:389:10: [warning] wrong indentation: expected 8 but found 9 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:392:10: [warning] wrong indentation: expected 8 but found 9 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:435:10: [warning] wrong indentation: expected 8 but found 9 (indentation)
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:438:10: [warning] wrong indentation: expected 8 but found 9 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/clk-ad9545.example.dt.yaml: ad9545@4A: 'clocks' is a dependency of 'assigned-clocks'
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/clock.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1491545

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

