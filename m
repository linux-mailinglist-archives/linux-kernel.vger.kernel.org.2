Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C098C435B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhJUGqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUGqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:46:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D08EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:43:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so4185156pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUNl839276rl+p9Am7/ZydRFkb1jUBmsHXSKG+zzq7k=;
        b=Ug3oydtJM8Sm4AKE3ggON83rK6JsksjtPLX7r1KdihM07+kTB7yQUqpQzlwlX11vrd
         +q39rR2MnpxzlEuUwVgZB/1lgHir6bFpP0EupLbh/l1ALp+iZhiKBEp9Qrgsgm4FLuWm
         K/ZBvaazbXJO/KmhlJISFAhT3ICSsytC3dic1qafalIsa61RzpHj75LjHjcZ9HOsTzc3
         noYc9S8aAAmLzcZDexm8KGyawiHDSWZS/2zVT4Uy2UnHLudzdoALqMOOHakvrA5KqzeH
         GrB905LeH8Cr6zBlie9znSuz3l/bw/wlsXfYi+B/1lnrbc7rKRjN3EaL2GInFPG+oa06
         QBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUNl839276rl+p9Am7/ZydRFkb1jUBmsHXSKG+zzq7k=;
        b=ZsYDVsNDDKm7O7jO7TJ3/68Vgkkhh2S83geHJDjBNqX2IHh1un3WRL2e5Sgpjo+zDp
         bvqfqCntC+QX3rGMdKY7UBYsUUneAyG80RrQLNDIJXT3rgluV1LcE2kRP7JgiUjsTQIf
         1eJPEINkGXPCrY1SU3R4JGBOTyvHMfPxZOik86iwoR8SXQQqD5lE2HY/gkagD0HhpLxX
         fytvlXdypDpOEv8FEztr6zc5Dxp1eJW4XuxyYTojqFuWbrCtgTDrFdYqHnhmpUs1Bn9w
         wdAV7NtIZmLLCAkA+1iafM8xE2ssOmpYWl3z8ZIcH0oXue52/eP7QAxpgdCJ7pI6dGSt
         G8RA==
X-Gm-Message-State: AOAM531BOGKBUc3ASiYJxWZW+i09Erfg233yHCFbhHgdEr6bKFvGdF66
        cpL/ChrHcWGF5SLNC/ej9fQX0nPzGHo=
X-Google-Smtp-Source: ABdhPJzr8KKGx7MqYquf8chccTAmhc+gAGjFDiZ6Ktwfz3QYnQk2VnALsvkFsWB1cEpcMbyX8gs5kQ==
X-Received: by 2002:a17:902:d50f:b0:13f:ac51:29b4 with SMTP id b15-20020a170902d50f00b0013fac5129b4mr3512357plg.51.1634798627162;
        Wed, 20 Oct 2021 23:43:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t9sm7965827pjm.36.2021.10.20.23.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 23:43:46 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     ye.guojin@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] arch/arm: fixup coccinelle warnings
Date:   Thu, 21 Oct 2021 06:43:27 +0000
Message-Id: <20211021064327.1047416-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 arch/arm/mm/cache-l2x0-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..a9bd05b82003 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
 	struct l2x0_event_attribute *lattr;
 
 	lattr = container_of(attr, typeof(*lattr), attr);
-	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
+	return sysfs_emit(buf, "config=0x%x\n", lattr->config);
 }
 
 static umode_t l2x0_pmu_event_attr_is_visible(struct kobject *kobj,
-- 
2.25.1

