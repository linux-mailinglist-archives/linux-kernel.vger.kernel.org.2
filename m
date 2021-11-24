Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D46645C907
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbhKXPqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241554AbhKXPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637768571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jgOTjRwb6ni7IM1JcHLBoeJmR0JqL9+uUHgS3quel1M=;
        b=WMs78sQ75U22UV6CeqArCcpiQfCfjPbQsDA/iSoYfOLBWavdKSrLbSVJjDleBst7wxb9o0
        7k9tv0yFDoqgZemtWXm+K2ls2KcQBrhh7K5ANHgYRz13EqTlGjM0KC4UjdXIH6xPmpl1py
        rGQDIt+6BjHF19S7Ac+j/DQ89BVm+dY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-zovgTKY7MTqzE-VxJ02ZMA-1; Wed, 24 Nov 2021 10:42:50 -0500
X-MC-Unique: zovgTKY7MTqzE-VxJ02ZMA-1
Received: by mail-wm1-f70.google.com with SMTP id c8-20020a7bc848000000b0033bf856f0easo3218805wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgOTjRwb6ni7IM1JcHLBoeJmR0JqL9+uUHgS3quel1M=;
        b=h9+jdrqG1iZREp+7P/BjfbSdWOtdpIR+fIgm/tSmkuQ06BLPpEt/0sswTMBkC6/tf4
         udYPOksob5AYj9ypF5dNlK0HBJmPbrJOjF1Y0IhOai1bjezHFOBEz4U7gWkhVQelHBf0
         94PntlxE5T4e3TY68wa8Q6mGartnAedOBqAJK+rATRbWAmztQEnHziu9dLOXPUGotSCE
         a+Eohf3ae9Zlh5XH5xPHmIFm4tvMo0pLUJacT6i1QCexbZQgaAZ3VI4kqmvbAusqGkQT
         T9t3Sld5vIJINSJmVlzmWE8lZW1Wo7LaHnI5UMT5M0waGD6J2NgeOXlIvlI9Giq+KR7P
         Hvrw==
X-Gm-Message-State: AOAM533C3Hl3idvhU9UCHw9GYRRCoHcXs40D6lkNW2B9SORVsf46/aPv
        GdRRudInIZQSkDHvlX7GtUlSeg+0kCAqdyWaNeOjnZbmmFtDqw7PJewq1MwqreelkpdJue3gRtz
        +ZHPcKWsAt/tYNAym+n6+1Dk7
X-Received: by 2002:a1c:90:: with SMTP id 138mr16412325wma.27.1637768569079;
        Wed, 24 Nov 2021 07:42:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaJsUMvB4tI7+Kx0faNllE9qaU5DSvohaRij86VVk3x4sNDrfRd0hrRE8a6KTBflY47mPM7w==
X-Received: by 2002:a1c:90:: with SMTP id 138mr16412273wma.27.1637768568827;
        Wed, 24 Nov 2021 07:42:48 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id w17sm150677wrp.79.2021.11.24.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:42:48 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com, mgorman@suse.de,
        bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        bristot@redhat.com, vincent.guittot@linaro.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] sched/core: Fix setup_preempt_mode() return values
Date:   Wed, 24 Nov 2021 16:42:46 +0100
Message-Id: <20211124154246.116178-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__setup() expects its setup_func() implementations to return 1 on
success and 0 otherwise. So let's honor that.

This gets rid of the following kernel log:
"Unknown kernel command line parameters "preempt=full", will be
passed to user space."

Fixes: 826bfeb37bb4 ("preempt/dynamic: Support dynamic preempt with preempt= boot option")
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

---
An alternative fix would be using early_param() instead of __setup(),
which actually takes 0 as success. But I figure __setup() was chosen for
a reason.

 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cd61e4109eecc..0d6eab5eeb4c9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6657,11 +6657,11 @@ static int __init setup_preempt_mode(char *str)
 	int mode = sched_dynamic_mode(str);
 	if (mode < 0) {
 		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
-		return 1;
+		return 0;
 	}
 
 	sched_dynamic_update(mode);
-	return 0;
+	return 1;
 }
 __setup("preempt=", setup_preempt_mode);
 
-- 
2.33.1

