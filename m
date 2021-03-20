Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E983342F77
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 21:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCTUPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 16:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTUPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 16:15:24 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8430C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:15:24 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y5so5068387qkl.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uS5lS0DS4Famxxuw37y8Mj4Kl+wZMQWER/VerzJMRP4=;
        b=jfOW0A3T5ooSAYCj0EmEaunyj5Lo5pqFmdqtSNDGqo5QTfuYyE+1/nZyBQnUxDRSAf
         iGhYplwurnNl90Zz8J13WjTuYKJ0vwCFutLpuW469LQSAy66qsKM82rs8LAOol3X3HEG
         AUJanMo+mxRU/nIOJMboBDpfeh0VBL1mx2WdR31AC7G9O5dZbStXgDql8qYQUNTGYfwq
         G8KcSTf/GcivGM7D/i396QvkS+bdYUvasR9Nz49i9sO2XwfL63Ecp08pj3b2Z6zwOgdi
         /RiNkbEn5CsmLRQ4bCjKzHp6FN2ezMSkvMM7qEyfSWTy/4hIj41bzlXYlGgCKAGoz2kZ
         bILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uS5lS0DS4Famxxuw37y8Mj4Kl+wZMQWER/VerzJMRP4=;
        b=S1Pr5d1GiKfUSTVnndVIYbxGTZVus/dzMghzY0avGXeS8lxKVMU6Cm2cTrIu8QFqMv
         TH7/mEzJXaK4nGzbvEzDQiDutTse1EfAbolKnyi6Y7sTAx1oLxl3IQWawfQyxhvHSL0a
         oCJtFPbVwTW9CUyR0R34J8xCwOb150Pxix/VEuXctC8CfADJ/EIrVIfyvqP0LGtT1SfX
         55nIHUB0CIB5f1zuIdA0fFNjVODeVP6TRjP1SSEuWp7W4VDqzZjg2zdIgENsrrZCyM4a
         rUPKyn861nJw2QvQFTdLbZ60iS3GUhphls+SpmO31AjkAWUH2FJAcCjs7n1mi+WBNqcX
         AYtg==
X-Gm-Message-State: AOAM531x0qv4WnuNAKO0gc1WHVWrkxptxvmKHREYNEInreFNEEw9FOyZ
        2KsAsE52rBjp67CLshKOP/k=
X-Google-Smtp-Source: ABdhPJze9Lv5uRbn6yVEEbVIAuWkzylhVOWN4e3gJwuYpqXeqBu2v4QsTVBYdBxed2GnCBqE4q1WNQ==
X-Received: by 2002:ae9:e015:: with SMTP id m21mr4165013qkk.420.1616271323854;
        Sat, 20 Mar 2021 13:15:23 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id f8sm7394129qkk.23.2021.03.20.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 13:15:23 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        lukasz.luba@arm.com, jroedel@suse.de, bgolaszewski@baylibre.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] driver core: Trivial typo fix
Date:   Sun, 21 Mar 2021 01:42:40 +0530
Message-Id: <20210320201240.23745-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/subsytem/subsystem/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index ba660731bd25..a8ce0dc3b758 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -49,7 +49,7 @@ struct dev_iommu;
 /**
  * struct subsys_interface - interfaces to device functions
  * @name:       name of the device function
- * @subsys:     subsytem of the devices to attach to
+ * @subsys:     subsystem of the devices to attach to
  * @node:       the list of functions registered at the subsystem
  * @add_dev:    device hookup to device function handler
  * @remove_dev: device hookup to device function handler
--
2.26.2

