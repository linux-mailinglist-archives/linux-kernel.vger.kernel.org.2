Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E049368795
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbhDVUD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbhDVUDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:03:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF242C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:02:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n2so70588388ejy.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y968Nj9WleLeQTLHRLot9K7vbTHywUm0eD5a13orsj0=;
        b=FrZzFesBWGW8fpO1qclSAZX0+PB1wPwA/C2iiLSM9Td4MP1rIB/3VYJ4SfJw82dQ6D
         VMwGBEg107oGJ7d0qDQ15Z93dLaFE2WmmdVgqD13Ucjf2z98IVLoFzI+rJrukrooR5SO
         vn4AEerNmi3vePhLPcPnG5WFkmvtUeyY6qzgLq8MhgKeF7h01jPKKRJRwSXhatX6B+f6
         eqKWNBkX3BR1TmvFsnaoaT3yPDqOmklne23g0z5GKTs1kmKw5OjOirCwQOICIOZ/LKuH
         nDFMbfydXD8UtgdsNO8xnoZHsXK+vZcBOnEzlABF08wZCqGRkMJ1x/3N/b/x7bC7+1cO
         bSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y968Nj9WleLeQTLHRLot9K7vbTHywUm0eD5a13orsj0=;
        b=iIDv6jsbdjsoym4VWkw1iFHGKDhTVoZhwcvfNnfnjVVR9yB/zcQfM+yDq7+gHuq9nl
         tAv8GMtIYE68V8ciNFTVKcSEF9wLPBTDEJNmdam4d5l4mUtjuYH1LyrAxqpncoVV9Bq9
         ngDngidaJNa83KxNWBIPuy/X6U9GePCc6OssPkX5P6BiDWSvAvP23x1UTs9TDCMFP5Iy
         js6kETQyOzoYMiaJpPfSwNPyuqveJenWTgfNPazoECTcpcn66TbxpnHh2C+foaAgdOX3
         oXEWJgVOQRDXEXZlKaWzY9txtfjjgwcrD8wWCjRZfYB4amy598AYCdOa3Pck9hAExkMz
         ZlOA==
X-Gm-Message-State: AOAM533QdxJo056B1zUTq2k3F5ucKstPIsT528KkFIiaJHpcFbMlocUj
        uPa8NUsxGafzO7C6d7X+zw==
X-Google-Smtp-Source: ABdhPJyZY7oiYiKfIZQlfp7SVHWYtF5cVoO1AhiQ4yIH3Wlz4IvqgWBsqQM1Sg2Ic44ILH5HyF6fQw==
X-Received: by 2002:a17:906:51d5:: with SMTP id v21mr418183ejk.252.1619121765722;
        Thu, 22 Apr 2021 13:02:45 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.145])
        by smtp.gmail.com with ESMTPSA id u15sm2936199edx.34.2021.04.22.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:02:45 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 2/4] sched: make nr_iowait() return 32-bit value
Date:   Thu, 22 Apr 2021 23:02:26 +0300
Message-Id: <20210422200228.1423391-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422200228.1423391-1-adobriyan@gmail.com>
References: <20210422200228.1423391-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating 2**32 tasks to wait in D-state is impossible and wasteful.

Return "unsigned int" and save on REX prefixes.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/stat.c             | 2 +-
 include/linux/sched/stat.h | 2 +-
 kernel/sched/core.c        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 941605de7f9a..6561a06ef905 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -201,7 +201,7 @@ static int show_stat(struct seq_file *p, void *v)
 		"btime %llu\n"
 		"processes %lu\n"
 		"procs_running %u\n"
-		"procs_blocked %lu\n",
+		"procs_blocked %u\n",
 		nr_context_switches(),
 		(unsigned long long)boottime.tv_sec,
 		total_forks,
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index f742229091ec..8a5b27ae7937 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -18,7 +18,7 @@ DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 extern unsigned int nr_running(void);
 extern bool single_task_running(void);
-extern unsigned long nr_iowait(void);
+extern unsigned int nr_iowait(void);
 extern unsigned long nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 713ea35cb995..2cc8d81cdc75 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4413,9 +4413,9 @@ unsigned long nr_iowait_cpu(int cpu)
  * Task CPU affinities can make all that even more 'interesting'.
  */
 
-unsigned long nr_iowait(void)
+unsigned int nr_iowait(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int i, sum = 0;
 
 	for_each_possible_cpu(i)
 		sum += nr_iowait_cpu(i);
-- 
2.30.2

