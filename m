Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A746E39C540
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhFECvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:51:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEFDC061766;
        Fri,  4 Jun 2021 19:49:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t28so8764519pfg.10;
        Fri, 04 Jun 2021 19:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRLzIEsUR/L5fTfNptj18L/QHNRpPol1gX/tfrGQ/rY=;
        b=vMtZvGvWgJh+MLhz7vq0Y74RYOtTWMAPvRvxDTrqQDs2+ZT9w5fR8TUG5ng3JsD9JK
         leWctDXqLGvy/VP4wbzyZIxUmXXKT8QpRYc52m6kbmuvEGU6C1LbXp/IHo5RE67FBmPA
         gDt1Bi6AxX6d8Sn5LBVfvamQZ3JZz7/wa2zQ7tLHp6dtViirrKblqdHttO7/kr4g/11T
         h4nvD0y7ffLByCi+FwT1fxmyt4m1CB+t27VSQr6tN9m31QdGouIVjeszX4z+6ugaKk9u
         AnSBUKKxdzTXx4scqzGSjI9lXpo6a6yeiwrNF1RcigZ5cn/Rq6rGTMYm0vU1sfsHTgJ3
         fHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRLzIEsUR/L5fTfNptj18L/QHNRpPol1gX/tfrGQ/rY=;
        b=SqVWqS/Vsk2qzH3o1UMTWfoggr/3bgbiu7sjh869IL7ooYma5s3xAxwA0wBxn9QjEF
         Br2GZslRiX8tENxGnWGwVo4+EMnyw0nkkMkPrCYqEX5K2H7M86tOI5DJq4lKk1GGsv+9
         1hcBbGBVMnUUesnJCbSBNZ+mMe08S28rd5U2GV74zHBMH8iS3dgkhCz/501k6HWBmkuR
         +9tyVvIuaU4QWb1epXJ1nZ1Se5PCnlHIOORcRrQ7PlG/VBQ8ktpSdsllw8aRcoiu6PG2
         5pw2D+mC9uLw207fZas+VuA8rx+m5l7qytLTVwAdBm3wkIQQmmoi5VArKWlv6I9BWjnC
         zsoQ==
X-Gm-Message-State: AOAM530ALgUMEiYsevLbP/gXu3HjpyvYas4EhWrvsvDrmZU4DAOIO67M
        Ot0dcDa1/GpgIkRKNsEF5mg=
X-Google-Smtp-Source: ABdhPJxm9uoxknYZibq9O6eZFPQl4/Jall6FyznwGPG2SrqNbe8NsGSDieW5gBEdxzRGZLWc0futSg==
X-Received: by 2002:a63:5a5d:: with SMTP id k29mr7676812pgm.215.1622861372959;
        Fri, 04 Jun 2021 19:49:32 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id y138sm2938553pfc.11.2021.06.04.19.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 19:49:32 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] arm64: dts: meson: vim1: add i2c aliases
Date:   Sat,  5 Jun 2021 10:49:26 +0800
Message-Id: <20210605024926.410043-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Add i2c aliases for Khadas VIM1.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index f116a9d91633..d175d6cae535 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -32,6 +32,8 @@ aliases {
 		serial2 = &uart_B;
 		serial3 = &uart_C;
 		serial4 = &uart_AO_B;
+		i2c0 = &i2c_A;
+		i2c1 = &i2c_B;
 		ethernet0 = &ethmac;
 	};
 
-- 
2.25.1

