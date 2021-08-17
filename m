Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92B03EF55B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 00:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhHQWCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 18:02:32 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36721 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhHQWCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:02:31 -0400
Received: by mail-ot1-f53.google.com with SMTP id r38-20020a05683044a600b0051a2c6dd421so276460otv.3;
        Tue, 17 Aug 2021 15:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6QPS7TkykReNzd5f1zYvT2KM5V+uXTZ813Lm5/LaSnM=;
        b=T0tLMFYCG0RP9mBuxq9IR2BJW2ZVhsv+wX5Qi6gu2uXIT+yttT1nIOwgO+6F/GXeYS
         908KPEkmkrvomAofPEkDgdUjGCunJUV/mxjRQm+xxCAO0FC2fywI4/SSu4WZqAO43ccG
         +ehxyi8pEHtKm3+/en8ly9meO6gU/caTBOMZdx+THgZT0gC+R3pRMghtIGGrHe4ZaAKC
         z3KBf8LLXQVmAeEy73Vvt7HZbupL+d+O7twKOtcS4fG2TNKwE3diedUP61rEYGVGF3Ft
         PkXbsZX7CPemj34QGHkqJo/VBu0LeDjyzjrkorspFq1Xy2WuZAtEpgbHdu6bBfzlxnyR
         IQZg==
X-Gm-Message-State: AOAM530kjxWaU87WopNstnCu6CkRL3GeeujuPCv10z8uixJYo0Y6GWBI
        CexF+4mV79kneCeAV9DV0w==
X-Google-Smtp-Source: ABdhPJwTGUl+yWVYMuiNS7FHMGT7FB+7sOsuccIKV1ubM3ZmJFr7xHnLBWobOqF2Wcl3NJRa5velng==
X-Received: by 2002:a05:6830:3115:: with SMTP id b21mr4471121ots.240.1629237717842;
        Tue, 17 Aug 2021 15:01:57 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o26sm657437otk.77.2021.08.17.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:01:56 -0700 (PDT)
Received: (nullmailer pid 916705 invoked by uid 1000);
        Tue, 17 Aug 2021 22:01:56 -0000
Date:   Tue, 17 Aug 2021 17:01:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alban Bedel <albeu@free.fr>, Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory: convert Qualcomm Atheros DDR to
 dtschema
Message-ID: <YRwx1Blpqq0+JK3m@robh.at.kernel.org>
References: <20210813143537.130310-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813143537.130310-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 16:35:37 +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm Atheros AR7xxx/AR9xxx DDR controller to DT schema
> format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../ath79-ddr-controller.txt                  | 35 -----------
>  .../qca,ath79-ddr-controller.yaml             | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/qca,ath79-ddr-controller.yaml
> 

Applied, thanks!
