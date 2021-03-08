Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1390C331AD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhCHXKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:10:01 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:36367 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhCHXJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:09:56 -0500
Received: by mail-io1-f45.google.com with SMTP id n14so11894127iog.3;
        Mon, 08 Mar 2021 15:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d9qdA9Y+xT1jiSESbe2fYHu9PMJNDVhY8kjXY15A+T0=;
        b=BK1KmD+Z6xfRYe7Fa8YxaoNDUM57E8KJGDMlkn5F+eGcqCMtbmWYs8KBbkvXsnoz3x
         +HtwGd93u2GXTqC1a8kPyKt7ROi2ExYPeEL0JVh1TQL+7eQJftr651DN54pb2UkSDqpa
         Ab+xJ/aUi1QABUU7B03W6ym7Dvr5+0kQiNCBlKbC9eKNXbbj5LuC5pu/Mrv7DRwraHBv
         cZeezc8q+C9zEnUxmbf9q01v42I/KCIuu+gHxOOU73ppQv/kocSCB1wm7CzwYQ1c3d7z
         eK0Gfmg9BK42YHAqGjW5tvIWtK4WwUJHX/2XMUb/tzaxldJVndSaHiw2PaWeMfU02gfv
         E1vA==
X-Gm-Message-State: AOAM533cg1djvxwmVdHl5N25DNP8tZa/9eV5DGK+a+/DrVx3zzm3CCp7
        4jN0ZKBKNw+1KBcWCZnxwe9vGge9/Q==
X-Google-Smtp-Source: ABdhPJwnPArl8lOuREEmgmFXC1BTCoNu9K/bNxJK1f13pcd1fHZaDB/4EwNahOpKKwS/g95K2Crkkg==
X-Received: by 2002:a5d:9e47:: with SMTP id i7mr20762814ioi.104.1615244996209;
        Mon, 08 Mar 2021 15:09:56 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y18sm6848627ili.16.2021.03.08.15.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:09:55 -0800 (PST)
Received: (nullmailer pid 3121887 invoked by uid 1000);
        Mon, 08 Mar 2021 23:09:53 -0000
Date:   Mon, 8 Mar 2021 16:09:53 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 11/13] dt-bindings: phy: phy-cadence-sierra: Add
 binding to model Sierra as clock provider
Message-ID: <20210308230953.GA3121857@robh.at.kernel.org>
References: <20210308050732.7140-1-kishon@ti.com>
 <20210308050732.7140-12-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308050732.7140-12-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021 10:37:30 +0530, Kishon Vijay Abraham I wrote:
> Add #clock-cells binding to model Sierra as clock provider and include
> clock IDs for PLL_CMNLC and PLL_CMNLC1.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/phy-cadence-sierra.yaml        | 17 ++++++++++++++++-
>  include/dt-bindings/phy/phy-cadence.h           |  4 ++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
