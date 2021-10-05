Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC1421FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhJEH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhJEH5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CC8C061745;
        Tue,  5 Oct 2021 00:55:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so2199188wmg.0;
        Tue, 05 Oct 2021 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aklJfE016CGNj//Nh6z2KRN4plECiMRueyyXVSPauQ=;
        b=UbVykP2ZXfEeE6SfslLdP2qnmhLBYgWkXDRWpRPpjtH9/xXl88RwbZ6PFgK04onDdX
         iAevxr03f+9C1O+6fiXBTF70wCiiAiIsnSgOu2bXXN6mDcN7Wu3nqGTkvuxAYDd3R9fE
         KYDySX/cZ3iSk8c18WlKE93Liil9AZj0gHLVp/Y4TwE/YgfvSt8CDXmB+ZjGZocxvdza
         gEG7wSJo6Z6bp+IBKieno+SsUDmHV+Wrdxn3Dg9EbhBnAUVCdyaqbHPXw8shshtLCj4m
         Zp2yLjWjVpHuDz1nQQMiE9teno+MtYh8ugm3pmYTIBE4FnaBwwQ2WIl/EjI6O3KKyBHt
         u9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/aklJfE016CGNj//Nh6z2KRN4plECiMRueyyXVSPauQ=;
        b=SALYv+w/7fewUD/cZsJrCvf/ueHzlbvbw4ZW4nImp1F7fIlOVit1oZ2YLPd4MJih3e
         1HaPcaoRakFWIfbS1N9E6z43q0/ZOrQgM24pdpYa1+jflVZwJtSYtphw/JBoiV7I+GPs
         1juPH++RNTcBlzrTFMcfzuHkrCyanmr+9FM7+Bi6/XCOaCv6nFnajWqhZiaBKmRrwZrK
         uaZQlFPQs+soJeL7/yy0r5QmklxiB4UCNoHTc5zk+ja+CgwGgJzSVpcrAyo0Eg9W8lnU
         Y+2nrZHjw8jYxuh7V13pj9NIqfkjruDcU+JXzQlJADsrXGbxR72fTKoIXEye0gexTASq
         ccRw==
X-Gm-Message-State: AOAM533ipvff0VLNb0xE7zxmSEmvo06A1WBJKzos4wbEOT3FWvRI2hi1
        tpenYdEoZFVaSyeohRTmDFc=
X-Google-Smtp-Source: ABdhPJyDfPcLkY3XMNRPKTJO+vD2Z8uUpoJpzCuxjTjT8E9gNWlPr25Xx1lL/QK66DciHbu6tlCW3A==
X-Received: by 2002:a05:600c:2057:: with SMTP id p23mr511705wmg.67.1633420526216;
        Tue, 05 Oct 2021 00:55:26 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:25 -0700 (PDT)
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
Subject: [PATCH v4 09/11] MAINTAINERS: rectify more entries with documentation-file-ref check
Date:   Tue,  5 Oct 2021 09:54:49 +0200
Message-Id: <20211005075451.29691-10-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of file entries can be automatically repaired with
./scripts/documentation-file-ref-check --fix.

The changes from this script were manually cross-checked for sanity.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6660b32c01f9..9a8a043ea9c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1889,7 +1889,7 @@ M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://github.com/ulli-kroll/linux.git
-F:	Documentation/devicetree/bindings/arm/gemini.txt
+F:	Documentation/devicetree/bindings/arm/gemini.yaml
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
 F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
@@ -3776,7 +3776,7 @@ L:	bcm-kernel-feedback-list@broadcom.com
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/brcm,bcmgenet.txt
-F:	Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
+F:	Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
 F:	drivers/net/ethernet/broadcom/genet/
 F:	drivers/net/ethernet/broadcom/unimac.h
 F:	drivers/net/mdio/mdio-bcm-unimac.c
-- 
2.26.2

