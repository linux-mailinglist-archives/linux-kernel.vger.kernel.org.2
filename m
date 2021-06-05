Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32B539C53B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFECuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:50:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DCEC061766;
        Fri,  4 Jun 2021 19:48:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g24so6525651pji.4;
        Fri, 04 Jun 2021 19:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NaibPNLx+MUOnhnXMB6TkyMyA3F3CqoWfhdvwpm1Q3M=;
        b=mSjrZfI8xos2jWzsimSw4G704XuV+i6qr0GEa8uz8Sx3fNuO+CK7eueQWtDdv0fc7F
         8Gh0s7K+KC0T7/Z67nIC23LxKAGksIKl251nu1IsxB90+4H28qpmKe8ZClxJ48geXokS
         gnQ/0K+7/xuH+PHFCtOe59lPdQbQl5+HVbmwU1rQgNzuVIAW7H6AeUx0h5+dnjZDVhkZ
         kA/K+RYd/yog+OHhV6vfEEM/QlXwRw9q61eLqDuPh3vXEK81VQ0ODNny5DNdYadLkBsu
         i7k3TNKGZtJHFoyPlJiRrBp9UXK2SXFNcx9IR+NQFk3nFcd+zgJT/NYycMRn51WdmbvS
         SpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NaibPNLx+MUOnhnXMB6TkyMyA3F3CqoWfhdvwpm1Q3M=;
        b=BHQLpahhNisegGyy5a6PpiQ6iqsXSX6Rci1fqE78qTG0TM6pi3ahXrEQkPMwbZbH20
         2rVXXZdz0FFpWjG4w6r7dxxVYQ+n/3PrFD8GPrKAvOq5Dm7JN5MF0YkLDnp6kM3L07lK
         Rh0/JIa19M5JvIA1Vd9Lbg0uTqsIcdCllRfadx3a2G7Mmn+OC44DnX4q+NtU5ziCFCaC
         zn9Q04t52MSr2dmtFpanGMx6fN4Z75Ecb6gghaU5GzfkCt3+JjkK9EL5uQK45U72BQqg
         XBln5Kd7e1syNvWDsIA51VtHZGmeks2IeCpbQfgbTQ4fZH931epxY3OhojL1JSIjojHD
         TPwg==
X-Gm-Message-State: AOAM533/DUsQbl9m1pnO0avsdiNECkxsoFokXLwvBWjM0a7Wq/6ep0DF
        2o8nnnxohJHKG9rwyrSHYYc=
X-Google-Smtp-Source: ABdhPJyObhqFEKZnaTSeLMJ4m1IVf/fWP+oz8VhowQVA0kbY0aAg0pQqYfwr9p3pLXBUE0h20Mk4Jw==
X-Received: by 2002:a17:902:cec6:b029:10e:e6d8:8fba with SMTP id d6-20020a170902cec6b029010ee6d88fbamr7345175plg.61.1622861294941;
        Fri, 04 Jun 2021 19:48:14 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id k1sm2683741pfa.30.2021.06.04.19.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 19:48:14 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] arm64: dts: meson: vim2: update serial aliases
Date:   Sat,  5 Jun 2021 10:48:02 +0800
Message-Id: <20210605024802.409823-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Update serial aliases for Khadas VIM2.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 18a4b7a6c5df..70488ae45876 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -17,7 +17,10 @@ / {
 
 	aliases {
 		serial0 = &uart_AO;
-		serial2 = &uart_AO_B;
+		serial1 = &uart_A;
+		serial2 = &uart_B;
+		serial3 = &uart_C;
+		serial4 = &uart_AO_B;
 	};
 
 	chosen {
-- 
2.25.1

