Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805C336A5AD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhDYIQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 04:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDYIQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 04:16:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B457C061574;
        Sun, 25 Apr 2021 01:16:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso3442899pjg.2;
        Sun, 25 Apr 2021 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wnpkL3ueOA+zoMhko8uVKbNai7YgfMgiPqjt6r4gZac=;
        b=r9Dd+O+wbK/P5tmd596jNPpN2wQePnAJpaj8OUvOejd7x/WqL0tZKv+dJ3PIuWasXs
         rjiUe+5sVtnnpEdPV58g8qR0euZKocq8MQ1ZXhlFr+cMqY+T5cEW30wlR661t38cGIiM
         nSWvRVIa3HODnKReMNU5mpOvOjxTw3b2mpNK90NjxZJ8ULWUQ5vo7tWm4wdZ5elXLPAD
         561OGso6a3xuapNM82koZ8Xf9NbcQoPMi7PzuhEl3K0d/rW0vSCw3cN/dXmmBj460/M3
         ESVukv+Jl3QPU4iIe+yQPMqF6HHmxl38x9Kfd5UL2M0dvxudWnv0Sr9VJ5Ju0jF8HUSl
         IFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wnpkL3ueOA+zoMhko8uVKbNai7YgfMgiPqjt6r4gZac=;
        b=gXASeVttPnaKg/R8lMMSwkmP7GzXcyoMtYCUoUY2qs0JHd0ZhPylHiqn0+a5zlyenY
         LCN8dQwGNnjHR3Tn5AUMifmuRdmxdXZ6UdI2SBZtIS5ioiRpSPs5kpukFabQ2Lyg/URM
         Qv7UbD+u/h6lfD/j2zGUUpJ2u8Q+jtg0/GhsiV0c0VhSF4yBNL8FOn8J8uR0Nh418W3u
         s1rkRJOcWDBQo2d8qUPSqzRcaoeR+akBq/I5Aoni2xCfrkE78ApbH2jHMOKXq/8dN3gf
         5Uje8xH4o0y31aykJ5xcgCnibQQID2mL0L1ytWF8aAs/pwgu4Y2pYhSbdHgOzqcR0Dpc
         99IA==
X-Gm-Message-State: AOAM531fqx+nrJVsUsMXalNf/PD2g65yknjR21Ol3xqWlz+w6ZIq/uN2
        MWrb+PMWEKcF10IbUf4kiQk=
X-Google-Smtp-Source: ABdhPJxYrg7gJC96ZRdTcEHuBp9yu2poWm4YcF6k7FJ/PnpVnt3ehs3/90tSwT1XgagYwaFeVJOwUA==
X-Received: by 2002:a17:902:9008:b029:e6:f37a:2183 with SMTP id a8-20020a1709029008b02900e6f37a2183mr12487050plp.49.1619338573533;
        Sun, 25 Apr 2021 01:16:13 -0700 (PDT)
Received: from localhost.localdomain ([49.37.83.82])
        by smtp.gmail.com with ESMTPSA id k127sm8871993pfd.63.2021.04.25.01.16.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 01:16:13 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH v2] usb: cdns3: Corrected comment to align with kernel-doc comment
Date:   Sun, 25 Apr 2021 13:46:05 +0530
Message-Id: <1619338565-4574-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor update in comment.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2:
	Updated change logs and address review comment.

 drivers/usb/cdns3/cdns3-gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 9b1bd41..21f026c 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -484,7 +484,7 @@ static void __cdns3_descmiss_copy_data(struct usb_request *request,
 }
 
 /**
- * cdns3_wa2_descmiss_copy_data copy data from internal requests to
+ * cdns3_wa2_descmiss_copy_data - copy data from internal requests to
  * request queued by class driver.
  * @priv_ep: extended endpoint object
  * @request: request object
-- 
1.9.1

