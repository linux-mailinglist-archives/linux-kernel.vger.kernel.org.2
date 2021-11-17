Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC86F453D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhKQBPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKQBPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:15:49 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F7C061570;
        Tue, 16 Nov 2021 17:12:51 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 136so760108pgc.0;
        Tue, 16 Nov 2021 17:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4U7aJ2c/OrCLSfs8lkK46XkDeObTTDEOGrWW7eHdek=;
        b=goKyoxMEGNfje+sDoFepIVvHWkw60Hq+MT2aTlDVFofvc4fCU44rE0reuoUwvlQCEg
         pYGjkdc4gUVxeq3pAfZnkjhabM1gq82yrhsgpfz6ushIxjJfqS+WXrt2c69oKpArY4JG
         K13aS3IJ8fgt9fdRf5NdItIOdr1eMVmuR779t4Gxr1B/rSmGcxF0s8XMUAAcbM76CRD9
         uQAIfAGDUbEmZKVhclcZy1sxsWUpdI29liS9mGmVOddNfs/Yu1oKL8nvga3adBkM9EoZ
         0Ke5GcyASdVIH3FQJU5BTeUESN4lMQmRfYuKtvAMOoPdst4X+COlhPUUJ8N7GcseJzGS
         tM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4U7aJ2c/OrCLSfs8lkK46XkDeObTTDEOGrWW7eHdek=;
        b=vgh+tf2r3/2fj0NME7lMTn+qbZk26TvBvkf2xWc/KoHerfyMPilWO7elG9WvgZqVpf
         l/+xk/1tsj2WaBbmv4M/yDf85Hv4i655lNUTTnw3xG+BGTAw1+/0PaIpaYd4/PdGsHda
         iQxXPnxLZo6u7ipqRUwOdK8BBOFw9xjgfsm7XHhivmYmsnkpiT9QECGyktRkvvsi69Hc
         EYJ5ml4y2G0UECwcER1wTYsCmsXWCqgoTvJCcvn7u3gOobXbytpI2bC20FdItPQ5qW8J
         j0GId+pciMs/OPAfrbJeu5GaUTU2/1o2VUqwn0iZGDyGlQ9Z9Bnp63fw/O54u/XCkRzx
         kN+A==
X-Gm-Message-State: AOAM533jK0KNJ5IqxjV60Q3/z99q5On7c39xK74ehXSIRfucxYI4XEwN
        V5XPcKR6uSo/jRXbD9nussk=
X-Google-Smtp-Source: ABdhPJyg8sBCkf80mS6/Covkq7nAOE6icJJF7Db8nXwyn6wC2NWjBk2bzme5BycUOcdR4d+EmZ7b2g==
X-Received: by 2002:a63:85c6:: with SMTP id u189mr2421925pgd.377.1637111571502;
        Tue, 16 Nov 2021 17:12:51 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h36sm16019469pgb.9.2021.11.16.17.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:12:51 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     avifishman70@gmail.com
Cc:     tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, mturquette@baylibre.com,
        sboyd@kernel.org, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clk: Use div64_ul instead of do_div
Date:   Wed, 17 Nov 2021 01:12:44 +0000
Message-Id: <20211117011244.158541-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. If the divisor is unsigned long, using
div64_ul can avoid truncation to 32-bit.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/clk/clk-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index e677bb5a784b..c75880af2b74 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -56,7 +56,7 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
 	otdv2 = FIELD_GET(PLLCON_OTDV2, val);
 
 	ret = (u64)parent_rate * fbdv;
-	do_div(ret, indv * otdv1 * otdv2);
+	div64_ul(ret, indv * otdv1 * otdv2);
 
 	return ret;
 }
-- 
2.25.1

