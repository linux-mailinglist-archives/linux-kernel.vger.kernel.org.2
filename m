Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3736F68E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhD3Hpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhD3HpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AAFC06134A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i24so21925705edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6sZe3osaLDDSPNYI5JYp+0cY5GbbYZW8NCqEYTYFpk=;
        b=BONAVKhuvsiBzo1U1aG0am/ap2s1ljf2D+UpwoEyYvtskQSzCTZIMofkJj4BhBcmy2
         5EOD4HyQHgHhH9qAEWZmsBAA7T3eBecuCRkCczlx45HcF5kHKZZHGDuKyR5UyknCW2J7
         HdELqgsn38jgfkC9SUNksO0MXEhB+WPAp+zLcHkmG7IBN86gbRBIXr6CVEOePAb5R5qD
         B+J/zknZxdry8S/l9wgpE1GjSr9X7NREXRvtpZ10wn4z+6WiRlTAHzmoMxb9FjgBjhdo
         KZ1AUTraKByDjbrZyMkStaEhYt7p/vE9exLj8pGdNTMjyOiJjicJlkbzxnKj8MjLZb3M
         dIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6sZe3osaLDDSPNYI5JYp+0cY5GbbYZW8NCqEYTYFpk=;
        b=t80q2y/REBFPzdAp4mbaFyYyYn7iASUm7659cygYCCyM/ZkFMksPSUKKGFrSMikpQ5
         588tSsJXbdtHKn0fwkAeol3GfXHwfSqK9UAU7KKSMySezXHAQY5tOR7SmmDjzzgNcT/Y
         mYcZulC21BQYDnw5B/FNqD5MeLOcQFBfVsr7DJrCvKgDkNwhg2EXz6zktJLDvGgEWfl8
         dtq1cWmjq7O5+phbpPgZIHOuT2v/+x1os4LRn5xm09zUuglx81j8Y+92L8q2UxDOwAyT
         anIitCtcj11pmmHq8hfxFyyJbw3cLmysJx2tu0SjMsQ0FIuGiM3qfSnl0X1tueQhM+yz
         QTHQ==
X-Gm-Message-State: AOAM5325ePDFgU6Uqe5HCXAuccgjpGsN4Vaulv9gV869eZQlQkfj38n7
        FXqqiKptZ1xxmmqVE1c2hiCPCS5A4Gr0jw==
X-Google-Smtp-Source: ABdhPJz2IvIATmKxe3qWO1+dIup+hKj1AYfuRyCy70ca3SxU0s+mtQa12nmAOlqe4ZVPQHYnsh5UYQ==
X-Received: by 2002:aa7:d5c7:: with SMTP id d7mr4199146eds.114.1619768669368;
        Fri, 30 Apr 2021 00:44:29 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id rv15sm1426820ejb.83.2021.04.30.00.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 15/43] staging: rtl8723bs: remove empty ifdef block
Date:   Fri, 30 Apr 2021 09:43:33 +0200
Message-Id: <edeea4e312d7efe459d89f8e6674962470db3f98.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty ifdef block

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index c359eabebb67..8ae9948fb0c6 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -95,10 +95,6 @@
 	#define ASSERT(expr)
 #endif
 
-#if DBG
-#else
-#endif
-
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.20.1

