Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535AC43077F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbhJQJcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 05:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhJQJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 05:32:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6FFC061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 02:29:54 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s136so9751292pgs.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAZwpsvpNd8mq9nsqgEh8qKdU0GjNG67jmNpaREej14=;
        b=OwJUXdJuxPyFxact+I7KRrvsh/grOzI6pnzmnzmE7s4eHCVFtty5Yye66fPHObgSF2
         OVxindJ4JDioKriRZA/oXot57wIoXjqs5pPRuM6vrudUUwfjdI46z9m/ymK/Oor4nmJw
         wWVSt2WgVzyc0DnDX6enAFsrM2SYnoZJRqqSOCa2sfRWMCA81Ne1kDorZOlzKXgHm7jy
         RV9psQgZuUMsOapgGOkzUGJl+Zi/oBViEKw4zh3kbPSqBUmqustqZKe7wejlbjB0FP3R
         Jv9kcsCxga5LXyH52qn0a5Vzs8iJYspD/p5YFjKZIN8z73coj3r9lWDyHW6xt5MPcM9A
         REiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAZwpsvpNd8mq9nsqgEh8qKdU0GjNG67jmNpaREej14=;
        b=UVHnXmKEoSLSoA3f27NJRUtZbYCbCjinmaIUgH2Fdh7btGwil6RshKR5IAsAn0RMmX
         6uNlPXDkgjBdFExnuyJyzg8jun3L5akz6uNUeJYnA6KnRzsLm6g4CGRUhE0TgSl4EtPz
         pklGUk2KizkmxQA7mIfzShcBVAxu511PV8ljg0ktK7znism9JOXXwAbCTeL3408HEf0x
         3Z6Vk5hkVRreYTa/lTeddjkTxayv/5ycZxolAmjMVskUjoZonmwtP5VY9NsjYG3I/3NY
         tUkhV5z9i+DnzYjPXg/sU5Ep1uV3oavGS3WVGEr/vwkBpiTgsAxukQdfK/bNhEZSoYy0
         gBuw==
X-Gm-Message-State: AOAM5336t4HEg8AEH5JBr3olbbu9+K+XHKc4qWo/HQgknDGgx6HLbf1t
        KAfMB+eseISWJbTEuLZpEs4=
X-Google-Smtp-Source: ABdhPJy4FkbbnlD6pGL3V3lXGcE+XLHf/lv52VjjdMRwg8gXjtFldVfZsJbxijCll16KOtnjmAhOEA==
X-Received: by 2002:a05:6a00:8d0:b0:44c:26e6:1c13 with SMTP id s16-20020a056a0008d000b0044c26e61c13mr22359382pfu.28.1634462994046;
        Sun, 17 Oct 2021 02:29:54 -0700 (PDT)
Received: from localhost.localdomain ([115.96.219.100])
        by smtp.googlemail.com with ESMTPSA id gf23sm10198222pjb.26.2021.10.17.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 02:29:53 -0700 (PDT)
From:   Kushal-kothari <kushalkothari285@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com, kushalkothari285@gmail.com,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2] staging: vc04_services: replace msleep() by usleep_range()
Date:   Sun, 17 Oct 2021 14:59:00 +0530
Message-Id: <20211017092900.134752-1-kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the warning:-msleep < 20ms can sleep for up to 20ms by replacing
msleep(unsigned long msecs) by usleep_range(unsigned long min, unsigned long max)
in usecs as msleep(1ms~20ms) can sleep for upto 20 ms.

Signed-off-by: Kushal-kothari <kushalkothari285@gmail.com>
---

Changes from v1: Reword both the subject and the log message.

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6fbafdfe340f..80a7898c5331 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -857,7 +857,7 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
 		if (status != VCHIQ_RETRY)
 			break;
 
-		msleep(1);
+		usleep_range(1000, 2000);
 	}
 
 	return status;
@@ -894,7 +894,7 @@ enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
 		if (status != VCHIQ_RETRY)
 			break;
 
-		msleep(1);
+		usleep_range(1000, 2000);
 	}
 
 	return status;
-- 
2.25.1

