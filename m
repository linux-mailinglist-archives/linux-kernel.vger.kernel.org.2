Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05B533C1A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhCOQYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:24:06 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:40403 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhCOQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:23:42 -0400
Received: by mail-il1-f174.google.com with SMTP id e7so9891095ile.7;
        Mon, 15 Mar 2021 09:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HgwqlBmuUehNrsPso/cPfGiCGc8t+4arPnqvft1WhQ0=;
        b=tlFS4gjWHSFFGEcXGnkvMMYt0OI/0H84r70+0W0TfFXKr2nhJfcV3K6yu5mxrH2BZi
         mUc4OFWvwFpsc6BgHIguZIMmh2ZRrx1FuiN3WdKkfymk2n9GCL478tc5LedFY7TrmN13
         68D2Zmho3lKEK51iTDVKZFVpGIT+5jNAKNh2uSrDp8XBYBuUxVmosw9G6640RiJJ1D3E
         zqtYQLfq2F+nZtEisENRjDy5D3k4cp5iGpjYOeTqPW+vCm8GlrnthgqElHiPD/l0oRq1
         AdwVcCkFqyFCSG4iDI8rT2Z/QWRjDkw3MiefqNz0EFA5+ZN+NZYab1YIzx8kgoti0V2g
         mWug==
X-Gm-Message-State: AOAM533oX7t6br9qUU9tebGGaaS+joMCm7uo+KZNmJ1yURjEoqxh3oPK
        JyeNDtghp+c+NacHje89Hg==
X-Google-Smtp-Source: ABdhPJwDAcpD05CHoQUAKE09TR1uWqtzl//CAmUKHIvFTBJMPDTDR0bhhtMfk58tO6VZivbHAbXuhA==
X-Received: by 2002:a92:c641:: with SMTP id 1mr357910ill.94.1615825421671;
        Mon, 15 Mar 2021 09:23:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o13sm7121497iob.17.2021.03.15.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:23:40 -0700 (PDT)
Received: (nullmailer pid 977577 invoked by uid 1000);
        Mon, 15 Mar 2021 16:23:38 -0000
Date:   Mon, 15 Mar 2021 10:23:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert nuvoton,npcm750 binding to
 YAML
Message-ID: <20210315162338.GA973222@robh.at.kernel.org>
References: <20210313175321.2515675-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210313175321.2515675-1-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 06:53:20PM +0100, Jonathan Neuschäfer wrote:
> The general trend is to have devicetree bindings in YAML format, to
> allow automatic validation of bindings and devicetrees.
> 
> Convert the NPCM SoC family's binding to YAML before it accumulates more
> entries.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> If someone else wants to be listed as the maintainer, please let me
> know.
> 
> 
> v3:
> - In this version, I removed the nuvoton,npcm750-evb compatible string
>   again. I had previously introduced it to simplify the binding a little
>   bit, but Tomer Maimon suggested to keep /compatible of
>   nuvoton-npcm750-evb.dts as-is (i.e. only use "nuvoton,npcm750", no
>   board-specific string).
>   Because of this change, I am not including Rob Herring's R-b tag.

I think you should add nuvoton,npcm750-evb. Not so much for that board, 
but to ensure any additional boards get a board specific compatible.

> 
> v2:
> - https://lore.kernel.org/lkml/20210116010907.3475405-1-j.neuschaefer@gmx.net/
>   https://lore.kernel.org/lkml/20210303154622.3018839-1-j.neuschaefer@gmx.net/
> - Fix indentation to satisfy yamllint
> - Fix $schema line
> ---
>  .../devicetree/bindings/arm/npcm/npcm.txt     |  6 ------
>  .../devicetree/bindings/arm/npcm/npcm.yaml    | 20 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 6 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.txt b/Documentation/devicetree/bindings/arm/npcm/npcm.txt
> deleted file mode 100644
> index 2d87d9ecea85b..0000000000000
> --- a/Documentation/devicetree/bindings/arm/npcm/npcm.txt
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -NPCM Platforms Device Tree Bindings
> ------------------------------------
> -NPCM750 SoC
> -Required root node properties:
> -	- compatible = "nuvoton,npcm750";
> -
> diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.yaml b/Documentation/devicetree/bindings/arm/npcm/npcm.yaml
> new file mode 100644
> index 0000000000000..8cca0396a5d59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/npcm/npcm.yaml
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/npcm/npcm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NPCM Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: NPCM750 development board
> +        const: nuvoton,npcm750
> +
> +additionalProperties: true
> --
> 2.30.1
> 
