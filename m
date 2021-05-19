Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA623897D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhESUWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:22:38 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41732 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhESUWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:22:37 -0400
Received: by mail-ot1-f41.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so12868732oth.8;
        Wed, 19 May 2021 13:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uvlLvoBclCDrgerZoN2kUifuo6+qRvAzD4p+vHWf9lw=;
        b=uZO+8Qz4Wl4feG8E7H6GQ2MT6Me93Ps492fWnsNWxZyIrgw66/Kbv+8j7s+QoIfVJu
         4f+sXGwdAztKM55G3So6vsNeK6sG0uzUthRUQA8txoQ2pYVi2Xhr7Zh3j1ZWTXG19HUi
         6SwTjYor9Y6ybUcLbd02dPxB5NoClW7cn1f1j+RkdZc9BekN8hJSSZqJbf5UQia4PQXD
         co3wcYjBLqjfQ5C0tjqhFI7X+114DGk2eIvURYJIUyG5rckOqoBlARq8RcUPrkYUowFd
         bdhorXjrgwc6MLYS6f3q/xSgPENYpUUihZ1XcqaTdczIoeqIYGo5oSQXFNmIKVX3Ijlp
         KKxA==
X-Gm-Message-State: AOAM530DEPmQ4H6dloicFoc/QIVReQRQ91W8mHpoJcQjMkXukJRiYiIH
        VAjd8UXEDePnOmhy3VDc/gXiqVmYIA==
X-Google-Smtp-Source: ABdhPJx++yl90zVKRdi3iZxZSviC1LWSXM6PVj1zj9ra7Dq5mSBR1BKrsnV/efeQLRqPmz8Zu4b1KQ==
X-Received: by 2002:a9d:269:: with SMTP id 96mr1061313otb.222.1621455676488;
        Wed, 19 May 2021 13:21:16 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q22sm158231otl.11.2021.05.19.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:21:15 -0700 (PDT)
Received: (nullmailer pid 3582732 invoked by uid 1000);
        Wed, 19 May 2021 20:21:14 -0000
Date:   Wed, 19 May 2021 15:21:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, David Jander <david@protonic.nl>,
        linux-arm-kernel@lists.infradead.org,
        Robin van der Gracht <robin@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/3] dt-bindings: display: simple: add Innolux
 G070Y2-T02 panel
Message-ID: <20210519202114.GA3582681@robh.at.kernel.org>
References: <20210518071555.9785-1-o.rempel@pengutronix.de>
 <20210518071555.9785-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518071555.9785-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 09:15:53 +0200, Oleksij Rempel wrote:
> Add binding for the Innolux G070Y2-T02 panel. It is 7" WVGA (800x480)
> TFT LCD panel with TTL interface and a backlight unit.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
