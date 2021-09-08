Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B292D403983
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351671AbhIHMKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:10:06 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39889 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351655AbhIHMKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:10:03 -0400
Received: by mail-ot1-f41.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so2608462otf.6;
        Wed, 08 Sep 2021 05:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrLLvw3xOTTCRU86Xfj4PMbgmYuibMDeCWrdzyiGca8=;
        b=DjjemY0QuHd0s/x+Ii3SnID2nXZc/Jwju8BloFka6+GNxhFc36J5ly5i46HHS0Mlwg
         Fw6Fz2RxYFJyxFiyS/GFq6a5mI/2sRDI+FAJsRd6FeQJ4awYkPRWjBSgOhCqLwBMhLyV
         ZjpnVVuB6VyOPKd4ui63UCxD0QhkRWEqlEmYCXPub1QzUQjW9eErYTxU98vsSkaM4Ov7
         qaAML4LYeVud8uwW90OAGyi+uarbfkj1wgdJxrcTzKkwwcDpHj6fWYMrciXp0sMeNAgN
         zrApYL6cHA9Jf105ZN6BxQo0eBhWXyHBKzedOtqXZRRpNGdpbrtrizZUDOOC6Ed2Jwsu
         ilSw==
X-Gm-Message-State: AOAM531mKoMkYx13W7JcFPoCu3XNe3fstk+NndbVJcK66m0t40Nkcdnx
        4SOCED6k412tptr7Iqldg3ZfvkiMiQ==
X-Google-Smtp-Source: ABdhPJyKe/fxlDI+Fva7pn1G9AJ4ZdpS+C3pvKgu6+LleWD1wC5liKyozojGH0TXlI8unEmxTos7Bw==
X-Received: by 2002:a05:6830:603:: with SMTP id w3mr2664233oti.147.1631102935279;
        Wed, 08 Sep 2021 05:08:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k21sm397255ots.53.2021.09.08.05.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 05:08:54 -0700 (PDT)
Received: (nullmailer pid 1867581 invoked by uid 1000);
        Wed, 08 Sep 2021 12:08:53 -0000
Date:   Wed, 8 Sep 2021 07:08:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Message-ID: <YTin1C4DHMTIAwH7@robh.at.kernel.org>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <20210903231536.225540-3-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903231536.225540-3-frattaroli.nicolas@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Sep 2021 01:15:34 +0200, Nicolas Frattaroli wrote:
> This adds the YAML bindings for the Rockchip I2S/TDM audio driver.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  .../bindings/sound/rockchip,i2s-tdm.yaml      | 218 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 219 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
