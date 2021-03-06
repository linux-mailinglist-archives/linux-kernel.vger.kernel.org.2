Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6A32FCFF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhCFUDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:03:08 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:44602 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCFUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:03:01 -0500
Received: by mail-pl1-f182.google.com with SMTP id a24so3031991plm.11;
        Sat, 06 Mar 2021 12:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rl3gI39V/O9J9xA+OpvlcUMaQ1pI12CT1UU/vVwFAWA=;
        b=QwXUqpb3jQxMNEwYa7Gyx/p2rVLJWkgghOQisJBTmNVuwATXbgvgs4DsphH1gFGq93
         ll8OgZlkJuj0IRkK+eZiYkNZ0Dae80ywtn8o+sapODTkJvoGCVVuL2yuk9KD7nyysaxg
         lFbrjWYc1Str7TKd57lydG2w71O79hxhhCUO0XHvmwVlrNe5cAkzVZSU5J3JQ6ZoGezB
         gnVWDkSyarQKLcSfF7Q4NVLMeTXyS8ws5PJKc2IDxJN4QzFY4Noqr8wiDF4ZLzzbbhu9
         pRXMXMgYychMKwX8GKvYj0LX1wf71ukh/+C0xfIzt3URDTkDtlu+Ux9AKDtO7NXasFEF
         hH5A==
X-Gm-Message-State: AOAM532eLg4U44HY6pq5kGr9K+dbkhtkjCInQu/j+JU6opTvPyqy9O70
        OB5mS7scLxv+V5cDsYmjug==
X-Google-Smtp-Source: ABdhPJyeBmfJrMc0Jnd9SiDCcJBT+V95QfZQwZweMLYv/hBsn4rVXviSu0TWef0nmS0FcuVJpJCXug==
X-Received: by 2002:a17:90b:691:: with SMTP id m17mr17429421pjz.191.1615060980719;
        Sat, 06 Mar 2021 12:03:00 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id y1sm15824098pjr.3.2021.03.06.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 12:03:00 -0800 (PST)
Received: (nullmailer pid 1128306 invoked by uid 1000);
        Sat, 06 Mar 2021 20:02:55 -0000
Date:   Sat, 6 Mar 2021 12:02:55 -0800
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        mkorpershoek@baylibre.com, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm64: dts: mediatek: Add mt8516-pumpkin
 board
Message-ID: <20210306200255.GA1128188@robh.at.kernel.org>
References: <20210223223613.2085827-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223223613.2085827-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 23:36:13 +0100, Fabien Parent wrote:
> Add binding documentation for the MT8516 Pumpkin board.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
