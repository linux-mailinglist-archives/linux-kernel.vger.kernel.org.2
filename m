Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D801D444BED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhKDAV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhKDAV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:21:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B62C06127A;
        Wed,  3 Nov 2021 17:19:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r5so4368377pls.1;
        Wed, 03 Nov 2021 17:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZX42t+m/L7F5rM7fN75MjjvJ4nCu4BRBA/sk5nwkbc=;
        b=WDMrEERxUsZdwgk51Hbd8ejOs4iA+QyerFqAmmMvauFZ9qDhxcjE2QAGP2Rg3IXoeY
         wpctvQkdjN/ZEUk8kBb0G/CJ9LuzbjV+7/tPzM2adM9ER2aBrfY3Id9BTOEk+uFeh7WV
         2HjzDz2I57Y/e8SQgSAPqmE4yMbCqrj+aqe1FEwTst7ERAKUHC9payrIrxh6KsLEpzpW
         7ih3NJEP4FFcifzoScR4N0Cj7H6+j+ZTbmmYcgFiCtj76s+LjJ8mricBjrz3T/g/p47w
         54vG0wRdhELfPG8CjiYlFmMejxDpxtSA8cSyIxQN2TbJWX1kL0m8DehqxTP5OGZLVKDx
         3KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZX42t+m/L7F5rM7fN75MjjvJ4nCu4BRBA/sk5nwkbc=;
        b=IRB4r1eW8ZMaLQivDC5jWyWqbIW6V0atShipDqB/k4Fr3ZVzhUWqc3wJXMuoHd6ZAn
         97tKQl3b7s8ksmH1t/7We0VhI2AifKJvGJap2E7yWx77egLb3V4ivn3Og4an66GVy0RU
         7jxQROBpPnARx+X4qRZzesYSf9uMtZkBKxIQPuLmo1W0FHbURgMAucNOXL/cvdxZTQav
         aaHiymhxG4zuWZ1c60HuCdGT6TUecCLMSpn+wkmcJllubklVKEEA1Z5FRdKNLMjhHLBY
         2WfAzuX6z9zQ0pY3/ef4uOOJnELdKy+KShfJaUCyRIlDZPWIl5Xhr3yS5WU5hszyvyq0
         h43w==
X-Gm-Message-State: AOAM530gBeT4efkI4OLKn+5SSrbGJc8zwqo/DZTr/pE4J22CnTx4F+UP
        HGiqbET1gEDm5/VyZLUZ3XcGhSy8N6A=
X-Google-Smtp-Source: ABdhPJz7K2yk7nXz+2n/EwO+XXGM+r7f18rXobDUeVUZnhL1EV1ve10ca2eHm0QXvxCyufIiGZwooA==
X-Received: by 2002:a17:90b:3889:: with SMTP id mu9mr18368048pjb.160.1635985158801;
        Wed, 03 Nov 2021 17:19:18 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id f18sm3442327pfv.74.2021.11.03.17.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 17:19:18 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     geert+renesas@glider.be
Cc:     davidcomponentone@gmail.com, akpm@linux-foundation.org,
        yang.guang5@zte.com.cn, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ia64: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 08:19:08 +0800
Message-Id: <20211104001908.695110-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
---
 arch/ia64/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 31fb84de2d21..5010348fa21b 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -208,10 +208,7 @@ sort_regions (struct rsvd_region *rsvd_region, int max)
 	while (max--) {
 		for (j = 0; j < max; ++j) {
 			if (rsvd_region[j].start > rsvd_region[j+1].start) {
-				struct rsvd_region tmp;
-				tmp = rsvd_region[j];
-				rsvd_region[j] = rsvd_region[j + 1];
-				rsvd_region[j + 1] = tmp;
+				swap(rsvd_region[j], rsvd_region[j + 1]);
 			}
 		}
 	}
-- 
2.30.2

