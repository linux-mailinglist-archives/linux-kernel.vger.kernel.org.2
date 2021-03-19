Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3C3341296
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhCSCBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhCSCBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:01:08 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC066C06174A;
        Thu, 18 Mar 2021 19:01:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h7so5686579qtx.3;
        Thu, 18 Mar 2021 19:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rO25QPbTaTK7y9+d8cTnyGvXpySixv1pofVpr5MQEt4=;
        b=pR4mmonDSj84LmmFOm5lGkrOBTZ3RLcSayOYyHXNwHU84CT/iLd4hkhiD0r6THd6oQ
         Ddz3YaDNvNzcnNjf67PrDnXw22kDwmRFh1/28rXsMCxDbJI7c6mw2hKLASYW/cDkNnc0
         kZDii3C8COoVHZO4iwudKtSAMAAxK0kCMQA/TszyT09ZVgDdFgNls4NXTeQNSXFSThxl
         KkVwji3YbDlRdNYNv0/dU1Wg9bkAS03cbyaMpQj8XO7mGHouaFx89QGTIwAoN+hCI3V1
         Eh2UdqwHo2A+1y2MgcUdl9I1vOmAHZ6YBnLXpjfNagCLO4Uha727wdnw+AJFmwhNRyKH
         z9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rO25QPbTaTK7y9+d8cTnyGvXpySixv1pofVpr5MQEt4=;
        b=UOKH9H+rS5Pc5tqJBc3pip2bRIS+oe95zYHj3cbqRbGTQdYuC5SVqsF3kYXIrdol+r
         1rXrAiuHW6jaPHg3Hr9nvODQm2QuTgCGJE5c7veI4mf7VR6BwBMpPke95ujX+e0qj5BC
         0+NImLv9Ekl4xFmZ4XV+Zoi2ZXRw+wFKmOWeECZBWLvD0nAV/D0CyX14rYbX+dllq5kl
         FCTukCLBa2sIBdZsds+b8rM4S8uV/iEBgdPx4DcBpbqkfSr3pOK+QA5RC5641fkeY49W
         AageKRh1CQ/9OAQ7kTrk0A6lnonNhxuMLP+TWsgB5DPItPxGPVSWAyox/p5g7KNnMJQU
         HgHw==
X-Gm-Message-State: AOAM532/+2JxYvEqodhc+ctyNZoy54muOe+8Fx9NRPIb/pGkUjXT5FDT
        OwOiQBuS0R7nuF+UB7af1i8=
X-Google-Smtp-Source: ABdhPJyVl6MUJQ8kbqTda5tNxbhC1xI6vXig+B4EosTjg8MKi3mPzS1X26NJ32vOm/44wFzXKmv9wg==
X-Received: by 2002:ac8:4510:: with SMTP id q16mr6314118qtn.241.1616119267081;
        Thu, 18 Mar 2021 19:01:07 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id e2sm2813453qto.50.2021.03.18.19.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 19:01:06 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     hirofumi@mail.parknet.co.jp, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: filesystems: Fix a mundane typo
Date:   Fri, 19 Mar 2021 07:28:48 +0530
Message-Id: <20210319015848.19515-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/provisoned/provisioned/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/filesystems/vfat.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/vfat.rst b/Documentation/filesystems/vfat.rst
index e85d74e91295..760a4d83fdf9 100644
--- a/Documentation/filesystems/vfat.rst
+++ b/Documentation/filesystems/vfat.rst
@@ -189,7 +189,7 @@ VFAT MOUNT OPTIONS
 **discard**
 	If set, issues discard/TRIM commands to the block
 	device when blocks are freed. This is useful for SSD devices
-	and sparse/thinly-provisoned LUNs.
+	and sparse/thinly-provisioned LUNs.

 **nfs=stale_rw|nostale_ro**
 	Enable this only if you want to export the FAT filesystem
--
2.26.2

