Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963883D2C19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 20:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhGVSFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGVSFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:05:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 11:46:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d12so6934427wre.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=jdTRy/YntlLC3FRP7x7d7wP8u7ujODvGgS3FK+ja6fY=;
        b=TCKQMz3TFkLpWfErPQpIOEOIhUO+IUofsn9TXZshTBBoP6L/UF5eE7r73YYLqii2qd
         eMHICEVsPw2Asra+h3owfdVzyFiMVfsfSbC4SaY3VH2+zd3X33userj+ysawzsIhxqUr
         5Lqw05/IZXH1DvY4GMlNj69V8kEidQth/Yids9xC6YjJHwYigN5ym6T0/Fuib0KBZJsm
         P6bfNP6MljwBZfrdd/hIqXSJjvrtUo+diSkILnd9D+6KAxmbJg+te/2KFdnxCRO8Vgdh
         ZbZ5BgfRpvAlbKihnt9VbbfylPNTHUFhpnglMj3tGy170QspeNLVNyMamh0r8KZAHQx7
         rKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=jdTRy/YntlLC3FRP7x7d7wP8u7ujODvGgS3FK+ja6fY=;
        b=Ir424UgoH/nVUeoHnnMN7IasZjwik1ZVM75TEfoAW4UY68PMbRFl/njhVwFJGIwDw+
         AyjZEKwvHNz3d7K3tegFgohuFVSlesaOPi0SCdRF4bojf+TCoQ5PY5HRILrt1zp9p/MX
         SuYDW5OkFDwW8ohFDgxGNo68Q8SWpXaKH7TWVOsgMtFXMQ4vp2LohVlb11UVprVHu+G/
         pVcp4vN4aqgU8KiUmiZITCaZR0B5NCu4BE22FUdYUHoBsS9+ceff5D2akF18PDelwGjx
         FCzAvPGarCAses1cOR7DMbBNtcF8euqfpPx7kyYwo0aJ9StPP2dk1yLBTm6irIXOQCdC
         d58Q==
X-Gm-Message-State: AOAM532+5FSAyPPgwsBkirb8dOPkm7mjF4/1DMCuzGV7nb2Z8JOlGMmy
        5Yaybwsp3d3btr9rWAWePH8HbQ==
X-Google-Smtp-Source: ABdhPJzfmL5IGsXSPZn0G4bapdPX658NK8gxY/fCeEtg3OB1bN8a0p566AQiRjQdinL5U9kKcEZGnw==
X-Received: by 2002:a5d:410b:: with SMTP id l11mr1349625wrp.173.1626979576394;
        Thu, 22 Jul 2021 11:46:16 -0700 (PDT)
Received: from localhost.localdomain (p200300d997080c0092cf6a8d541a2359.dip0.t-ipconnect.de. [2003:d9:9708:c00:92cf:6a8d:541a:2359])
        by smtp.googlemail.com with ESMTPSA id t9sm29523166wrq.92.2021.07.22.11.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 11:46:15 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC PATCH] shm: extend forced shm destroy to support objects
 from several IPC nses
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
References: <CAJqdLrov0VBzHamSvMRKBHSJX+NROUx0TUsRD9U0zEWUn5XxDA@mail.gmail.com>
 <20210714173005.491941-1-alexander.mikhalitsyn@virtuozzo.com>
Message-ID: <bd0a1f71-4624-d88a-98a8-6550926349b3@colorfullife.com>
Date:   Thu, 22 Jul 2021 20:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714173005.491941-1-alexander.mikhalitsyn@virtuozzo.com>
Content-Type: multipart/mixed;
 boundary="------------E806D47D8E247ABC3FEA7CB2"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E806D47D8E247ABC3FEA7CB2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexander,

A few more remarks.

On 7/14/21 7:30 PM, Alexander Mikhalitsyn wrote:
> This is total rework of fix.
> Thanks to Eric Biederman for suggestions (but may be I've misunderstood some of them :))
>
> I've tested it with reproducer of the original problem. But of course it needs
> detailed testing. I hope that I get some general comments about design and implementation.
>
> ToDo: remove unneeded "ns" argument from shm_destroy, shm_rmid and other functions.

What ensures the that shp->ns is not destroyed prematurely?

I did some tests, and it seems that shmat() acquires a namespace 
refcount, and shm_release() puts it again, and the shm_release is late 
enough to ensure that the ns cannot go out of scope.

But I haven't checked all combinations (with/without shm_rmid_forced, 
delete via exit(), shmctl(), shmdt(), mmap()).

And: This should be documented somewhere.


> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -65,6 +65,7 @@ struct shmid_kernel /* private to the kernel */
>   	/* The task created the shm object.  NULL if the task is dead. */
>   	struct task_struct	*shm_creator;
>   	struct list_head	shm_clist;	/* list by creator */

I think the comments are wrong/outdated.

Some parts of the new code checks with list_empty(shm_clist), not by 
looking at shm_creator.

> +	struct ipc_namespace	*ns;
>   } __randomize_layout;
>   
>   /* shm_mode upper byte flags */
> @@ -115,6 +116,7 @@ static void do_shm_rmid(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
>   	struct shmid_kernel *shp;
>   
>   	shp = container_of(ipcp, struct shmid_kernel, shm_perm);
> +	BUG_ON(shp->ns && ns != shp->ns);

Is shp->ns == NULL allowed/possible? From what I see, it is impossible.

I think we should not have  NULL check in a few codepaths, but not in 
other codepaths. Either everywhere, or nowhere.


>   
>   	if (shp->shm_nattch) {
>   		shp->shm_perm.mode |= SHM_DEST;
> @@ -225,9 +227,32 @@ static void shm_rcu_free(struct rcu_head *head)
>   	kfree(shp);
>   }
>   
> +static inline void task_shm_clist_lock(struct task_struct *task)
> +{
> +	spin_lock(&task->sysvshm.shm_clist_lock);
> +}
> +
> +static inline void task_shm_clist_unlock(struct task_struct *task)
> +{
> +	spin_unlock(&task->sysvshm.shm_clist_lock);
> +}
> +
> +void shm_clist_rm(struct shmid_kernel *shp)
> +{
> +	if (!shp->shm_creator)
> +		return;
> +
> +	task_shm_clist_lock(shp->shm_creator);
> +	list_del_init(&shp->shm_clist);
> +	task_shm_clist_unlock(shp->shm_creator);
> +	shp->shm_creator = NULL;
> +}
> +
>   static inline void shm_rmid(struct ipc_namespace *ns, struct shmid_kernel *s)
>   {
> -	list_del(&s->shm_clist);
> +	WARN_ON(s->ns && ns != s->ns);
> +	//list_del_init(&s->shm_clist);
> +	shm_clist_rm(s);
>   	ipc_rmid(&shm_ids(ns), &s->shm_perm);
>   }
>   
> @@ -306,10 +331,10 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
>    *
>    * 2) sysctl kernel.shm_rmid_forced is set to 1.
>    */
> -static bool shm_may_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
> +static bool shm_may_destroy(struct shmid_kernel *shp)
>   {
>   	return (shp->shm_nattch == 0) &&
> -	       (ns->shm_rmid_forced ||
> +	       (shp->ns->shm_rmid_forced ||
>   		(shp->shm_perm.mode & SHM_DEST));
>   }
>   
As written before: what ensures that shp->ns->shm_rmid_forced was not 
released already?
> @@ -340,7 +365,7 @@ static void shm_close(struct vm_area_struct *vma)
>   	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
>   	shp->shm_dtim = ktime_get_real_seconds();
>   	shp->shm_nattch--;
> -	if (shm_may_destroy(ns, shp))
> +	if (shm_may_destroy(shp))
>   		shm_destroy(ns, shp);
>   	else
>   		shm_unlock(shp);
> @@ -361,10 +386,10 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
>   	 *
>   	 * As shp->* are changed under rwsem, it's safe to skip shp locking.
>   	 */
> -	if (shp->shm_creator != NULL)
> +	if (!list_empty(&shp->shm_clist))
>   		return 0;
>   
This collides with the comment above: here, list_empty() is used.
> -	if (shm_may_destroy(ns, shp)) {
> +	if (shm_may_destroy(shp)) {
>   		shm_lock_by_ptr(shp);
>   		shm_destroy(ns, shp);
>   	}
> @@ -379,51 +404,77 @@ void shm_destroy_orphaned(struct ipc_namespace *ns)
>   	up_write(&shm_ids(ns).rwsem);
>   }
>   
> +void shm_init_task(struct task_struct *task)
> +{
> +	INIT_LIST_HEAD(&(task)->sysvshm.shm_clist);
> +	spin_lock_init(&task->sysvshm.shm_clist_lock);
> +}
> +
>   /* Locking assumes this will only be called with task == current */
>   void exit_shm(struct task_struct *task)
>   {
> -	struct ipc_namespace *ns = task->nsproxy->ipc_ns;
> +	LIST_HEAD(tmp);
>   	struct shmid_kernel *shp, *n;
>   
>   	if (list_empty(&task->sysvshm.shm_clist))
>   		return;
>   
> -	/*
> -	 * If kernel.shm_rmid_forced is not set then only keep track of
> -	 * which shmids are orphaned, so that a later set of the sysctl
> -	 * can clean them up.
> -	 */
> -	if (!ns->shm_rmid_forced) {
> -		down_read(&shm_ids(ns).rwsem);
> -		list_for_each_entry(shp, &task->sysvshm.shm_clist, shm_clist)
> -			shp->shm_creator = NULL;
> -		/*
> -		 * Only under read lock but we are only called on current
> -		 * so no entry on the list will be shared.
> -		 */
> -		list_del(&task->sysvshm.shm_clist);
> -		up_read(&shm_ids(ns).rwsem);
> -		return;
> -	}
> +	rcu_read_lock(); /* for refcount_inc_not_zero */
> +	task_shm_clist_lock(task);
>   
> -	/*
> -	 * Destroy all already created segments, that were not yet mapped,
> -	 * and mark any mapped as orphan to cover the sysctl toggling.
> -	 * Destroy is skipped if shm_may_destroy() returns false.
> -	 */
> -	down_write(&shm_ids(ns).rwsem);
>   	list_for_each_entry_safe(shp, n, &task->sysvshm.shm_clist, shm_clist) {
> +		struct ipc_namespace *ns = shp->ns;
> +
> +		/*
> +		 * Remove shm from task list and nullify shm_creator which
> +		 * marks object as orphaned.
> +		 *
> +		 * If kernel.shm_rmid_forced is not set then only keep track of
> +		 * which shmids are orphaned, so that a later set of the sysctl
> +		 * can clean them up.
> +		 */
> +		list_del_init(&shp->shm_clist);
>   		shp->shm_creator = NULL;
>   
> -		if (shm_may_destroy(ns, shp)) {
> -			shm_lock_by_ptr(shp);
> -			shm_destroy(ns, shp);
> +		printk("exit_shm() %px refcnt=%u, id=%d,key=%x\n", shp,
> +			refcount_read(&shp->shm_perm.refcount),
> +			shp->shm_perm.id, shp->shm_perm.key
> +		);
> +
> +		/*
> +		 * Will destroy all already created segments, that were not yet mapped,
> +		 * and mark any mapped as orphan to cover the sysctl toggling.
> +		 * Destroy is skipped if shm_may_destroy() returns false.
> +		 */
> +		if (shp->ns->shm_rmid_forced && shm_may_destroy(shp)) {
> +			/*
> +			 * We may race with shm_exit_ns() if refcounter
> +			 * already zero. Let's skip shm_destroy() of such
> +			 * shm object as it will be destroyed during shm_exit_ns()
> +			 */
> +			if (!refcount_inc_not_zero(&ns->ns.count)) /* get_ipc_ns */
> +				continue;
> +
> +			list_add(&shp->shm_clist, &tmp);
>   		}
>   	}
>   
> -	/* Remove the list head from any segments still attached. */
>   	list_del(&task->sysvshm.shm_clist);
> -	up_write(&shm_ids(ns).rwsem);
> +	task_shm_clist_unlock(task);
> +	rcu_read_unlock();
> +
> +	list_for_each_entry_safe(shp, n, &tmp, shm_clist) {
> +		struct ipc_namespace *ns = shp->ns;
> +
> +		list_del_init(&shp->shm_clist);
> +
> +		down_write(&shm_ids(ns).rwsem);
> +		shm_lock_by_ptr(shp);
> +		/* will do put_ipc_ns(shp->ns) */
> +		shm_destroy(ns, shp);
> +		up_write(&shm_ids(ns).rwsem);
> +		put_ipc_ns(ns); /* see refcount_inc_not_zero */
> +	}
>   }
>   

I do not see the advantage of first collecting everything in a local 
list, and then destroying the elements.

Attached is my current test case. Feel free to merge whatever you 
consider as useful into your change.


--

     Manfred


--------------E806D47D8E247ABC3FEA7CB2
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-ipc-shm-locking-questions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-ipc-shm-locking-questions.patch"

From 7ac17dcf2615f40cef789b203d6f6876038627b6 Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Thu, 22 Jul 2021 20:19:47 +0200
Subject: [PATCH 3/3] ipc/shm: locking / questions

for discussion, not for merging:
- make locking a bit more explicit
- there is no advantage of a temporary list in exit_shm(),
  thus delete segments one by one.
- lots of debug pr_info.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 include/linux/ipc_namespace.h |  16 ++++
 ipc/namespace.c               |   4 +
 ipc/shm.c                     | 160 +++++++++++++++++++++-------------
 3 files changed, 121 insertions(+), 59 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 05e22770af51..f3a09604d0d5 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -126,11 +126,22 @@ extern struct ipc_namespace *copy_ipcs(unsigned long flags,
 
 static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
 {
+pr_info("get_ipc_ns: inc for ns %px.\n", ns);
 	if (ns)
 		refcount_inc(&ns->ns.count);
 	return ns;
 }
 
+static inline struct ipc_namespace *get_ipc_ns_not_zero(struct ipc_namespace *ns)
+{
+pr_info("get_ipc_ns_not_zero: inc for ns %px.\n", ns);
+	if (ns) {
+		if (refcount_inc_not_zero(&ns->ns.count))
+			return ns;
+	}
+	return NULL;
+}
+
 extern void put_ipc_ns(struct ipc_namespace *ns);
 #else
 static inline struct ipc_namespace *copy_ipcs(unsigned long flags,
@@ -147,6 +158,11 @@ static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
 	return ns;
 }
 
+static inline struct ipc_namespace *get_ipc_ns_not_zero(struct ipc_namespace *ns)
+{
+	return ns;
+}
+
 static inline void put_ipc_ns(struct ipc_namespace *ns)
 {
 }
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 7bd0766ddc3b..4160ea18dcd2 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -117,6 +117,7 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
+pr_info("free_ipc_ns: worker task for namespace %px.\n", ns);
 	/* mq_put_mnt() waits for a grace period as kern_unmount()
 	 * uses synchronize_rcu().
 	 */
@@ -129,6 +130,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
 	kfree(ns);
+pr_info("free_ipc_ns: worker task for namespace %px done.\n", ns);
 }
 
 static LLIST_HEAD(free_ipc_list);
@@ -164,9 +166,11 @@ static DECLARE_WORK(free_ipc_work, free_ipc);
  */
 void put_ipc_ns(struct ipc_namespace *ns)
 {
+pr_info("put_ipc_ns: got called for %px.\n", ns);
 	if (refcount_dec_and_lock(&ns->ns.count, &mq_lock)) {
 		mq_clear_sbinfo(ns);
 		spin_unlock(&mq_lock);
+pr_info("put_ipc_ns: destroying namespace %px.\n", ns);
 
 		if (llist_add(&ns->mnt_llist, &free_ipc_list))
 			schedule_work(&free_ipc_work);
diff --git a/ipc/shm.c b/ipc/shm.c
index a746886a0e00..f55118d0a425 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -62,9 +62,14 @@ struct shmid_kernel /* private to the kernel */
 	struct pid		*shm_lprid;
 	struct ucounts		*mlock_ucounts;
 
-	/* The task created the shm object.  NULL if the task is dead. */
+	/* The task created the shm object, for looking up
+	 * task->sysvshm.shm_clist_lock */
 	struct task_struct	*shm_creator;
-	struct list_head	shm_clist;	/* list by creator */
+
+	/* list by creator. shm_clist_lock required for read/write
+	 * if list_empty(), then the creator is dead already
+	 */
+	struct list_head	shm_clist;
 	struct ipc_namespace	*ns;
 } __randomize_layout;
 
@@ -130,6 +135,7 @@ static void do_shm_rmid(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 #ifdef CONFIG_IPC_NS
 void shm_exit_ns(struct ipc_namespace *ns)
 {
+pr_info("shm_exit_ns(), %px.\n", ns);
 	free_ipcs(ns, &shm_ids(ns), do_shm_rmid);
 	idr_destroy(&ns->ids[IPC_SHM_IDS].ipcs_idr);
 	rhashtable_destroy(&ns->ids[IPC_SHM_IDS].key_ht);
@@ -237,15 +243,30 @@ static inline void task_shm_clist_unlock(struct task_struct *task)
 	spin_unlock(&task->sysvshm.shm_clist_lock);
 }
 
-void shm_clist_rm(struct shmid_kernel *shp)
+/* It has to be called with shp locked.
+ * It must be called before ipc_rmid() */
+static inline void shm_clist_rm(struct shmid_kernel *shp)
 {
-	if (!shp->shm_creator)
+	struct task_struct *creator;
+
+	creator = READ_ONCE(shp->shm_creator);
+	if (!creator) {
+pr_info("shm_clist_rm: creator already NULL for %px.\n", shp);
 		return;
+	}
+
+	task_shm_clist_lock(creator);
+
+pr_info("shm_clist_rm: creator %px locked for shp %px.\n", creator, shp);
 
-	task_shm_clist_lock(shp->shm_creator);
-	list_del_init(&shp->shm_clist);
-	task_shm_clist_unlock(shp->shm_creator);
-	shp->shm_creator = NULL;
+	/* A concurrent exit_shm may do a list_del_init() as well.
+	 * Just do nothing if exit_shm already did the work
+	 */
+	if (!list_empty(&shp->shm_clist)) {
+		list_del_init(&shp->shm_clist);
+		WRITE_ONCE(shp->shm_creator, NULL);
+	}
+	task_shm_clist_unlock(creator);
 }
 
 static inline void shm_rmid(struct ipc_namespace *ns, struct shmid_kernel *s)
@@ -305,6 +326,8 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
 {
 	struct file *shm_file;
 
+pr_info("shm_destroy: current %px, namespace %px, shp %px.\n", current, ns, shp);
+
 	shm_file = shp->shm_file;
 	shp->shm_file = NULL;
 	ns->shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -333,6 +356,11 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
  */
 static bool shm_may_destroy(struct shmid_kernel *shp)
 {
+pr_info("shm_may_destroy for current %px, ns %px, shp %px.\n", current, shp->ns, shp);
+
+/* TODO:
+ * understand refcounting for shp->ns: What guarantees that ns cannot go out of scope?
+ */
 	return (shp->shm_nattch == 0) &&
 	       (shp->ns->shm_rmid_forced ||
 		(shp->shm_perm.mode & SHM_DEST));
@@ -365,6 +393,7 @@ static void shm_close(struct vm_area_struct *vma)
 	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
 	shp->shm_dtim = ktime_get_real_seconds();
 	shp->shm_nattch--;
+pr_info("shm_close for current %px, ns %px, shp %px.\n", current, shp->ns, shp);
 	if (shm_may_destroy(shp))
 		shm_destroy(ns, shp);
 	else
@@ -413,67 +442,66 @@ void shm_init_task(struct task_struct *task)
 /* Locking assumes this will only be called with task == current */
 void exit_shm(struct task_struct *task)
 {
-	LIST_HEAD(tmp);
-	struct shmid_kernel *shp, *n;
 
-	if (list_empty(&task->sysvshm.shm_clist))
-		return;
+pr_info("exit_shm: called for task %px, current %px\n", task, current);
 
-	rcu_read_lock(); /* for refcount_inc_not_zero */
-	task_shm_clist_lock(task);
+	for (;;) {
+		struct shmid_kernel *shp;
+		struct ipc_namespace *ns;
 
-	list_for_each_entry_safe(shp, n, &task->sysvshm.shm_clist, shm_clist) {
-		struct ipc_namespace *ns = shp->ns;
 
-		/*
-		 * Remove shm from task list and nullify shm_creator which
-		 * marks object as orphaned.
-		 *
-		 * If kernel.shm_rmid_forced is not set then only keep track of
-		 * which shmids are orphaned, so that a later set of the sysctl
-		 * can clean them up.
-		 */
-		list_del_init(&shp->shm_clist);
-		shp->shm_creator = NULL;
+		task_shm_clist_lock(task);
+		if (list_empty(&task->sysvshm.shm_clist)) {
+			task_shm_clist_unlock(task);
+			break;
+		}
 
-		printk("exit_shm() %px refcnt=%u, id=%d,key=%x\n", shp,
-			refcount_read(&shp->shm_perm.refcount),
-			shp->shm_perm.id, shp->shm_perm.key
-		);
+		shp = list_first_entry(&task->sysvshm.shm_clist, struct shmid_kernel,
+				shm_clist);
+
+		/* 1) unlink */
+		list_del_init(&shp->shm_clist);
+		WRITE_ONCE(shp->shm_creator, NULL);
 
 		/*
-		 * Will destroy all already created segments, that were not yet mapped,
-		 * and mark any mapped as orphan to cover the sysctl toggling.
-		 * Destroy is skipped if shm_may_destroy() returns false.
+		 * 2) get a reference to the namespace.
+		 *    The refcount could be already 0. If it is 0, then
+		 *    the shm objects will be free by free_ipc_work().
 		 */
-		if (shp->ns->shm_rmid_forced && shm_may_destroy(shp)) {
+		ns = shp->ns;
+pr_info("exit_shm: called for task %px, current %px, processing shp %px, ns %px\n", task, current, shp, ns);
+
+		ns = get_ipc_ns_not_zero(ns);
+		if (ns) {
 			/*
-			 * We may race with shm_exit_ns() if refcounter
-			 * already zero. Let's skip shm_destroy() of such
-			 * shm object as it will be destroyed during shm_exit_ns()
+			 * 3) get a reference to the shp itself.
+			 *   This cannot fail: shm_clist_rm() is called before
+			 *   ipc_rmid(), thus the refcount cannot be 0.
 			 */
-			if (!refcount_inc_not_zero(&ns->ns.count)) /* get_ipc_ns */
-				continue;
-
-			list_add(&shp->shm_clist, &tmp);
+			ipc_rcu_getref(&shp->shm_perm);
+		}
+		task_shm_clist_unlock(task);
+
+		if (ns) {
+			down_write(&shm_ids(ns).rwsem);
+			shm_lock_by_ptr(shp);
+			ipc_rcu_putref(&shp->shm_perm, shm_rcu_free);
+
+			if (ipc_valid_object(&shp->shm_perm)) {
+				if (shm_may_destroy(shp))
+					shm_destroy(ns, shp);
+				else
+					shm_unlock(shp);
+			} else {
+				/*
+				 * Someone else deleted the shp while we have waited.
+				 * Just unlock and continue.
+				 */
+				shm_unlock(shp);
+			}
+			up_write(&shm_ids(ns).rwsem);
+			put_ipc_ns(ns);
 		}
-	}
-
-	list_del(&task->sysvshm.shm_clist);
-	task_shm_clist_unlock(task);
-	rcu_read_unlock();
-
-	list_for_each_entry_safe(shp, n, &tmp, shm_clist) {
-		struct ipc_namespace *ns = shp->ns;
-
-		list_del_init(&shp->shm_clist);
-
-		down_write(&shm_ids(ns).rwsem);
-		shm_lock_by_ptr(shp);
-		/* will do put_ipc_ns(shp->ns) */
-		shm_destroy(ns, shp);
-		up_write(&shm_ids(ns).rwsem);
-		put_ipc_ns(ns); /* see refcount_inc_not_zero */
 	}
 }
 
@@ -566,6 +594,8 @@ static int shm_release(struct inode *ino, struct file *file)
 {
 	struct shm_file_data *sfd = shm_file_data(file);
 
+pr_info("shm_release for current %px.\n", current);
+
 	put_ipc_ns(sfd->ns);
 	fput(sfd->file);
 	shm_file_data(file) = NULL;
@@ -731,9 +761,21 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	if (error < 0)
 		goto no_id;
 
-	list_add(&shp->shm_clist, &current->sysvshm.shm_clist);
 	shp->ns = ns;
 
+	task_shm_clist_lock(current);
+	list_add(&shp->shm_clist, &current->sysvshm.shm_clist);
+
+pr_info("newseg: current %px, namespace %px, shp %px.\n", current, ns, shp);
+	{
+		struct shmid_kernel *shp;
+
+		list_for_each_entry(shp, &current->sysvshm.shm_clist, shm_clist) {
+pr_info("newseg: current %px, list entry %px.\n", current, shp);
+		}
+	}
+	task_shm_clist_unlock(current);
+ 
 	/*
 	 * shmid gets reported as "inode#" in /proc/pid/maps.
 	 * proc-ps tools use this. Changing this will break them.
-- 
2.31.1


--------------E806D47D8E247ABC3FEA7CB2--
