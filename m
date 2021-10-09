Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C0427B7A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 17:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhJIPsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 11:48:31 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33886
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234373AbhJIPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:48:30 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7667240015
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633794392;
        bh=v1+QlvKaJ7Bh5M6oMybEXJsFX39EduvKj9WCPeD3iRE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ktP2f3fq7PHuT1E6KdcNjSe9xSf7Jr/Vm9lvJSOqxattK3D/7O6FDL3s0ZePS+iU+
         WXrfFIdfbWmalHTxCBcHlRdCRsywzCBGqKmpXfLp354Pq1pS9zv9dVuBZKK2zswtf6
         I3rJRjsXJelfJmV1SlVIMBzCxJBmmb4El8ciTsW0SJwUi+/EBTphRQZqvQ+Jbrb3q4
         WkjfaxW+2Sl/tJHKTgCUmtS7MMelQ82woZ7+o0yto+1BiDBcOQ0ySgPRbfzu1Mzzet
         S3MnuE1XLEJMs+Jke97cT8KV27hp5UjGBcdZOtiAIEILieC1tohRbBXyBeuisBPG/9
         O9mFjoHKkdbtw==
Received: by mail-ed1-f69.google.com with SMTP id p13-20020a056402044d00b003db3256e4f2so11902461edw.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 08:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v1+QlvKaJ7Bh5M6oMybEXJsFX39EduvKj9WCPeD3iRE=;
        b=7AbEVlbGQDEZW/vd8nfpQp7jL9UIiLTDcGKrCWOISivS8S4011sstjk2shu6MS8boS
         8twDsRB92FIerdW55V7Rpg4gt1InIWOnTCS/bh3zQ5jNsynbGgktrB7Vf3O6n62Qs+Gp
         pib8unSmifgshcHiUqK/dWv0CHfx2/QtEvoDojEuQYNuTK79lHTXxKT6p1jMrpXpTnVj
         aMkQx1P1+ZPAoGYVgJXL6Qi2f3CusSRpsHnqK9G9vgop8uOGIbVZn0p9xyk1nXRk4dS1
         roxfKv5TuH6Ws5IrJwMA3txkIKx5rQVzyqwT5c6Xi66xx/MchKJEAhEE1zpaTj4j84/L
         LKuA==
X-Gm-Message-State: AOAM532d4+zbZ//xQAqQD0zP4l6zBkO2rPQsCJivV2QcSCbdNuZ65my+
        eBabcmAoecyeFp7rfQG9Cru7R/H6t9lcMP8V4KU0n3Lgc+o2C74MOfPJQsUkSfIGOP3DA3s018x
        YKdmU9hOs/TTat4lp4IB5rbOhRW+wAGQQlIROA7+qwg==
X-Received: by 2002:a50:9d8e:: with SMTP id w14mr24670462ede.74.1633794391988;
        Sat, 09 Oct 2021 08:46:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2VPYG8VbUO+BMxIVbYguDgxJuPFsNUpuHGhQL3ig+n1yG0BiNoNGTraMX8HzkO8k4m52zUQ==
X-Received: by 2002:a50:9d8e:: with SMTP id w14mr24670441ede.74.1633794391842;
        Sat, 09 Oct 2021 08:46:31 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l5sm1096050ejx.76.2021.10.09.08.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 08:46:31 -0700 (PDT)
Subject: Re: [PATCH v2] dt-bindings: net: nfc: nxp,pn544: Convert txt bindings
 to yaml
To:     David Heidelberg <david@ixit.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht
References: <20211009153003.33529-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8050a43b-8278-8148-2827-cccbfc28b414@canonical.com>
Date:   Sat, 9 Oct 2021 17:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009153003.33529-1-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2021 17:30, David Heidelberg wrote:
> Convert bindings for NXP PN544 NFC driver to YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2
>  - Krzysztof is a maintainer
>  - pintctrl dropped
>  - 4 space indent for example
>  - nfc node name
> 
>  .../bindings/net/nfc/nxp,pn544.yaml           | 65 +++++++++++++++++++
>  .../devicetree/bindings/net/nfc/pn544.txt     | 33 ----------
>  2 files changed, 65 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,pn544.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/nfc/pn544.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/nfc/nxp,pn544.yaml b/Documentation/devicetree/bindings/net/nfc/nxp,pn544.yaml
> new file mode 100644
> index 000000000000..6a4bc511d962
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nfc/nxp,pn544.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nfc/nxp,pn544.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Semiconductors PN544 NFC Controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +properties:
> +  compatible:
> +    const: nxp,pn544-i2c
> +
> +  clock-frequency: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: Output GPIO pin used for enabling/disabling the PN544
> +
> +  firmware-gpios:
> +    description: Output GPIO pin used to enter firmware download mode
> +
> +  pinctrl-names:
> +    items:
> +      - const: default

I wasn't specific, because pinctrl always go together - names with -0.
This as well should be dropped.


Best regards,
Krzysztof
