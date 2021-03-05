Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6223932F62F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCEWza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:55:30 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41737 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhCEWzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:55:18 -0500
Received: by mail-ot1-f49.google.com with SMTP id w3so3377561oti.8;
        Fri, 05 Mar 2021 14:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LvO/pXvRIOKjKpXkJTQlwURSVtLYQ3uX1kCxtEQMd4=;
        b=ns83OqMOwxbsfJehwiBy1St7nwhB+h+a/zG0F42nvKynYZLFFL41j+m9pdONifPxZB
         4sPw4k3MOoAyBXSnBs/efNR8XZvELAhguAe7yMvzUogfVvj0SR7GlCZDpZcSabagMRj9
         TiSp8nYCTWZj30GZkJsPJMCNmR6MY8192Zf6+Tu0y7eaidXpMyuD83n1vtwewAC+IqSM
         IuuOe4K1cR4hTwPpGot1JuaZtwa3rQN/8WREDP6dvqVA7cuNUcyE0f8g4Mw2rnvG7R25
         wrhw40vyvx5hzhQP/hVc7txw6eW9m5QjGuY6zYPK03YKC6yjL8wP1a8fB3ubZ+1rgMzM
         NLwQ==
X-Gm-Message-State: AOAM533HZ1UKyuA/FuDAyhaYfmghh2ixCLkcuG3QsYEdQBLfTlnyKCjg
        uWsxe63rH2wa1baBexsTRw==
X-Google-Smtp-Source: ABdhPJxfJBjhLPRwDXPm3FVxlkMZT61cTRJ2+/ZaWzPtwZvm0JFTwdGdR8BnqBZHjEsiGVwt1MSddg==
X-Received: by 2002:a9d:788:: with SMTP id 8mr4984590oto.197.1614984917483;
        Fri, 05 Mar 2021 14:55:17 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b14sm828586ooj.26.2021.03.05.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:55:16 -0800 (PST)
Received: (nullmailer pid 794144 invoked by uid 1000);
        Fri, 05 Mar 2021 22:55:15 -0000
Date:   Fri, 5 Mar 2021 16:55:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Max Merchel <Max.Merchel@tq-group.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/9] dt-bindings: display/panel: add Jenson JT60250-02
Message-ID: <20210305225515.GA794098@robh.at.kernel.org>
References: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
 <20210218225458.823773-6-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218225458.823773-6-giulio.benetti@benettiengineering.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 23:54:53 +0100, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Add DT binding for "jenson,jt60250-02".
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
