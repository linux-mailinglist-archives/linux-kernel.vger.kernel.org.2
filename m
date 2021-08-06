Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1463F3E314A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbhHFVnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:43:06 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:34423 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244031AbhHFVnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:43:05 -0400
Received: by mail-io1-f45.google.com with SMTP id i7so7980311iow.1;
        Fri, 06 Aug 2021 14:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qd944/33EGNvarYt9LguiByGSn6PliDxz6H/Wc7YWo8=;
        b=D3x2EDAsLQtfXHecAlpmcX8CuDYZxwJp4UhDuPch6aA33mFULGWPO/KgtYduruH5lp
         cqxncfEg88/xvbYBPBMLKn3QCXKeftvWLxQTWdK/RrM2cZe5Yl6viz94VR58WhJCXYkI
         PqZfGYvVCRfG03YX4qyAZzYECv02XWrKiy9P2siF66nLIBZM2zw85GJPtmO5XkGAEPnS
         QfXexHBEBw/SFpcuKuuhm9dX9h6yzZczwkJBr/HaHzGpNSyvOSfdOcWOiIQOtXG8xZgL
         z86ZVnh+1Y8c7uiuTLPoP7t+BE8Zq85vrIYGDlhrE9rVCVnwqbIh9jjfClPqQsaKaysZ
         j7WA==
X-Gm-Message-State: AOAM532Jvz3oaSdoZCaMWL6B0xz0xRB8+yB1Ksw65vKAqCM3XBBgccLt
        2/lwXYbf5WC4STtv+47WkA==
X-Google-Smtp-Source: ABdhPJz+ZOeoBtNGfcez4vKR0YkxjL0B2Oc4THdp++CjixnxsCCq3YPDlYVhyfTSfhujhXR42ytigA==
X-Received: by 2002:a05:6638:208:: with SMTP id e8mr11670283jaq.66.1628286168793;
        Fri, 06 Aug 2021 14:42:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d16sm1087635ilc.39.2021.08.06.14.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:42:48 -0700 (PDT)
Received: (nullmailer pid 1854740 invoked by uid 1000);
        Fri, 06 Aug 2021 21:42:46 -0000
Date:   Fri, 6 Aug 2021 15:42:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@lists.linux.dev,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 12/17] dt-bindings: mmc: sunxi-mmc: add R329 MMC
 compatible string
Message-ID: <YQ2s1gUHJJjaizsC@robh.at.kernel.org>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-13-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-13-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021 14:22:07 +0800, Icenowy Zheng wrote:
> R329 SoC has two MMC controllers similar to ones in the previous
> Allwinner SoCs. However, as R329 has no eMMC controller, the two MMC
> controllers look like a mixture of previous SoCs' ordinary MMC
> controller and eMMC controller.
> 
> Add a compatible string for R329 MMC controllers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
