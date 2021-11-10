Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125F444BB81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 06:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhKJGA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhKJGAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:00:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCAFC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 21:58:08 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x131so1641960pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 21:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtXmmg9dGHPppNGKAh1ky0T/obgVNR9+9tzTJDolRaM=;
        b=O7JXWtCHStYsIDNyN8IfeOw78miiMRglRhIIw+7mfxQeiiRaPTB8H+voMZt0FFZdIC
         /HOFYhXfz34NW62w7OnF1gLILSP2OaNIbQ8NaBeFf6/LXXSdy9aFpdfsmtrnAeLe8KDY
         LAIHUCWSnTR5yly92S2hIdVYwkMEdszWvPV0B5Yb02ZS/2C8SYyuVCjP0BGBGTJ4vsYb
         5oogHmgHEGpf3kfBvpAM60sB58xFWzOlfJ1eUA9uve2CLVTGrEU2eLbXj4H6n9Fa/p/W
         3Ss6oP1pQxI4aZpI1WtUW1+0K9iQS31QR3nLGIi8SQuSJYA34SOt3muWQA1m8FsvVEQO
         PZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtXmmg9dGHPppNGKAh1ky0T/obgVNR9+9tzTJDolRaM=;
        b=6+qheFyyUijy+eohfFtrYTCPdDYFU1dea03BOSND/5pMCN0OKNadQqZtYHYIDH8N5t
         ac/3tTa81Gyiw7qvrQ8U4lQOm4S9D2eB5FO6WCqFFC2AcyYVJ0A9Sjiq/uHDUEkE36pM
         IwICKSrqekT4tjQVvZmKTW++yc0amdy4DYKEFlUbE7u54O83KwDOq9DbzQG+qRFSgXiW
         IPp/juPeCAKgHEbqy3nugcr1HV04aNb1IOMM8kwiwHJtSa2reGSka0NZt67Wqyzmdm5N
         4E4BkCSc2/ILkHUBgbZKa3L2g4kwbjV7Lhd3z9HGtkSSXtL6rJVwt4XyJgPeuCg1EQTU
         PMSA==
X-Gm-Message-State: AOAM530Vhb8AVOPxfGzTqFhAXjmOxO6vtLG3sTslhu17xOaFTef+OGn1
        Pb81MJZXEj2i0CeWtIH1Xere7DgC3kM=
X-Google-Smtp-Source: ABdhPJzNhN/SZQH3d03YCf7Zz+NEKx/3ZHoSmQzKkUPoNmulDpXalt94t3g4E6rw6FuNw8KXPw4njw==
X-Received: by 2002:a62:5215:0:b0:49f:a996:b724 with SMTP id g21-20020a625215000000b0049fa996b724mr13848683pfb.3.1636523888253;
        Tue, 09 Nov 2021 21:58:08 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mr2sm4356749pjb.25.2021.11.09.21.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 21:58:08 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] kernel:sched: Remove Unneeded semicolon
Date:   Wed, 10 Nov 2021 05:58:04 +0000
Message-Id: <20211110055804.137012-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

Fix following coccicheck warning:
./kernel/sched/core_sched.c:206:2-3: Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
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

