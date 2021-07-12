Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6DB3C64CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 22:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhGLUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 16:15:43 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:39891 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbhGLUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 16:15:42 -0400
Received: by mail-il1-f174.google.com with SMTP id a7so1585996iln.6;
        Mon, 12 Jul 2021 13:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tXKPZzwXcZV9/HhIQdnNlNgejKZgtrP4Woag5BXnZA8=;
        b=OnMRIs4hPRVSTuukOPJea/513gEPFD6tTfcVK/nFsmr35ro+ammAZ1ZmJx/l7LtWJV
         fFjAuNh0EQrV0F3qy9CaVf5oVMnBUCtJYXS96QAispIenOigh5dXslqkj40YplEoUynl
         puRMB52HlLhzjvEvnYOVDrBMJNApHGA4rpA4zLwZD1bCQh9M/jv4RZJ0KyG0201ytLzC
         8kSYYSpKdKSBQMv+mkHdoxlo83/2LOlkVfBjU7IH0UxbShC0oQDpgI8A0H3y6GRZ5cEC
         Js2E7MGQ8a4C39yLBfNKCmunrAXnO7E9ViqGd7cGD2bXycVFyaC3MEl+6QWyMXIjBeOM
         j6Xw==
X-Gm-Message-State: AOAM533aiIMQsFf5QnnYpOlltDaMPKo1RLEu6c0jxuBG6R6bB9EhdyBb
        nBFEFzlv3rw+WyFxFPo7rQ==
X-Google-Smtp-Source: ABdhPJwEiRi1fPrJ1vXs/JakffS9HIKIXv05lezYQORSM3cPk//aDIffadrxDcsjEBtl/OQj9SenMA==
X-Received: by 2002:a92:dd02:: with SMTP id n2mr376597ilm.259.1626120772614;
        Mon, 12 Jul 2021 13:12:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u16sm8177345iob.41.2021.07.12.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 13:12:51 -0700 (PDT)
Received: (nullmailer pid 2410180 invoked by uid 1000);
        Mon, 12 Jul 2021 20:12:49 -0000
Date:   Mon, 12 Jul 2021 14:12:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: mediatek: tphy: add support
 hardware version 3
Message-ID: <20210712201249.GA2410138@robh.at.kernel.org>
References: <1624070839-1233-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624070839-1233-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2021 10:47:17 +0800, Chunfeng Yun wrote:
> The PHYA architecture is updated, and doesn't support slew rate
> calibration anymore on 7nm or advanced process, add a new version
> number to support it.
> Due to the FreqMeter bank is not used but reserved, it's backward
> with v2 until now.
> For mt8195, no function changes when use generic v2 or v3 compatible,
> but prefer to use v3's compatible, it will not waste the time to
> calibrate the slew rate, and also correspond with hardware version.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: add more commit log suggested by Rob
> ---
>  .../devicetree/bindings/phy/mediatek,tphy.yaml     | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
