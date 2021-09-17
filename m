Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9073B40EF03
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 03:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbhIQCA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 22:00:27 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:42886 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhIQCA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 22:00:26 -0400
Received: by mail-il1-f169.google.com with SMTP id m4so8638787ilj.9;
        Thu, 16 Sep 2021 18:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QncgAYsEAj4J6mbF3tLEr0rEZvz4D8ZpN12NlUMUfpg=;
        b=PMLCg3P243RddnzS/h8Q00884VeMa2k0PSE+y6qhHr3QD5Xfx78rbf2iQY9zbQPLl5
         2T2Bn6V9ffh4/jiCfz1p8pjE7vhLM46Y/URLJwIm+lsDT8/g7Pvbzoz3NMWUOlvSAp/e
         bYDECF59pD5Au8gO6VhP6mKpHX2Wip9K3MC2juFkGc8aLhpFjHUHMQyghKojKfJ09eiz
         Jgf7o56Km22D/ncuglEsYrJBgbs6fBHbUD35WzJuZ63Mkg6BD16XsIrY8yHNTssxSq16
         AB9CETqEmE8O2nqXxnizm8REG1nTJHLwofZgF95sEqwlJskve032ACZMGP6/Q5Ulq8Im
         lNqg==
X-Gm-Message-State: AOAM532TdHnOO/gii/XCBZ2tKiglBpJZdVjSw3l4JB1LAB6dGfxbCqPY
        N6cUajqYmEw8wIfxltQPhA==
X-Google-Smtp-Source: ABdhPJy4oTaM24SB6z0pQT/ToKAlRejgZB3SLM155KVMirfdI7mWZ3F3MD1XWjhJyelSQtEkJV3ltw==
X-Received: by 2002:a05:6e02:20c3:: with SMTP id 3mr1021317ilq.269.1631843944967;
        Thu, 16 Sep 2021 18:59:04 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id 9sm2670305ily.9.2021.09.16.18.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 18:59:04 -0700 (PDT)
Received: (nullmailer pid 1610039 invoked by uid 1000);
        Fri, 17 Sep 2021 01:58:57 -0000
Date:   Thu, 16 Sep 2021 20:58:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Jonathan Corbet <corbet@lwn.net>,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: Re: [PATCH v2 03/23] dt-bindings: arm: mediatek: mmsys: update
 mediatek,mmsys.yaml reference
Message-ID: <YUP2YYKTVHdvTfD+@robh.at.kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
 <a87eb079a73e8ab41cdf6e40e80b1d1f868da6bd.1631785820.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87eb079a73e8ab41cdf6e40e80b1d1f868da6bd.1631785820.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 11:55:02 +0200, Mauro Carvalho Chehab wrote:
> Changeset cba3c40d1f97 ("dt-bindings: arm: mediatek: mmsys: convert to YAML format")
> renamed: Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> to: Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: cba3c40d1f97 ("dt-bindings: arm: mediatek: mmsys: convert to YAML format")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
