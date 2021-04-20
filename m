Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BE1365F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhDTSa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:30:29 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:39552 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhDTSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:30:26 -0400
Received: by mail-oo1-f42.google.com with SMTP id g9-20020a4ad3090000b02901ec6daba49aso1859592oos.6;
        Tue, 20 Apr 2021 11:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sP61S/5Ei7GoLiO2+Xq/4uwjVjtkrBpHlzUNjBjvixU=;
        b=mND0Kw39pHBXVCVwOccmZIJkwtAyLNvTskXxD/N9//MeAiTU+Ej8qZiIqFySs4mllb
         K+HiOEjSCcBVYQaclaXFHKyb34V0HBdkmTjSyhNN/Ptp2dqb8lHZUKvFSjkC8GabG9hE
         L1MVXtsEEqpHrjiLlZlEH/oC4OPNUFYjAcgjKe+FWTOZbFFuuysfeFiMg+IA4fRq3IY3
         3ZeQr8rye25e6rKY5YDUKzHXdc0QU5ITUQPCGeTgJJxnYTVSycsRqrcNufOnGIWcvPty
         RUtrjXyBu8CGiA4rvM8Xea4p6JWw/k4vrvX+RE0d0oDz9crSvCclslIsow0Ehl/JeeRi
         XpGQ==
X-Gm-Message-State: AOAM533q9Q5SSt4FO4jgECRQBNmZb5QCyBCMk/NEuhA6JRVL2XwFTN9G
        yP60DRTPlliZliN0QOYYMw==
X-Google-Smtp-Source: ABdhPJy/xdD2FX9SeCd0t6/y5ntqAQbXa6eJ9+A391M7uk2ybqFLJ+beapdhokRWa8De5UfdHnpYtg==
X-Received: by 2002:a4a:e615:: with SMTP id f21mr17906359oot.41.1618943394364;
        Tue, 20 Apr 2021 11:29:54 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 34sm552948otf.38.2021.04.20.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:29:53 -0700 (PDT)
Received: (nullmailer pid 3596620 invoked by uid 1000);
        Tue, 20 Apr 2021 18:29:52 -0000
Date:   Tue, 20 Apr 2021 13:29:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/8] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-burnet
Message-ID: <20210420182952.GA3596569@robh.at.kernel.org>
References: <20210416164055.3223088-1-hsinyi@chromium.org>
 <20210416164055.3223088-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416164055.3223088-3-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2021 00:40:50 +0800, Hsin-Yi Wang wrote:
> Burnet is known as HP Chromebook x360 11MK G3 EE.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
