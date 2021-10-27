Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1A43D39A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbhJ0VPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:15:18 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34537 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbhJ0VPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:15:16 -0400
Received: by mail-oi1-f177.google.com with SMTP id w193so5360083oie.1;
        Wed, 27 Oct 2021 14:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LmFO9ISj7JJOkQ2M8hIxGbbUJDnwvS+JdNTBzIHK5jQ=;
        b=kE3PMkU8iFYXUdO+/si15PAnNt07eSllf9hT52NOllOOfB9QryZr/n1ZH538u/Ghvg
         2MG6wO2vK516U4ZSmu3ACxlxcwly8XiS+dcSuP87aKOdL1shnLR26mj8dv1uHu1lQkLw
         iQeUTxevPAt9yQ/oOyQio77VadfcyCwRpEcF/YIUzY86KHWaIhFTDIaDQkS0fF2Q5dKP
         lYlKXD8uvwKreHC12Zdo9SnZ/Dj4dcnNCeIARAqmbs6GXxao43z70SwjiLHsDULHXCjk
         j15Ykv1kG/oW/kJP6LM8qevbkN8k85rBPkVzAUdvKPrYPbHUj2a+UTW4g96awZi7oKrN
         5g1A==
X-Gm-Message-State: AOAM530vNO4uZ7LVwqhiwotHWm9SFLfLWg/06lFRZ9wbgsPAacSkr8+x
        ZkaemcI08OmO7YbkiI8PcQ==
X-Google-Smtp-Source: ABdhPJw3irUQ5lx7h0OxDhGXcoMJe2VJC2GTlcFMMf25h427FBJgmF3yedQkSIlnzmYwi9tpOoACNQ==
X-Received: by 2002:a05:6808:301e:: with SMTP id ay30mr54242oib.75.1635369170558;
        Wed, 27 Oct 2021 14:12:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bd39sm507021oib.2.2021.10.27.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:12:49 -0700 (PDT)
Received: (nullmailer pid 2170245 invoked by uid 1000);
        Wed, 27 Oct 2021 21:12:48 -0000
Date:   Wed, 27 Oct 2021 16:12:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Flora Fu <flora.fu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v3 3/7] dt-bindings: arm: mediatek: Add new document
 bindings for APU
Message-ID: <YXnA0FIzpSUwAR2x@robh.at.kernel.org>
References: <20211023101334.27686-1-flora.fu@mediatek.com>
 <20211023101334.27686-4-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023101334.27686-4-flora.fu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2021 18:13:30 +0800, Flora Fu wrote:
> Document the apusys bindings.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,apusys.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
