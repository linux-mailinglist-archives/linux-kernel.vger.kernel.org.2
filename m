Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD054312BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJRJK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhJRJKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:10:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1374C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:08:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q5so15461209pgr.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WivVudv0HA6+/S4GcdhqzlDpKhjNRPSqHHYwrtNgOdc=;
        b=gJPL20m29DAYWxhLpiRwBuT/NCX7ZVH3CA68J3EV9W19SayAU12HXeLZuFW7medBI9
         rImPXqr7YEFU23IRs6cI8hNUs9ilB7jFGEQqbI++u3B5RReDcf6uSS0V3FtbTBzjdzeo
         JAOXkVInqD8BAIpBAtAvL4ywyyCOics7eWHFIKs8BQAijg5ChAANZEnfyjWuatOjKo+N
         idfMJemrKpmA+uhVhwJ2qmKMjTwt/uTJxl6yyeqt6jGEtEO8/ONzcM1yO3aBKzM+5sB5
         buSUcBL0ufyDhnfgXgBblx1Q1iN6giA8sScZFsUfQ0+F3zyKfy8G7KmkyAQL1DLDCXi4
         YXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WivVudv0HA6+/S4GcdhqzlDpKhjNRPSqHHYwrtNgOdc=;
        b=gS0jN/gzlceSq0GyDcjk4HcJXkHoKVIV93FLJ5syBeAUDmoFPK0Ehs89rWtOiEXa+y
         NSGd3enZoEMBbt1Jo7L1kHzXf30K9mdxb8SgQQIaUhaa7+qseZg5oPHxZxb2Eowh7BU6
         ie50xtu4dkdnpZ89ycI9ZrmXeAg8nrmdDXWEoxKNpuK+1kxDSXKeN1QmJ7BhTSQXB5iR
         TNUZk08Ob8Epz+RV96QVHJIBO4c1qIA+03cUN4+YnlHUFTnyy7aNpHCCM3fHmk/ACCer
         yS/AtzfZ0jQTODVpOOYj588nkHc6IFnpHk5lIi4/CkP2AMVVij6PiMmAsTQvRZ2yRAfB
         vVEg==
X-Gm-Message-State: AOAM530hCmpbY9Xm8+m/99z362zHIP8/r1JOb3R1oCTLxqB5qXtOWvJq
        JkJVWqYKSBk+uGTfMAL5brh6DpXBcyg=
X-Google-Smtp-Source: ABdhPJzB43Ljs1uH/xnlsY4/xEzVqlqWQ1X2xzvpOno4QQeUblu9SPFWhFB+V5d25zHeRg/8AAj7oA==
X-Received: by 2002:a62:aa15:0:b0:44d:6eda:17b2 with SMTP id e21-20020a62aa15000000b0044d6eda17b2mr27982302pff.74.1634548120191;
        Mon, 18 Oct 2021 02:08:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y203sm12738803pfc.0.2021.10.18.02.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 02:08:39 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-kernel@vger.kernel.org, penghao luo <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] cdrom: Remove redundant variable and its assignment.
Date:   Mon, 18 Oct 2021 09:08:34 +0000
Message-Id: <20211018090834.856992-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: penghao luo <luo.penghao@zte.com.cn>

Variable is not used in functions, and its assignment is redundant too.
So it should be deleted.

The clang_analyzer complains as follows:

drivers/cdrom/cdrom.c:877: warning:

Although the value stored to 'ret' is used in the enclosing expression,
the value is never actually read from 'retâ€™.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: penghao luo <luo.penghao@zte.com.cn>
---
 drivers/cdrom/cdrom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 89a6845..393acf4 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -871,7 +871,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 {
 	struct packet_command cgc;
 	char buffer[32];
-	int ret, mmc3_profile;
+	int mmc3_profile;
 
 	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
 
@@ -881,7 +881,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	if ((cdi->ops->generic_packet(cdi, &cgc)))
 		mmc3_profile = 0xffff;
 	else
 		mmc3_profile = (buffer[6] << 8) | buffer[7];
-- 
2.15.2


