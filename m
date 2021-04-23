Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D6636954D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbhDWPAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242875AbhDWO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEFDC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d200-20020a1c1dd10000b02901384767d4a5so1397066wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXy+IJQRVDR3sYe4/6l8EGuC3E4LyBPWu4+9MmcXFm8=;
        b=H+WtiIRvwNbzkw/+dTERd3TXZBOyJZ7z8tt92shh/Bm5qfMSIkpBeQwzSxrevg5IrL
         UdT6yCECljn4RkI/qHkzXQQS+bR7ml32EqYGv0c3CDAw2J32hAaYyp5sBC7Zh07ReQBs
         cyqEQEPYZ09XTYQ0+iSk3fAKfuhVWdkyDhk+df1pmidi+eq1/0B9A161I8D23266aeQ5
         DEDPvTqnQmkWSihI+HeePUUCeE0/ySApS5z5d9dbFLWkLLiUmnjdGZ7D8RvwO5dNoAAq
         VqjPyyEZzRvnje7rDPuryMwh1QQG4R07zdWzAhQSJCa5kP+WoCT91X/nMfI6Mmpehnga
         TSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXy+IJQRVDR3sYe4/6l8EGuC3E4LyBPWu4+9MmcXFm8=;
        b=UB6XFW6AmRmZSW2G3roGSQR4sWBwXMfx3mAaEieyzxKPrbKScxFW1590COGQcnASLK
         TVotFlqmc0lBx9TKAd/QeubfIueGmfumKiKx715CqHclsekJ+lryWtUKmyUQik+r6u4p
         1gud4B48Nu9rpL3xu/qK0mgMxfpt3VpVOvdNcPzmHSRoiKRkPVIpuMXSWrk6CwhrkBz6
         ncqrgxGfm4Qx74Uukjhdit0j6FTuK5QsYZiJmOpWz8cUx4hj0brjPay7Yk5Z8XPw8xVo
         UvpAMl9d9EQtXmL+/psyRqu9A1fsb8xhdd3+6FgTuwDHwAEYvW5BtJGN7RlWrqWdlwYI
         uiZQ==
X-Gm-Message-State: AOAM533UKTLIDRTFFLCXmYwY+cE/zJjMZVGhAcfFyvEFtcU3tAYPceuY
        HEuZK/5xvc3bzA0cymIkMYjX/zYmK44=
X-Google-Smtp-Source: ABdhPJxPIU0EF9AqLbCzh5mh7Gh1ia8X4cRyCAPwnG3iYpwPfYbvnpSUBjJ+mkgkGAh6vqkl9WMidw==
X-Received: by 2002:a05:600c:3790:: with SMTP id o16mr4743289wmr.174.1619189939707;
        Fri, 23 Apr 2021 07:58:59 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id z17sm9552436wro.1.2021.04.23.07.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/49] staging: rtl8723bs: remove unneeded header file
Date:   Fri, 23 Apr 2021 16:58:02 +0200
Message-Id: <e57a0c829c5bb83e7a58887b3720e454770340f3.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded header file.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 579724e8fc2f..acf4deacd3a7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,8 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#include <linux/trace_seq.h>
-
 #define _drv_always_		1
 #define _drv_emerg_			2
 #define _drv_alert_			3
-- 
2.20.1

