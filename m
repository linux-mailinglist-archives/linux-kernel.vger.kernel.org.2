Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B03D69D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhGZWLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:11:19 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:39795 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhGZWLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:11:18 -0400
Received: by mail-il1-f175.google.com with SMTP id r1so10475426iln.6;
        Mon, 26 Jul 2021 15:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S3bndg0PWQudUwiPkf5sUqdpIG+ck3mRjPX7ERfAv2Q=;
        b=TJyWFbYI/hlCIKhmbZovwbcRVBo2n2KNDp7BQxMei0ptcuuX/gm+Cm6fpdtSq7kxkZ
         23H89r4yGsmtW2OGtFwUU2e2I95SbRHjQlFXwtNjsKqNsuyrhzbl7aiGJdtxzN7D9ydG
         pyEcjHoVX38e1A1O4dGY6ejiP//SiaM5dE4MbZT5g2etm7aZeBHHBrMDmyyDHBeYHriY
         z+27b1tMTTNNnJeFkWuFBZuMQHZ+gDG8kENhtYc65Pfq0gpm454SM2avLjKtXLdw0EAJ
         T4RZbYWf6ivnxI3uYPBbZp/+kSMx88Z3VbA58PFRwOjJs8OfONOLLo5bF4IWvS/hcmp5
         f0Vg==
X-Gm-Message-State: AOAM531of1+VYEPaVW5oz4J+vDw167VfOHi3l6d+Ggnnt5EYw+0TvFQv
        Qu+3BxQ5YitzdThRxVVVTA==
X-Google-Smtp-Source: ABdhPJwfeJyxBqy2HaHqECAN0ktYBYR14COcSSRH65EFa47QJYrfFtFduZWq+Frg6rRYYLxxQDCUKg==
X-Received: by 2002:a92:7b08:: with SMTP id w8mr14888807ilc.190.1627339906631;
        Mon, 26 Jul 2021 15:51:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m26sm752777ioo.23.2021.07.26.15.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:51:46 -0700 (PDT)
Received: (nullmailer pid 1024213 invoked by uid 1000);
        Mon, 26 Jul 2021 22:51:44 -0000
Date:   Mon, 26 Jul 2021 16:51:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@crapouillou.net
Subject: Re: [PATCH v3 2/3] dt-bindings: Add DT bindings for QiShenglong
 Gopher 2b panel
Message-ID: <20210726225144.GA1020985@robh.at.kernel.org>
References: <20210725221527.1771892-1-akawolf0@gmail.com>
 <20210725221527.1771892-3-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725221527.1771892-3-akawolf0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 01:15:26AM +0300, Artjom Vejsel wrote:
> Add DT bindings for QiShenglong Gopher 2b 4.3" 480(RGB)x272 TFT LCD panel.
> 
> Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 3624363938dd..e7f3db118c5d 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -244,6 +244,8 @@ properties:
>        - powertip,ph800480t013-idf02
>          # QiaoDian XianShi Corporation 4"3 TFT LCD panel
>        - qiaodian,qd43003c0-40
> +        # Shenzhen QiShenglong Industrialist Co., Ltd. Gopher 2b 4.3" 480(RGB)x272 TFT LCD panel
> +      - qishenglong,gopher2b-lcd-panel

Does 'gopher2b' refer to anything besides this panel? If not, then 
'-lcd-panel' is redundant. Otherwise, '-panel' is redundant. Every LCD 
is a panel.

>          # Rocktech Displays Ltd. RK101II01D-CT 10.1" TFT 1280x800
>        - rocktech,rk101ii01d-ct
>          # Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
> -- 
> 2.32.0
> 
> 
