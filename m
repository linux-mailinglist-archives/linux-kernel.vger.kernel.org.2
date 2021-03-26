Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB6349EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCZBqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:46:46 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:39555 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhCZBqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:46:37 -0400
Received: by mail-io1-f45.google.com with SMTP id k25so3884140iob.6;
        Thu, 25 Mar 2021 18:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nvithE7/FIorOvL9kBoun3Ntwce32avmj2Owugyp6qI=;
        b=VwpFtPcyX80CT241/rbVTkOUgWseXvhpNzThxS8WhZ9YFjmx7lrTEob0XVHcEpYKtt
         pcOnJJp7V8bkM+nh/wZW0QrYBR4y3OEITqfb85AUvnbVnkWWCsG2mxoFnKHPV66UKcVh
         XJV7KCcDmAjDcEEznWC1aCkKn3gNoWd/muNdynd1k60S+/0fpWNHUtPPKZuEKFwQ5VGS
         gw7wNfi6fMUa6iRVcy+zu0xJWsze4xUcxAQfS+3HFKaumcscYQTgROfr/mSNavIjFhQi
         SWT2LE0aCw6wrFJWgLQbhBgn16d14dz2oqIDP7eiqzJqYb3J17HlWZpqJ+8geiInebzd
         nQRg==
X-Gm-Message-State: AOAM532xMowNi5RenJJ9liIS53BTLHaApK3NzASjKtOVGBQIgWt3HSpy
        lbzozdpHMD8UZW3uPhnfag==
X-Google-Smtp-Source: ABdhPJyDWeoqK4Lz3I+ovulrBbiFBNy8x20L52/OCMJ3dD8MkbG7dI1iRyAnnxpnYS3fxan0WplBmg==
X-Received: by 2002:a6b:5818:: with SMTP id m24mr8253046iob.144.1616723197079;
        Thu, 25 Mar 2021 18:46:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q21sm3395845ioh.41.2021.03.25.18.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:46:36 -0700 (PDT)
Received: (nullmailer pid 2154786 invoked by uid 1000);
        Fri, 26 Mar 2021 01:46:35 -0000
Date:   Thu, 25 Mar 2021 19:46:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-damu
Message-ID: <20210326014635.GA2154730@robh.at.kernel.org>
References: <20210319035245.2751911-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319035245.2751911-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 11:52:42 +0800, Hsin-Yi Wang wrote:
> mt8183-kukui-jacuzzi-damu board also known as ASUS Chromebook Flip CM3,
> using mediatek mt8183 SoC.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
