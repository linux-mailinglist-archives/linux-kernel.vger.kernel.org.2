Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4245D177
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 00:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbhKYACZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 19:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244870AbhKYACW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 19:02:22 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F794C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:59:12 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c131-20020a621c89000000b004a343484969so2416933pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t7FdhzxvsZEaT0mOxjq3xyS9+1eldYre4hZBRnUvw50=;
        b=XeEU3PAGavc7VvBMypFLluu+ieBo76Q+zJ39ZTNFi6b5dJ5s8y79SbwbGCFPHJO7qe
         iUp9PDs2knNmYnC0Rc49wtUu66reODZVX0XweepNO8ec4ZnpA4ngpThkRkm04eApGFn4
         BcGW+53Z0vi0ABD0ZY6p8765F2G7V9az6dCLJZ+D9Yy4Y+jIgg4pZYfm5bFDRpBifUwA
         mUGjXZEgG1Q7Gcd51ADbYPrOlAPUxSIvInm8OYi+IUVSBeXfyoJW7Axf9GkQE7J9wU7z
         ZL4c/YNyXnf4IhCqXGXOYin80aaul8joX00TnEhQmKZcIGWs8cseJPdCKDZvi0TD4bXQ
         /zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t7FdhzxvsZEaT0mOxjq3xyS9+1eldYre4hZBRnUvw50=;
        b=0wDFBmmof6xaq36p9OQuRIZ0usUgFTVAR6K2ahA7kB4CrUSS+KGe7kInWnK6x28w80
         3LYFMu1lk/warBautHohYEOhi2SIjE2iciYGBM8ZxPze1vLOC3XAZ0o12xg9jY0HacOo
         +E85hf8vd3s+ZME5ZyNiH5/gH03xG+XZgi1zgxM83Z+jhfnTGwERJUAqQSeoVtpGVjD3
         /IT7XNmMhEtcUA4cD1sH51gPGEZiCmX6/WM55h+uCUqZnQmzs7sq12VemSdJl83N6flX
         SRc+8XWm0Z7q7YxGmIxQliCMQM5SpteZ4Rs1D6IYd7motLxOcueYB0RAeKb4t9E4sWmU
         MDRw==
X-Gm-Message-State: AOAM532o9k2Fsfm1EWAVFmcyRY4GvVak6pGT4KV7GCx1nMp9WHbvToLo
        Y86uF0oVxavbjdDRg8dmMx0Orvs2hUU=
X-Google-Smtp-Source: ABdhPJy11r8Cp9qEV7E2WGPyNi2vSpjmD9e1BGWfSYrrDL2dDwJV+yrk5EsdtC2BNTHjzJgHlKsupPO6pi4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e6ae:ce8f:3b61:8f18])
 (user=surenb job=sendgmr) by 2002:a63:150c:: with SMTP id v12mr13231871pgl.442.1637798351805;
 Wed, 24 Nov 2021 15:59:11 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:59:06 -0800
In-Reply-To: <20211124235906.14437-1-surenb@google.com>
Message-Id: <20211124235906.14437-2-surenb@google.com>
Mime-Version: 1.0
References: <20211124235906.14437-1-surenb@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 2/2] mm/oom_kill: allow process_mrelease to run under
 mmap_lock protection
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With exit_mmap holding mmap_write_lock during free_pgtables call,
process_mrelease does not need to elevate mm->mm_users in order to
prevent exit_mmap from destrying pagetables while __oom_reap_task_mm
is walking the VMA tree. The change prevents process_mrelease from
calling the last mmput, which can lead to waiting for IO completion
in exit_aio.

Fixes: 337546e83fc7 ("mm/oom_kill.c: prevent a race between process_mrelease and exit_mmap")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/oom_kill.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..67780386f478 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1169,15 +1169,15 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		goto put_task;
 	}
 
-	if (mmget_not_zero(p->mm)) {
-		mm = p->mm;
-		if (task_will_free_mem(p))
-			reap = true;
-		else {
-			/* Error only if the work has not been done already */
-			if (!test_bit(MMF_OOM_SKIP, &mm->flags))
-				ret = -EINVAL;
-		}
+	mm = p->mm;
+	mmgrab(mm);
+
+	if (task_will_free_mem(p))
+		reap = true;
+	else {
+		/* Error only if the work has not been done already */
+		if (!test_bit(MMF_OOM_SKIP, &mm->flags))
+			ret = -EINVAL;
 	}
 	task_unlock(p);
 
@@ -1188,13 +1188,16 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		ret = -EINTR;
 		goto drop_mm;
 	}
-	if (!__oom_reap_task_mm(mm))
+	/*
+	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
+	 * possible change in exit_mmap is seen
+	 */
+	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
 		ret = -EAGAIN;
 	mmap_read_unlock(mm);
 
 drop_mm:
-	if (mm)
-		mmput(mm);
+	mmdrop(mm);
 put_task:
 	put_task_struct(task);
 	return ret;
-- 
2.34.0.rc2.393.gf8c9666880-goog

