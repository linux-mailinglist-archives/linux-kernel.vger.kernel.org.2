Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF26E44D3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhKKJF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbhKKJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:04:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF47C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:01:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso4177437pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mc0Tzhtgh4/qXgYv8Pba3NIwdWL9eEUNhYWCL2YZn7s=;
        b=AVuC2Qy/Ov2rAVoK5pSuBabo+Wy3IA0iRqDiXo62eWaj69nR5hRBIj2yjgflpy1EvO
         jSHS1wV+QFBxga5x/tEnB7a0+Ej9R7/MjKLa844PJBN7h84Z4FlfFP/EDJD7f5M3WIuS
         zgHNj8RINJRBh1VIRc/J6PhcTChl1Xe7j0BiH6leWrf3QrKmDFaeBBIf1uMT2U4joDkk
         Ogm3ohDqg3UBkmPdKKcgqJezP0HZ7apEY9gY35q+DqvnzAt84A3o9WmjCMAEdXuSR4UR
         LzqmJGwQhffcd+LMFhw3UartO6vBWctW/YRKvUjGpK18bteOKe0ehFTcv99/asxRYcql
         xkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mc0Tzhtgh4/qXgYv8Pba3NIwdWL9eEUNhYWCL2YZn7s=;
        b=lYUBLKeg2IffVIPj2XDD6VSo4Aee2pOfIH3tPVFIK7OiIul8MSq164FrvJfuGT26mL
         sW8dyCNixNvDFMFDqxYs6RE59nhOWqc6wuhEE8K1MSGdez+jGtKU2kHfyBAgfWNmz7s4
         X3y3sXi2HIYhWPEhc1h59Q4mZQvcQSq7joksqddd8l4vsZnuheCQtiCqnVnVkF7up8x3
         r5KtMA14Q888d4ARh+Q+9yF9Rrpn29MLlr1bTQw2Ci2okWcejBvNApXQryTuXDJNjDwD
         lJxMc/MobupWfTkQAm+aYmHa/16vTKOCAMlT311atJtjbOs8kjqIrU8/hg3jlohC78r/
         cRig==
X-Gm-Message-State: AOAM530Iivj3sMjVMacmF0k6WI3bOmMAjA8GuLd3cLFbrnknzUHtGBbH
        P/o4IlJRjwWx6bG7aR4iTHRQ2Xbbg54=
X-Google-Smtp-Source: ABdhPJxgtyZwf7guZdlFY7m+JGzYzycnnF0BIbLStZDWlvqJYOG2csnO7zongK5JUKVM8m2H44XtPw==
X-Received: by 2002:a17:902:aa49:b0:142:5a22:428f with SMTP id c9-20020a170902aa4900b001425a22428fmr5987312plr.39.1636621311144;
        Thu, 11 Nov 2021 01:01:51 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f22sm1746177pgk.21.2021.11.11.01.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 01:01:50 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] agp: Remove redundant assignments
Date:   Thu, 11 Nov 2021 09:01:30 +0000
Message-Id: <20211111090130.158582-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

i will then be assigned the same value

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/char/agp/amd64-agp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index b40edae..0413b31 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 	if (!amd_nb_has_feature(AMD_NB_GART))
 		return -ENODEV;
 
-	i = 0;
 	for (i = 0; i < amd_nb_num(); i++) {
 		struct pci_dev *dev = node_to_amd_nb(i)->misc;
 		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
-- 
2.15.2


