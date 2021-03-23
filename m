Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFD43455A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCWCme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhCWCmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:42:25 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66BBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:42:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g20so12950469qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=c+DkjD8+g+GuA9Rlrk1LdN9Og93yfSADjJ8IOeTNB0g=;
        b=Wis1KBSHokagMAD15H44Ytx+ga+flpehXMcxTfVH0gy9ZU80Z2S6FcZUtkVHvHd31n
         GoWnQGoQnxmgApZN8nbL35V7hgLrO9bv+oxl0vzeRTygwPlArwsTX0cFmd4RzLoXs1OO
         l1j0mhA4AYE76jjPIWu32laXQJnyNeo4GKw2g53Lw4PZr3/sgaiZGd+Cc+Paz2868fZk
         yEiTDWuvSvfxgr9KmHyqNNP9AynaBgnL+mLW0yIR9/5v4k8XO9nx2QpqMl+9hNzpXdCy
         EF4rPnon9pajXCJPi2f/+u+n5kr08HVKkA6jW7Ni0krvb9xMG6Py+aXAhMpaZMto0f7C
         izFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=c+DkjD8+g+GuA9Rlrk1LdN9Og93yfSADjJ8IOeTNB0g=;
        b=j/1wJBVGlJFYcwywTqanP/q2WnO+1o/db5PTQV0qH2y2DLXY3drC0zdRnEVR6Dff3e
         wVePw6UEMIw1ZokBmFJaOMBc7OarV4HZHgxQ5RUg64C/gTgjL4M/e4SVBlRrEMP81KsH
         IDRiBdttfKdXCP/c7wMoQEI/ApDZZggs9aOZ1o0pS2pzng/pSP6VijK0g3eBKscvamSv
         Q1PwGh+Jk5zAzlLYDTVNHtlRXnPnoaZOnA9alGVBlNkxkXB7xe8BTCE+1zO8Jj0QZoO8
         FyJ7rBoKt8uUo4kV4+Bl4wUp8ZiBoKPzAwwnkfP1P40MZLNdW/qeJzWD2PmtQWPi9fkA
         UxbA==
X-Gm-Message-State: AOAM533+GWAAPCnpZbzbTKwkwwIpDN/qj7l9/5J3PMyeytEde8c+J3QU
        Ro4REr+XkK9nL8uOvs5+kC4=
X-Google-Smtp-Source: ABdhPJwh6oAxkvtmOQ52kA3CiLIs0lxZrbLAR+btg/4CPuv72CY4YbMlf7+AHvKD5/vejXu6V67cNQ==
X-Received: by 2002:a37:6c1:: with SMTP id 184mr3305549qkg.462.1616467344162;
        Mon, 22 Mar 2021 19:42:24 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:5155:3abd:5705:9236])
        by smtp.gmail.com with ESMTPSA id f8sm12512817qkk.23.2021.03.22.19.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:42:23 -0700 (PDT)
Date:   Mon, 22 Mar 2021 23:43:06 -0300
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     rikard.falkeborn@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] w1: ds2438: fixed bug in get_page function
Message-ID: <20210323024306.r3xwrzhckfgtsp64@LuizSampaio-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_page function always returned register values from page 0.
Fixes by writing the actual page number to the bus.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index a9884fc8c726..08f4b451c349 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -62,13 +62,13 @@ static int w1_ds2438_get_page(struct w1_slave *sl, int pageno, u8 *buf)
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_RECALL_MEMORY;
-		w1_buf[1] = 0x00;
+		w1_buf[1] = pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_READ_SCRATCH;
-		w1_buf[1] = 0x00;
+		w1_buf[1] = pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		count = w1_read_block(sl->master, buf, DS2438_PAGE_SIZE + 1);
-- 
2.30.1

