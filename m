Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6A3A0907
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhFIBbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFIBbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:31:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4224EC061574;
        Tue,  8 Jun 2021 18:29:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so431549pjs.2;
        Tue, 08 Jun 2021 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuNMncGZs3GHDbKWNjfQWlX3Vob302GR1aWzQRy79OM=;
        b=CfvIC7jYnQjz5rAmKprStBaZhx/nr7tAy99U5m6LITpLwvUcuh/EkzRqqHrYgEhXn7
         9LNNhdyneC9lMFwyWd429vLtXCQny/DIW96gbjDVyLoZWXQEaLVufMCph8HLrZ0mWy9i
         TGnhjYBPBe7nfshN1ss9FRH9m++DgtXxrJePgPf7PruZBxhl9MAUNcS4QLVpqjH7AZUe
         FkIaWSEa7REROSod+op5IYYviKnyfYuHE0QpWLS2+cL37FbNZTUBokZs1oAyFHBDEHrj
         MLtu6MCdwT/VENHDJDM90l+fgSu7DxfrlifsAIgRPMzPfmBy/cjdeuUQw+01Z630h6BI
         4J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuNMncGZs3GHDbKWNjfQWlX3Vob302GR1aWzQRy79OM=;
        b=J6Z/iSyKUOSFN8U28P+ERmIfkAxna8S4A8OqU81RxQnCDEKpHokR5M/YFSTS+hqxYD
         Fo+LE8JWDiIEKh027Wz6gFnULYxOr8IO3gfYO3AGyECEk1lOJLcMi3OWt9IoSk2+3n7i
         XCWT9lBEKpfQkljJcOovyRuvoncYVARNfu9IXNi6yB6dDariLgTnrN/F6lTUEoZq42YW
         xwVOlPBtycJn84LU+APpNS8D6SyVpPTcO037PdoQ5PN0nL5u/oGfyBH4g6fYJsyNCPw9
         XuwEHA5kVIrAoi7zzs1UeCNsoTpknk1b3z+Lvp7E8b6FcyKNepOdysPer39vMQ5jPLCJ
         ZVWw==
X-Gm-Message-State: AOAM531Q5QMFtDzmR+wzcpMTh26P4aK11Pp4yjZyGd289zeaS9iPyU7P
        1MtjAkeQbHrMO7EWPqOFoWsTXI7DaNEp+A==
X-Google-Smtp-Source: ABdhPJxGKs7mSSbDSGwey9L30wPI4VVIdKFHnVrqDnTDrV0ZhWEMLVxaqFokG5rCTR5r+O3GvJxD7Q==
X-Received: by 2002:a17:90a:fa95:: with SMTP id cu21mr8027656pjb.210.1623202141900;
        Tue, 08 Jun 2021 18:29:01 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id d15sm11493714pfd.35.2021.06.08.18.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:29:01 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] arm64: dts: meson: vim3: reduce cpu thermal fan trigger temperature
Date:   Wed,  9 Jun 2021 09:28:49 +0800
Message-Id: <20210609012849.797576-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Reduce the MCU FAN trigger temperature from
80 degree centigrade to 50 degree centigrade.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 66d67524b031..a9c34fee91f4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -256,7 +256,7 @@ &cecb_AO {
 &cpu_thermal {
 	trips {
 		cpu_active: cpu-active {
-			temperature = <80000>; /* millicelsius */
+			temperature = <50000>; /* millicelsius */
 			hysteresis = <2000>; /* millicelsius */
 			type = "active";
 		};
-- 
2.25.1

