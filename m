Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5193A3FA3B7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 06:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhH1Eav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 00:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhH1Eau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 00:30:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD5C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 21:30:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 17so7824029pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 21:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ThXq/38kzog6YWsBoPcGtQqrTsog3IJpMTo1ZeSwCSQ=;
        b=kOHbNHP81KjALs3KHPR4QZtz/g+Z6/ozhPpsMWu2ss+Vj6xuQ79CW3ytwfryPkrLe4
         X/P+gYyB3tLOfL8Aa6X4EvtgD7Dfwgl0VvhCbJq89bpapbFFsPt392DzBMU9VrgDGDzC
         N/DN1G3h8cGeCRM1FZY3lAfG+Nc7LKmNs2/Rt/pb7d5HFFnfMN7WVPMMTdIsfhZYnM3X
         TR27mALAevEkq4tcFaC0xjGLtXShnYTGV82Pq7GeVEJvOnnIyqaMjhphoPEibZKThv8V
         POAjMEauU+4l5nUL3+BW1HiFHEkRk/3YjsXIC5I60sjmzc/kcbrjZPEXGrkGyV1rYQEZ
         d/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ThXq/38kzog6YWsBoPcGtQqrTsog3IJpMTo1ZeSwCSQ=;
        b=Yr4dPL96Ho3SrhTG7HqrX95IZSW6pDPurHpVQjx0fdRe02PChUM7v1idFNPSgBz9Nv
         /i5nx6g4WTfS+SVUS2jOrCAKhDEqetwwuhmBfxQ7kCMGd4LbnBVMLFpsZ4zC81BsJhSd
         eu2bErBJ9HGcMUUCyZ2eqACYkn7ob6i79/nmd485ziiglP+5rdIVxtPeLlOj9NqaGnSz
         lGUUIRbQYzAqsyI6zHMHNaq2knKpdnOOEPsxC1MMlgnxUrAGLH70v2agfFXc7RdTyrHG
         rn/a5AMHSQbZfqkBzrcqLFiYheliMgDSdR2Xk7UsbGANB1I7ITqq+pZ6FYhNnHnH2i2O
         qCtQ==
X-Gm-Message-State: AOAM531wKhmBllO4X4QuwwgEdKFSs/bY+hthyOoFckIQh1GNz6oKn9Za
        DeBhS9ABA7mHlC1hDunRFGI=
X-Google-Smtp-Source: ABdhPJzQ0qQ2Gs96Y2NARCplv357ZroJmAly06xqBxiLFM/5uBiJ/f1Ku2hHM7V3JSWGemA1djBczA==
X-Received: by 2002:a63:2242:: with SMTP id t2mr10476568pgm.111.1630124999426;
        Fri, 27 Aug 2021 21:29:59 -0700 (PDT)
Received: from xps.yggdrasil ([49.206.124.188])
        by smtp.gmail.com with ESMTPSA id 6sm7992463pjz.8.2021.08.27.21.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 21:29:59 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: fix invalid assignment warning
Date:   Sat, 28 Aug 2021 09:59:49 +0530
Message-Id: <20210828042949.2276341-1-aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p80211_hdr->frame_control is u16, change to __le16
to satisfy sparse warning:

wlan-ng/prism2sta.c:253:43: warning: invalid assignment: |=
wlan-ng/prism2sta.c:253:43:    left side has type unsigned short
wlan-ng/prism2sta.c:253:43:    right side has type restricted __le16

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/wlan-ng/p80211hdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/p80211hdr.h b/drivers/staging/wlan-ng/p80211hdr.h
index dd1fb99bf340..5871a55e4a61 100644
--- a/drivers/staging/wlan-ng/p80211hdr.h
+++ b/drivers/staging/wlan-ng/p80211hdr.h
@@ -149,7 +149,7 @@
 /* Generic 802.11 Header types */
 
 struct p80211_hdr {
-	u16	frame_control;
+	__le16	frame_control;
 	u16	duration_id;
 	u8	address1[ETH_ALEN];
 	u8	address2[ETH_ALEN];

base-commit: f6bc526accf861728d36b12fbc25ac94cd057fc9
-- 
2.32.0

