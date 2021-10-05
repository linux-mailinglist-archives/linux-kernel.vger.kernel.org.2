Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3291C421FED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhJEH5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhJEH5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF7CC061749;
        Tue,  5 Oct 2021 00:55:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e12so15448445wra.4;
        Tue, 05 Oct 2021 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1ACAdPpXdD7+6xlsaFl8y9pYKjykE5MoAahHiFRZ5E=;
        b=er4wiUbQiLkmUVpKn+tlxmS/Qs66tV0kj619OOdd/4IahYBHC0sQVo3cMYjzP1i5X6
         ZbGbK60zuyoe3y8Hh6YUTvvOQfEGBhpWUH8Kooj5X5FZYTucrzXj7Ftl/rZKMdzca4aZ
         g7tS4lOZZVKh3lnzn4CZ8gLDQZO6+iy1JbPodKviWHfNRvwHLFkwt+O7bwryyvPt8JJN
         Xqb6GGWaXkKWm50xPDD5dPdcK6F2pBizjyxSuJm12Ybfp9ObTGhxfIj0St2/vI60jF4r
         qt07H30FuZWdYNS1N/ofd+9mvJqa+SqzJMzlyb47RoH8pz1FMcrSpllKlv65AE7InABx
         nWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1ACAdPpXdD7+6xlsaFl8y9pYKjykE5MoAahHiFRZ5E=;
        b=w+3TEcPwo0E/0MOnSUY0USvRYdiFE3YWHYxSfAUQSzya+LWQlxz5eU+Rcdy7zJB/02
         NUWDakJWJfcgplpXb/GEFTsBL+K1vOkY017dWqAmNe+FZEIY6cHLrmFuMmEA/hsRJlIa
         nqgC8OC+AKMrCMziinmmB9nagc0IqPz3m8LTeHsXvF87gum6QJKIgQkFr7N4Mzi6xjQ0
         MhJu9w3EEXnL/svz2LmJIIxK1EYUmlsDQqEyo+/5T2up4strhDA9DYfw3G3GpUTEVP2E
         QbsE8Pn8Hv1vJjo8u2KprXjpxNBmOI46WaNMXEfq82h7HlVRN5A710SI5+7nS/ukbs5w
         cIIA==
X-Gm-Message-State: AOAM532VzzPhKCOSS8wyoCz8BkM5rAy3G9tVlnlhtW68xNd/iljMozQl
        stqW/BLA9+6vBu9i0YtfEEM=
X-Google-Smtp-Source: ABdhPJwDIbP8wwo0ZNAP9e9uSY7WrXGStyt4Ykt1Eq+rfFKv2BP59bZHZhVmj6pZY91sllPZGUnEVA==
X-Received: by 2002:adf:a2c8:: with SMTP id t8mr19955799wra.215.1633420528694;
        Tue, 05 Oct 2021 00:55:28 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:28 -0700 (PDT)
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
Subject: [PATCH v4 11/11] MAINTAINERS: rectify entry for CHIPONE ICN8318 I2C TOUCHSCREEN DRIVER
Date:   Tue,  5 Oct 2021 09:54:51 +0200
Message-Id: <20211005075451.29691-12-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 04647773d648 ("dt-bindings: input: Convert ChipOne ICN8318
binding to a schema") converts chipone_icn8318.txt to chipone,icn8318.yaml,
but missed to adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
a broken reference.

Repair this file reference in CHIPONE ICN8318 I2C TOUCHSCREEN DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e537e78f426..84acb8c57176 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4415,7 +4415,7 @@ CHIPONE ICN8318 I2C TOUCHSCREEN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
+F:	Documentation/devicetree/bindings/input/touchscreen/chipone,icn8318.yaml
 F:	drivers/input/touchscreen/chipone_icn8318.c
 
 CHIPONE ICN8505 I2C TOUCHSCREEN DRIVER
-- 
2.26.2

