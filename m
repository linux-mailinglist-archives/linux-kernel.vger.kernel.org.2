Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5269354149
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhDEKts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhDEKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:47 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8288C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id i19so8139901qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=AAa1Gt07MFDtB6UhuBKQnpm//yBxBir0r37aKfOKzJz29r8naMYj15wPYxKrha7dt0
         8to/4YnJSQX+yxurqkUUv6p8bHws6etGMeK775bcrSiMc6X6kAWaKI8EZMvhGjXdrl/1
         5U9vFmteLdLXL6AtKbSuAkgVJPbkq1m1u7miMyKzgBNUtu6mHoBL8Y2HIil5QbJVMKmR
         bZRx1sz/X/9ktwKYz9MhVImXdeNzzqV1T8z959Y2UuwGzbZxu5BW+eCur4VE8TrVOXFD
         BwU7MzA4JOqTuzBxnYKmXVLOxi0mE7XlW1CEjo08v1i9WVWh1h3GIMjDDqmwesBpDBiL
         iiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=Xa0WvmctCAKcMOLcaHfsZbxTBU7Q9O9gmrvjmeixJrxjACLRzqy7D5HUw80AUhX329
         z8EfiT9kl/Wl5Ll3lu59x+U8w5j+AOn6+iszhlXA1Tc7L5c2bXb0H1owBN3jOrJL9Ins
         I4S/MvB/JsSHhk5ksiu3djV71ypWtFHNZ+qxFRLDacV8aDiyDfN6yU6YV1xjYPP7/piN
         DpaWIfyhnGMvFNTcQm/oiAVQGgYw6IO9Ws269pZJXgcHcqqnuXxHE6L7vUI7rJYvRYmK
         rxFqn4/k8ZsAEJPdEM1ClA6S3XZW6sJFqISFob6wnQtJe7rlXEkv8mU244LxrKyrQa5u
         QKOw==
X-Gm-Message-State: AOAM53397XjTzzfvsTo8alFrhvw/eYdl9ba9Lf4C2I3zN7f99/2H8eHE
        GY2h0+BZnRJWiW/reodEiPo=
X-Google-Smtp-Source: ABdhPJy1BJCL6BmiTZV5PHI2kWLEVQwQeD9lqxcAw5f85R3OwAWChCVbHsKRNa91qi7iA5WwHn5prQ==
X-Received: by 2002:a05:622a:447:: with SMTP id o7mr22300829qtx.72.1617619781165;
        Mon, 05 Apr 2021 03:49:41 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:41 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 7/9] w1: ds2438: fixing bug that would always get page0
Date:   Mon,  5 Apr 2021 07:50:07 -0300
Message-Id: <20210405105009.420924-8-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
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

