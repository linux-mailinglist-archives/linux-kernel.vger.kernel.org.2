Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D47B36E7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhD2JOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbhD2JOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:14:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E24C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:13:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m11so2482969pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=daUJAt6BDK7VQ+WlkM9PDlnlylglMZJCEcrdwOXNXiU=;
        b=dNRaCOjTd5rJ7pIJnhapOyuioT2WF6PhpsaQCTwi1yiyoLsaEvwWhg5Z3OGraNih4r
         OC4ksq2pViFc7pxL74+nvCFkIHYeEduPukhei/uOD6wluDzc/q3pDLOxMRVXGKxlEYDr
         3GkddQuJo2r64VSK59jDrkq83TdwwdrIwo28NS5rtc0CuGZj1KsmSL15NZNTzVm+opM/
         9JbB1GiIeJoVO352iE4vPzacPls6qm/71ytbk1fUTEtoNI9RjjwZf+ir5ir7J8JsF5/l
         dkKSU7Bz+ksevFT6M6q4PhIvBqbxiFCq4I+HEeT1PN9Jz3XmEeQOYlC5hrxqSluvaWa+
         tWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=daUJAt6BDK7VQ+WlkM9PDlnlylglMZJCEcrdwOXNXiU=;
        b=KFpWXrD0jja2zBeFzhA7M7T5x3AfBB3NuJZ2i2FJzYZ1suUQvmiTpcn0/1/nLD6CYo
         0QpTVLAeo20AZDzl0wHYEFsou66CgJ5xaW8rryrmWEbFkTJwIqxUmNlmFDxyayaAUy+Y
         99z5dzIVt25zxIIS0k2t3DAF6aQgBcYZw88NXDoDXh0KF57uDz/kIfplVbJ8yJnRfiYI
         ML1Ju5WHhibVyUT5B3nh2eYP7eQI6IAHf0zy9AR/m5uscVTFTGoQ7uzOr+4jjOYm/uPg
         wBXp9/7fNpUV4JoPkCVN18zyNGsc8SUs/Fr6IyMZAbN3f8ACOZE8r5BnOUW87Z6p3asu
         p+FA==
X-Gm-Message-State: AOAM531r3tjpNuEb7l+xDxuJ+72TLvccG5Zeo6tUShZieTVU3LDg2C9s
        7o3s2PQ87TEXP09QLdJ82vI=
X-Google-Smtp-Source: ABdhPJzr/RTLTDeRIA2mpucsICAgg8RNCsrSGdBG2uZfNJqu9CaM5wRHqkVwXZrbDKneSWC4E/dYOA==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr31624182pgt.356.1619687617917;
        Thu, 29 Apr 2021 02:13:37 -0700 (PDT)
Received: from localhost ([115.99.169.0])
        by smtp.gmail.com with ESMTPSA id f20sm2011925pgb.47.2021.04.29.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:13:37 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:43:33 +0530
From:   Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
To:     linux@dominikbrodowski.net, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Remove space before tabs
Message-ID: <20210429091333.bw25zy7datkegtt2@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Space before tabs are removed to maintain code uniformity.

Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
---
 drivers/pcmcia/yenta_socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 84bfc0e85d6b..e9da9c197ff1 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -6,10 +6,10 @@
  *
  * Changelog:
  * Aug 2002: Manfred Spraul <manfred@colorfullife.com>
- * 	Dynamically adjust the size of the bridge resource
+ *	Dynamically adjust the size of the bridge resource
  *
  * May 2003: Dominik Brodowski <linux@brodo.de>
- * 	Merge pci_socket.c and yenta.c into one file
+ *	Merge pci_socket.c and yenta.c into one file
  */
 #include <linux/init.h>
 #include <linux/pci.h>
-- 
2.25.1

