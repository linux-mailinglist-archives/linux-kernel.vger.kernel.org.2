Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E649D3EEB76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbhHQLTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbhHQLTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:19:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC0C061796
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so4615905pjz.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PJBGOPQVQSjxbyTJ11WnQjYnniE4DXQ6NEAF6qVTmmM=;
        b=avprjDds3pVrGSPoBQnlu4Lhx+NujqpW+AfOLIu5t1dGqnZEG2bTwQcP9ZiOrXDwCh
         14T2EskxNMUr7Cgc4yc2RCs6rhvOd603Ci83ckLPKX1UG1k1Th4sGSGfoBFVJAOBjVgP
         jh4ypHimoVke8Re/WgAOZcfizwr1XTQOdV/QjThTB83rnZruO55ZEbJR/vYAz0Z3SQPo
         /xsPoNk/y0FCOyq2uv6FthEfAeNLVYNqZIzdWzdU0McqRLA3JyVU/Vg357UJ6kQtRxBI
         6mRfz16JidxP5VO+Ayi7Ga00cHpi/BMzEaVy/7dKPWKLp7v9DcGVyA6mBtej8rHqRbwR
         KUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJBGOPQVQSjxbyTJ11WnQjYnniE4DXQ6NEAF6qVTmmM=;
        b=XlJQMHy/9lEJKyn0h5sG0s0zzK2I7RzVlZXOUigMA2Tl3Je38Hi9HEg+139BlHBYur
         Kc/l/n9cvH8s+c+scRgelfmemlz2qjXrMeREyvuF+T+MQwjLl5SWwCgfShojb4EBkDQV
         veMflOUWDsgKU3TM5xsIKCq3+djR/MxUPnQo3L2hljNqF4TDC0isviQvxi0OoUohLF7L
         uArs/C2Wl3vUOHEJBEHgv3S6Tya4wCITD3QtUUn+NUKKqHAfAeJKBOcFHCCz0cygJ8K7
         Fzt/t7H1IGUSRD9JNl972iLc2/NmllqzAVLPD4ohUdIDQOzpxBFbEbhv+zN9m/M2AehK
         rptg==
X-Gm-Message-State: AOAM531OCpWH/mXCoiko0hcsVhA22fpJK2ji5X+5HNe9eC+8LRXCNM3H
        /Z1pPN4zUynLJd0ldZyQNAzoZfRY2x8=
X-Google-Smtp-Source: ABdhPJx0oZSyIBbF0jkOGNRzy/ykfSdSsxw0R/1jfV4XwB8NN65I+KLsiHVYCzIEqadhQeG7v/P2ag==
X-Received: by 2002:a17:90a:ce0a:: with SMTP id f10mr3100131pju.71.1629199115193;
        Tue, 17 Aug 2021 04:18:35 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id 22sm2728594pgn.88.2021.08.17.04.18.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 04:18:34 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 6/6] workqueue: Remove unused WORK_NO_COLOR
Date:   Tue, 17 Aug 2021 09:32:39 +0800
Message-Id: <20210817013239.3921-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210817013239.3921-1-jiangshanlai@gmail.com>
References: <CAJhGHyBsn+rqVQzNqRw2RxtpHyrpQpa0kMtU1RcZP7TCbC6dqg@mail.gmail.com>
 <20210817013239.3921-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

WORK_NO_COLOR has no user now, just remove it.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/workqueue.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 38e479bcdbfe..ba914e67c5ab 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -51,19 +51,14 @@ enum {
 	WORK_STRUCT_STATIC	= 0,
 #endif
 
-	/*
-	 * The last color is no color used for works which don't
-	 * participate in workqueue flushing.
-	 */
-	WORK_NR_COLORS		= (1 << WORK_STRUCT_COLOR_BITS) - 1,
-	WORK_NO_COLOR		= WORK_NR_COLORS,
+	WORK_NR_COLORS		= (1 << WORK_STRUCT_COLOR_BITS),
 
 	/* not bound to any CPU, prefer the local CPU */
 	WORK_CPU_UNBOUND	= NR_CPUS,
 
 	/*
 	 * Reserve 8 bits off of pwq pointer w/ debugobjects turned off.
-	 * This makes pwqs aligned to 256 bytes and allows 15 workqueue
+	 * This makes pwqs aligned to 256 bytes and allows 16 workqueue
 	 * flush colors.
 	 */
 	WORK_STRUCT_FLAG_BITS	= WORK_STRUCT_COLOR_SHIFT +
-- 
2.19.1.6.gb485710b

