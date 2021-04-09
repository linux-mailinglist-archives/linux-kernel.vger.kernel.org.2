Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81D735A5AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhDISX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:23:56 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42797 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:23:54 -0400
Received: by mail-ot1-f53.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so697478oti.9;
        Fri, 09 Apr 2021 11:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d207QBVLXb7TnGS575+pzpbSUq1/8jioPIMHCrj9Isc=;
        b=PHR6B/PVqyx0UMoN/lGgksvY2PUX0tQOrBV4jYqNuTqWGCb3p6YRB34jzbW83g7pis
         R1LSPrfqWWyfx46b7ck4FvXBWWCr6MUdle7tdwl7Eu++OB85vPed2rvzJrHe0GJTfKhr
         g/0pW4/muvwjGBae34r0te8b8TYXN+HnP8pGfM1j4zrieMmzStG6UDlbxcIJ0vOnJWIC
         vR+P2DmL9apHv2gBvGbxAhN8SoGn6j4fWy3OgS5rcAGO0zqYB3VIBI8f1IQyzar8Uv8X
         H+Fu2SWDPBW5O/Q8RXJztu1aKbagKVsE5FG+hDk5hHlatGA++UlAPRNBahg/XN6nE7UE
         gM+g==
X-Gm-Message-State: AOAM532LdEZ8R6XI0H401tShH7zl/Hx62HwWHYBIza9bVxWNoABiIagO
        1iGygUqO+dQIhDUkLt/AiA==
X-Google-Smtp-Source: ABdhPJzRgWnpxCjum+zOKwCCVU1QTor6U2aI8C2aYZTN61R1qG4ctru1jV7yiE5oulHX5NC/Kkzkhg==
X-Received: by 2002:a05:6830:14d6:: with SMTP id t22mr146613otq.152.1617992620114;
        Fri, 09 Apr 2021 11:23:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 128sm661264oog.37.2021.04.09.11.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:23:39 -0700 (PDT)
Received: (nullmailer pid 3913489 invoked by uid 1000);
        Fri, 09 Apr 2021 18:23:38 -0000
Date:   Fri, 9 Apr 2021 13:23:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Flora Fu <flora.fu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: apu: Add MT8192 APU power domain
Message-ID: <20210409182338.GA3895583@robh.at.kernel.org>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
 <1617766086-5502-4-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617766086-5502-4-git-send-email-flora.fu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:28:01AM +0800, Flora Fu wrote:
> Create MT8192 APU power domain bindings.
> Add top power domain id.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  include/dt-bindings/power/mt8192-apu-power.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8192-apu-power.h
> 
> diff --git a/include/dt-bindings/power/mt8192-apu-power.h b/include/dt-bindings/power/mt8192-apu-power.h
> new file mode 100644
> index 000000000000..b821bd4811a6
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8192-apu-power.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8192_APU_POWER_H
> +#define _DT_BINDINGS_POWER_MT8192_APU_POWER_H
> +
> +#define MT8192_POWER_DOMAIN_APUSYS_TOP	0

Really, you don't know what the other power domains are? Please make 
this as complete as possible. These headers create a merge mess.

Rob
