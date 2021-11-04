Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677C4444CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhKDBMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhKDBMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:12:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74593C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 18:10:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k4so4495280plx.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 18:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K7K+tHdK20GBd/ySrom3i+DrmDsH2xwdErxdX8kh7s0=;
        b=FggLV6NxJc7LVtJbw2NTovwtBYcOxBQTt9rpDHTyYAphphRtXHFrVnZfBy4lA9yCgy
         Paj18XO5V42GDSOICVBzZtRTAig6zXzcFbwz6YAWwermstOTg6PZkSl6sSBsqHOWH8zu
         ZxBqNTzppX8ZYPYm1KMJF12SKDctLHFWkiaClnU88mGIPwkzEIPWR7pIpVTyFzyid6+8
         aDQGOh74q4ioCPbxeRmnhN8Z/SHsEk+yJa38AjwBYz2qWZ4VF5Z7BmXpXKaieq/Pngrt
         Lp53zXzQ7g/psaKmvR/9JUHzKw+FYxw8S736pJsvRN/U3PTj/4vv7mFV1+axKSuY0k9q
         2yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K7K+tHdK20GBd/ySrom3i+DrmDsH2xwdErxdX8kh7s0=;
        b=eDKzikFE7qAgQGqzSe8NvGQn984FPiOnXOb4kyF6+GBIjKr5KDQEFR8qkaBysp5d+y
         UDi2+USsE/cW+TxidRpuOqBh/aW0JcJnz1tFC3KD0cwQxr8QM7L5RBrGWew6zoPLpWwj
         rDHZpYdglXVluFeVEhipBXuqEeRL4RYDwGRK+b3U2zjNKvFKZx9jXHEkMUMBwAT4lOCF
         fBr9vkmquDV93MMiWX2SxmijIhcKAvmv/ECm9ZRsjPRtmeGbDC4q/cp7RBn63gGsaH8/
         t4sGgpAXyQM1gDE6GpzkyZ91D7mZ0I6VG4Mpn8AkCaM6ltwLYBfaCxAQzogGQk8lwZyB
         ZsOw==
X-Gm-Message-State: AOAM533tIxXukjx4pVUUWncl6jP6MSH+NOJyCKcNv4TvjbuyuF4ybzY/
        kSvjTPAfVtiduaOw596cdTc=
X-Google-Smtp-Source: ABdhPJyP8hi2lnQ0Srk4nYqIiLVvbmDQk8OWCtw4kOJ0Ha0/AYJLPHTRRGLnUqqorh5zM+d0sZ+Uvw==
X-Received: by 2002:a17:902:a70e:b0:141:a01d:9d6c with SMTP id w14-20020a170902a70e00b00141a01d9d6cmr38669636plq.84.1635988203020;
        Wed, 03 Nov 2021 18:10:03 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id x17sm3422500pfa.209.2021.11.03.18.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 18:10:02 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     benh@kernel.crashing.org
Cc:     davidcomponentone@gmail.com, mpe@ellerman.id.au, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, yang.guang5@zte.com.cn
Subject: [PATCH] powerpc: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 09:09:51 +0800
Message-Id: <20211104010951.1027348-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/powerpc/platforms/powermac/pic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 4921bccf0376..75d8d7ec53db 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -311,11 +311,8 @@ static void __init pmac_pic_probe_oldstyle(void)
 
 		/* Check ordering of master & slave */
 		if (of_device_is_compatible(master, "gatwick")) {
-			struct device_node *tmp;
 			BUG_ON(slave == NULL);
-			tmp = master;
-			master = slave;
-			slave = tmp;
+			swap(master, slave);
 		}
 
 		/* We found a slave */
-- 
2.30.2

