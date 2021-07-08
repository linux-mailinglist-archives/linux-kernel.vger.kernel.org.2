Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A03C193C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhGHShZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 14:37:25 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43958 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGHShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:37:22 -0400
Received: by mail-pf1-f178.google.com with SMTP id a127so6306309pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 11:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wpe7pq4aVg7ucsvY4mN5cBs5bzV8w5kf4tTHNcQD3vs=;
        b=LJeV+0AK6DwT6Ih9F4qeEVQgo3IsmQNlNY3219OGUv+q1ygkXkwzGjED/NZUKUn92u
         +EOWpuWUIE2NKTYzrW9ImEFKKXZVBm8BYdQh+ZYmgO2L8xJG1Vx5OD1sjHhpKP9g/nsI
         NDCvi5ZCc/VgukCBv+56QgG5QO+Q6ywyvFVj5G7cEi9Zu2HOhLcoF/dF5jDCIgjCa/tC
         WI1SGKl372v585VPeHaqAeZ9fRGOXX0PyyB7QHLUQUejjkURg2rUA6xNO87lA/yjARgX
         DDCslHZJMVAJbF1hCZaOk77lwoBeNglCVwn4eDTpBI+4N0kiyBQAdt4pGSp+wjY3TDbE
         kaAg==
X-Gm-Message-State: AOAM532TDlH3LzxRHLd+o4OGFRCbTMKCORJhLmkAb4bGXXbiwVkofOuV
        hpShH9aEXFQkTs+DGVdOWyM=
X-Google-Smtp-Source: ABdhPJyiEXc2GsLpWLlrf3P0O3J1DElExeEgyGes7bnBbh+mGyn90FM9uwHKc2ap8tWXjbzgzjWMTw==
X-Received: by 2002:a63:cc0c:: with SMTP id x12mr32758737pgf.1.1625769280197;
        Thu, 08 Jul 2021 11:34:40 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:a726:7139:5a1a:7978])
        by smtp.gmail.com with ESMTPSA id w22sm3768302pfq.83.2021.07.08.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 11:34:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] fault-inject: Declare the second argument of setup_fault_attr() const
Date:   Thu,  8 Jul 2021 11:34:26 -0700
Message-Id: <20210708183427.22842-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to pass a const char * argument to
setup_fault_attr() without having to cast away constness.

Cc: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/fault-inject.h | 2 +-
 lib/fault-inject.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index e525f6957c49..afc649f0102b 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -42,7 +42,7 @@ struct fault_attr {
 	}
 
 #define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER
-int setup_fault_attr(struct fault_attr *attr, char *str);
+int setup_fault_attr(struct fault_attr *attr, const char *str);
 bool should_fail(struct fault_attr *attr, ssize_t size);
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index ce12621b4275..45520151b32d 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -15,7 +15,7 @@
  * setup_fault_attr() is a helper function for various __setup handlers, so it
  * returns 0 on error, because that is what __setup handlers do.
  */
-int setup_fault_attr(struct fault_attr *attr, char *str)
+int setup_fault_attr(struct fault_attr *attr, const char *str)
 {
 	unsigned long probability;
 	unsigned long interval;
