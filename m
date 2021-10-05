Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6F421FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhJEH5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhJEH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E13C061760;
        Tue,  5 Oct 2021 00:55:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o4-20020a05600c510400b0030d55d6449fso2158515wms.5;
        Tue, 05 Oct 2021 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bj0lp+DiVpOwf4wcllODbG+D7kkm4UYTiTPIzhxy6tE=;
        b=lwqvoW7MmT91ukrCDwqWZbWooPN3/UYLihtt/GVeN6nDbvxXuah5H5pAE3DQkJyPRT
         2z6bmPg9q2QRJQNcHKGKw22QHtRQFP7ETbJgxLP4UA4hnEVfm8AQ85v+aw4T2yEASKha
         UbrHlblc+RNa8lbC2PGSa/RGAqpbFi20rTjXIXo7SZU6OmoCWVZhI3TTkjnFDrssFPJv
         bb4rE6vXLIxgtMviurLnnUI6eyzL+hlAIH7ZTyxIo/n48/a3OlUNoLLTck/oenRNxpLq
         5ySCsrGLfw021Veave2csP3T3INKSP20K0e5XIgpAvcyIMWvfx9pBJ1V2x2/pIpVMvbT
         xEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bj0lp+DiVpOwf4wcllODbG+D7kkm4UYTiTPIzhxy6tE=;
        b=0q8xcOOP1lLcHfTRpkKiceyoRYRKzX5DlS2DN7xX7QhpUIT/h1FQDmRZiUSHD+y2ht
         GjkKGFIjLpEBHleAZSssPb804Nad3Re1XKQTe6+qCDTQKgXBLjUbyI7OpOHsRpND4gk8
         GKdaVg7JHxA7B0x0IP7qHFFjs31KmEf/5o88Yk3Hm6WUoC9iMAMjW4pMMFezhtFZcTHe
         3e8TRtg6JojEQl9Az6ODnOjOFAgliOPxM6srIH4SIorqU7TogjXnc661xm/kdOUnxxt9
         1yXp25PiyF+/hdYNl3YhNBauJPZkfClXR7YvGcoHn2Vo/aQq7wo8yHZMdW+QxVF5ijIO
         NUAw==
X-Gm-Message-State: AOAM532w8FzgmddnytyCW1gVmRMbemN3z0PQuesE82z70p5weKc1AIVf
        wnrFHkdEoeCH99K+B5VsKno=
X-Google-Smtp-Source: ABdhPJzBUkiOUAT9na9YE3EPgTQkjtJl4cD4S01G4qq7VeNl9ArLGbjIYExkss+HswhMJrIJ30Vpyg==
X-Received: by 2002:a05:600c:41d6:: with SMTP id t22mr1860941wmh.59.1633420518258;
        Tue, 05 Oct 2021 00:55:18 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:17 -0700 (PDT)
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
Subject: [PATCH v4 03/11] MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
Date:   Tue,  5 Oct 2021 09:54:43 +0200
Message-Id: <20211005075451.29691-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed794057b052 ("drm/kmb: Build files for KeemBay Display driver")
refers to the non-existing file intel,kmb_display.yaml in
./Documentation/devicetree/bindings/display/.

Commit 5a76b1ed73b9 ("dt-bindings: display: Add support for Intel KeemBay
Display") originating from the same patch series however adds the file
intel,keembay-display.yaml in that directory instead.

So, refer to intel,keembay-display.yaml in the INTEL KEEM BAY DRM DRIVER
section instead.

Fixes: ed794057b052 ("drm/kmb: Build files for KeemBay Display driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3eb7154df430..15cb81c935e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9566,7 +9566,7 @@ INTEL KEEM BAY DRM DRIVER
 M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
 M:	Edmund Dea <edmund.j.dea@intel.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,kmb_display.yaml
+F:	Documentation/devicetree/bindings/display/intel,keembay-display.yaml
 F:	drivers/gpu/drm/kmb/
 
 INTEL KEEM BAY OCS AES/SM4 CRYPTO DRIVER
-- 
2.26.2

