Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3109A4427A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhKBHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhKBHJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:09:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B0C0613F5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:07:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t21so14561274plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 00:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMI7pynxheqFYbCOJ1SIixE40Oy4tlFktPtjKi1YeQo=;
        b=I9OERzFOQlQ6Pl0219Y6IzuOO+9HDdIjniEtzNg+Yo5myWsaV6AiptI8r6riJo4Cyt
         WMo4/aDXbl+25fpUeco+loa4RR7L9SpHIzD7dKpwYOD1uMh/fvyOQjr9MZZv5BQTA7ci
         U9zsBnP5KOKxR8qKA2Xl0YhFZDOF7/K//IDwOKXqeaU2s29OXNb2FrLmqU8qCPF1w6g+
         wM9VeVHWSy+tNQ97qLUAc5kN9eep6b+wnGgb48dQPHlkQhd43P99eeRqnEOF6jgBxaof
         Knvh4Ykrhsv1tpzNBhRtVLVRC/mDmRIk0HI5ZWcLqy3e7mOr+3sF+uK36HVIJRsgrru2
         oVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMI7pynxheqFYbCOJ1SIixE40Oy4tlFktPtjKi1YeQo=;
        b=w5ugfaHoZC4UyhffNr1aMaQ4An0sLmzg3r5rPZPzyDuJYhKTvTgXgd0tkxs5AL121x
         Np5f4a0maQF1CwVpPiPZAhAvz3/IBHbq4bSpfRpvsHkNBqXvg7AO+e7tcpsyWUrtvYHi
         kp54fgBlpWsGGeN3oWE9ZOoPTqcVe+LFaIUuhaJvDlZNRAZqzvcHU0I74kfpZ9vHpS93
         IyXxr0rU9Idgwf2EAMFrqPWovcv4813hf83pogmanvsHIMW/9mr1c/ASQEbKjENDFwy+
         nvbf4zXJRwjd5mflRF+Oe+6NiBqBVY0gnYjMeEp5Hxa60+KcQubD4zgGWFzFCIkPCnX/
         81fQ==
X-Gm-Message-State: AOAM532//wWhJm3Y4S7Dd9Lyf728VtkHKDj96799L+kpe5D6Pbt+h9H9
        UDtkbvCHApCBXgTkMEfLt1U=
X-Google-Smtp-Source: ABdhPJyFCOhJMnrYRLgRdSHWpRfBrQSmh4Njh3Ah4iTPbeeV8J2V9espi9GPqwixGzI3wFGukIaz7w==
X-Received: by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP id c8-20020a170903234800b00141d60bee90mr14786352plh.15.1635836830222;
        Tue, 02 Nov 2021 00:07:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g7sm14417934pgp.17.2021.11.02.00.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 00:07:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sched:Remove unneeded semicolon
Date:   Tue,  2 Nov 2021 07:07:04 +0000
Message-Id: <20211102070704.5206-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Eliminate the following coccinelle check warning:
kernel/sched/core_sched.c:206:2-3

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 kernel/sched/core_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 517f72b008f5..f945b0c373db 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -203,7 +203,7 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	default:
 		err = -EINVAL;
 		goto out;
-	};
+	}
 
 	if (type == PIDTYPE_PID) {
 		__sched_core_set(task, cookie);
-- 
2.25.1

