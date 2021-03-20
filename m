Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E0434298F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCTBCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:02:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40636 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCTBBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:01:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616202102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ABb3tLK6AiZyfUvK+8JOl+Scoejb76vmqVbbFrl8O0=;
        b=f7Ws/LjFXJF4tiehzQo1Tl7BZVyVoaOd3JIyBz/DT2SkeVCmTBxNzGgVuGiaIAuZZYkveD
        pEawsLFez7a35IcfWrUVR7RWQEPcm5SHNRcIENaDCVcmVWxlYQqb73DWu4Oh8bFbE6OWGJ
        tZaTeyue2Mtaa7CDILVyaUUv9kVSqEgoM2TSxpj7oLmxA4ANGmPMzxPpQMplOfvDdx9mS1
        vukbDiQ1sZsheMirPbUwob8MRTpfWs3MF4UBs2UoJbPdyeZvUTc0iWCfryFAwLDEz+otVt
        q3mmffddgjW3CniP8WRRv14k2LlFvIcGRgYCpR6RS3+uDY1KLdSyTo0TkstoNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616202102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ABb3tLK6AiZyfUvK+8JOl+Scoejb76vmqVbbFrl8O0=;
        b=rfMokOr39bMLI5fUvHNvFIi6Y/xuw2OlOZ7fzlhw9Iy5EzRLiyDCWNFF9U4s+XeRxDtmxE
        exaQ67Kq37wv/ODg==
To:     "Luck\, Tony" <tony.luck@intel.com>,
        "Yu\, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Li\, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "Yu\, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
In-Reply-To: <d98d86f9f5824573b2441089e0c2ae91@intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com> <20210313054910.2503968-3-fenghua.yu@intel.com> <871rca6dbp.fsf@nanos.tec.linutronix.de> <d98d86f9f5824573b2441089e0c2ae91@intel.com>
Date:   Sat, 20 Mar 2021 02:01:42 +0100
Message-ID: <87k0q2bpu1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2021 at 21:50, Tony Luck wrote:
>>  What is the justifucation for making this rate limit per UID and not
>>  per task, per process or systemwide?
>
> The concern is that a malicious user is running a workload that loops
> obtaining the buslock. This brings the whole system to its knees.
>
> Limiting per task doesn't help. The user can just fork(2) a whole bunch
> of tasks for a distributed buslock attack..

Fair enough.

> Systemwide might be an interesting alternative. Downside would be accidental
> rate limit of non-malicious tasks that happen to grab a bus lock periodically
> but in the same window with other buslocks from other users.
>
> Do you think that a risk worth taking to make the code simpler?

I'd consider it low risk, but I just looked for the usage of the
existing ratelimit in struct user and the related commit. Nw it's dawns
on me where you are coming from.

So that seems to become a pattern ... so the uncompiled thing below
might solve that.

Yes, it makes the efivars thingy slower, but do we care?

We neither care about efivars performance nor about the buslock
performance.

But I pretty much care about no having to stare at code which gets the
fundamental refcounting wrong.

Thanks,

        tglx
---
 fs/efivarfs/Kconfig           |    1 +
 fs/efivarfs/file.c            |   11 +++++++++--
 include/linux/ratelimit.h     |    1 +
 include/linux/ratelimit_uid.h |   26 ++++++++++++++++++++++++++
 include/linux/sched/user.h    |    4 ++--
 kernel/user.c                 |    7 ++++---
 lib/Kconfig                   |    3 +++
 lib/ratelimit.c               |   41 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 87 insertions(+), 7 deletions(-)

--- a/fs/efivarfs/Kconfig
+++ b/fs/efivarfs/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config EFIVAR_FS
 	tristate "EFI Variable filesystem"
+	select UID_RATELIMIT
 	depends on EFI
 	default m
 	help
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -63,6 +63,14 @@ static ssize_t efivarfs_file_write(struc
 	return bytes;
 }
 
+static const struct uid_ratelimit_cfg efivars_rl = {
+	.which		= UID_RATELIMIT_EFIVARS,
+	.interval	= HZ,
+	.burst		= 100,
+	.flags		= RATELIMIT_MSG_ON_RELEASE,
+	.delay		= 50,
+};
+
 static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 		size_t count, loff_t *ppos)
 {
@@ -73,8 +81,7 @@ static ssize_t efivarfs_file_read(struct
 	ssize_t size = 0;
 	int err;
 
-	while (!__ratelimit(&file->f_cred->user->ratelimit))
-		msleep(50);
+	uid_ratelimit(&efivars_rl);
 
 	err = efivar_entry_size(var, &datasize);
 
--- a/include/linux/ratelimit.h
+++ b/include/linux/ratelimit.h
@@ -3,6 +3,7 @@
 #define _LINUX_RATELIMIT_H
 
 #include <linux/ratelimit_types.h>
+#include <linux/ratelimit_uid.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 
--- /dev/null
+++ b/include/linux/ratelimit_uid.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RATELIMIT_UID_H
+#define _LINUX_RATELIMIT_UID_H
+
+/* Per UID ratelimits */
+enum uid_ratelimits {
+#ifdef CONFIG_EFIVAR_FS
+	UID_RATELIMIT_EFIVARS,
+#endif
+	UID_RATELIMIT_MAX,
+};
+
+#define UID_RATELIMIT_NODELAY	ULONG_MAX
+
+struct uid_ratelimit_cfg {
+	enum uid_ratelimits	which;
+	int			interval;
+	int			burst;
+	unsigned long		flags;
+	unsigned long		delay;
+};
+
+extern int __uid_ratelimit(const struct uid_ratelimit_cfg *cfg, const void *func);
+#define uid_ratelimit(cfg) __uid_ratelimit(cfg, __func__)
+
+#endif
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -40,8 +40,8 @@ struct user_struct {
 	atomic_t nr_watches;	/* The number of watches this user currently has */
 #endif
 
-	/* Miscellaneous per-user rate limit */
-	struct ratelimit_state ratelimit;
+	/* Miscellaneous per-user rate limits storage */
+	struct ratelimit_state	*ratelimits[UID_RATELIMIT_MAX];
 };
 
 extern int uids_sysfs_init(void);
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -102,7 +102,6 @@ struct user_struct root_user = {
 	.sigpending	= ATOMIC_INIT(0),
 	.locked_shm     = 0,
 	.uid		= GLOBAL_ROOT_UID,
-	.ratelimit	= RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
 };
 
 /*
@@ -139,8 +138,12 @@ static struct user_struct *uid_hash_find
 static void free_user(struct user_struct *up, unsigned long flags)
 	__releases(&uidhash_lock)
 {
+	unsigned int i;
+
 	uid_hash_remove(up);
 	spin_unlock_irqrestore(&uidhash_lock, flags);
+	for (i = 0; i < UID_RATELIMIT_MAX; i++)
+		kfree(up->ratelimits[i]);
 	kmem_cache_free(uid_cachep, up);
 }
 
@@ -188,8 +191,6 @@ struct user_struct *alloc_uid(kuid_t uid
 
 		new->uid = uid;
 		refcount_set(&new->__count, 1);
-		ratelimit_state_init(&new->ratelimit, HZ, 100);
-		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
 
 		/*
 		 * Before adding this, check whether we raced
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -701,3 +701,6 @@ config GENERIC_LIB_DEVMEM_IS_ALLOWED
 config PLDMFW
 	bool
 	default n
+
+config UID_RATELIMIT
+	bool
--- a/lib/ratelimit.c
+++ b/lib/ratelimit.c
@@ -11,6 +11,9 @@
 #include <linux/ratelimit.h>
 #include <linux/jiffies.h>
 #include <linux/export.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/cred.h>
 
 /*
  * __ratelimit - rate limiting
@@ -68,3 +71,41 @@ int ___ratelimit(struct ratelimit_state
 	return ret;
 }
 EXPORT_SYMBOL(___ratelimit);
+
+#ifdef CONFIG_UID_RATELIMIT
+int __uid_ratelimit(const struct uid_ratelimit_cfg *cfg, const void *func)
+{
+	struct user_struct *up = get_current_user();
+	unsigned int which = cfg->which;
+	struct ratelimit_state *rs;
+	int ret = 0;
+
+	if (WARN_ON_ONCE(which > UID_RATELIMIT_MAX))
+		goto out;
+
+	rs = up->ratelimits[which];
+	if (!rs) {
+		/* ratelimit_state_init() does a memset(,0,) */
+		rs = kmalloc(sizeof(*rs), GFP_KERNEL);
+		if (!rs)
+			goto out;
+		ratelimit_state_init(rs, cfg->interval, cfg->burst);
+		ratelimit_set_flags(rs, cfg->flags);
+		if (cmpxchg(&up->ratelimits[which], NULL, rs) != NULL) {
+			kfree(rs);
+			rs = up->ratelimits[which];
+		}
+	}
+
+	while (1) {
+		ret = ___ratelimit(rs, func);
+		if (ret || cfg->delay == UID_RATELIMIT_NODELAY)
+			break;
+		msleep(cfg->delay);
+	}
+out:
+	free_uid(up);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__uid_ratelimit);
+#endif



        
