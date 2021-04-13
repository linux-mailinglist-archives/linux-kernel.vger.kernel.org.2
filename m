Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7D35E46A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhDMQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:56:23 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36810 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhDMQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:56:22 -0400
Received: by mail-pf1-f178.google.com with SMTP id b26so6668754pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sUpSVvkMU+aPK+DNmgsnS+6a8vD5+JAsTuntfol5gy8=;
        b=hdVno7YavyzfILsuVJzbAKdc7CvbcuqREdEPVLJ5PWQ23XyYjIwj9RFSnwx6rDi+lA
         se5UZki2Lyjyl1YJ73HV15f8ZUgiGrrvBTgB2ZsyBISUZ91lizUJxF+qFMQDO2JcZY9A
         yRB7JXlnC5WkgYt4edgOa856+AEmGRGoB7XEpJC2eJ0H0hFe7zTfObQ0qAr94yDdjDpY
         oWURagE62WRe3sbXhvkjTAFvzPz6iTWH4f7fK8C1nO3sLI9GSsVcEbTrTc3udtPkrcXY
         xA191vjacb7u1NZWC8n/0x8yP/P/K8Qmp9MsBux8h6Ef0ownsbbnIUwLWQG/em/IHPL2
         psGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sUpSVvkMU+aPK+DNmgsnS+6a8vD5+JAsTuntfol5gy8=;
        b=JuUSaZreha09hpE6J9WFOdvXmPtS4HBE+gvEEU/XSC8lg/ru4ennx/kKZCZ7Urr1ii
         to+A4XQ7h8pBlH78RkHT8ifCN+4kGl+aUDpf1TIeeE1PWgH7V+3nmANZXZYiWgnDIwqw
         asRj+/6sUhFqSB3en68H07Ywf2m5hNP4lo/K0W0dHc9Li4CAnW6MMvB0z3p6EPadfCwS
         HtCwyh4pZNVXvuJZDKyZgoCusWpXkOiT6XZfl9tShkuRy4U+AhGyiUbITxadT7SXhPoh
         icYiyGYL1aIM0I5Z2VW1lcRIGxqle8bdojRKLYNGviZ8R3jpL+P2tqmu8ocZ+UV0Yjn5
         T9cg==
X-Gm-Message-State: AOAM531LuhNT6En9Aoe2hnc8dP6Sk9JgGf59YjHTb+oDuU/rttF46xcd
        VRzBSFRNjG+nY105p66P70+0tA==
X-Google-Smtp-Source: ABdhPJxGy692tTN+dAOl9VqSyETi6yi+oKFuJ1oc6Yaz09/MXY2NIMPJ7ZzOr0XOCifqeGzc5V0v2w==
X-Received: by 2002:aa7:9843:0:b029:24e:8215:f546 with SMTP id n3-20020aa798430000b029024e8215f546mr8204673pfq.10.1618332902565;
        Tue, 13 Apr 2021 09:55:02 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id v6sm9905966pfb.130.2021.04.13.09.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:55:02 -0700 (PDT)
Date:   Tue, 13 Apr 2021 10:55:00 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 2/8] dt-bindings: remoteproc: imx_rproc: add i.MX7ULP
 support
Message-ID: <20210413165500.GA750651@xps15>
References: <1617846898-13662-1-git-send-email-peng.fan@oss.nxp.com>
 <1617846898-13662-3-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617846898-13662-3-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:54:52AM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX7ULP compatible.
> 
> We use i.MX7ULP dual mode and in which case i.MX7ULP A7 core runs under
> control of M4 core, M4 core starts by ROM and powers most serivces used

s/serivces/services

> by A7 core, so A7 core has no power to start and stop M4 core. So
> clocks and syscon are not required.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml          | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index b13bf8d70488..58bc2a23f97b 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -18,6 +18,7 @@ properties:
>        - fsl,imx8mq-cm4
>        - fsl,imx8mm-cm4
>        - fsl,imx7d-cm4
> +      - fsl,imx7ulp-cm4
>        - fsl,imx6sx-cm4
>  
>    clocks:
> @@ -57,8 +58,6 @@ properties:
>  
>  required:
>    - compatible
> -  - clocks
> -  - syscon
>  
>  additionalProperties: false
>  
> -- 
> 2.30.0
> 
