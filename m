Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A243D08F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhGUFwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 01:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhGUFwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:52:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9472C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 23:32:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u1so913531wrs.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 23:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K4/tTyAim94SuiBGH2WxK1Hy6RGoM/ycqbm/orSpsqU=;
        b=U8A8mTypzSqhR7WPZiVhoRMIuPbHOKJd9q5fJc7X1pfGMwOQKOmZQUKG8AhQg0Ux4a
         5vZKTVpla37mq20T8HyQbJP5vwiCdvM1REH08CXZHhVqoEodRg3DrbzDyCWrdhbsPWrU
         7JCLRbaCoQVtFlLHX8b8aiCgciGBtrb465z+Lbb/Xr5ndVCKKbHXeR8Dl68rxXwJ4HB2
         SNOC3cYczDXUDGsECCFoDpILkO9ZFsR7q1HHtCP9JS/ZK+dUw6gdg9CgGFpYmTAE/Vu2
         FgDWVInyGee3xkVYkkjchTQY2AvE+wMJMS3dtvSLEBJWu0OVKXKw7ss9cnXw9Ig3xh50
         pKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K4/tTyAim94SuiBGH2WxK1Hy6RGoM/ycqbm/orSpsqU=;
        b=TjWAr4HUmVmA16RS6KaQHbAdd7vkhHgIMuncsc4ylVz5WlSiONGlMV8hUJPVJF+nUQ
         /DFgFweOHcWmsUWhQCXu0nhZV8ltiDExyhZt4GSL5LSsDonVSMtBN8z7z/9tLvh8YlZq
         UFnSQFRfteVIso/xsTWDG02IOO2PyazVg24rIf9kV7RzaE2vI4SKWpyBSBJe7a3PDtuh
         Ttx56AgkyPmRPrQhOutcKlSwO7RFAYV0DXp1LcCqkXjmlv9exmD2VioLVLZBFUg+MN14
         FY9I9dZs/MRgbb2ACwnZaUWepLo4Pn0yexza6I5GhdJootf59TH0DVifTKHVbSuaPBaF
         O0qA==
X-Gm-Message-State: AOAM530HdMXTgpEQ3k9Kq4g9+FfflYn0/ReEWLqHMdXLJnUm93zeMBWT
        T575gXk/no5z0PAP5ayq12Tf9A==
X-Google-Smtp-Source: ABdhPJxVZr/c5rpa434wyKQk1k5tuAF08SGAATZdtTokvxIGOGWD9+g1cX+7mvFuCxsF5gkwKt1AXQ==
X-Received: by 2002:adf:a54b:: with SMTP id j11mr41057475wrb.305.1626849164354;
        Tue, 20 Jul 2021 23:32:44 -0700 (PDT)
Received: from localhost.localdomain (p200300d997077700cd9afa019fa87b05.dip0.t-ipconnect.de. [2003:d9:9707:7700:cd9a:fa01:9fa8:7b05])
        by smtp.googlemail.com with ESMTPSA id z4sm12074358wrv.40.2021.07.20.23.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 23:32:43 -0700 (PDT)
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
        Alexander Mikhalitsyn <alexander@mihalicyn.com>, 1vier1@web.de
References: <CAJqdLrov0VBzHamSvMRKBHSJX+NROUx0TUsRD9U0zEWUn5XxDA@mail.gmail.com>
 <20210714173005.491941-1-alexander.mikhalitsyn@virtuozzo.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <8575f01e-049a-b54e-352f-d0fbaac9b1d1@colorfullife.com>
Date:   Wed, 21 Jul 2021 08:32:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714173005.491941-1-alexander.mikhalitsyn@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 7/14/21 7:30 PM, Alexander Mikhalitsyn wrote:
> This is total rework of fix.
> Thanks to Eric Biederman for suggestions (but may be I've misunderstood some of them :))
>
> I've tested it with reproducer of the original problem. But of course it needs
> detailed testing. I hope that I get some general comments about design and implementation.
>
> ToDo: remove unneeded "ns" argument from shm_destroy, shm_rmid and other functions.
>
> Fixes: ab602f79915 ("shm: make exit_shm work proportional to task activity")
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
> ---
>   include/linux/shm.h |   5 +-
>   ipc/shm.c           | 128 +++++++++++++++++++++++++++++++-------------
>   2 files changed, 95 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/shm.h b/include/linux/shm.h
> index d8e69aed3d32..8053ed1433df 100644
> --- a/include/linux/shm.h
> +++ b/include/linux/shm.h
> @@ -11,14 +11,15 @@ struct file;
>   
>   #ifdef CONFIG_SYSVIPC
>   struct sysv_shm {
> -	struct list_head shm_clist;
> +	spinlock_t		shm_clist_lock;
> +	struct list_head	shm_clist;
>   };
>   

Can we use task_lock() instead of adding a spinlock to struct task_struct?

And: please document the lock nesting.

If I see it right:

- ns namespace rwsem

- shm_perm.lock

- the new shm_clist_lock


>   long do_shmat(int shmid, char __user *shmaddr, int shmflg, unsigned long *addr,
>   	      unsigned long shmlba);
>   bool is_file_shm_hugepages(struct file *file);
>   void exit_shm(struct task_struct *task);
> -#define shm_init_task(task) INIT_LIST_HEAD(&(task)->sysvshm.shm_clist)
> +void shm_init_task(struct task_struct *task);
>   #else
>   struct sysv_shm {
>   	/* empty */
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 748933e376ca..a746886a0e00 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -65,6 +65,7 @@ struct shmid_kernel /* private to the kernel */
>   	/* The task created the shm object.  NULL if the task is dead. */
>   	struct task_struct	*shm_creator;
>   	struct list_head	shm_clist;	/* list by creator */
> +	struct ipc_namespace	*ns;
>   } __randomize_layout;
>   
>   /* shm_mode upper byte flags */
> @@ -115,6 +116,7 @@ static void do_shm_rmid(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
>   	struct shmid_kernel *shp;
>   
>   	shp = container_of(ipcp, struct shmid_kernel, shm_perm);
> +	BUG_ON(shp->ns && ns != shp->ns);
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

I see that you didn't write this comment, but is "not yet" correct?

i.e. if a segment is created, mapped, unmapped, then would it be a 
candidate for getting destroyed?


> +		if (shp->ns->shm_rmid_forced && shm_may_destroy(shp)) {
> +			/*
> +			 * We may race with shm_exit_ns() if refcounter
> +			 * already zero. Let's skip shm_destroy() of such
> +			 * shm object as it will be destroyed during shm_exit_ns()
> +			 */
> +			if (!refcount_inc_not_zero(&ns->ns.count)) /* get_ipc_ns */
> +				continue;
> +

get_ipc_ns() means "copy/pasted from get_ipc_ns()", correct?

This asks for trouble, I would  prefer if a get_ipc_ns_not_zero() is 
added into ipc_namespace.h.


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

What if someone attaches between shm_may_destroy() and this shm_destroy()?

The other callers seem to do down_write(rwsem); if (shm_may_destroy()) 
shm_destroy();


> +		up_write(&shm_ids(ns).rwsem);
> +		put_ipc_ns(ns); /* see refcount_inc_not_zero */
> +	}
>   }
>   
>   static vm_fault_t shm_fault(struct vm_fault *vmf)
> @@ -681,6 +732,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>   		goto no_id;
>   
>   	list_add(&shp->shm_clist, &current->sysvshm.shm_clist);
> +	shp->ns = ns;
>   
>   	/*
>   	 * shmid gets reported as "inode#" in /proc/pid/maps.
> @@ -1573,7 +1625,11 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
>   	down_write(&shm_ids(ns).rwsem);
>   	shp = shm_lock(ns, shmid);
>   	shp->shm_nattch--;
> -	if (shm_may_destroy(ns, shp))
> +#if 0
> +	if (shp->shm_nattch)
> +		list_del_init(&shp->shm_clist);
> +#endif
What is the purpose of this change?


And I think after ipc_addid(), task_shm_clist_lock() is missing.

>        /* ipc_addid() locks shp upon success. */
>         error = ipc_addid(&shm_ids(ns), &shp->shm_perm, ns->shm_ctlmni);
>         if (error < 0)
>                 goto no_id;
>
+ task_shm_clist_lock(task);

>         list_add(&shp->shm_clist, &current->sysvshm.shm_clist);
+ task_shm_clist_unlock(task);

>         shp->ns = ns;

I think locking is needed here, otherwise a parallel IPC_RMID on an 
unrelated segment could corrupt shm_clist


--

     Manfred

