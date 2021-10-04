Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D04E421464
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhJDQtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:49:36 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45845 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbhJDQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:49:35 -0400
Received: by mail-ot1-f49.google.com with SMTP id e66-20020a9d2ac8000000b0054da8bdf2aeso20153646otb.12;
        Mon, 04 Oct 2021 09:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bX1AWjTVQ99QhdMBAvTgxvLZsO8dKqZ24tnr3dEHNw8=;
        b=sdBcnya7haGVyy8rMSgoNrblNYqgnUM4BQuTXmSMbUJ1z2rQ5ZTp9lQwwU8/XFSwW1
         9SkXzPgWzfwtvGOEVrRb1ptnzfnRPem3vQSoc3SuQrrWsdHxwxbftPWEGGGwv/6Za0lR
         bmJgiaILq//JB5U/DX4yFWV81S8ZxdQmbR0aMW1kEhVbgxJIMVj4NlXzM588xYU4s043
         cb7rX/z9OYJJyECg+6EAoxQ4brgetgL0w/+CEkHRRQ77Q3wIwBmwSoVz4R7Bwyk3Uf9h
         GorVObrfEWuPTWPb8G5K5u7fqaFBloCElEjB5v0HC6dscRzfKqH3aY5I69D2VEUqRZxm
         j9mQ==
X-Gm-Message-State: AOAM533TUyY1PcTAaZC8oxf8ry/iFCkIzHzr6lG0KgIpvu5zgCqsS977
        bKjkzxtMgNPgiPX0qsvQ3w==
X-Google-Smtp-Source: ABdhPJwRXaKWlO5doyFlIqDOX6eKpoHs6FSOnYo+lTc7QnEVeYigsMQ3rRlJ7Hq/fQ3+OH+d8D37Lw==
X-Received: by 2002:a05:6830:3486:: with SMTP id c6mr10175603otu.101.1633366065420;
        Mon, 04 Oct 2021 09:47:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g12sm2919168oof.6.2021.10.04.09.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:47:44 -0700 (PDT)
Received: (nullmailer pid 1453765 invoked by uid 1000);
        Mon, 04 Oct 2021 16:47:43 -0000
Date:   Mon, 4 Oct 2021 11:47:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     drinkcat@chromium.org, matthias.bgg@gmail.com,
        Rob Herring <robh+dt@kernel.org>, chunkuang.hu@kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>, kernel@collabora.com,
        eizan@chromium.org, hsinyi@chromium.org, jitao.shi@mediatek.com
Subject: Re: [PATCH v4 2/7] dt-bindings: mediatek: Add #reset-cells to mmsys
 system controller
Message-ID: <YVswLzTQhuj7zI4Z@robh.at.kernel.org>
References: <20210930083150.3317003-1-enric.balletbo@collabora.com>
 <20210930103105.v4.2.I3f7f1c9a8e46be07d1757ddf4e0097535f3a7d41@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930103105.v4.2.I3f7f1c9a8e46be07d1757ddf4e0097535f3a7d41@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 10:31:45 +0200, Enric Balletbo i Serra wrote:
> The mmsys system controller exposes a set of memory client resets and
> needs to specify the #reset-cells property in order to advertise the
> number of cells needed to describe each of the resets.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Based on top of the patch that converts mmsys to schema
> 
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
