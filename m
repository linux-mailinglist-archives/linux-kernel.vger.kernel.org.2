Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925A5410345
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 05:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbhIRDku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 23:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbhIRDkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 23:40:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BDFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 20:39:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n2so4830565plk.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 20:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ms3vEIwed7axJJI4pRikbtTzcex85bsJ251ErKhjvo=;
        b=ilabGGj9uvmj1RzfihJGadghI0jqdj7TpAxqd3kz0KVNSQU+vatTG66po7Kh7Vfwu9
         bqFijo1p2oHK1xTeLRjINt/oom/UUpaB924qPdsdVTZR0kuOKGswdUhitdnJk3Cm6SMk
         Dwpj8mExHsS1QB4+RWb091sLAxtbd2+7zqEFlrXXVqh+B7FsTLEKLi2q6fKEu4wT437y
         9BziNBe1bXZhv/WCkAgUkIb6/1JF82lL9ESPIyMk+cNOSct5OXYWXM8+ZrHeuL7HG7G7
         kwsrW+izsl9cMAMtPeoGAG38hHAQKv+G0eL6z6bR3JtrsF9VvS4f3yd/BwRIIg86hnAj
         NQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ms3vEIwed7axJJI4pRikbtTzcex85bsJ251ErKhjvo=;
        b=jWXXwWW8prYaa03YkqHNbcPLwt6/msrYCsn41yQtTVw2uz+nxLZtWAT/y33vvmAOiv
         6DOE4u8S/2xy8afNyVUI+7LW1z+h8lH9hnS1fOpgUKAntcmZbzhWoIQXYYGBJfGoIO+B
         BHNxuhpuexXo5Yy8B0bxnHMKTwqTW8XzQGb/xEjQdE6M/LFQmhhBTut1cO8NS7e6eLD4
         J5Di5k9gXzd2sA/QcBi2Y0k4GEJ/BQd6NNPtlpGb+GU4IT93pM7WnGOIjxuSPPGGtmr/
         MwpbBHGZu6ePGPfdVSDb23L4oynHtQYxLJd1z1BFXxwzBkDGF6gwwUO12IFnxoEn9oT2
         foeQ==
X-Gm-Message-State: AOAM533gltVb3+8NxynuJPZOKVhurt/9neEXxcDtu9k76Qnoaf8F8xeO
        XIiWnQL0mHu5L4+sG6Y3TsY=
X-Google-Smtp-Source: ABdhPJwEZdSvXJGp8Ad+4wmgoHbSl5eovwDglEYhz2ffvQC8RCf8ldTGHJz/LI58C78RaV9i4Oo0wg==
X-Received: by 2002:a17:902:b717:b029:11a:fae3:ba7c with SMTP id d23-20020a170902b717b029011afae3ba7cmr12696892pls.28.1631936363747;
        Fri, 17 Sep 2021 20:39:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m21sm7926957pfa.216.2021.09.17.20.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 20:39:23 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, martin@kaiser.cx, paskripkin@gmail.com,
        nathan@kernel.org, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH V2] staging: r8188eu: use ARRAY_SIZE
Date:   Sat, 18 Sep 2021 03:39:10 +0000
Message-Id: <20210918033910.237216-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index d04d2f658ce0..44bee3b2d0ce 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -261,10 +261,8 @@ static void process_spec_devid(const struct usb_device_id *pdid)
 	u16 vid, pid;
 	u32 flags;
 	int i;
-	int num = sizeof(specific_device_id_tbl) /
-		  sizeof(struct specific_device_id);
 
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < ARRAY_SIZE(specific_device_id_tbl); i++) {
 		vid = specific_device_id_tbl[i].idVendor;
 		pid = specific_device_id_tbl[i].idProduct;
 		flags = specific_device_id_tbl[i].flags;
-- 
2.25.1

