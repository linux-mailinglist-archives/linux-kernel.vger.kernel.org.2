Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1D38CA58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhEUPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:44:37 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:45766 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhEUPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:44:35 -0400
Received: by mail-oo1-f46.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so4667256oop.12;
        Fri, 21 May 2021 08:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yegbdR8KSApe+4ngi1kXcS7ZM10vxGbU/4zWEQ1128I=;
        b=T5nMBF/lis22N2+Cg4+DmOeodXnVAv1o0tQ+fzgjWZaSX4cYyE5QBEw7a5P+tgrU4/
         geH9nghJK+gukmMxKpefjmaOEp1H6aDqoWlYuTEiUSICd0VrcBPQ+JEp9CFaejhWs3zC
         aYPRAe6T6SzhiOsNbfY8HNKFDpcpYBd0RsgR9OSpoRenOuBmarEUYyD6g8euGJKvvzzE
         PsMC003Mc4JbG3sEUjCFbvTKe5s2Hnqv1jWe+AZ71ZKCLpNrGc7CHxyl03BXljyYJykV
         9p93483v4kTtp26MnOpYukt1lSrraIUKaKGW4du6M0VaKHDSr4O6TE4i0eDCV41RXAJg
         5vEg==
X-Gm-Message-State: AOAM530VHuIlnvMPQW+OkYGVAEda1bx5tkq0Dx80ubgM7ALh40OGBQXO
        o/R+OLuVVFpHxt+0QuyYfA==
X-Google-Smtp-Source: ABdhPJyCmpOnE/ZQpkS6yGfTc1tG2/P8pWGm0a0vKvhQXR6E8uy3tjPzY7AuBhG7J2uRoccf3GXjDQ==
X-Received: by 2002:a4a:9b0b:: with SMTP id a11mr8799792ook.73.1621611792431;
        Fri, 21 May 2021 08:43:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t39sm1244580ooi.42.2021.05.21.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:43:11 -0700 (PDT)
Received: (nullmailer pid 4051106 invoked by uid 1000);
        Fri, 21 May 2021 15:43:10 -0000
Date:   Fri, 21 May 2021 10:43:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1] ASoC: dt-bindings: Convert imx-audmux binding to json
 schema
Message-ID: <20210521154310.GA4051048@robh.at.kernel.org>
References: <20210521122129.1371-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521122129.1371-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 14:21:29 +0200, Oleksij Rempel wrote:
> Convert the imx-audmux binding to DT schema format using json-schema
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/sound/imx-audmux.txt  |  28 -----
>  .../devicetree/bindings/sound/imx-audmux.yaml | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/imx-audmux.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmux.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
