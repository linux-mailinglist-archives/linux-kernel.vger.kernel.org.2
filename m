Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A39362822
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbhDPS4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:56:21 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35734 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbhDPS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:56:19 -0400
Received: by mail-ot1-f54.google.com with SMTP id a2-20020a0568300082b029028d8118b91fso8159123oto.2;
        Fri, 16 Apr 2021 11:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hma+9zO1Y6oeqJ6JVhr4MtqPIcdulc3xEHbwZSzOoVY=;
        b=ex03S20ZroWbTdEFxO1ZFVXpAYwEIX2SM+fVQIpSGhz433bQvffAyCZK02tTY0Bkxk
         XceHoAIjivV8ajIrVSvlDbSXSbFO/Xn3QW5E/FqjAEyWqxs1Feh6klF8sCUkTyDKhbkk
         tY8Y60QMlwQ5nlWZujNQtE6EYnqDGvcdSRv2Po6GAw6ptHROqhq0IWDGOC4F2Q2ei8Qn
         UnfNZ+QVDFqLWgwf0eVczd8JjQH/29NSpYfLZcLzkXYXwn3enj4JAHoACP8+l8a4Ajo+
         1urb94zDOJjnO15Uz3mnu3uzyoNhaq+TIWJKIW3uuLGv7iiqiXGDmZzWnOeEsMT8LfHi
         tinQ==
X-Gm-Message-State: AOAM533nEUiuTaNzco3o84kZ7is8NFxGIS/MZ17pYRsuj/md7+B63R/r
        zkJUjfD8PqA5JLC/hkLy2bPLFz25Ew==
X-Google-Smtp-Source: ABdhPJxp/ZNYTBcin4+hkWrZfaH8k7QNcoxv1l7/DutQRgLTMiDLbgoQatvHS8OXjYhAkYyOwgnv2Q==
X-Received: by 2002:a05:6830:10d3:: with SMTP id z19mr4938562oto.59.1618599353779;
        Fri, 16 Apr 2021 11:55:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 8sm1539175ott.68.2021.04.16.11.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 11:55:53 -0700 (PDT)
Received: (nullmailer pid 3752283 invoked by uid 1000);
        Fri, 16 Apr 2021 18:55:52 -0000
Date:   Fri, 16 Apr 2021 13:55:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        enric.balletbo@collabora.com, zhangqing@rock-chips.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 12/15] dt-bindings: arm: rockchip: add more compatible
 strings to pmu.yaml
Message-ID: <20210416185552.GA3752233@robh.at.kernel.org>
References: <20210416080342.18614-1-jbx6244@gmail.com>
 <20210416080342.18614-13-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416080342.18614-13-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 10:03:39 +0200, Johan Jonker wrote:
> The compatible strings below are already in use in the Rockchip
> dtsi files, but were somehow never added to a document, so add
> 
> "rockchip,px30-pmu", "syscon", "simple-mfd"
> "rockchip,rk3288-pmu", "syscon", "simple-mfd"
> "rockchip,rk3328-pmu", "syscon", "simple-mfd"
> "rockchip,rk3399-pmu", "syscon", "simple-mfd"
> 
> for pmu nodes to pmu.yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip/pmu.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
