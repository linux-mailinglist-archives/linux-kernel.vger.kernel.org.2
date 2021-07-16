Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50373CB757
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhGPM1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGPM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:27:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B176C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 05:24:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w14so12710542edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BMKCPL2w13f5WuMU0JgMEQHWXhkHxmWwCk8sPwLJLo=;
        b=f+z0EStJ61uRmypKqDpI4LQoNgp/1jmED87SY+jDnoYajHg6vvm0mXoNK+peeSwtmT
         gObMT4v4+c+v+XSiWb0v7Fvi5Hz5RwhKEBniq8P63z1vZSX4Y0u75RGO7If+ViOJDXao
         4byGu49ixAoixeTWl/pP3L+EgytCHYhSBBerGyQ0V2t78hiEQisTlCBGnwwImLfLlVLJ
         viHspfUd5o8v46N0pXQuvwEv4gFRgWZsJy4aXrJ/nYPBPNqYIx/Cx6jdzprqDqY9O1UH
         gHkyBZ1Cdt2N0tAnNvmVE3Xd4cjXXJm89Civ3nfJO1KgLep5meUH3fqzo4ZXANW/DIrd
         HIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BMKCPL2w13f5WuMU0JgMEQHWXhkHxmWwCk8sPwLJLo=;
        b=Yn+2GMVoU3iaOU/lSJyisMtnXqST8L2BU9d7BQ5tmVusPy8TVCLOB7wpz7IrYcfLVL
         t+7R8agX5Ut2mlFU73gIfSqAA67MEp2t0GdSoati+R71n2lWVa8LmIzIqZDnM9gnx7Gl
         nWkP0ziZMScXHBqQFUyxmuBcf4xIVVW0hlac5zBMBZE+snazM/SUJuf0+sWWGP2SEpNM
         rROAB05NGY8pIbFg/eh4h/M+QgnPyIYdcO9vW2FBYdUGYfhkWLnRuAo3Ove1nWDqW29T
         KUA+1QORHSFGiuOFbxSPga09s+atzO8xjfGHDjdSXVXdotLeMJ+6SsnMUAccdjRz9Kcs
         08YQ==
X-Gm-Message-State: AOAM5331RMnj40kv7biZ20xPjxm76Y4i1bvMQEmKddNAEVtXXPPx1g6K
        V4jYAWUVXWUN4vugpvyWuyQ=
X-Google-Smtp-Source: ABdhPJyRcx/pwhzlb2vzxL9dpc4XEadqNTuFNrhog0Dzlpx96CfewL7pPlW4pheoqqfV7nRv9A95DQ==
X-Received: by 2002:aa7:cb9a:: with SMTP id r26mr14530421edt.78.1626438284859;
        Fri, 16 Jul 2021 05:24:44 -0700 (PDT)
Received: from localhost.localdomain ([5.176.51.215])
        by smtp.gmail.com with ESMTPSA id m8sm3678649eds.10.2021.07.16.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 05:24:44 -0700 (PDT)
Date:   Fri, 16 Jul 2021 15:24:40 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in profile_init
Message-ID: <20210716152440.368d4250@gmail.com>
In-Reply-To: <000000000000610af005c714c1d1@google.com>
References: <000000000000610af005c714c1d1@google.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> kernel profiling enabled (shift: 1000000)
> ================================================================================
> UBSAN: shift-out-of-bounds in kernel/profile.c:110:31
> shift exponent 1000000 is too large for 64-bit type 'long int'
> CPU: 0 PID: 8453 Comm: syz-executor969 Tainted: G        W
> 5.13.0-syzkaller #0 Hardware name: Google Google Compute
> Engine/Google Compute Engine, BIOS Google 01/01/2011 Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
>  ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
>  __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
>  profile_init+0xfc/0x110 kernel/profile.c:110
>  profiling_store+0x5e/0xd0 kernel/ksysfs.c:80
>  kobj_attr_store+0x50/0x80 lib/kobject.c:856
>  sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139


I believe, something like this should fix it:


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

 

But this function can be called not only from sysfs and I can't
understand will my patch break something or not. And, I think, error
message is needed somewhere here to inform callers about wrong shift
value.


Thoughts?


-- 
With regards,
Pavel Skripkin
