Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C770E3CB82E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbhGPN6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbhGPN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:58:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F659C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:55:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hc15so15294110ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=5Z2GBjvLCUhCncAuWbr0fkZ4jBcjKvlBje88iTLBcf8=;
        b=ioUGpGRu2eQ/VmD6q2Eo1nHNP7SRyyWcoTaHEiy9ectlJv+jBDJsa6fM0J9YAo022w
         uaqVC6x5S2bApwAIxilM4Sww4JGksqV0zZxbe+Kn0RCIbvkOB5VTiKwHtnuAxXe2Vp9g
         ZEwY4XY8qcxPemm9XX5MNxHZ+UFeNJcoTh499K6pD3uVgDAOuEqAH632PmR2lN8LqJNm
         jZaHhCa6xk5dDXaD+oy8ER2k2Zld1fM1f33hDYQ4aDKjLTYxVDqCziB1G0gHTP4CdKri
         QGHf6yIvZ8yKHHy4jcqYZPXLZTxy6KgVc1FwCKUiI5nCGNB3TfT73KDip3mOyLqM2juX
         BQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=5Z2GBjvLCUhCncAuWbr0fkZ4jBcjKvlBje88iTLBcf8=;
        b=XOt+6syQ5/zDuGJSuxnUj1rOg5JjnIPRRKusKBlIJU6QUAIHvgW1w7q9PgrVxvUnA2
         6q1gufZo8l9p+Fopl5InSpsoc51wHV0gIphE8h0YQqNeNQ0AXDfP9EOZ/JqvphXhbd/q
         dp7L2pNnxW0gNYU4Coj5UAQntobK7oaziHgTDkr/qQmPFBxP8Y3+RMlSLMJ7kydpoCAu
         EtFlgEx5+D8EgUWv8LNWedDTv1/8RbIfENObyI14lVIvHKitBk/ryASjnFYhZyofkSNn
         7FDFD+wVNY2CHkHXyrTadTf/izCnpzvjRNJSXSfrWTVjt66d+JHwBIJkOdRfKhWBX/IK
         V01Q==
X-Gm-Message-State: AOAM532dhRKlpTgqmMBKjuqXhBJ5a5IJRHRbcrItBBFTkC7tBY4AwZAV
        3lK67cw6yI3ANV/On3dv0oI=
X-Google-Smtp-Source: ABdhPJzo5SUJCjwibclPKhPjPoBhfRjlYTj+l7b4epDhGga6X6DRNYDcnASUeDZyo+qtLmapEUGFIg==
X-Received: by 2002:a17:907:2151:: with SMTP id rk17mr11924766ejb.3.1626443731673;
        Fri, 16 Jul 2021 06:55:31 -0700 (PDT)
Received: from localhost.localdomain ([5.176.51.215])
        by smtp.gmail.com with ESMTPSA id n14sm3791103edo.23.2021.07.16.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:55:31 -0700 (PDT)
Date:   Fri, 16 Jul 2021 16:55:26 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in profile_init
Message-ID: <20210716165526.20e3c1a9@gmail.com>
In-Reply-To: <000000000000610af005c714c1d1@google.com>
References: <000000000000610af005c714c1d1@google.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/FtqA8ZNL/PoFAHornl+9Aju"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/FtqA8ZNL/PoFAHornl+9Aju
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 14 Jul 2021 05:47:21 -0700
syzbot <syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3dbdb38e Merge branch 'for-5.14' of
> git://git.kernel.org/p.. git tree:       upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=11342328300000 kernel
> config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=e68c89a9510c159d9684 syz
> repro:
> https://syzkaller.appspot.com/x/repro.syz?x=149a96d2300000 C
> reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114e5bc4300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit: Reported-by:
> syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com
> 


#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master



With regards,
Pavel Skripkin

--MP_/FtqA8ZNL/PoFAHornl+9Aju
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-profiling-fix-shift-out-of-bounds.patch

From 52652f42abee7eadcdf52fd38ee6cfb0b025448d Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Fri, 16 Jul 2021 16:47:17 +0300
Subject: [PATCH] profiling: fix shift-out-of bounds

/** ... **/

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 kernel/ksysfs.c  |  4 +++-
 kernel/profile.c | 18 +++++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 35859da8bd4f..ca075d9f671a 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -76,7 +76,9 @@ static ssize_t profiling_store(struct kobject *kobj,
 	 * has a ton of callers and is not const.  It is
 	 * easiest to cast it away here.
 	 */
-	profile_setup((char *)buf);
+	ret = profile_setup((char *)buf);
+	if (!ret)
+		return -EINVAL;
 	ret = profile_init();
 	if (ret)
 		return ret;
diff --git a/kernel/profile.c b/kernel/profile.c
index c2ebddb5e974..5c61677030f4 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -42,6 +42,7 @@ struct profile_hit {
 
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
+#define MAX_PROF_SHIFT			sizeof(prof_shift) * 8
 
 int prof_on __read_mostly;
 EXPORT_SYMBOL_GPL(prof_on);
@@ -66,8 +67,11 @@ int profile_setup(char *str)
 		prof_on = SLEEP_PROFILING;
 		if (str[strlen(sleepstr)] == ',')
 			str += strlen(sleepstr) + 1;
-		if (get_option(&str, &par))
+		if (get_option(&str, &par)) {
+			if (par >= MAX_PROF_SHIFT)
+				return 0;
 			prof_shift = par;
+		}
 		pr_info("kernel sleep profiling enabled (shift: %ld)\n",
 			prof_shift);
 #else
@@ -77,19 +81,27 @@ int profile_setup(char *str)
 		prof_on = SCHED_PROFILING;
 		if (str[strlen(schedstr)] == ',')
 			str += strlen(schedstr) + 1;
-		if (get_option(&str, &par))
+		if (get_option(&str, &par)) {
+			if (par >= MAX_PROF_SHIFT)
+				return 0;
 			prof_shift = par;
+		}
 		pr_info("kernel schedule profiling enabled (shift: %ld)\n",
 			prof_shift);
 	} else if (!strncmp(str, kvmstr, strlen(kvmstr))) {
 		prof_on = KVM_PROFILING;
 		if (str[strlen(kvmstr)] == ',')
 			str += strlen(kvmstr) + 1;
-		if (get_option(&str, &par))
+		if (get_option(&str, &par)) {
+			if (par >= MAX_PROF_SHIFT)
+				return 0;
 			prof_shift = par;
+		}
 		pr_info("kernel KVM profiling enabled (shift: %ld)\n",
 			prof_shift);
 	} else if (get_option(&str, &par)) {
+		if (par >= MAX_PROF_SHIFT)
+			return 0;
 		prof_shift = par;
 		prof_on = CPU_PROFILING;
 		pr_info("kernel profiling enabled (shift: %ld)\n",
-- 
2.32.0


--MP_/FtqA8ZNL/PoFAHornl+9Aju--
