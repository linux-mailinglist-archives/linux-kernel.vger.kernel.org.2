Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59D3F6169
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhHXPS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:18:28 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:39510 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHXPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:18:26 -0400
Received: by mail-ot1-f52.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so46951670otf.6;
        Tue, 24 Aug 2021 08:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xzCZ/DSiFpYX/pfQQrLjgsOGXJhpAq/f18GVHHyrKso=;
        b=WJgog8Pc0RQGH3SBbAfxVG/yGISuoGmaOARg88M7UOe9WZcwa12+q8ORrmqEq4/hyk
         J6zg+RGwKz7Rwq/N+k+f/TlUYjI96GZFqm6pdnBSyxcS+lRn74oTx0iy5k15rf9WhXIS
         IqSRoAgdPpIzP4ODnfPpJQR3v1NcEtUoOqxv9fQr/y3rDmVugVok6DDNfDQvJUBNx8Aw
         atbK5ccvXNhIoY+kbiT1oojFRG4iF05HFpf9fOxVTmDxRzvVSrpU11Edftr+KX24CSzW
         6EX9OWzli5y4Nw2XILcs3CUsKQhxjizUV9cq2fBdJpyoACj77xY3v5R7Em/y6Oi9yEpy
         wkfw==
X-Gm-Message-State: AOAM531t70qgFdYxOvvW9/jVpa6/iyt2aQDW+iJho008NJwV3KrvKKkD
        ZVvkpQJCX4CIzC3nR/28Aw==
X-Google-Smtp-Source: ABdhPJwEpQ4jQKM+F7cNh3mpA5TGHYL1v0YAFfYdETQzN7PRWoBSPCQp/mS1+w6gaZfI+6Ace00BLA==
X-Received: by 2002:a05:6808:19a:: with SMTP id w26mr3305105oic.80.1629818261783;
        Tue, 24 Aug 2021 08:17:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w15sm4258088oiw.19.2021.08.24.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:17:41 -0700 (PDT)
Received: (nullmailer pid 467053 invoked by uid 1000);
        Tue, 24 Aug 2021 15:17:40 -0000
Date:   Tue, 24 Aug 2021 10:17:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        srv_heupstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [v2 02/24] clk: mediatek: Add dt-bindings of MT8195 clocks
Message-ID: <YSUNlPq2jY6ZM09J@robh.at.kernel.org>
References: <20210820111504.350-1-chun-jie.chen@mediatek.com>
 <20210820111504.350-3-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820111504.350-3-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 19:14:42 +0800, Chun-Jie Chen wrote:
> Add MT8195 clock dt-bindings, include topckgen, apmixedsys,
> infracfg_ao, pericfg_ao and subsystem clocks.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8195-clk.h | 864 +++++++++++++++++++++++++
>  1 file changed, 864 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8195-clk.h
> 

Acked-by: Rob Herring <robh@kernel.org>
