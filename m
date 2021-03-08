Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB033148A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhCHRTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhCHRSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:18:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0F3C06174A;
        Mon,  8 Mar 2021 09:18:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lr13so21936623ejb.8;
        Mon, 08 Mar 2021 09:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbKnutjFeuKN2eCb9zbjA189ugDvCI2YrROp3wTICT4=;
        b=VM+O3J7thF6KXIkr30kOwBkv0Tc38k1Jvlm6YNjLzz50+bz8wX6MSYf8T4MSnRTTqO
         b7+q+W4OaSbimhETBoMAHrau0LXQN1NNupJRRPiPM+HWG49PQjhpyKtZQxrZejeMWkXO
         xOPpSsEsw7ILsAzhl/rjTymtk37vwlPjjHzi3qxBwRcWygjPBnxr02KPQEn1RWo9aan1
         hIzPfJE1BN9VPYJziNywKBHUoBqp7GlM0OYaQ4TseZuf0+ntg92PISjgIL24qjWXTOGO
         bO6mSrV18HnVUm7RNsms02cNSZFnr0r0DEcVIKfZIVpviGaDQO8kwXiIo4IWceEOwskr
         KqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbKnutjFeuKN2eCb9zbjA189ugDvCI2YrROp3wTICT4=;
        b=eMPlQfvYUqve0vn0akZ24nVkaWOzQ7F/K/0eJ2BaVfBF4W5d8KJCAK5Av+0001a1+X
         ARVTlqdiJHkDzaC5RqO+lErNHl6U3H7KUfbIa2MM7qUz4KYlLLgbS/UVEEzvgTMNJu/v
         mZD7HrF65bjKO18zp0bi1pNfaor5B0FVKz3M/F0IRy104oHpl4mBW4wSU0EWzSS7lbF5
         2qrFrNpFyJOiqZuAjg0D0SfpYtaWkk1DoPVcZz+BY+jFML0ijZ2Zuv+wva4LaqJCb/Wz
         Fd1qsmNS6jJnUcDRQfoCambLfRSDVSBavTYB2bWkJfm3LufkW73PKb9Zz8ON/jgToBIf
         e/EQ==
X-Gm-Message-State: AOAM531BcujlHcRstXIrv6ZltHeJfPVit9WCvSfD5opnj7VcEGSS2FRp
        RTyz3iot7fW2DiYZeJcS+lE=
X-Google-Smtp-Source: ABdhPJylZIODIf2YTYVcYrnYaUyYSLxrDdQA9Fl2UhMyGSt1EURUu8O3OE+j5LPAzBL/4gweoILfBQ==
X-Received: by 2002:a17:906:3899:: with SMTP id q25mr15845840ejd.157.1615223919714;
        Mon, 08 Mar 2021 09:18:39 -0800 (PST)
Received: from localhost.localdomain ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id r5sm7457714eds.49.2021.03.08.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:18:39 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: clock: Add NIC and ETHERNET bindings for Actions S500 SoC
Date:   Mon,  8 Mar 2021 19:18:30 +0200
Message-Id: <fa6bcb2dc4309ca1972340694aebbcc5f55bd61c.1615221459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing NIC and ETHERNET clock bindings constants for Actions
Semi Owl S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
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
2.30.1

