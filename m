Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36B38D350
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 05:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhEVDyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 23:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhEVDyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 23:54:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370AAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 20:53:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 6so15746754pgk.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AjcjWUX0+a5d2FTBPQMqavI4ib60Yqx+0j1uJmyc/hg=;
        b=DEunz0Za+9SJBe/9D6v30ZOdzM9XmooOxNJ8hMX9iZKdJ6G/X9U+r4ulC7y5CWtqKg
         6v5NEdumV2agey2v7igwc2Bd/TVUI9FXHs1RveeVci7zDq5OgzAobQMxaglsxAux4YRK
         ykt6gehLhbyDNzoS+SgGCavYHoVlkTz+X9G+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AjcjWUX0+a5d2FTBPQMqavI4ib60Yqx+0j1uJmyc/hg=;
        b=j+RIp5xyPIs3PuXyAAioFTgljqEdL/AfomUFqk3SbT418CixtemNrHkHZwhan2EGQJ
         JSemDi/9QB4kgSmDP87Jgl39NxRzEjkGuzavx9kWjpxLJQhy8gwBzfIlByOa7FJQ1lcg
         MsbH+1PaJQRkNMMyXsZNnekOZ/uSEwEwuPIj4jCgSa4l80fWaFNi9UyAdiraX//NwX3V
         +u7fHoevc1py04dQKQl7iYCisWn5ULMdJaYI1opbk2x5fE3S8KDNSidhr8F1QKL+Usgm
         PUo0dS3ggj0CTCWU3NhyzJnohPvMNE3025J0BVWPI17CwzEeUbbpwCvbaUzlEcSwwyBt
         A8uA==
X-Gm-Message-State: AOAM5325DqHocsZDyZv0NiZ+9kQguQXEPYJQflNH97s8fFRTzqghvtcH
        9Z2R8u75vAFSMADQcDAUPrbygQ==
X-Google-Smtp-Source: ABdhPJw95DbdEHWHzFp6CjGF/qWTwguZ38M1hRfQZXpXu+iKAoa6WzLeCwUuAbqwMu5Hiuemm91JOQ==
X-Received: by 2002:a62:f24b:0:b029:2dc:9098:c14c with SMTP id y11-20020a62f24b0000b02902dc9098c14cmr13271806pfl.19.1621655599514;
        Fri, 21 May 2021 20:53:19 -0700 (PDT)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id e6sm6739892pjt.1.2021.05.21.20.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:53:19 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, romain.perier@gmail.com,
        linux@armlinux.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
        mohammed.billoo@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] MAINTAINERS: ARM/MStar/Sigmastar SoCs: Add a link to the MStar tree
Date:   Sat, 22 May 2021 12:51:48 +0900
Message-Id: <20210522035148.1586043-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a link to the MStar tree on github.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index def1640cc294..3d10dbf3dc01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2168,6 +2168,7 @@ M:	Daniel Palmer <daniel@thingy.jp>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
+T:	git git://github.com/linux-chenxing/linux.git
 F:	Documentation/devicetree/bindings/arm/mstar/*
 F:	Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
-- 
2.31.1

