Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B953432D2A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbhCDMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhCDMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:10:20 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 04:09:40 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id x29so10538532pgk.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 04:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzYVAISPt3TaegXMOLGB4Oy5qytGjaveA71U3tYl9D0=;
        b=jfNMQoYmSq9X9SAJRJf1iX3rQhdNUd7OPwoyeHFAyjdL46A8w/fprBmT4mZ3z38fTD
         BVuUf8wDS1+9isu2Ak+ifQdwmRw4h4MH3z1fFU8iJM1mTkGh91OVLhy/SYwnLNUIJol4
         MYopPWIVjvkzRVzJLxufxhQ704D2Oraz2DkSXPvUSz7LrDtwaBBswrHdqj7qEC+u03wl
         nQJE39O7hg04UalNLh1bPs00pzfvvDeV2d4TSB25JW5FpOJ8H5iX9JnpetYgUgE7HEXH
         PSKLJyHabMNuwy7IwAl5RAhQw0lp8u5DAPAPRt/IXY2XxWDgpxTvw7spcNcj1KWs7Arc
         fKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzYVAISPt3TaegXMOLGB4Oy5qytGjaveA71U3tYl9D0=;
        b=uhrGogfPNubGj7fH+c8rEeVio8utUUwBq0gpnPNKe2tCnvxhZPZLoqk9i6DmwVqBuH
         bcWBDuBQu2pwdawQu3pIqOc55WbZZnvL0lXLNgcD1EvZGYWrm693fIEZx2jeAjdTDITL
         gG9B6r4Ed4kiN2ypq+8u7WEga6SgTFvtvRDdotObScUrg2+8yD5U618BcNyhmcX6Sy7q
         DJimnT27E9e8VKSgGLKDB1EsG864iZNjM3q5ocYTGQ34ad8MU/C6Wpgxaq6Ph+/4JRhd
         HnWqL6XmIeVhZRXhkQMHPBmvu3+0Wclu8N0aVfzzmZRitgg8WFYq4eF7k+sajgXBAap7
         oiBA==
X-Gm-Message-State: AOAM531atbyqxEDeRWe28D9Y2k6yKdVQ4l2BoSSxRVTomJJnSrDlV1gB
        EpteHSqKAed1jTZo1NnaYB4=
X-Google-Smtp-Source: ABdhPJzffNbaWyhrkcXHV+sm1ONUhH4PX6a01Zaw5XD+WzvzvTOTjyw4w1AS+dJrzAAKe82K/iQn7Q==
X-Received: by 2002:a63:f913:: with SMTP id h19mr3416276pgi.413.1614859779830;
        Thu, 04 Mar 2021 04:09:39 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id mp1sm9924281pjb.48.2021.03.04.04.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 04:09:39 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: xiong.zhenwu@zte.com.cn
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
Subject: [PATCH] kernel/sched: remove duplicate include in sched.h sched.h
Date:   Thu,  4 Mar 2021 04:09:26 -0800
Message-Id: <20210304120926.194628-1-xiong.zhenwu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>

'linux/psi.h' included in 'kernel/sched/sched.h' is duplicated. it also
include in 59th line.

Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
---
 kernel/sched/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..235d8381f142 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -344,7 +344,6 @@ extern bool dl_cpu_busy(unsigned int cpu);
 #ifdef CONFIG_CGROUP_SCHED
 
 #include <linux/cgroup.h>
-#include <linux/psi.h>
 
 struct cfs_rq;
 struct rt_rq;
-- 
2.25.1

