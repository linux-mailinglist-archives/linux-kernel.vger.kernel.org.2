Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC4312752
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 20:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBGTui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 14:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGTua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:50:30 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452BC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 11:49:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i5so2815760wmq.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 11:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqPLnymGHD3zFj+2wjzUexDZkU2xeBl6heZW7yAkQ8o=;
        b=fWygfAtyMKutmMhmSS17F+sgLI9PWZpZqy7xhnMlRbW0Dxa3B+g3RrMURKfB7DYN01
         UMB1A61lOihn/8HdIZNO0j+hi56db6qNV6u2tLItxVl/llw/FdNlE4rXdRPvzrCZEZuG
         BnkzCcEm//V/sV0VFM4GtLq5A5TO7PzGUhkBuHEEpTjUz+l2vG8IJhCclsgYhOgVpg3V
         QdK+84OIaY0qZOOlwRZDSA0of3+R7hO6NLiSl3fIbd8lZVtMEju5bYIXvvKn0oZ5suxr
         LB67GOM2GzNseFIe56euts9DpqJUWMjvOTUx8FpjsGAK3vhx77osv/JqHjUu09y71Y3U
         tJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqPLnymGHD3zFj+2wjzUexDZkU2xeBl6heZW7yAkQ8o=;
        b=dcxdnjmcwNi6cNSEQgjf0JBe4xwiU7evIKMXmqILkz1S61Dkpd2mhWFAVHmxmDIf0S
         By2p8VLoDHwXG3Wo6OE8F0dYJlC96o5hTNir8kPl+9KI/jFGYqkHr8OddHUG9lUnH8qi
         zWcEcYK4dxsskyeecGfD5kKR5VkpUn+WpU/mBJTs9BRLi2vXhbk3kBM7a1FywfrVODF0
         /gVWR9+nOlIBEns7gxuRMSwNM/m7dfWDlBnPQfGU5alG0zetsmdSNlXw00XhByjmBGi/
         VpQ/BBv65h3aydlEMSR55FjZhdg9G05CHAiK5052RtJRSHz/v27hmLo/4yka/IxAvvWp
         MqcQ==
X-Gm-Message-State: AOAM533sCxBEAd2nLtvuqL0N5ac3PcbQQuBYhYIR7iFsNvCCTuQ5gL7U
        FzWDQjfxj/Cj6DGPtYbrEDN6rw==
X-Google-Smtp-Source: ABdhPJwYIjzv4Rotx6lxOP7IkAcGqPVDuPAFFXDALp7dqR3KI/VsBAsHhw3Bhaw7bASAXvVJC3SZmQ==
X-Received: by 2002:a05:600c:3549:: with SMTP id i9mr12251988wmq.47.1612727388512;
        Sun, 07 Feb 2021 11:49:48 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id e12sm25598826wrs.67.2021.02.07.11.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 11:49:47 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: replace spaces with tab for a closing if brace
Date:   Sun,  7 Feb 2021 19:49:44 +0000
Message-Id: <20210207194944.113613-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spaces preceding closing brace of one of the nested if statement
blocks inside the rtl92e_leisure_ps_leave function, and replace with a
tab, to align it properly with the start of the block. Fixes a
checkpatch warning.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 9475f8c6edf7..c5e89eb40342 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -290,7 +290,7 @@ void rtl92e_leisure_ps_leave(struct net_device *dev)
 				if (priv->rtllib->SetFwCmdHandler)
 					priv->rtllib->SetFwCmdHandler(dev,
 							 FW_CMD_LPS_LEAVE);
-		    }
+			}
 		}
 	}
 }
-- 
2.29.2

