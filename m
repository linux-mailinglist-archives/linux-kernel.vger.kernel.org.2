Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECC135D131
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 21:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245301AbhDLTih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 15:38:37 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39868 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhDLTif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 15:38:35 -0400
Received: by mail-oi1-f178.google.com with SMTP id i81so14593418oif.6;
        Mon, 12 Apr 2021 12:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+YGPC6j0Haf5jPJGvyQH9U1N8NEZhf+Gd+k7m/Egkc4=;
        b=WkP/0rSqEmaPTyPduPyvr4tQ4i12/DRkCMAigk5wyZBCmNlYDfSAeBIAvg3N8zx+ah
         nlhg1yJ0caGjmMg+SNkTJbBqMbUfXVTXGInr2yQCsrtUqMLkJLjvocLsn7DNo+dWb49T
         3knwCUevnb09W/XN1ahx/yo6tSZn46yiDAmgDR4TLAx+ae5ZlFDV5dZOp8DJyPMA1X/w
         F6IaESKZ/te+0i+EXxXF1aFUOk5KRHS02pUb4xBX+Y9TAGyoIwHWd5gWlkaRwoI64uUj
         60lv37I57juHJA5iHUsmJs3SVWCKj75g/VBHmAcTGdjIhwcogEZOXCBX9E8uDL2HcK5k
         aHUQ==
X-Gm-Message-State: AOAM5332yFvYlSCMkFW+Z5PJVdTgbS4Wu5vd/vvBXvV14qt45276BPvg
        RVigMaM9ZXRh2VlpE2Vi33mvL02cbA==
X-Google-Smtp-Source: ABdhPJwEYboQJdDHmtsifAJ0k0QLcvHMN4a2nDgSlZ2sVnTxA6x2CYbjGtVvUUODi9aPRJ1wH5BRZw==
X-Received: by 2002:a05:6808:57b:: with SMTP id j27mr559474oig.161.1618256297227;
        Mon, 12 Apr 2021 12:38:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j4sm2262581oom.11.2021.04.12.12.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:38:16 -0700 (PDT)
Received: (nullmailer pid 55658 invoked by uid 1000);
        Mon, 12 Apr 2021 19:38:14 -0000
Date:   Mon, 12 Apr 2021 14:38:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        narmstrong@baylibre.com, sjakhade@cadence.com, daniel@ffwll.ch,
        robert.foss@linaro.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, laurent.pinchart@ideasonboard.com, nikhil.nd@ti.com,
        mparab@cadence.com, airlied@linux.ie, a.hajda@samsung.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Message-ID: <20210412193814.GA55613@robh.at.kernel.org>
References: <1618078449-28495-1-git-send-email-pthombar@cadence.com>
 <1618078508-30466-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618078508-30466-1-git-send-email-pthombar@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Apr 2021 20:15:08 +0200, Parshuram Thombare wrote:
> Add binding changes for HDCP in the MHDP8546 DPI/DP bridge binding.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp8546.yaml    | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
