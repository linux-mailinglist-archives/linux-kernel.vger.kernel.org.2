Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4386532F624
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCEWxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:53:45 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:43079 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCEWxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:53:43 -0500
Received: by mail-oi1-f169.google.com with SMTP id d20so4265387oiw.10;
        Fri, 05 Mar 2021 14:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MptyKcKkrBvMdU5T4FKB96zYxJGrM+Ad5xW7zai5ozg=;
        b=W86x2KocQaGIDTauFaPOC5s4ylDKVBcDushggROiulAEEsghMFiJ8nnsBNvwiOO7ci
         buSaFItqb6xK72Efk9CKwLd6UYlnyQYIKtUkK+G3ECR8oVXqEJFL00S2+GMGR/BrXL4D
         m84sP1NDVDGqHCSMLKYg/aQe8KidEcLRFGPYzJrswJXsr5bQRCnyaJ0zO/2/gfSA7lQm
         Jf9J8So1pb4wYRo8Th0o5Fo1f62RmnkR9Cg4F3hexsBP2cGOvMiieEYMMuJMixCeZcMW
         cb8T6En1F+QrrcHSnBBCKdGdvQ+wFUPltYB6M1F35hgoAXMef+4xYwRw5hJYxn7jcnnB
         bDWQ==
X-Gm-Message-State: AOAM5305NBZCIl+joWFNUJDg8wcERtRZVOHdVyop5NEbLw4eLR78z5DQ
        qehULCyqr8pVFTm6GQn+GQ==
X-Google-Smtp-Source: ABdhPJxdtgSbpJixrz+Z5LbK4JUHrcE45GXpKZt1VhHXd1m6xPLZB7yzMMYTbsMptezYOQkEUMS5xg==
X-Received: by 2002:aca:4a87:: with SMTP id x129mr2883349oia.107.1614984822707;
        Fri, 05 Mar 2021 14:53:42 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t2sm954269otq.45.2021.03.05.14.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:53:42 -0800 (PST)
Received: (nullmailer pid 791904 invoked by uid 1000);
        Fri, 05 Mar 2021 22:53:40 -0000
Date:   Fri, 5 Mar 2021 16:53:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        allen <allen.chen@ite.com.tw>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        dri-devel@lists.freedesktop.org,
        Max Merchel <Max.Merchel@tq-group.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/9] dt-bindings: display/panel: add Jenson JT60249-01
Message-ID: <20210305225340.GA791875@robh.at.kernel.org>
References: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
 <20210218225458.823773-4-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218225458.823773-4-giulio.benetti@benettiengineering.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 23:54:51 +0100, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Add DT binding for "jenson,jt60249-01".
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
