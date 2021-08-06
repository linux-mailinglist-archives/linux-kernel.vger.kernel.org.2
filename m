Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6843E3148
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245289AbhHFVmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:42:51 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46674 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244031AbhHFVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:42:50 -0400
Received: by mail-io1-f54.google.com with SMTP id x10so3349907iop.13;
        Fri, 06 Aug 2021 14:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6dNm4/ayIKAUGrrE4umEzhHFHKl/3I8/jdHqQJ6Pdo8=;
        b=JGTu4y+CRIiQy0h5baLoNkud883phUcBDOJvQzxR7NgoA6SeqfudJK8LsVnZvysXJS
         JSgRBGHRunSOIzfLHCFoCYzwt0bF+Vkkz/slNQV/iEhSDCMj69SJoovkWEqiUouFCryY
         1+n32WsOOsGMaYlFbwLH5ry20cm0QzHHj41yy/9t7ajjxt9iaAwipLbB+19JXHONK8/Y
         MkIquOyiZMl3zlNxENW9gyKeXYHvw9gPhES91i6biImnmgf7TXkt1HvOfG3Eh4t5U6ww
         InwOvLI0/rtqo5HFuGvJc4fsPZNhxK5C3JP+aXDMlFNiOE9+2lhIb3qu0dqWwJ2sDtk6
         lhug==
X-Gm-Message-State: AOAM531I4dteJjWVVbZMDbPDFW/4QJCXfodgLgXQ8+6zHB8r9R0ZDhW6
        KB7bvY69JN7T8O/PrTtdkQ==
X-Google-Smtp-Source: ABdhPJxjvpIzcJ+Q1ncETcICb7qXJ/KAhp09G2GpESQjQUNQfAZiWS+hDruh5FQG9de3TYUm07UcQw==
X-Received: by 2002:a5d:8154:: with SMTP id f20mr106230ioo.89.1628286154032;
        Fri, 06 Aug 2021 14:42:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n14sm5013066ili.22.2021.08.06.14.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:42:33 -0700 (PDT)
Received: (nullmailer pid 1854231 invoked by uid 1000);
        Fri, 06 Aug 2021 21:42:31 -0000
Date:   Fri, 6 Aug 2021 15:42:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] clk: sunxi-ng: add support for Allwinner R329 CCU
Message-ID: <YQ2sxynJYuMEBNRD@robh.at.kernel.org>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-12-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-12-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:22:06PM +0800, Icenowy Zheng wrote:
> Allwinner R329 has a CCU that is similar to the H616 one, but it's cut
> down and have PLLs moved out.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig                |   5 +
>  drivers/clk/sunxi-ng/Makefile               |   1 +
>  drivers/clk/sunxi-ng/ccu-sun50i-r329.c      | 526 ++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-r329.h      |  32 ++
>  include/dt-bindings/clock/sun50i-r329-ccu.h |  73 +++
>  include/dt-bindings/reset/sun50i-r329-ccu.h |  45 ++

Same here.

>  6 files changed, 682 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.h
>  create mode 100644 include/dt-bindings/clock/sun50i-r329-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-r329-ccu.h
