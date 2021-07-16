Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC453CB8CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhGPOlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhGPOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:41:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E765C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:38:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id go30so15477809ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=S0B53JupZUVPWGl7zblvxhsUkB9aj6fgTRefNriF+/4=;
        b=SxMqSoRKZ8gc05sAqETI4IBGEZOBRWQoITWwRZF0U21M7uk3+Dh1Y2ji1S61lNcx4Y
         ko4jWUdnJMs6HBfNu+qFtEdX7Kk45VGH2HmRSrc2jmdozsfIRZ5WzYN1hQeIhRpEc0E+
         krJAO0f5CFjk5ZpGEruR5tIVprDTfQSpWRQAOnLDztBhKWc/ldaio6g5p8Euwmoezb+W
         6Z5zUkOHK+6i4pgP5rHW6D8WePnPESckZb1OzWU5PZVfT6Ne2fWh4QBZXWfkHc8l6qxY
         kxfyl9k2AzcWr2KgVXV9zSr+BPs/UDGT80ZzwMM5Nf0r9EYYHq32ZWWw2Pmoyyk0OKSo
         MZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=S0B53JupZUVPWGl7zblvxhsUkB9aj6fgTRefNriF+/4=;
        b=nqEo3L9jRagQzi0Ev38DvoIUSTq4AkoD197wAOiI3/mE1ISM0ZUIVwpGu60U0APdtg
         QmXFrOvPRsloBLVPMrjfP8i7Rjv2tyx8x/0qj7LnVReGx4PN8B9uWNsSQJV2Nw5E+/Hg
         2yrnA5DSyRX7svxOE0xEuL00TLoqr+L1k1GLf3EWm3K+bntKDztMGVxZy11dcFSPc7LM
         SQ3e1l6Y5ixCGFgnpLXqgwKiQo+vUbzT+PR5n8NLof8zpPa2qh4qAB3mboygTgk+ZHa/
         x3GFuqDqxPeA+0E7617JNRUNGNnoWcW+cpMM3FieXX4WHVEpQEweTxd9105of1Gb4HO4
         XzfA==
X-Gm-Message-State: AOAM531yEPNgc9qubrn/V7XyFKZO80UrE2JxwGxcJsvamQiCgXEDYX4c
        y+I7RL/QRiovs8zcznLcT50=
X-Google-Smtp-Source: ABdhPJzHWhk4OGAY9VB5XvEayJo7+xnGatII5PblBHVM5Ct5Boa4X0sDWJBp1ho0yzAf4FgKeKqn1w==
X-Received: by 2002:a17:906:9b8d:: with SMTP id dd13mr12205091ejc.480.1626446304224;
        Fri, 16 Jul 2021 07:38:24 -0700 (PDT)
Received: from localhost.localdomain ([5.176.51.215])
        by smtp.gmail.com with ESMTPSA id kf3sm1745600ejc.118.2021.07.16.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:38:23 -0700 (PDT)
Date:   Fri, 16 Jul 2021 17:38:19 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in profile_init
Message-ID: <20210716173819.07aa5afd@gmail.com>
In-Reply-To: <000000000000610af005c714c1d1@google.com>
References: <000000000000610af005c714c1d1@google.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/g74i.zzQeycjOyjMhJiMNv1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/g74i.zzQeycjOyjMhJiMNv1
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

With clamp() call suggested by Tetsuo

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master



With regards,
Pavel Skripkin

--MP_/g74i.zzQeycjOyjMhJiMNv1
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-profiling-fix-shift-out-of-bounds.patch

From 6dadb86239173d28b1d36e974e000d39b088177e Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Fri, 16 Jul 2021 17:27:44 +0300
Subject: [PATCH] profiling: fix shift-out-of-bounds

/* ... */

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 kernel/profile.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index c2ebddb5e974..c905931e3c3b 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -42,6 +42,7 @@ struct profile_hit {
 
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
+#define MAX_PROF_SHIFT		(sizeof(prof_shift) * 8)
 
 int prof_on __read_mostly;
 EXPORT_SYMBOL_GPL(prof_on);
@@ -67,7 +68,7 @@ int profile_setup(char *str)
 		if (str[strlen(sleepstr)] == ',')
 			str += strlen(sleepstr) + 1;
 		if (get_option(&str, &par))
-			prof_shift = par;
+			prof_shift = clamp(par, 0, (int) MAX_PROF_SHIFT - 1);
 		pr_info("kernel sleep profiling enabled (shift: %ld)\n",
 			prof_shift);
 #else
@@ -78,7 +79,7 @@ int profile_setup(char *str)
 		if (str[strlen(schedstr)] == ',')
 			str += strlen(schedstr) + 1;
 		if (get_option(&str, &par))
-			prof_shift = par;
+			prof_shift = clamp(par, 0, (int) MAX_PROF_SHIFT - 1);
 		pr_info("kernel schedule profiling enabled (shift: %ld)\n",
 			prof_shift);
 	} else if (!strncmp(str, kvmstr, strlen(kvmstr))) {
@@ -86,11 +87,11 @@ int profile_setup(char *str)
 		if (str[strlen(kvmstr)] == ',')
 			str += strlen(kvmstr) + 1;
 		if (get_option(&str, &par))
-			prof_shift = par;
+			prof_shift = clamp(par, 0, (int) MAX_PROF_SHIFT - 1);
 		pr_info("kernel KVM profiling enabled (shift: %ld)\n",
 			prof_shift);
 	} else if (get_option(&str, &par)) {
-		prof_shift = par;
+		prof_shift = clamp(par, 0, (int) MAX_PROF_SHIFT - 1);
 		prof_on = CPU_PROFILING;
 		pr_info("kernel profiling enabled (shift: %ld)\n",
 			prof_shift);
-- 
2.32.0


--MP_/g74i.zzQeycjOyjMhJiMNv1--
