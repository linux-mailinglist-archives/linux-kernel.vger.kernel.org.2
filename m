Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C006380DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhENPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhENPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:55:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E2C061574;
        Fri, 14 May 2021 08:53:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id di13so35230301edb.2;
        Fri, 14 May 2021 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJjqUh+eedhnbrR//6OaBv5/ZsdN4XZOU4mhcsRuoyg=;
        b=f5pKrku0e6EM6tOZFoRr8i5ryGCMprW/ArJmi1G1tF1P3P7TB/vGZt6eUZBeYX1OGP
         4onTfNm+56vE+G3yKyyomtIVL/0TNH+IF3DEnOwqDIJ0EUpf+yDjVYVMnXLC0j8N9vlB
         0LablOmpCVmnbJPG82EWGdqqbeH62hmqq9UT7wSqc5XZut/4D2/BTlqC4eYe0rLabD2v
         OFQOhntIB1I9aLkzF8xewSXdLpLPngab91x9DAK63/E85M4PiX9uswAdiBkxJTD159me
         eg2D15l8+0Xts9zanmFZyE/89732PpRS0TuLEsgtcyKUJAca/Yq+j0vuZGPanW1zZSNI
         9gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJjqUh+eedhnbrR//6OaBv5/ZsdN4XZOU4mhcsRuoyg=;
        b=iBxSHTFSUkdblwtojqoFYQHFQyg29m6VLtqRfilNWXdi11BjuqAqEYhAcBSRT/4WZe
         K2Z5oqYRzDeOEcW5DT9sYYVZDf+/msQtRijZ3GAcxPcJaMOsJqqIu+tqDKhOEFWS/q54
         zsA0MOOpNLYLOJYgAsROZsmecTHHPGWv7TVXTvUZWzRfzzc6aypxNcdpv4RTzB2ehVkk
         /yawg4bkKkvLWxApl5CMp9B5m0Jqd2LF9UHJQqlkBb0aUUjNJJPJ+yrHGIdcJaC0UVwn
         I/qebaDkvS+YbR7YBtQ3Xn+jE61FQh92hPesU4iLPLCdVdhqFTyVXma+K2IHYIIMgLXY
         yQ+g==
X-Gm-Message-State: AOAM533mMctgnnb+S3nr/kskna/Rgmc1stPyZuDpir9g+HMnfE4Po0gg
        QBYOXu3fgw6b4NF2NN+IwiTGZiqkCFU=
X-Google-Smtp-Source: ABdhPJxiEhDApEu75kJdXXESrqi6t2oBygLR+znc2KM99z8D4A006a1c0919pGQoeo6o0GXD+663Ew==
X-Received: by 2002:a05:6402:2753:: with SMTP id z19mr56769103edd.158.1621007635210;
        Fri, 14 May 2021 08:53:55 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ks10sm3911610ejb.41.2021.05.14.08.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:53:54 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] dt-bindings: soc: rockchip: grf: add compatible
 for RK3308 USB grf
To:     Tobias Schramm <t.schramm@manjaro.org>, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210514150044.2099298-1-t.schramm@manjaro.org>
 <20210514150044.2099298-5-t.schramm@manjaro.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <e995a144-1cbb-06c6-074f-2623bf31b003@gmail.com>
Date:   Fri, 14 May 2021 17:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514150044.2099298-5-t.schramm@manjaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

The grf serie is currently still under review. So things can change.
Must add a change log below a "---" in the commit message for rob+dt.
Maybe add a patch that fixes the reg size of "rockchip,rk3308-grf" as well?

Johan

On 5/14/21 5:00 PM, Tobias Schramm wrote:
> The RK3308 has a USB GRF.
> This patch adds a compatible string for it.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 84bdaf88d5a6..df77bd2e6752 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -30,6 +30,7 @@ properties:
>                - rockchip,rk3288-grf
>                - rockchip,rk3308-core-grf
>                - rockchip,rk3308-detect-grf

> +              - rockchip,rk3308-usb2phy-grf
>                - rockchip,rk3308-grf

Sort alphabetically.

>                - rockchip,rk3328-grf
>                - rockchip,rk3328-usb2phy-grf
> 

Also allow usb2-phy as sub nodes name.

+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,px30-usb2phy-grf
+              - rockchip,rk3228-grf

               - rockchip,rk3308-usb2phy-grf

+              - rockchip,rk3328-usb2phy-grf
+              - rockchip,rk3399-grf
+              - rockchip,rv1108-grf
+
+    then:
+      required:
+        - "#address-cells"
+        - "#size-cells"
+
+      patternProperties:
+        "usb2-phy@[0-9a-f]+$":
+          type: object
+
+          $ref: "/schemas/phy/phy-rockchip-inno-usb2.yaml#"
+
+          unevaluatedProperties: false

===
Heiko's sort rules:

compatible
reg
interrupts
[alphabetical]
status [if needed]

===

Sort #phy-cells below interrupt-names.


+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
