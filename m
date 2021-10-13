Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9552842C2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhJMOZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:25:32 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:38767 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhJMOZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:25:22 -0400
Received: by mail-ua1-f41.google.com with SMTP id h19so4824223uax.5;
        Wed, 13 Oct 2021 07:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmaDEcxWA+7aThLlosNjJjitKQ1Jx2oL/R8PL2Ik0Qo=;
        b=G2QRcbW4RFyjgsqHC2fmdVJWV1C4hqAfvyrzaOSm3Uh/zjWELtMQXVWYDaSdL3P4mz
         3mH6bxyIqHB6gG1wt/dLhzoddyl6kRhIAipsJuEG5lPJf2lBZG69YAafzHlhhL9zXy78
         oWXLvhOTwvpfAMbjUlHiT1lrKcT00qKLVA+jIxh0v95S5SbLhQFU1xNO1hhcr7YBpulO
         RsXE5IWOOD/7a6xIuIefmPyT0mE6IwcsGxyyWe7B3Sxe1/FBq58H9RfmyVgCYnZTuIGN
         xlvl7kO3PJeI3jSqTyc7OgRxYBPBVhmcTTqsQaNv0EsQi/Z+1YzAVFHQ4a5WAfM8UMws
         Xc0w==
X-Gm-Message-State: AOAM53385km0pRhKFi39w1uddQXGVbcyhHf3+/PgUW9bzzF1cEgmrhKz
        Ro8DjAkwaMOW3ZFdWSSZuNY/ASGhLNMXaaGA8lE=
X-Google-Smtp-Source: ABdhPJx/woSUBDxE6KJTOIyuKrRZXt/yE5rDWIX6/v6+/wMer84b/7EGmQ6G/0iJEzE9IgJLQc/oLpW3CpVffi8wpyw=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr39495819vsl.9.1634134988939;
 Wed, 13 Oct 2021 07:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-2-zhang.lyra@gmail.com>
In-Reply-To: <20210923064137.60722-2-zhang.lyra@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Oct 2021 16:22:57 +0200
Message-ID: <CAMuHMdWq3M3i+5yATeGEUxupU6Gb5ZnJeNsn9czX6tukEbHQng@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan.

On Thu, Sep 23, 2021 at 8:42 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Add a new bindings to describe ums512 clock compatible strings.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

> +  clock-names:
> +    minItems: 1
> +    maxItems: 4

After applying this to my local tree, as it is a dependency for 2/4 in
for-mfd-next:

    Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml:
properties:clock-names: {'required': ['maxItems']} is not allowed for
{'minItems': 1, 'maxItems': 4, 'items': [{'const': 'ext-26m'},
{'const': 'ext-32k'}, {'const': 'ext-4m'}, {'const': 'rco-100m'}]}
    hint: "maxItems" is not needed with an "items" list
    from schema $id: http://devicetree.org/meta-schemas/items.yaml#

so please drop the maxItems 4.


> +    items:
> +      - const: ext-26m
> +      - const: ext-32k
> +      - const: ext-4m
> +      - const: rco-100m
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
