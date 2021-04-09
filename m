Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721533592DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhDIDPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhDIDPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:15:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4156C061760;
        Thu,  8 Apr 2021 20:14:56 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y12so3206393qtx.11;
        Thu, 08 Apr 2021 20:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=q0YxXX5Mt9eefEsjfjHNXXCbx5zzfeuQhsbj6KdGLsHTVEMQ1vzeTb602XCLDQBvCi
         oV+bl/D39Coaf6l4vGAHPUmlHMbUuQh1KJ4hEpTmP2EmOsRfywm8N8rUHARHAffaTWqB
         EgYwxt2WrpbtH4N40Q2uziJFDuRreV2nalTOHK4JtKho1VbN4siTWBDjFO+MdTI4H90J
         qIF+JI1dUns6UinCTSvu5fAQ/xfjKJv1SGnLzWA3FiAfOrbARxe2HMLxLcXS9ZgPup9y
         kLKGOAahb4XAkVFT0NovL0v0Y2uS/pJV21BG/VpxWoxgQydGHciVjmlbfSw0oSEHw6lQ
         BpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=el7n8crxmCwFqVWtSKXYJz3h95GFWI+agCS/xKol8xKLDasYGKSy2mHoJoTbr4Yp3W
         YXePNIxudVDjbEVzCTZthkhM/iKLqd8UU0pruJLdUhDNRfbIcWVTtcP2L39PXNX+KQsw
         nOz0byTsXfNcEe/1orOt413jUPlSNWGkksU/Rr3pTRBGc0VSSpSW/2WhFWcTA49+w89K
         F5ZAUOTRDvRTHVkXZCpYGurSdZTVqyYpw7frwM4AK7gwOZp6H/Btv3zQpoB5AM4cVuSS
         8X6aK7fl07ieqP6DZTr+EHIldAL3pXrMh87Wu3UuNUOsSPHMKqUVIuIfPnsHCEW+CKCk
         XLPA==
X-Gm-Message-State: AOAM532fu46Y9WOCDpIsWwofeN0eIs6SIGs91Jkk7PvK0iVGisnpqQSr
        ZiCEyhQBM8VBZjzQQvW+gMua+7lC+RPW8eV5
X-Google-Smtp-Source: ABdhPJwh3tr50Q+AC0V7MpXJF+pl5MtomamuG5yiKfw7anNNyhdS+S4Bar1EDjlazfDUapbuTtmDhA==
X-Received: by 2002:ac8:768a:: with SMTP id g10mr4280577qtr.245.1617938096065;
        Thu, 08 Apr 2021 20:14:56 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id x1sm1003167qtr.97.2021.04.08.20.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:14:55 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v6 4/6] w1: ds2438: fixing bug that would always get page0
Date:   Fri,  9 Apr 2021 00:15:31 -0300
Message-Id: <20210409031533.442123-5-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409031533.442123-1-sampaio.ime@gmail.com>
References: <20210409030942.441830-1-sampaio.ime@gmail.com>
 <20210409031533.442123-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the w1_ds2438_get_page function is to get the register
values at the page passed as the pageno parameter. However, the page0 was
hardcoded, such that the function always returned the page0 contents. Fixed
so that the function can retrieve any page.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index ccb06b8c2d78..ef6217ecb1cb 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -62,13 +62,13 @@ static int w1_ds2438_get_page(struct w1_slave *sl, int pageno, u8 *buf)
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_RECALL_MEMORY;
-		w1_buf[1] = 0x00;
+		w1_buf[1] = (u8)pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_READ_SCRATCH;
-		w1_buf[1] = 0x00;
+		w1_buf[1] = (u8)pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		count = w1_read_block(sl->master, buf, DS2438_PAGE_SIZE + 1);
-- 
2.30.1

