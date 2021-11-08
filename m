Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD92449D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 22:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbhKHVHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 16:07:34 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34449 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239682AbhKHVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:07:33 -0500
Received: by mail-oi1-f177.google.com with SMTP id bg25so29065012oib.1;
        Mon, 08 Nov 2021 13:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dLj06l1wmESDNcs8MD+tMJu6hG5JZ+huSjOUnPTWIms=;
        b=nsC4eNwasN/o/nd7V/GXfwzU3jWWA4LQz5I3oczBwkZn8S+tCgTly+WA6yAlzA8G2z
         rxf0oRPWgAVPEKGIFb3ZW8Jw8GkfCwrs4zlZKgrWEn5Y78t9EQw8w0y+MSr/m4bNHlRV
         ezc8r7912r+rgWvkDPc2fQCklMI3MjJwZ9vV4Ec/u/2InyohIkE5zabsQTAqC3aqzgw6
         XMk+NhDjJdNghz3sOmNUgy+t3jSpEGzOAfnHgfohQtf4VBNmqj5M8Hvg3Qi4tDUrv3+8
         qheD/Ue48XzyBhzVFbi7oid7guukKdwMde3g23JW+mu3n/dJZsOV0KCpuiXdesjDagU/
         xF4A==
X-Gm-Message-State: AOAM533wCfX90g7pARZRnQ17yjPTXKlZxCZmbNQd7m0IkmyH0HJUzXrz
        8ZRoWqBDo9hJt3zshvMyw91rLRyOaQ==
X-Google-Smtp-Source: ABdhPJzgvZiyH3h067LzXWI0cQ4/N1FWjU0WpFR4uRRAaF0ibj9cAeUsZYzrHJXzWGQ7Y2Wdivex9Q==
X-Received: by 2002:aca:3e86:: with SMTP id l128mr1169280oia.120.1636405487943;
        Mon, 08 Nov 2021 13:04:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k4sm6359902oic.48.2021.11.08.13.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:04:46 -0800 (PST)
Received: (nullmailer pid 16501 invoked by uid 1000);
        Mon, 08 Nov 2021 21:04:44 -0000
Date:   Mon, 8 Nov 2021 15:04:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, - <kernel@puri.sm>,
        ~okias/devicetree@lists.sr.ht, phone-devel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: sound: gtm601: convert to YAML
Message-ID: <YYmQ7OCIIb2AbnjY@robh.at.kernel.org>
References: <20211030121753.50191-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030121753.50191-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 02:17:52PM +0200, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - add #sound-dai-cells
>  - put kernel@puri.sm into maintainers
> 
>  .../devicetree/bindings/sound/gtm601.txt      | 19 ----------
>  .../devicetree/bindings/sound/gtm601.yaml     | 36 +++++++++++++++++++
>  2 files changed, 36 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/gtm601.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
> deleted file mode 100644
> index efa32a486c4a..000000000000
> --- a/Documentation/devicetree/bindings/sound/gtm601.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -GTM601 UMTS modem audio interface CODEC
> -
> -This device has no configuration interface. The sample rate and channels are
> -based on the compatible string
> -	"option,gtm601" = 8kHz mono
> -	"broadmobi,bm818" = 48KHz stereo
> -
> -Required properties:
> -
> -  - compatible : one of
> -	"option,gtm601"
> -	"broadmobi,bm818"
> -
> -
> -Example:
> -
> -codec: gtm601_codec {
> -	compatible = "option,gtm601";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/gtm601.yaml b/Documentation/devicetree/bindings/sound/gtm601.yaml
> new file mode 100644
> index 000000000000..e81a6aa75522
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/gtm601.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/gtm601.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GTM601 UMTS modem audio interface CODEC
> +
> +maintainers:
> +  - kernel@puri.sm
> +
> +description: >
> +  This device has no configuration interface. The sample rate and channels are
> +  based on the compatible string
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: broadmobi,bm818
> +          - const: option,gtm601

This does not match what the binding originally said. And generally this 
combined with the one below should never be valid.

> +      - items:
> +          - enum:
> +              - broadmobi,bm818  # 48 kHz stereo
> +              - option,gtm601  # 8 kHz mono
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gtm601_codec {
> +        compatible = "option,gtm601";
> +    };
> -- 
> 2.33.0
> 
> 
