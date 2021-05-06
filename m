Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B78F3752CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhEFLMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbhEFLMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:12:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4FDC06138A
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 04:11:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so2660998pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7c2DJQP03s9fn0WIBfki1JSJeIAo3NbsgjxoPOnEhNQ=;
        b=u+MXHhEKE+uMYSdZfMqMccYSnR19aLT8Br+9FCmmvf3B6tNa/560v3wsbL9mGs+5GB
         DP+VxKM6iWnobwWTklsJ9SmvS9m3sS3Oq6bVRWC3HkkyuNjOwRlhzms0STj/xPnTg+Yo
         oYMkwdb5Sse2yh6WA/abCWd3V7GCacPH+lNY7GWmkz45gWYj+3CUEvLo0MJl9viD+h4Q
         3FedG3aIPypZvwYq/mQfitmGUWeQhjOStbKx4asMV1ld0ZVoJ4vBEcRxurBqQnpxSYwk
         3Hxf6VfuzhhRAd5f087PRE5nVmioLyOMlLqFnWeH9faJvTzG4tXvqaDWF0s2rtXjWMYP
         Wm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7c2DJQP03s9fn0WIBfki1JSJeIAo3NbsgjxoPOnEhNQ=;
        b=Aluhm6tuo60x1K60yaf5aHAUCMdn3C3r1XnwYOFidItDS0jeYzlOmRYPVd089YxJ3N
         Q3OfzerPz6NjxlrgNS7gghuB+/KGAORzSkPFSp1wLvJuNs2NIiw/WL9XgfcT5Gxtgi/2
         vxvEYRgJfDQN1PI0DqIdZU90raiDvI5o65SuZzycW82P6itL1/AdZReYmr6XCpe0zJeJ
         uXIk05FBeueWIJHDvFIZkQCRR/vphvW8v/SZrTFSRRXmYP/41Ceru5SUGiPXJFA9mt0z
         tTVZBd9dIoUT7t4aczkY1otJhGqXRVdOuzO3NVPS5nkSkaa0YshmPzzoiBhkALCnWtyV
         JKeg==
X-Gm-Message-State: AOAM532vOPHPhRMvt8Ilhuv6R0K8qSY501wBWNZoNAXPGr6+eGAgdN18
        YV+Nh+gC5Wg7lUb8ACF9HBU=
X-Google-Smtp-Source: ABdhPJy4SIF6gbIHHLZrknXSByDC7Hut1//xEsS9O4P+5pcu1OuOsgs7x8Uert6giPhrACF50ldN3Q==
X-Received: by 2002:a17:90b:1bcd:: with SMTP id oa13mr17138090pjb.22.1620299484122;
        Thu, 06 May 2021 04:11:24 -0700 (PDT)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id dw18sm9594709pjb.36.2021.05.06.04.11.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 04:11:23 -0700 (PDT)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     vincent.donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, xuewyan@foxmail.com
Subject: [PATCH] sched/pelt: Add UTIL_AVG_UNCHANGED flag for last_enqueued_diff
Date:   Thu,  6 May 2021 19:09:36 +0800
Message-Id: <20210506110936.8797-1-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

The UTIL_AVG_UNCHANGED flag had been cleared when the task util changed.
And the enqueued is equal to task_util with the flag, so it is better
to add the UTIL_AVG_UNCHANGED flag for last_enqueued_diff.

Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5e457fa9dc8..94d77b4fa601 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3996,7 +3996,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (ue.enqueued & UTIL_AVG_UNCHANGED)
 		return;
 
-	last_enqueued_diff = ue.enqueued;
+	last_enqueued_diff = (ue.enqueued | UTIL_AVG_UNCHANGED);
 
 	/*
 	 * Reset EWMA on utilization increases, the moving average is used only
-- 
2.29.0

