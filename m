Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE153D8708
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 07:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhG1FGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 01:06:18 -0400
Received: from mout01.posteo.de ([185.67.36.65]:35497 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhG1FGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 01:06:17 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 8014824002A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1627448774; bh=zwaz/1puC1BrOgvpuLqtmc0DM3Amg63/saOUUCdJnhg=;
        h=Date:From:To:Cc:Subject:From;
        b=ICD1kisduv585UraVWWQ4Wiq6rsJr8/OIwOq7oj0GIa/LW98cauufkgIU1T0VV0NJ
         jzE8QeYI75PeVqliUcXovgI2f5U+/bItTtDQbFsiYFnnBeim87gl06Hpfj5hxbGQPF
         IgRY4oCMNlPj/jDpVnoGplPT9ImyVLhZBMfDB4OsuXKHqTQs3nSQJ7yYGqpaZsuYPC
         ZFWJpxgVhCMB6GAxw5VNk5qdksxFdRysCDzVRpXuWb3+WS0Eay3axCRdg3P5IaMWIq
         B5wvBw6CEVNu0P0G7zav5XDIgjWTn4yNiTQZbFNOKq3BuH0HhxgkPhcDD2MtcnJtip
         Zm9nOmmaLST3A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4GZM7j18k2z6tmQ;
        Wed, 28 Jul 2021 07:06:09 +0200 (CEST)
Date:   Wed, 28 Jul 2021 05:06:08 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] MAINTAINERS: rectify entry for ALLWINNER
 HARDWARE SPINLOCK SUPPORT
Message-ID: <20210728070608.5f5b8d14@monster.powergraphx.local>
In-Reply-To: <20210726142943.27008-6-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
        <20210726142943.27008-6-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 16:29:40 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock") adds
> Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml,
> but the related commit 3c881e05c814 ("hwspinlock: add sun6i hardware
> spinlock support") adds a file reference to allwinner,sun6i-hwspinlock.yaml
> instead.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches  F:
> Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml
> 
> Rectify this file reference in ALLWINNER HARDWARE SPINLOCK SUPPORT.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c5a407015e2d..8f36b6763073 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -755,7 +755,7 @@ F:	drivers/crypto/allwinner/
>  ALLWINNER HARDWARE SPINLOCK SUPPORT
>  M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml
> +F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
>  F:	drivers/hwspinlock/sun6i_hwspinlock.c
>  
>  ALLWINNER THERMAL DRIVER

Uh, yeah, totally missed that. Thank you for fixing this.

Reviewed-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

greetings,
Will
