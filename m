Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3827D32F62C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhCEWyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:54:55 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43180 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhCEWyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:54:47 -0500
Received: by mail-oi1-f173.google.com with SMTP id d20so4267793oiw.10;
        Fri, 05 Mar 2021 14:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YmJy9RHCJy3uQpyMxegFKyRBZmNkXavxc/ygHGcpB/Q=;
        b=hraon5aFcVIgq6fUtwtSv2SbrJjEUob4rqicCZ2xfow5x8luF/uJjIT7sFbIYZUCjj
         Ehcsbq9dJigXSnJGalMp1T1OcDV2CLAUzoF4cNhpec+PRuZOeZWxXjM4cM0DSlsK3Jfz
         s4+xPj2MEQ2AIKojaSsbHVIlKTzpBVB2SCQPdGBnnYkKxeMFCCFzdSPdNlzFtQu8Bado
         qyEQQoeFij9ciNUxMcstxgU9G92RI4o+KGxHattWxMdmQN1bceqEUTUhemZQfbojEvGY
         JgrAWz7zuDU9Nk5mptAa9UFvifVJnIhzAjTzBkk8gwAxzNGk8tzooWClM8F93G0FLAic
         rWzQ==
X-Gm-Message-State: AOAM531C9m1yM6P/U3Bq3R1/wxKa0L++o63gdlMHqGhUhLVugjb6Vs7Q
        GvN0yy1rzdriUnQ5OSbQPw==
X-Google-Smtp-Source: ABdhPJwgqxdxeG3gLvugwUTSgjpNpEvow3sM8VSthPlMcISqgz/neBTZry3GPD1+z9Sob/oL1Ma0uw==
X-Received: by 2002:aca:ad02:: with SMTP id w2mr8911700oie.143.1614984887139;
        Fri, 05 Mar 2021 14:54:47 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i3sm926972otk.56.2021.03.05.14.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:54:46 -0800 (PST)
Received: (nullmailer pid 793356 invoked by uid 1000);
        Fri, 05 Mar 2021 22:54:45 -0000
Date:   Fri, 5 Mar 2021 16:54:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>, allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] dt-bindings: display/panel: add Jenson JT60245-01
Message-ID: <20210305225444.GA792026@robh.at.kernel.org>
References: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
 <20210218225458.823773-5-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218225458.823773-5-giulio.benetti@benettiengineering.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:54:52PM +0100, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Add DT binding for "jenson,jt60245-01".
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 08afd6501094..fd0d2a573350 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -169,6 +169,8 @@ properties:
>        - jenson,jt60248-01
>          # Jenson Display JT60249-01 5" (800x480) TFT LCD panel
>        - jenson,jt60249-01
> +        # Jenson Display JT60245-01 7" (800x480) TFT LCD panel
> +      - jenson,jt60245-01

It was going so well. Alpha-numeric order please.

>          # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
>        - kingdisplay,kd116n21-30nv-a010
>          # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
> -- 
> 2.25.1
> 
