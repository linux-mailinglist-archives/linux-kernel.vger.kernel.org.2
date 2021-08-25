Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9829C3F7BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbhHYSBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:01:48 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:44928 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhHYSBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:01:47 -0400
Received: by mail-oi1-f169.google.com with SMTP id c79so481157oib.11;
        Wed, 25 Aug 2021 11:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StvxwzuUjKTXJ8etoPop6YIFzoNsqeQQ9cFPcDXSgUQ=;
        b=iSbEtrz8v7ThWX8kalVEmeULuGo9MLGpB5I+qVjPBm7Srv0y2GGTrCSCL213MxxRn/
         76Q7LBitbESDuSdWXU9jrF6Kxhg9cddH9y2FHmDFnGdmM9WgNQWm2t2YDf+1h5P6p8vF
         sgxw6jFmZuzgeWROAjnMDoSKrgJXy08F+Mb9jWm3/4VJkr8jGy3gloq57DBjOFRXpxgu
         iblzkltDSmaotVi2M6GUMPBtTtTnjRKpCpqBMCup0JsNCVAOm7grtrU4xK19pilNqB3G
         qt4JBUE05bnzjuVmOeRCU2p/JPVIi3dl9LdfvFJfCRCIQD4JyExkj0Sde9bd8i8VszN8
         YMFg==
X-Gm-Message-State: AOAM531nEPA1uzrFRSHB6t/e84fLr0apKnDa6rc4KB9l6pQZ0gP2ERzO
        Ra3bVTBwzMSe+f1HdHqWYQ==
X-Google-Smtp-Source: ABdhPJzVqj5x9uLmRN2lgjLZhTfqE2wN22QpqispY6hg6L4dCpXVVihRcuCXfG0noVAjNHT14RXJug==
X-Received: by 2002:a05:6808:13c8:: with SMTP id d8mr7920087oiw.104.1629914461549;
        Wed, 25 Aug 2021 11:01:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x13sm97073otk.42.2021.08.25.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 11:01:00 -0700 (PDT)
Received: (nullmailer pid 3023570 invoked by uid 1000);
        Wed, 25 Aug 2021 18:00:59 -0000
Date:   Wed, 25 Aug 2021 13:00:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v3 7/8] dt-bindings: clock: samsung: convert S5Pv210
 AudSS to dtschema
Message-ID: <YSaFW5s47ss/JE2M@robh.at.kernel.org>
References: <20210825134056.219884-6-krzysztof.kozlowski@canonical.com>
 <20210825134251.220098-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825134251.220098-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 15:42:50 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung S5Pv210 Audio SubSystem clock controller bindings to DT
> schema format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Include header to fix clock IDs error in example.
> ---
>  .../bindings/clock/clk-s5pv210-audss.txt      | 53 -------------
>  .../clock/samsung,s5pv210-audss-clock.yaml    | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/clk-s5pv210-audss.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
