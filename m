Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2E13F06CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhHROfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238662AbhHROfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57BB560FBF;
        Wed, 18 Aug 2021 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629297270;
        bh=ZLF6wNvdkCa5d9Gqk0Qj8C0bCJjSoFD3PF1+6ShotK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QWb30O1CU2Qay10/k5WA08Gw5tyQlF68vJTR33AVZGv/RK5HLGUarrr9LwHE0S22x
         J+Svsu9hkb+qIvd5aXLYJwHgEYjUxXJQFFVQHTTQVjZD4dkResObSw8xj4m90wde7W
         ZiZeGOoQ/BnqCfIHa95XzxqiFsK5z6qFiNq0hiTavH/U9ED8f6JEzzXqguR0JD3UK+
         dFeTXcmzXMh87CPL1Z5lGKcdwroddkomj6EYxecjUcvv6ODoes9W+8264hpJK8RRGV
         jir5fAeODW+rJ3jl8i/qxQ9IKfxDdvM0gm0TXNXbUMdeZnI0aQo9BAArwhjV8x96gF
         naLfGR5Ui4FZA==
Received: by mail-ed1-f43.google.com with SMTP id i22so3446604edq.11;
        Wed, 18 Aug 2021 07:34:30 -0700 (PDT)
X-Gm-Message-State: AOAM530TagKRA+Npl8UcgA+iPrTNQrnU3xhZZXWGhYnhyH4BSKSnuXBi
        NKPfsnkqT+qM8NzMXUZ1t0GqgSOPWNLN0PT65w==
X-Google-Smtp-Source: ABdhPJw1tY+8wtuouFMDe+vJET3QMM0PEOSW1q4Jr4fufTp9S1lV5i6YV8pohcZgiLtsC9+DyBDhTnWpoWNbN+/6iiQ=
X-Received: by 2002:a50:9b52:: with SMTP id a18mr10533087edj.165.1629297268956;
 Wed, 18 Aug 2021 07:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210813143537.130310-1-krzysztof.kozlowski@canonical.com> <YRwx1Blpqq0+JK3m@robh.at.kernel.org>
In-Reply-To: <YRwx1Blpqq0+JK3m@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Aug 2021 09:34:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ_6pvRy2K_msX5wr6TcLUNjV2AwK1_RHB9puGXJTJ6Xw@mail.gmail.com>
Message-ID: <CAL_JsqJ_6pvRy2K_msX5wr6TcLUNjV2AwK1_RHB9puGXJTJ6Xw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: convert Qualcomm Atheros DDR to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alban Bedel <albeu@free.fr>, Paul Burton <paul.burton@mips.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 5:01 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 13 Aug 2021 16:35:37 +0200, Krzysztof Kozlowski wrote:
> > Convert Qualcomm Atheros AR7xxx/AR9xxx DDR controller to DT schema
> > format using json-schema.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >  .../ath79-ddr-controller.txt                  | 35 -----------
> >  .../qca,ath79-ddr-controller.yaml             | 61 +++++++++++++++++++
> >  2 files changed, 61 insertions(+), 35 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/qca,ath79-ddr-controller.yaml
> >
>
> Applied, thanks!

I applied forgetting you are maintaining the memory-controller
bindings. I can drop if you prefer. I see you've got a few more too.

Rob
