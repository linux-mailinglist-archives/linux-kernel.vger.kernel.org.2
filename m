Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD032F542
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCEVWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:22:31 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44195 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCEVWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:22:23 -0500
Received: by mail-ot1-f54.google.com with SMTP id f33so3151711otf.11;
        Fri, 05 Mar 2021 13:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kgp+8TKM8Byg9mm9YN8yCXWXwp0Cjl6dB6xN7JrKEoA=;
        b=mK9SiAsUQRFuhszOALgGTyb8pIIJhDOTvoZGvRWEqqkYpFsgOHcya82W4r2a8d9DfR
         pUukeCPv/HsmoKnzS2/2c2T6Cl6Dla8aHYtsxjIithKkT3QMVbXc57n1RNIe8/frDuP6
         vKHVEabOhDRyReYzA8n4m+Zf1o2HTqJcnv8Age6vLiLrr6AvPod74J6Y8zc1fss1V9Je
         jLyMveNlI884Vhrjo+A8xX2miJupu4yUTypqcsEfq0zrE/HBUEWrSqt8MGNKJOu5MgQB
         yZzS9QEG5lrAoIzRyVykXq7h7yNocCmESkYodXCwYzrflKCv7Qzvs5iFP8HUY8FePEbW
         r5gQ==
X-Gm-Message-State: AOAM5318ruahZUtfMV9va7IkVeWK/kpAgkLG4x3twiIXNHfl5xDLXnL0
        N2I+/IMxNryBt96S+dgebw==
X-Google-Smtp-Source: ABdhPJxyV6oOQN8jtAqS+9qD1PurYNE5/fuZV85hlswq63NopRqt9wgna7asDgqiQi9Ks2vJ9nJ4Kg==
X-Received: by 2002:a9d:6019:: with SMTP id h25mr9691347otj.203.1614979342668;
        Fri, 05 Mar 2021 13:22:22 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w11sm770351ooc.35.2021.03.05.13.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:22:22 -0800 (PST)
Received: (nullmailer pid 668925 invoked by uid 1000);
        Fri, 05 Mar 2021 21:22:21 -0000
Date:   Fri, 5 Mar 2021 15:22:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Haidong Yao <yaohaidong369@gmail.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mailbox: Add interrupt-names to SPRD
 mailbox
Message-ID: <20210305212221.GA667054@robh.at.kernel.org>
References: <20210213122143.19240-1-orsonzhai@gmail.com>
 <20210213122143.19240-3-orsonzhai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213122143.19240-3-orsonzhai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 08:21:42PM +0800, Orson Zhai wrote:
> From: Orson Zhai <orson.zhai@unisoc.com>
> 
> We add an optional supp-outbox interrupt support to SPRD mailbox driver
> with newly added sc9863a support and change to configure interrupts with
> names in device tree files.
> 
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> ---
>  .../bindings/mailbox/sprd-mailbox.yaml         | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> index 26a5cca3f838..67736450ee93 100644
> --- a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> @@ -15,6 +15,7 @@ properties:
>    compatible:
>      enum:
>        - sprd,sc9860-mailbox
> +      - sprd,sc9863a-mailbox
>  
>    reg:
>      items:
> @@ -22,9 +23,18 @@ properties:
>        - description: outbox registers' base address
>  
>    interrupts:
> -    items:
> -      - description: inbox interrupt
> -      - description: outbox interrupt
> +    minItems: 2
> +    maxItems: 3
> +
> +  interrupt-names:
> +    oneOf:
> +      - items:
> +          - const: inbox
> +          - const: outbox
> +      - items:
> +          - const: inbox
> +          - const: outbox
> +          - const: supp-outbox

You can do this instead:

interrupt-names:
  minItems: 2
  items:
    - const: inbox
    - const: outbox
    - const: supp-outbox

>  
>    clocks:
>      maxItems: 1
> @@ -40,6 +50,7 @@ required:
>    - compatible
>    - reg
>    - interrupts
> +  - interrupt-names
>    - "#mbox-cells"
>    - clocks
>    - clock-names
> @@ -56,5 +67,6 @@ examples:
>        clock-names = "enable";
>        clocks = <&aon_gate 53>;
>        interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "inbox", "outbox";
>      };
>  ...
> -- 
> 2.17.1
> 
