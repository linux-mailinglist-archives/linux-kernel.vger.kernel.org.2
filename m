Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365BE3434A5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCUUgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhCUUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:36:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:36:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y1so18524937ljm.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mWs4m4H0UHckILPcAJUyWMZRqNTjkHacTsWOznu0H/A=;
        b=qT5/q7jJzAfAVVXHOLetaLhKzffdZEoHfZ4kfub/yUAx08GW2+FyODQ0x8h6MwH0/k
         UsjmfOqRY6zEkYh9h+ux2PCQTRVu917npCcZ+9sF0FH86VGQ7RrsuYAkpGf+FQk6lIxk
         KTU9HxELxVRZVXpBSXtTNIPCVJuNPkX+pif277OcIF2XI9PLWIjx9RKBNjGUER1ov1/Z
         TkhHywmAXDeC5Y6pgOPmEDmFzT5SLJ9WeMDxlrvUfZ7SPX/0Q51IPLz2lSO9V6pBrZaN
         Bz/Uy/RWnrrOnFEaw5jhU4etf0ejeQadqQWXy3ddJYpq1ms9fsVb0XOb0r3gpxSZESe0
         mHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mWs4m4H0UHckILPcAJUyWMZRqNTjkHacTsWOznu0H/A=;
        b=ocutNRNgUUIS8wCzudcYkgGjVHzhzKs9uclr8A0WDDtUrqvnCVBk5vC1PxzYE0RFHE
         t6Il+G0hui9PHvar5SZw2kGxJYHMXbk4H21OnWeJosic+Ttj7ttq6c8ERQLXyKlDx4je
         eaT8b7FCzxCePqpEcccP5xe8B+7kJNkD55/GK/L8TrIlc2K+ZZN+hX+XX7GMeoKR8qQN
         rmtI149MVEziBlqQeq1BEprg7F6ugAXaxyXdARAkAldBIaMSVX3j7qfJm8fbdIcDKC2k
         INMPQQYanNrrDEtkSGltxggm7OueAU8ulbeD/fCTLOiwsQQhnwHkrZoXDfuipIpz/ONN
         JSMQ==
X-Gm-Message-State: AOAM5314s16OwBAAFY7LgJIPQNvZ0XQlGO7xG40ItTNJgNoaH3uoPTGc
        UF2WG07hUMfDlKXyMAl8GuI=
X-Google-Smtp-Source: ABdhPJwZSINVw3nh/Sdhh7sNdJauxv6S5AXZtqEIsXUtBmO384SIZB3yQ82xLrzfJDUO08xJJ3CVAQ==
X-Received: by 2002:a2e:8708:: with SMTP id m8mr7552461lji.339.1616359004288;
        Sun, 21 Mar 2021 13:36:44 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id y8sm1701460ljk.9.2021.03.21.13.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 13:36:42 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 44FA65601D9; Sun, 21 Mar 2021 23:36:42 +0300 (MSK)
Date:   Sun, 21 Mar 2021 23:36:42 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrey Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] prctl: fix overwrite last but one entry in auxv vector
Message-ID: <YFeuWsnb6qKEU8+h@grain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey reported that current PR_SET_MM_AUXV (and PR_SET_MM_MAP) overwrite
too many entries on non 64bit kernels. This is because auxv is defined
as an array of longs and in result access to AT_VECTOR_SIZE - 2 entry
is not a type of auxv entry but rather an entry before the last one.

Since it is a common code for all architectures lets use __BITS_PER_LONG
definition to determinate each type/value pair in auxv_t is fitting
into `long` or not.

Note that on compat mode (ie Elf32 running in 64bit compiled kernel)
the preallocated vector size will be big enough to carry all entries
and zapping two entries at the end of the vector won't cause problems.

Same time lets drop useless task_lock()/task_unlock() calls from
PR_SET_MM_AUXV. It doesn't protect anything here and seems to be
sneaked in accidentally (Oleg pointed me to this moment).

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Andrey Vagin <avagin@gmail.com>
CC: Dmitry Safonov <0x7f454c46@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
Take a look please, once time permit. The issue on its own
should not be that critical but better to fix it. I tested
it manually via trivial test but I think it is not enough.
Need to implement some selftesting as well. Also obviously
I ran test on x86 only.

 kernel/sys.c |   73 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

Index: linux-tip.git/kernel/sys.c
===================================================================
--- linux-tip.git.orig/kernel/sys.c
+++ linux-tip.git/kernel/sys.c
@@ -1961,6 +1961,33 @@ out:
 	return error;
 }
 
+static int copy_auxv_from_user(unsigned long *auxv, size_t auxv_size,
+			       const void __user *addr, size_t len)
+{
+	BUG_ON(auxv_size != sizeof(current->mm->saved_auxv));
+
+	if (!addr || len > auxv_size)
+		return -EINVAL;
+
+	memset(auxv, 0, auxv_size);
+	if (len && copy_from_user(auxv, addr, len))
+		return -EFAULT;
+
+	/*
+	 * Specification requires the vector to be
+	 * ended up with AT_NULL entry thus userspace
+	 * will notice where to stop enumerating. Thus
+	 * if someone is passing a screwed data make sure
+	 * at least it has the end of vector sign.
+	 */
+	if (len == auxv_size) {
+		if (__BITS_PER_LONG == 64)
+			auxv[AT_VECTOR_SIZE - 2] = AT_NULL;
+		auxv[AT_VECTOR_SIZE - 1] = AT_NULL;
+	}
+	return 0;
+}
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data_size)
 {
@@ -1987,22 +2014,12 @@ static int prctl_set_mm_map(int opt, con
 		return error;
 
 	if (prctl_map.auxv_size) {
-		/*
-		 * Someone is trying to cheat the auxv vector.
-		 */
-		if (!prctl_map.auxv ||
-				prctl_map.auxv_size > sizeof(mm->saved_auxv))
-			return -EINVAL;
-
-		memset(user_auxv, 0, sizeof(user_auxv));
-		if (copy_from_user(user_auxv,
-				   (const void __user *)prctl_map.auxv,
-				   prctl_map.auxv_size))
-			return -EFAULT;
-
-		/* Last entry must be AT_NULL as specification requires */
-		user_auxv[AT_VECTOR_SIZE - 2] = AT_NULL;
-		user_auxv[AT_VECTOR_SIZE - 1] = AT_NULL;
+		int error = copy_auxv_from_user(user_auxv,
+						sizeof(user_auxv),
+						prctl_map.auxv,
+						prctl_map.auxv_size);
+		if (error)
+			return error;
 	}
 
 	if (prctl_map.exe_fd != (u32)-1) {
@@ -2079,25 +2096,17 @@ static int prctl_set_auxv(struct mm_stru
 	 * up to the caller to provide sane values here, otherwise userspace
 	 * tools which use this vector might be unhappy.
 	 */
-	unsigned long user_auxv[AT_VECTOR_SIZE] = {};
-
-	if (len > sizeof(user_auxv))
-		return -EINVAL;
-
-	if (copy_from_user(user_auxv, (const void __user *)addr, len))
-		return -EFAULT;
-
-	/* Make sure the last entry is always AT_NULL */
-	user_auxv[AT_VECTOR_SIZE - 2] = 0;
-	user_auxv[AT_VECTOR_SIZE - 1] = 0;
+	unsigned long user_auxv[AT_VECTOR_SIZE];
+	int error;
 
 	BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
 
-	task_lock(current);
-	memcpy(mm->saved_auxv, user_auxv, len);
-	task_unlock(current);
-
-	return 0;
+	error = copy_auxv_from_user(user_auxv, sizeof(user_auxv),
+				    (const void __user *)addr,
+				    len);
+	if (!error)
+		memcpy(mm->saved_auxv, user_auxv, len);
+	return error;
 }
 
 static int prctl_set_mm(int opt, unsigned long addr,
