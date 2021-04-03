Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081A835329E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbhDCEr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhDCEry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:47:54 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9AFC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 21:47:51 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c6so4984280qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 21:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=FHiBAjlxr/C6tGmWYxz7S+DKAm5/GOdxVRm5ocLl83+Eu5Ft1sit36qRr9SCwWfv8H
         ty9FTHCkKnf3kIBrgXtrFl4nyOzfSGTJ1zIT0VXjbfwX6G2fZAo3olRabp9qxMJNxDFC
         P6LQeNq739kds8gBe5YzV7HMk+dVDWnn/27C7M4Pg49QwM8hjjqM9bK/L5G7NP8EeWkm
         QqB/Xa9rzTAJjKbSptZaG2606VU1PCJhoHzeWAnIf4cPlVMVejubsWkUO2p4RpfuGyqU
         ILc+3UCs2vDJciZzaI9/VO5vxNyHcW2F7IfJTehHgZ0Ofzj6v47+t8D9ErYYkzq2mjWn
         3GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=fhqyJ6duoLmNgeMCXoEn2td3qaxv+AawFucTni5cq9Y6/Wwt6R5jjTDyEafL0skfY2
         A/v3dj3wie0rXDWa7N12Q+TBmhv1e8Qu1m0GdwER3fcosVyZ9264rEpj/mrxg15NJBP6
         feVJYLpkKuMgnVTstb5WyKr+DTzSV+2nq/as8/jnaZb5mm0FOmnzAfjLyRstTMT9/SoC
         c4BXCXh5oavKf7pOfKT9oSAh9pYpp+4ubWeufg6Nj4CXLabGZ1+Wy+2FlYshuyHWdMNW
         LX9hPtjDaiNHWEcdAjjCyDSF5L2BWpJPPQwxMzjfR9pV+RjkO2K56C8VX3peeO2TKqiV
         HSXQ==
X-Gm-Message-State: AOAM53104t7cv0ZoH4cKOavzOtOzRJIjV2/5TmJ4GdtV+TKGUUMN2Bv6
        CrYb/efww4FjIYjUAa/4a5E=
X-Google-Smtp-Source: ABdhPJxHwncmw7M1qI+VkC3HNwVDnt6zS7YVxAA51QTTSFkarjoaWGbDkIGxd8s9DeI3IjKVXtYVAw==
X-Received: by 2002:a05:622a:34b:: with SMTP id r11mr13987716qtw.121.1617425270782;
        Fri, 02 Apr 2021 21:47:50 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id k126sm8800598qkb.4.2021.04.02.21.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 21:47:50 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v3 7/9] w1: ds2438: fixing bug that would always get page0
Date:   Sat,  3 Apr 2021 01:48:19 -0300
Message-Id: <20210403044821.390485-7-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403044821.390485-1-sampaio.ime@gmail.com>
References: <20210403044547.390226-1-sampaio.ime@gmail.com>
 <20210403044821.390485-1-sampaio.ime@gmail.com>
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

