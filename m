Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020124247FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhJFUgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:36:54 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40521 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJFUgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:36:52 -0400
Received: by mail-ot1-f45.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so4710544otq.7;
        Wed, 06 Oct 2021 13:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E7TG+Uac4bJI7YKY+TM3uFDkJ28g/4VdhiFymUZGx+g=;
        b=WeAmN70WYZ7hyWw4k0xXPEW6p0cI4UhL+hhtLLbDGqloZMl9wFedR7JruDu2WbL0EU
         OGw9df+ZedPnga3gRQxd8Cj8mueNUIll99ugFl1Q75+Ar0LNcrcTL/aygeQ9dsJtmv26
         jKudYfuaixdLkVeesNHcJp8kkcNx7sIFfL5Aw38bKqX1RK6Xqi4u/VLienfj18EtwDFq
         CP/FieO1H+bGX3nGaYTyl/JV8fTTuXwuI09Bq2QfK2CjcRvqvaYcOowybHH1agDHXwkh
         ixybDPwhl0Q2A2I2cE2tQ5lahsBvoSDgV8XmcRVeyGS/nMmg195z5FaEzvvGmlka/0tv
         DzKw==
X-Gm-Message-State: AOAM530Xy477HpRcFeL/s08zGa1DGo1Crm2mKLZ/t5/wpyRnLGsFE3NI
        rXgQzPJkpx96kPAncvvosw==
X-Google-Smtp-Source: ABdhPJxbEWwDH9gdxDVfwWllfZTAK9KZZ4LOqy8pBSoAuEChSsWJ4j6phpzKcAtlTbWut41rkvsvqQ==
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr268795otj.191.1633552499973;
        Wed, 06 Oct 2021 13:34:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w141sm315186oif.20.2021.10.06.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:34:59 -0700 (PDT)
Received: (nullmailer pid 2823957 invoked by uid 1000);
        Wed, 06 Oct 2021 20:34:58 -0000
Date:   Wed, 6 Oct 2021 15:34:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philip Chen <philipchen@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        dianders@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        swboyd@chromium.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] dt-bindings: drm/bridge: ps8640: Add aux-bus child
Message-ID: <YV4IcnuERzAxckIV@robh.at.kernel.org>
References: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <20210929173343.v2.2.I6050ba184b24d887e92692a72ee3054d643d6091@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929173343.v2.2.I6050ba184b24d887e92692a72ee3054d643d6091@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 17:34:57 -0700, Philip Chen wrote:
> dp-aux-bus.yaml says we can list an eDP panel as a child of
> an eDP controller node to represent the fact that the panel
> is connected to the controller's DP AUX bus.
> 
> Let's add it to the ps8640 bindings.
> 
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  .../bindings/display/bridge/ps8640.yaml       | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
