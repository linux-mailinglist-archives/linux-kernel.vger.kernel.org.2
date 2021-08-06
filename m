Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B33E313D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbhHFVj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:39:56 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:42739 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhHFVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:39:55 -0400
Received: by mail-io1-f49.google.com with SMTP id h1so14138861iol.9;
        Fri, 06 Aug 2021 14:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LFUiDTXxmqI19QFlwHJPxtb+BipTCydsira5/f1jjM8=;
        b=UuoIp/Cg3jFlvSpQ3HnK3Kd5KYGwcRzVnXRn4FYY4fBPnfVMvfJFTTaYPqLemp8mIw
         AUe+hdQoR49KDg5+/lducGgqrfi5Nnyx6YAbUPbUlcQF/DL2ur7U/E8yoWEiLB9YVhom
         Adu3kFWou1CNqeaQqRtVObfIYUNZx6DtPrxx1EbrQGKY9KnJI284Q3CgrqwETw6EAPbt
         Gs9bvWqWaS5UitFTjpuGFg69Ub6Qo6fYtQY6YfSKFAW/XyNgHKyIJNai1lkPJ7rMSTcJ
         cZL17wCpzZ0FSr3IW5D3gTGg1I8wloEABVuUMXczZ19K/nC4IjLXSQasIPqR2jhxGTtC
         uwbQ==
X-Gm-Message-State: AOAM533C4sx5Xc7HXacdZdyYED6sdcSlRUPdQLabt/y6Zy1GqWdePkBa
        wTCHjQoSGHIhQiSGwQGRGg==
X-Google-Smtp-Source: ABdhPJwIhWbZiov4Z+/Tf+BcwVYV4SkW2FbrmW76/c1CJtFwoThzkfW69ygmMoVvW2ARJ5u7jWgISw==
X-Received: by 2002:a5d:9808:: with SMTP id a8mr180089iol.1.1628285979063;
        Fri, 06 Aug 2021 14:39:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b23sm4582799iof.8.2021.08.06.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:39:38 -0700 (PDT)
Received: (nullmailer pid 1849291 invoked by uid 1000);
        Fri, 06 Aug 2021 21:39:36 -0000
Date:   Fri, 6 Aug 2021 15:39:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/17] dt-bindings: rtc: sun6i: add compatible string for
 R329 RTC
Message-ID: <YQ2sGGFqmDLroBtI@robh.at.kernel.org>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-5-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-5-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021 14:21:59 +0800, Icenowy Zheng wrote:
> Allwinner R329 has a RTC similar to previous ones, capable of
> controlling LOSC and IOSC and with only one alarm.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
