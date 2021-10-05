Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761AA421FE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhJEH5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhJEH5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC6C061765;
        Tue,  5 Oct 2021 00:55:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso2173730wme.1;
        Tue, 05 Oct 2021 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnxkwu+jla6ut+IvJVQYqIBJUbwnUPabboo+Da4W4N0=;
        b=m8HoarMf1s6bCFaOn4CAiigvWMxLZaKUuCApzgBtO13KGqb7AL+XMf/vcB6EwZ81vr
         lKvNjWiIgPb/ptbHjUWaeRq6hU3RfQ0AkSDBRllvHYp3vo1lAyCNAJYHLeyagQpAYSl6
         YyNqZ4rngJuXv/mVHLUleOuHmJPkGJHI1eJU1Ba0X8aURaBZgm+Y9SWOyZTM19IwNzzs
         GKASX840Y7oZQ0IvSPoBRXTR9mfVksBaKC7Mss5ySeAp1rmiAjZM02HilS7m+lfPAJTo
         0/36WefREyNKwSsfp8wAfNYhQJMP8XXCEujbrpc07Kk19FAultk7a0C2cC3xWWIRfRvh
         ufow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnxkwu+jla6ut+IvJVQYqIBJUbwnUPabboo+Da4W4N0=;
        b=7OEt4Fx0WC2T9vL16WlJbv2mCgpQ2qm0WNg5sVanQS/ZhlF5eaW/aBRcK16Of2sVRW
         L6UOnWUzFkHk4M8g1b79BQZO5Q2pJwnk5lSeQHEs3MeGRGUdDLuyape/HoAV3U32dC5C
         5UPfXEumeC9dDMr1wTDaLTOysZ+iFA7N4oFaUk3jCgwFzS6yM+zq5Wv0CBFM+bu6ec/z
         BfwPOOsq47wHnLG/0un7wsVXp3xXlTQR3rKAL97reseY8JiR5EG+FKPv/2RjpsLJbOsu
         uLm5CF2TLiD4e75TvXordP64r+jI23M/GpuiqPu2U+ym16gFjg8one6lbVdVDJystTbL
         xLSA==
X-Gm-Message-State: AOAM533TPVSz04yrYmQAPmfWRlxlMmUjfXIBf6EF49xgpfxzEsQgvmwY
        gKp1WYjsm1LINap14u01bbHDxZVYvQ7Kwg==
X-Google-Smtp-Source: ABdhPJzRuWG43QbOjd2qa0K9HJVF6+r67DkGymvaqQc4rEARzw15ugPywEADgmXlbE8131GSOgEEGg==
X-Received: by 2002:a1c:ed13:: with SMTP id l19mr1874484wmh.48.1633420520850;
        Tue, 05 Oct 2021 00:55:20 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
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
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v4 05/11] MAINTAINERS: rectify entry for ALLWINNER HARDWARE SPINLOCK SUPPORT
Date:   Tue,  5 Oct 2021 09:54:45 +0200
Message-Id: <20211005075451.29691-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock") adds
Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml,
but the related commit 3c881e05c814 ("hwspinlock: add sun6i hardware
spinlock support") adds a file reference to allwinner,sun6i-hwspinlock.yaml
instead.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches  F:  Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml

Rectify this file reference in ALLWINNER HARDWARE SPINLOCK SUPPORT.

Reviewed-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09c166e2a239..9db2012ebae4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -776,7 +776,7 @@ F:	drivers/crypto/allwinner/
 ALLWINNER HARDWARE SPINLOCK SUPPORT
 M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
 S:	Maintained
-F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml
+F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
 F:	drivers/hwspinlock/sun6i_hwspinlock.c
 
 ALLWINNER THERMAL DRIVER
-- 
2.26.2

