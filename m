Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FB3C15E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhGHP2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhGHP23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:28:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77666C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 08:25:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a6so6020229qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=ZlsmpUZ3dqpWLyD9xGWZtjT/n2aBeI2MV4ZA7OeTIJE=;
        b=JX1jiFOpEifP7nXEV+l7qXTqB/HpAHr5Y4V5OqIKYTgubw7yR7sQ0AMWtdU252XEPV
         nulK4XSgludUXIgMZNSh3t0VUIeJKPP6uIdsM6ZklTJ7WvjoTZm5YkI9pVHVNZEzUjn6
         RBPChln9daFTztYlfZOPh8jiHA21Qi07eeHIXBor4KJ9bB4ga7zZTSxpUBPAUuxugDx8
         rCjL9SUIwGO6jA10YB2JPZ9yIw75IsEbS2PMYcJGubbskvqGPK+k41coVcF4VHTqaYI2
         FQlpAXIBNW329Q/H5iQSiuIXBJiZXaVGEG6DmZUxafOvKWiI/js5h6k8iuAWO/RCcL1S
         e9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=ZlsmpUZ3dqpWLyD9xGWZtjT/n2aBeI2MV4ZA7OeTIJE=;
        b=Vj6zSOfdTQ1i0XX/Xqt91DZcJkH1NMULZA9Ya6xLyz5Or+XnE28Vua/X0uP591I7in
         1jc5NYaW/CZVgR1UBmzIBq9ErxQqQ2JErVZvI4RuGhvr7quCG8ficvdzX1oT2BfkMHnn
         0+WH20E8HQEw9b+WsVWksDUTkB6911L6b5a1beke1dm5T5zfK59AKAEEIsdQ7CxKa17d
         soonMA0602Z0UWMqESxSeWgPezGI1RLvQFEPa0hJzQl5KJ9gozht2ZnFFWoGMuIHag2u
         ptCD838E6wsvCenVRUCO5B1D1e5gJf6TSAu94hr/KSDYtiqKd2gCjP6d5+lhMHQ+5WTj
         REuQ==
X-Gm-Message-State: AOAM533UBpV8yaAAWHPpFfevuUm2eX0wYEWB+TSqT++mv2DQGuLeNnS9
        Hs/w3jcLLkDSngK0TdZ9ZiMJdA==
X-Google-Smtp-Source: ABdhPJzlnN/DdwjUTZRoDmXWDXPzwZfq3mQopOF5elSUKGRVoaL7qo3K3JzF8ZcimejjDuXT+boFxA==
X-Received: by 2002:a05:620a:4dd:: with SMTP id 29mr27156031qks.250.1625757945517;
        Thu, 08 Jul 2021 08:25:45 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id b188sm1073658qkf.133.2021.07.08.08.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:25:45 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     James.Bottomley@hansenpartnership.com
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: [PATCH] drivers: parisc: Follow the indentation coding standard on printks
Date:   Thu, 08 Jul 2021 11:25:44 -0400
Message-ID: <1793924.CQOukoFCf9@iron-maiden>
Organization: Virginia Tech
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation of printks that start at the beginning of the line. Change this 
for the right number of space characters, or tabs if the file uses them. 

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 drivers/parisc/iosapic.c               | 4 ++--
 drivers/parisc/sba_iommu.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 8a3b0c3a1e92..5d27c23e6429 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -633,7 +633,7 @@ static void iosapic_unmask_irq(struct irq_data *d)
 	printk("\n");
 }
 
-printk("iosapic_enable_irq(): sel ");
+	printk("iosapic_enable_irq(): sel ");
 {
 	struct iosapic_info *isp = vi->iosapic;
 
@@ -642,7 +642,7 @@ printk("iosapic_enable_irq(): sel ");
 		printk(" %x", d1);
 	}
 }
-printk("\n");
+	printk("\n");
 #endif
 
 	/*
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index dce4cdf786cd..c3381facdfc5 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1550,7 +1550,7 @@ static void sba_hw_init(struct sba_device *sba_dev)
 
 
 #if 0
-printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
+	printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
 	PAGE0->mem_boot.spa, PAGE0->mem_boot.pad, PAGE0->mem_boot.cl_class);
 
 	/*
-- 
2.25.1




