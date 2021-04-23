Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4F836954A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbhDWO7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242850AbhDWO7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66238C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1390667wmy.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sc8HgTLbiRFbrMbWcYG4U/VQmwhqHIp2KM2VpwNB9S4=;
        b=Lxh2N0gXHXSTBDK6pOfjqBsw3Cu2a+VkkhzzG1IWlMvk18anEyk+FkSQaLZ0fZ+65d
         s/J0wyJ5PWrIVrTLFxXkdfC1ellCq/bINFkKdqVIHbc7WkRMDjDCe8fwTP0WWyn8waHn
         7cWw41DJg7wc25EXSkvpGNXE4YYLaxseVvWSZKy5ojaYS4XNlogiRE/tY59RZ264zrcU
         HSGCxpyFJFibgIQ54fOs81DJZOdwVdACyejLeAnaf97tJOtWbXTJ2ZPn3dA77jbL8zbM
         z2pK75D9eFBtuMR5BP7MdakhFMzfcD704i+SPbv7WEEdbaa1GpQIneYnjkFR7j+oat+z
         fXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sc8HgTLbiRFbrMbWcYG4U/VQmwhqHIp2KM2VpwNB9S4=;
        b=lq8FOyB/S+FFKPZzLQw5BSXSKkITP5GzzNWrSQg1b+JdfsNiaB+6OEx8Ab6nyq8YTn
         4+krTkij9J3dZApPb5NAJQRhS7Qw5ok1EDPE15zyclDZV1nN+UqOZtcCBaDmVDMd9yvN
         386ccKV1zOPaH/9dk9lz9eEpkoJUsX/hffKm/V4sOL5itS9h7rTBfynGk5Rgaw0/sRul
         ME9UdXmxRR3iv/FIE/ABUV88sV/dsq7oKmuTWwJLt90g6bI6W10F+2WY7pobQrmMKZCf
         YNzkCwQ78qI+mE2/P7FKyzgRqjtiIO3VbDiqxArJ+aGUzYPnLbdiLBGqPy2zUdHZ5doN
         ne4A==
X-Gm-Message-State: AOAM5302mXe3yCiaAsYodideWj3rQ15Jel/0p5zop9YkKCLVGvO2vpum
        ISenY+bN8CeycgwTOtg6gtXXj8yO3so=
X-Google-Smtp-Source: ABdhPJxcOZPhOg0vSSTDmNsW4+YkIYBIGU/XFG19D801LgblS4HC/IT5l9A9SBzb18MZD/Bib/oNVw==
X-Received: by 2002:a1c:9856:: with SMTP id a83mr4761086wme.14.1619189934965;
        Fri, 23 Apr 2021 07:58:54 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id p18sm9047731wrs.68.2021.04.23.07.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/49] staging: rtl8723bs: remove unused RTW_DBGDUMP macro definition
Date:   Fri, 23 Apr 2021 16:57:59 +0200
Message-Id: <a0421881e2e0993ead23b52932584ef3e2d19269.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused RTW_DBGDUMP macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index fc187a4ed2c3..c7e8187ca7f5 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -144,8 +144,6 @@
 
 #if defined(_dbgdump)
 
-#define RTW_DBGDUMP NULL /* 'stream' for _dbgdump */
-
 #endif /* defined(_dbgdump) */
 
 void mac_reg_dump(struct adapter *adapter);
-- 
2.20.1

