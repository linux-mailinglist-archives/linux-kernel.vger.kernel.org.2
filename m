Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24EC3C940B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhGNWyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:54:31 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:41551 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhGNWya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:54:30 -0400
Received: by mail-il1-f169.google.com with SMTP id p3so3204607ilg.8;
        Wed, 14 Jul 2021 15:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0JF+oI0cxnhcWNAgVCD4GCZHjj0Z7CzhW9QR4n4PKp4=;
        b=ffJvBQ5zdMqyWeoQ9WtVrFyOE77s4oCUuzvjMznl6bso+kO+NYZ+jWXZGZUdUvT92Q
         nIqWrJBmgGnpjVTcaNg70KOo+9LDC8MdSPJi1C2TOh3TSWZOSGZcgsUebrPJ3LTERojE
         Yok+wy5BEM/x3rnXe62kbCmxxQK7Cr9LyFQTpGlwV1Q5BnopN+sCeRH6BREroUq4R14e
         Kn5J97jRups3mtfsqMkZwjFSAgiG+dQZA7AyEwLZ1j5jRCWLPG3T0BApJG3lYgKsRFRc
         4v7gYJgMCjYGpgIPojgSxIdVh6su/H6yb7cdyyS0raGp3f9nZkc0zj+tvH5+7ZTDxM45
         mjgg==
X-Gm-Message-State: AOAM532/g/BP4ZhCP+astFN/biO2J3JnTvEcWkWQc2EAhYqj+4h7G5yj
        YUEp6+W433gj1HnovSsT4cA7J/rO2WnB
X-Google-Smtp-Source: ABdhPJy16i6Syh/W3o9kw5cPeTZ6AuFUBJ10fqojPiP57hKSEqIFARvQyv94ug4/a/DoDG0+UzvECw==
X-Received: by 2002:a92:6902:: with SMTP id e2mr62609ilc.275.1626303096930;
        Wed, 14 Jul 2021 15:51:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i3sm2034041ilr.56.2021.07.14.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:51:36 -0700 (PDT)
Received: (nullmailer pid 3685336 invoked by uid 1000);
        Wed, 14 Jul 2021 22:51:34 -0000
Date:   Wed, 14 Jul 2021 16:51:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Ash Logan <ash@heyquark.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: nintendo-otp: Document the Wii and
 Wii U OTP support
Message-ID: <20210714225134.GB3683016@robh.at.kernel.org>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210701225743.14631-1-linkmauve@linkmauve.fr>
 <20210701225743.14631-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701225743.14631-3-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 12:57:40AM +0200, Emmanuel Gil Peyrot wrote:
> Both of these consoles use the exact same two registers, even at the
> same address, but the Wii U has eight banks of 128 bytes memory while
> the Wii only has one, hence the two compatible strings.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  .../bindings/nvmem/nintendo-otp.yaml          | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
> new file mode 100644
> index 000000000000..c39bd64b03b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0

GPL-2.0-only OR BSD-2-Clause

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/nintendo-otp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nintendo Wii and Wii U OTP Device Tree Bindings
> +
> +description: |
> +  This binding represents the OTP memory as found on a Nintendo Wii or Wii U,
> +  which contains common and per-console keys, signatures and related data
> +  required to access peripherals.
> +
> +  See https://wiiubrew.org/wiki/Hardware/OTP
> +
> +maintainers:
> +  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nintendo,hollywood-otp
> +      - nintendo,latte-otp
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    otp@d8001ec {
> +        compatible = "nintendo,latte-otp";
> +        reg = <0x0d8001ec 0x8>;
> +    };
> +
> +...
> -- 
> 2.32.0
> 
> 
