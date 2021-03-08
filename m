Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D5033153F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCHRwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:52:01 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:44755 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhCHRvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:51:47 -0500
Received: by mail-io1-f49.google.com with SMTP id 81so10842952iou.11;
        Mon, 08 Mar 2021 09:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1FOD5D9xxHDNgtK+29L+sX5QWs/XhQ0EtS1cLbdgvrI=;
        b=Ti/4sybBaHp1Zz4KXIaPdZaiHuKNbD1fkcNe4oyt4RHhw4GquwnBIlU9m1EDebIDss
         2RejP7vCnaZyLzHvJ9oqz2OJnmj+qpKQFe8vR8+xBTgXnodZboDcIImw2TzeUuO6fgzu
         U/3q2SShw/902ts6u4MXX4+zP8yCsJzQqw63NsNSfTIyInpuhRXK6jidvniofEhjhzpe
         7rznCsQKHJFz3rjb4YU6TAYMwygS+H4jNAQ5qP72AUCMGN1cPpwA2K2c/WYGoPqbqsrm
         WY6rCs/dX7fm+G+7trVYNq/tdF3HYXVtcfIQV77roMXaeHEcgCWZ7GfuhgHtxgjk+eDW
         8tug==
X-Gm-Message-State: AOAM533lYDIwbvfIz98mISlXAR6jwxUUp+D/vXdJsg29T5HcKzvc8kwA
        BteY1R076pz+eooylWwBXA==
X-Google-Smtp-Source: ABdhPJwUJytuS0RCGx4Q+0ue0LiQ/tA6r+XTeDw7X5gZsXBu+RQ+dGxrAGpT7mhTjck9tKkYZNtgMg==
X-Received: by 2002:a5d:9693:: with SMTP id m19mr18429388ion.46.1615225906920;
        Mon, 08 Mar 2021 09:51:46 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a5sm6523670ilh.23.2021.03.08.09.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:51:46 -0800 (PST)
Received: (nullmailer pid 2698859 invoked by uid 1000);
        Mon, 08 Mar 2021 17:51:43 -0000
Date:   Mon, 8 Mar 2021 10:51:43 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: phy: cadence-torrent: Add binding
 for refclk driver
Message-ID: <20210308175143.GA2698807@robh.at.kernel.org>
References: <20210222112314.10772-1-kishon@ti.com>
 <20210222112314.10772-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222112314.10772-3-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 16:53:07 +0530, Kishon Vijay Abraham I wrote:
> Add binding for refclk driver used to route the refclk out of torrent
> SERDES.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml     | 20 ++++++++++++++++---
>  include/dt-bindings/phy/phy-cadence-torrent.h |  2 ++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
