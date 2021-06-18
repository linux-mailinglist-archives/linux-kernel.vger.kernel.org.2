Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA183AD41D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 23:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhFRVIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 17:08:32 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:47054 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbhFRVIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:08:30 -0400
Received: by mail-oi1-f179.google.com with SMTP id c13so11940206oib.13;
        Fri, 18 Jun 2021 14:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F22AKDNL3d07Kxi7bAvLGrzvtDt3Ggs0m0nDR4Vfnrk=;
        b=nciQevG+X7aHBxOxbSwpoohLA8X3W27bMLtVCa5Ic0P22mo2C49MjZbNUrZpxwAe+u
         bmefIHhQXjqmOLIzgeQ4UA90KtK2yRSHwVel5TSIUqXMGTt4I4X+RMV9i6IKku7u92zf
         MxNOlz/CXiBLf6tFJvYe1+2MxmuOaTjSv/KsO28VZyUe65VO5qbp3FR+E/ZKO7H9rky3
         jLt7hJPJkswthqP9RA/wKbGCk1xVYYZ/cJBpilRVBYAsdTSczYVfA95H2OY4zvGtRgXV
         tibWpO6je7SMetSw+qBdOeXuT+2eZ8tzXtk4sMLrOhI0aEZBp/nzqLsXyDJSuEpzeJt4
         LQgg==
X-Gm-Message-State: AOAM532eMo3JhbcwLQNISXLBhFojTgISKAgPB5Fk7LH3EGWYDBlqcc5w
        TplNYcA/2P67kaZkd0P6S73AZAovFQ==
X-Google-Smtp-Source: ABdhPJxJZLUHgtZu7sTq3PAbrobAWO/1QnPSMepIbgPrF28rW+Vr/C9MDt7TspFK7/RwnzNGmtYu0A==
X-Received: by 2002:a54:400c:: with SMTP id x12mr15730026oie.89.1624050380272;
        Fri, 18 Jun 2021 14:06:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t3sm1647263oic.48.2021.06.18.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:06:19 -0700 (PDT)
Received: (nullmailer pid 2873797 invoked by uid 1000);
        Fri, 18 Jun 2021 21:06:13 -0000
Date:   Fri, 18 Jun 2021 15:06:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 1/4] dt-bindings: display: simple: add some Logic
 Technologies and Multi-Inno panels
Message-ID: <20210618210613.GA2873750@robh.at.kernel.org>
References: <20210609121050.18715-1-o.rempel@pengutronix.de>
 <20210609121050.18715-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210609121050.18715-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2021 14:10:47 +0200, Oleksij Rempel wrote:
> Add Logictechno and Multi-Inno panels:
> - Logic Technologies LTTD800x480 L2RT 7" 800x480 TFT Resistive Touch Module
> - Logic Technologies LTTD800480070-L6WH-RT 7” 800x480 TFT Resistive Touch Module
> - Multi-Inno Technology Co.,Ltd MI1010AIT-1CP 10.1" 1280x800 LVDS IPS Cap Touch Mod.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
