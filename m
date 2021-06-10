Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8286A3A3489
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFJUHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFJUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:07:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F0C0617A6;
        Thu, 10 Jun 2021 13:05:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g18so32505359edq.8;
        Thu, 10 Jun 2021 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqklbb1b+FGK11o6PjF8j0OzGaPb5SlSdCs8dzovjLM=;
        b=E1MHE601YYllcozgVxcLv4bUNvFScaukRBWFue1xnQPgNIPmQvXr3+O8abm8FcVoim
         aOfAoJr1lACcSX4FGTfNT2Z4rMLyTz4TP4NzvkUcc1uJjmDW5IXsPNHC9GAgwsslVkdQ
         mUft+STrRO/nrdmDTfwAZU0j0zHwd6mP4OXgGveX6gBzDUkHFBQp9Pxn06NbNd0ml/Jj
         jf8yQ6V2/bqkBU1PMZ/OoxJ/5uzR2+x3mfDuBBTSXL0r/77jFOu/Mqmo5aWWF1p4oC0U
         XDPDF6luM+S7JWtDBSqEYw+HdCp5h0Renkzq3/Hd/2vcS0InbwSDGvCXd9uo3y6K+1pR
         aUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqklbb1b+FGK11o6PjF8j0OzGaPb5SlSdCs8dzovjLM=;
        b=Iw7jbYqnUqSNpAn7m6GOFit5v0+Uqi+qoQtnD/fWsw0UPBqHCDlTphCRu61V0nLQbW
         cSX8MdSLsg2iRaMUjOC15pWABE64Tgz6xiFh4ATmwyeo3jb7U3tfUPO8GjONBrK/Mvq5
         rG4eiYJvJ9lDXZFXqqDpYOw/U5QX+f0ZoocHRx+g+VI3zrZ9iibhciGQUqLOKXQkSMtj
         VT64jCyrUEI1ThHu7UvQ9xQ78FaYpvrjYb8HEx3KiRIFK5xZDWHoqTwP2VwlhUNqtZzx
         nNfMdd2zF+GkNGPyDlmbbc6M0mBLK4h2SpJ0n1i26HFXaeBiL/kVRjVaYOhRir0kULYL
         lHUg==
X-Gm-Message-State: AOAM533wrGAn6+hVjf5fGqCtB6m+s4VocAz2Eb6l/Wc6XkATETonuG9k
        Mullb7PI9bfcfkRONVWc7pg=
X-Google-Smtp-Source: ABdhPJz4OPleI5+1+Gqt8G9O/F3TBu4ayZ5zXX3Jd24SXMOOajxQzgLiU8bmAmrgyx3ElmbomcgRhg==
X-Received: by 2002:a05:6402:1111:: with SMTP id u17mr189797edv.87.1623355535695;
        Thu, 10 Jun 2021 13:05:35 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id du7sm1800978edb.1.2021.06.10.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 13:05:35 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 5/6] dt-bindings: clock: Add NIC and ETHERNET bindings for Actions S500 SoC
Date:   Thu, 10 Jun 2021 23:05:25 +0300
Message-Id: <1d0902cf073f76a1a602410061481ccb3fc36a72.1623354574.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing NIC and ETHERNET clock bindings constants for Actions
Semi Owl S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by tag from Mani

Changes in v2:
 - Added Acked-by tag from Rob

 include/dt-bindings/clock/actions,s500-cmu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/actions,s500-cmu.h b/include/dt-bindings/clock/actions,s500-cmu.h
index a250a52a6192..a237eb26accb 100644
--- a/include/dt-bindings/clock/actions,s500-cmu.h
+++ b/include/dt-bindings/clock/actions,s500-cmu.h
@@ -74,10 +74,12 @@
 #define CLK_RMII_REF		54
 #define CLK_GPIO		55
 
-/* system clock (part 2) */
+/* additional clocks */
 #define CLK_APB			56
 #define CLK_DMAC		57
+#define CLK_NIC			58
+#define CLK_ETHERNET		59
 
-#define CLK_NR_CLKS		(CLK_DMAC + 1)
+#define CLK_NR_CLKS		(CLK_ETHERNET + 1)
 
 #endif /* __DT_BINDINGS_CLOCK_S500_CMU_H */
-- 
2.32.0

