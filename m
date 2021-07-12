Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924853C64C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhGLUOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 16:14:30 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:38409 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbhGLUO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 16:14:29 -0400
Received: by mail-io1-f50.google.com with SMTP id k11so24285039ioa.5;
        Mon, 12 Jul 2021 13:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQIGOfZ9xP5XhtIaQ8VkC7v7sAXj1rbJpx/JTLj7+aU=;
        b=bdEPIapW2U2Lntdqx6Ifk6CRVs0gZ0nhkBwBe69g0VQVkXPsN9pwYoUDJy605xeIuT
         UssUJjFPBcW5rbQrUkbBH3Wdr3+T8zLG+FAL9QbcG41uYBFVkLXuoDUargHNsOph2onm
         wLGdVudzElutsUf+TCjVmMzd9SNPcroXdpbv40lKFOGYVNs8VQvVBs4sXLlGugTA5Ptv
         PFZ9Gp+Vm6ICFHR3asvik0VTKurZoJvSzKAux0sqD62226Y/bpEgyf6BABfk104q8C4k
         k7NfdwE5CQiIG1Vd3MQWKLw25LbGoJBG9VRmBNndw7gkl//ENUy//N/d84NualCm0w/J
         XXsQ==
X-Gm-Message-State: AOAM532OEE41mc+20/z563Ab6hD4aNk+7uwc0Gyi2QtnN8u8ZUigAMFS
        E2aTtXvznnrBklm6xMZwOg==
X-Google-Smtp-Source: ABdhPJxcpniyee6ILry/QHvrQ2OrFoTqoJfCa4tRWk9rFnfjHgLdXRmDbFPnrRFUxSH4jTF723x4ew==
X-Received: by 2002:a05:6638:264e:: with SMTP id n14mr640343jat.71.1626120700117;
        Mon, 12 Jul 2021 13:11:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w13sm8749396ilh.39.2021.07.12.13.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 13:11:39 -0700 (PDT)
Received: (nullmailer pid 2408076 invoked by uid 1000);
        Mon, 12 Jul 2021 20:11:36 -0000
Date:   Mon, 12 Jul 2021 14:11:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     soc@kernel.org, olof@lixom.net, devicetree@vger.kernel.org,
        ulli.kroll@googlemail.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: add vendor prefix for edimax
Message-ID: <20210712201136.GA2408046@robh.at.kernel.org>
References: <20210618205533.1527384-1-clabbe@baylibre.com>
 <20210618205533.1527384-3-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618205533.1527384-3-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 20:55:30 +0000, Corentin Labbe wrote:
> Add vendor prefix for EDIMAX Technology Co., Ltd (https://www.edimax.com/)
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
