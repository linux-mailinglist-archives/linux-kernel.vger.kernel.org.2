Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4C234B87F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhC0R3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:29:09 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:40718 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0R2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:28:44 -0400
Received: by mail-oi1-f178.google.com with SMTP id i3so9034720oik.7;
        Sat, 27 Mar 2021 10:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=43kaMhB3q/Kj38hyiBJmFaUkUztVOtgdfAsesdOAszA=;
        b=mZhIQR4JIceCBLpUQqDMbN7r9afCHZ4MbjxJEe5pK33q2AgOk9EWQfcLSKTlEB0NU1
         bjE32hJ7HzOen0EinUEKe6eAvAOujsjeSlDGdzUs/e96W8FNXvKmGw1UUwz8dITD4BvL
         ASDCiLjQa0mJ/8iD3ngawINBkM3K/I9fnqVWKed4iIPfGPbybiYdEReD77nbVaLfNpP1
         FKwwOb5NiZirPNjs1eJzbh/rJbdfWl5fwiZIP57fC3fF60Iu9soCoiA5xtkSPwgPtdhp
         9Pg0traaYWgSw0tAl78vnBNeccsbKAcyO+tg4ZhIkNkLCDoT0GpILp6kq6F3/M64iFGL
         4raQ==
X-Gm-Message-State: AOAM5337W7XX+SFsK/XWD6DWbwSHw3lNMLrZrPKby0Ke3MhbKs9XSEP0
        sHyhOBP3ZPfDiByy2/EhvA==
X-Google-Smtp-Source: ABdhPJwnDrTWcH4ZbP9AsCzdaGXUuDULIbvwhDZ5vBzuAa7ucioqsV+K9RS+lK09Q2VOPmpau0ZYfA==
X-Received: by 2002:aca:b787:: with SMTP id h129mr14030961oif.58.1616866123966;
        Sat, 27 Mar 2021 10:28:43 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id i4sm2459520oik.21.2021.03.27.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:28:43 -0700 (PDT)
Received: (nullmailer pid 281403 invoked by uid 1000);
        Sat, 27 Mar 2021 17:28:40 -0000
Date:   Sat, 27 Mar 2021 11:28:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 03/13] dt-bindings: usb: mtu3: support wakeup for
 mt8183 and mt8192
Message-ID: <20210327172840.GA279100@robh.at.kernel.org>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
 <1616482975-17841-3-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616482975-17841-3-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 15:02:45 +0800, Chunfeng Yun wrote:
> These two HW of wakeup don't follow MediaTek internal IPM rule,
> and both use a specific way, like as early revision of mt8173.
> 
> Due to the index 2 already used by many DTS, it's better to keep
> it unchanged for backward compatibility, treat specific ones without
> following IPM rule as revision 1.x, meanwhile reserve 3~99 for
> later revision that following the IPM rule.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: modify revision format
> ---
>  .../devicetree/bindings/usb/mediatek,mtu3.yaml         | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
