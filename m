Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C36444CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhKDBTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhKDBTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:19:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A89C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 18:16:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t11so4484376plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 18:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gEXRn75gpgYJoi++XkClMRFUw+9gSiCE8ywmr+MiRc=;
        b=TousO7TSdDVpLwphsP56oLnGu+5u+ODCk8N+foVRVRLHpX4v+AwBJU3owGnQ+1+o6M
         /EUPyLw2i2iurNHdaco2v5CO1oCEVrjDjtCeEWWBlWTioVTQItX57zKgBucIz4DEAUWa
         VPGD+bWnsMcNER3M4rqFdvUy3ahVldjKm875bOrbJ2YFnURFozBw1Ypx5FkHOd8ndFxB
         nNavnHwNbuCo4MI+vg9L5FKIGwMoz6SXOXhFRe2KB8vSZPwhrUQ8WR7161xxb8HrhkOw
         JJcx4OIAPqsE/9bX06hP3XGMLBiAGF3AKOSmCTo4WQdirXAHu87UY0AxSid9VEx8NCbM
         2KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gEXRn75gpgYJoi++XkClMRFUw+9gSiCE8ywmr+MiRc=;
        b=a7EOo8+Kal+G5yx5ul1fpZGZksXc4Io6xwYSBkoD1q8XX0x7zbHi0a0/hTUFvhVf8P
         EWa6m7GpKzztW5UM6mIylxhtnk9m/Nyc6oVI8LVAtHNKHj4HbPbO1NCWQ7Y3lHSDRsVL
         NCZKTbyHWGked+JonOFyKUQq7Pe2KgemZ1Dr1kwqi4McAWSg5/qJgPD1BpfkGNd1rGTc
         71SuAnmQ/DNjv0Ffv8CXYqgIfQEsq4jDeKqyi+9t64g9RrpBYlR9FQXTGiId8dmpYTKn
         Da5y/9A1H6VwpxJ3cDaiKO4lQz3txEJYzrM4qj3PjXZUSnKl5mt4BZYPUHWkPZIEywLE
         OqjA==
X-Gm-Message-State: AOAM530xAf4xyA8E5m12pTB64nMjFeJu4EBmpyXcaKTNit/5NCzPDtAv
        boTHuUPh4nJ9mFZxhPFvO/c=
X-Google-Smtp-Source: ABdhPJyaYgT9xLc4VNUXbiy9LWj4P8ZGgaUdUy7KgqxycRdR7M7kBUOxp9Jw9RXDr5OG8XMglzfpwg==
X-Received: by 2002:a17:90b:4b4e:: with SMTP id mi14mr18693062pjb.6.1635988586842;
        Wed, 03 Nov 2021 18:16:26 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id s2sm6700777pjs.56.2021.11.03.18.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 18:16:26 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     urezki@gmail.com
Cc:     davidcomponentone@gmail.com, akpm@linux-foundation.org,
        yang.guang5@zte.com.cn, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] lib/test_vmalloc.c: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 09:16:16 +0800
Message-Id: <20211104011616.1028001-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 lib/test_vmalloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index e14993bc84d2..cf41fd6df42a 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -393,7 +393,7 @@ static struct test_driver {
 static void shuffle_array(int *arr, int n)
 {
 	unsigned int rnd;
-	int i, j, x;
+	int i, j;
 
 	for (i = n - 1; i > 0; i--)  {
 		get_random_bytes(&rnd, sizeof(rnd));
@@ -402,9 +402,7 @@ static void shuffle_array(int *arr, int n)
 		j = rnd % i;
 
 		/* Swap indexes. */
-		x = arr[i];
-		arr[i] = arr[j];
-		arr[j] = x;
+		swap(arr[i], arr[j]);
 	}
 }
 
-- 
2.30.2

