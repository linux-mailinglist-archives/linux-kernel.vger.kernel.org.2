Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4F346BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhCWWHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbhCWWGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:06:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:06:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 184so27663484ljf.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EHMlmYQIY1zAyaktxhetsYB9LwfRsFjHKsYIqK2yIPE=;
        b=NL/Co5BLITlTYN7kxz+Jle2CCoEzUx0zdpkXrCp6McutrLYknJDxjaRisePsg0Itdg
         YXLrzwZf6Jnh7rXEsoNmbick+PowINW9q9DfcxsM13u9UbthdKq9hZb3iaZPnsyKr9LG
         p8kcrA60ntMrbLpijMBd/6B0OVfISWzW/cNGe49ABVIQ0mUVKCVQXvhLN0awGQG/4PRw
         +3ArX91ALZHgyp6fDLEfThX/1LzCL+OmTRM3VFv4mU/Bb4x6E/8a+jaagI0ftUbGQtDe
         yEZCaEpHMQHfuIhPX40LdlJ8WO+3/F+j/FfnMQ7gxMLBSR/VhRJS+THLneV555w6rQVC
         l5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EHMlmYQIY1zAyaktxhetsYB9LwfRsFjHKsYIqK2yIPE=;
        b=KW+2XNz5KxsPgWgBEUyCP2LFFWMT12pxeg0hdwnt18+FxQgmT8WkLSOMdwCzpTy2z3
         rxf8bhNpPK0vhVSDt4N49yYNAqZl4Zzs/KQUY/S56z7Zjusws0Kr1MqWdQBpWlmIX+bY
         m/bzzSljf2LYV6ge0KeKLLXTnVKb1fSCMF3OcZmyV8fZDj7sWh/vzJEvX9GZ5Nx6/Hms
         syqgOrOmY9gy6zHqTiUYJcx0gb4HZKZPIWVDR6qHUVtIkS5PwoImjq6YrFZRe0HxgLDb
         e6xRjbv7czpfTCYZMXV3sjZfAIZ0nU8gAON6AFdSq+CUwALhEcsb2l5YjNVMOjlOhjl5
         nEuA==
X-Gm-Message-State: AOAM533DPkGR+gnU6EKUazpiEzSNnQLLklrybHqIRXTLKs9b8Mnk3t4/
        cTb8uM+vQXnz2Iyd+D36Y6o=
X-Google-Smtp-Source: ABdhPJwi8ly8FYpgqKCEcCsHJFA0QF0YArKAhDfSRhmrCHP+AtGkInmCrFx24FcVkDT7FxEzd3S3Bw==
X-Received: by 2002:a2e:b6c7:: with SMTP id m7mr26714ljo.241.1616537205932;
        Tue, 23 Mar 2021 15:06:45 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id m3sm33513lfo.190.2021.03.23.15.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:06:44 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 4BC1C5601CE; Wed, 24 Mar 2021 01:06:44 +0300 (MSK)
Date:   Wed, 24 Mar 2021 01:06:44 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrey Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] prctl: PR_SET_MM - unify copying of user's auvx
Message-ID: <YFpmdGXmGQ6IetoX@grain>
References: <YFeuWsnb6qKEU8+h@grain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFeuWsnb6qKEU8+h@grain>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prctl(PR_SET_MM, PR_SET_MM_AUXV | PR_SET_MM_MAP, ...) copies user
provided auxiliary vector to kernel and saves it to mm::saved_auxv,
this involves same code in to places. Lets move it into one helper
instead.

When we copy data from user space we make sure that the vector ends
up with AT_NULL key/value pair as specification requires. And here
is a bit vague moment if task is running in compat mode: instead of
one last value we zeroing two entries at the end. This is done for
code simplicity (if arch supports compat mode then the initial vector
size must be big enough to store values needed for the native mode
as well, that's why we define the vector as an array of longs. In
particular when Elf executable is loaded the vector is considered
as pairs of elf_addr_t elements, which is 4 byte per each on 32
bit environment and 8 byte per each in 64 bit kernel).

Same time lets drop useless task_lock()/task_unlock() calls from
PR_SET_MM_AUXV. It doesn't protect anything here and seems to be
sneaked in accidentally (Oleg pointed me this moment).

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Reported-by: Oleg Nesterov <oleg@redhat.com>
CC: Andrey Vagin <avagin@gmail.com>
CC: Dmitry Safonov <0x7f454c46@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 kernel/sys.c |   70 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

Index: linux-tip.git/kernel/sys.c
===================================================================
--- linux-tip.git.orig/kernel/sys.c
+++ linux-tip.git/kernel/sys.c
@@ -1961,6 +1961,30 @@ out:
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
+	 * ended up with AT_NULL entry so user space
+	 * will notice where to stop enumerating.
+	 */
+	if (len == auxv_size) {
+		auxv[AT_VECTOR_SIZE - 2] = AT_NULL;
+		auxv[AT_VECTOR_SIZE - 1] = AT_NULL;
+	}
+	return 0;
+}
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data_size)
 {
@@ -1987,22 +2011,12 @@ static int prctl_set_mm_map(int opt, con
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
@@ -2079,25 +2093,17 @@ static int prctl_set_auxv(struct mm_stru
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
