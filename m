Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CF83F26A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhHTGGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHTGGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:06:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43991C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:06:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l3so6649469qtk.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoaMkljyHgS1AidboqHVoPwYgokiMzyEn+N7OSq7Bz4=;
        b=YOvqmwVAy3VyvO6UUIEAnr/ZZl8CE6w00IOazxDDS3DN5vX33r/3W1s5fZsNGgbHJa
         pKiGqSD46QagaRdP3WhFDoHte00ZhaRCR31A3EhmlVGu8TaQ0Kby9+1Bz/VXfPL/yK/Q
         neIZ0anGLf0LyqQZqrIcIOGlkqlJRAoiCk43yqw932WYyoVuqGrXmL+cb3JB9dEYkIdT
         dIDi4fq/M75307Sc90kujNSbhHEDZs2ib/J9X8opDF2SEWURDZBLgU6bDFMk+XM8pZsn
         f8NJlY8el9//nOqqMaDt+F/YwJBPclBaya4mS/+DMYX9gNJQKB77bVUgZuV/CqFe6rJJ
         qk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoaMkljyHgS1AidboqHVoPwYgokiMzyEn+N7OSq7Bz4=;
        b=q1UFn+DnPDjAAOdgbezJbvyion55YG/C5LBM2c4IOIJ75HveupOppY7WyHhMezVI+9
         RHWOpYSrE2RjpuQ7BdpPrSqX3ioVth51TRMaNGRXKza54Ru5SSHmyhZkN7Bqv+9JXBr6
         c7F63JRTezAlQ4H7Omi0IYXr6rD55krLpyX4saHv0ehxS0I7Azgq2k9wKFXNoLBDnnV5
         q5yToShLGeYL8Ac+PgINsCPLJJC+CSvTit6oHY5aTOzQjPWv26APxeO0orf/awI9OlX3
         5Yhheq/F1arAeOzaWHF53gBhwxiI2SQ4orPPCcanImafKUedVrglOAHP+GDzO0r3SE4Q
         4EGA==
X-Gm-Message-State: AOAM532gXc1p4J0XLSIu5UcXOo7ZMcv7uDPF75iH7R0njDJYQioY53E8
        BRS5jlsieK39WXnrdQB/Je+6L4UdWsg=
X-Google-Smtp-Source: ABdhPJyC/Ludf3TuV3qvCbhgJe8n27OptTdRaU8tu7w0qHt+b3j8tbSzJjNk00i3EJfTw+v3BcMO3w==
X-Received: by 2002:ac8:7483:: with SMTP id v3mr15974649qtq.113.1629439567325;
        Thu, 19 Aug 2021 23:06:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m19sm2163837qtx.84.2021.08.19.23.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 23:06:07 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] firmware: edd: fix Coccinelle warnings
Date:   Thu, 19 Aug 2021 23:05:50 -0700
Message-Id: <20210820060550.14285-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

WARNING !A || A && B is equivalent to !A || B

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/firmware/edd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 14d0970..e8b409e 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -694,8 +694,7 @@ static void edd_populate_dir(struct edd_device * edev)
 	int i;
 
 	for (i = 0; (attr = edd_attrs[i]) && !error; i++) {
-		if (!attr->test ||
-		    (attr->test && attr->test(edev)))
+		if (!attr->test || attr->test(edev))
 			error = sysfs_create_file(&edev->kobj,&attr->attr);
 	}
 
-- 
1.8.3.1


