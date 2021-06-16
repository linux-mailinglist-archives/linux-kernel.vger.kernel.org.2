Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D153AA769
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 01:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhFPXZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 19:25:05 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:34765 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhFPXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 19:25:04 -0400
Received: by mail-io1-f41.google.com with SMTP id 5so1055192ioe.1;
        Wed, 16 Jun 2021 16:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sT55r6CNEZMib5uoieAPwMKrpqQFOR915u+G/id+O8c=;
        b=ZTouQHEmY6f5xu1dNeNl7sYyszj4p4JiM9b2KKTSadUIW+T+wD0OfreXgCcBKrHFMO
         oM9XpZYgUpSoG0UXuUp6tk/WMy4bYmggwW1VA/+r7/OhtMGtvW6QKlkeOqhVv84Fp7Mx
         OQLvFyWr9AEOftvs4HS/3pCR3yR56fp8gztSXW0nIdzyGW/tN7MVOjhWIZ0BAT5E87MT
         m4guuqDofH8ANKezAAzuYes8zqHXujzCO48gsC+4RTe1UETJANlQr6hPVuNaOLA+eA4W
         LdX3yjhDjt4B4FwY4uGQCUf/jublR6ucpGUHlRtFr4BZL8bP15ezN4JGq2F3CeWiGv4y
         9vTw==
X-Gm-Message-State: AOAM5322fKbdEL0kfY1agHKKMqbnGMVFrfv5aInCUEsdKo1IZ1Y79uO6
        nlwR62D5TV2TNOPcujEUDigdXczVmw==
X-Google-Smtp-Source: ABdhPJxz0m48Lc6wge8V7RgY/VykuKzOdsCXuhgzkBYxqe29UMDL46K1NPHO39N8+gpYuvPhjjXiiw==
X-Received: by 2002:a6b:8f81:: with SMTP id r123mr1108781iod.154.1623885776371;
        Wed, 16 Jun 2021 16:22:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e4sm1829304iow.47.2021.06.16.16.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:22:55 -0700 (PDT)
Received: (nullmailer pid 277485 invoked by uid 1000);
        Wed, 16 Jun 2021 23:22:53 -0000
Date:   Wed, 16 Jun 2021 17:22:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-cerise
Message-ID: <20210616232253.GA277451@robh.at.kernel.org>
References: <20210604052312.1040707-1-hsinyi@chromium.org>
 <20210604052312.1040707-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604052312.1040707-2-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021 13:23:12 +0800, Hsin-Yi Wang wrote:
> Cerise is known as ASUS Chromebook CZ1.
> Stern is known as ASUS Chromebook Flip CZ1.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
