Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7445ED21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376806AbhKZMAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:00:02 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:24638 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349006AbhKZL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:58:01 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211126115447euoutp01bdf3d04fa9ff0955547dd100e4d1f5c1~7Fo2o-gBb0595105951euoutp012
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:54:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211126115447euoutp01bdf3d04fa9ff0955547dd100e4d1f5c1~7Fo2o-gBb0595105951euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637927687;
        bh=FcgJbwZalDc1jhUWc/nDu0zu5FGTz+abHABrzEleX3Y=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=MO/2qOrJ8ylaTaqo7ZPc6dNm3FBxzccPZQmlbvOS9xV1kUwnhuJen784GQ6ILq9sE
         i86//FJLsfk9kYwhvc8m1EOf48DgTMXUahMICOznjKoesZ1TPihTKM/IAYaacnaGFW
         WvjV2PQyiFWvR7w+NtTBxEj922/ZEA4osmB7vStk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211126115447eucas1p1ab4cef45dc4c08641bbda20385d5e658~7Fo2gqLNj0506505065eucas1p1t;
        Fri, 26 Nov 2021 11:54:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 93.62.10009.60BC0A16; Fri, 26
        Nov 2021 11:54:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211126115446eucas1p2e377cf7718c6da6bfe40a016bc0191a8~7Fo195wQ30523705237eucas1p2I;
        Fri, 26 Nov 2021 11:54:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211126115446eusmtrp19bd5f401394e14ec9dd08f4b36c974e6~7Fo18JjTZ2346223462eusmtrp1-;
        Fri, 26 Nov 2021 11:54:46 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-3e-61a0cb06b69a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.02.09404.60BC0A16; Fri, 26
        Nov 2021 11:54:46 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211126115446eusmtip1433e90b77fa24138f9557ed8fd423bc5~7Fo1j-OXc2989629896eusmtip1h;
        Fri, 26 Nov 2021 11:54:45 +0000 (GMT)
Message-ID: <a7464856-486a-a76a-937c-35a426555507@samsung.com>
Date:   Fri, 26 Nov 2021 12:54:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] kernfs: switch global kernfs_rwsem lock to per-fs lock
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20211118230008.2679780-1-minchan@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzneV220wsSDSY+MbNoXryezeLyrjls
        Fsu+vme3+LX8KKMDi8emVZ1sHvvnrmH3+LxJLoA5issmJTUnsyy1SN8ugSvjwvZjbAWtmxkr
        ml/6NTCu6GPsYuTkkBAwkXi6azc7iC0ksIJR4sFexy5GLiD7C6PE0jcvGCGcz4wSuz79YILp
        WLftMAtEYjmjxN11V9ggnI+MEifb/4PN5RWwk9jxZRcbiM0ioCrx89pVNoi4oMTJmU9YQGxR
        gSSJCSd2g00VFvCW2HbhN1icWUBc4taT+WBxEYEiiV+7LzNBxNUltu27wgpiswkYSnS97QKb
        ySlgJfHp2jJWiBp5ieats5lBDpIQ2MEh8e5qO9TZLhLbVi5lh7CFJV4d3wJly0icntzDAtHQ
        zCjx8Nxadginh1HictMMaDBZS9w59wtoHQfQCk2J9bv0IcKOEk/+zGECCUsI8EnceCsIcQSf
        xKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkIJlFpL3ZyF5ZxbC3gWMLKsYxVNLi3PT
        U4sN81LL9YoTc4tL89L1kvNzNzECk8rpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrzOgfMThXhT
        EiurUovy44tKc1KLDzFKc7AoifOK/GlIFBJITyxJzU5NLUgtgskycXBKNTC5aX+bkJrGrzLz
        UuNurhi/2dd/TwnU4zSeGHf68et5hn0PC/8wXE0NfV6SZLmOS77cTdy1Zlkl3xpV+YdibVwb
        nsw5I9CbbcXbfnj1gTC9WTrKYV82G39WvrHASLJn0qEnIjXW/OwrX0qtEl6y4JRwUmnN1fZH
        PSxSYa5H9XM35n+Ur3a3n1Lm8Sh8mq77sqLD9aXa3I95D9Xzd7D9zL1W7nojZFZdIesKrn+F
        G/+9SpCsmrD22Za4gK8aTRcXVmms/XgkZ73wljS2uPWyrg+PN+14y5fS8zx12c2HUsrS1Ve+
        hHPILTNJznvC96Mqb6pCx/3ivT4P+PqbTz/I2fhktuHlzb+3LGdua2BfyajEUpyRaKjFXFSc
        CABIcjFemQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7pspxckGqxYJWzRvHg9m8XlXXPY
        LJZ9fc9u8Wv5UUYHFo9NqzrZPPbPXcPu8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Ghe3H2ApaNzNWNL/0a2Bc0cfYxcjJISFgIrFu
        22GWLkYuDiGBpYwSM1afY4FIyEicnNbACmELS/y51sUGUfSeUeLGhS/MIAleATuJHV92sYHY
        LAKqEj+vXWWDiAtKnJz5BGyQqECSxNMDnWBxYQFviW0XfoPFmQXEJW49mc8EYosIFElc27OP
        GSKuLrFt3xWwxUIClhK3jjaB9bIJGEp0ve0CszkFrCQ+XVvGClFvJtG1tYsRwpaXaN46m3kC
        o9AsJGfMQrJuFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMom3Hfm7Zwbjy
        1Ue9Q4xMHIyHGCU4mJVEeJ0D5ycK8aYkVlalFuXHF5XmpBYfYjQFhsVEZinR5HxgHOeVxBua
        GZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAVtMb27D95We3LlEdqPv0n
        JuzduyzZV09rYeJBlu439dwViU5W3psbrr2YO/XMCUb/3VeYnKrKPyeeXzjNQ0i0YK1HX/yq
        2/dNTA8XWbtXXV1lybrf3mLPrPzzKk2Lp2i8KhFcvm2lG6+9yqpJf9Une/Foci1zD5OfcyTC
        QOzLC6eMrmWLUm6I/Ao53mQ040dg9btFEossYhUrnx4+VZSWzLPiBtv3/47fjyh8dPbKm7Te
        P+1kxs+wVc49sbM7Cu++7Ty7oNnszG2TzIlqDGeOzfmXcFx8y6vbrHP4luz2Dvif/EnuyHmH
        x/+7H3SYHO2aMa8k+/36Ag2BP8skQpsL030X/y3lUpRuavgh/0tdiaU4I9FQi7moOBEAX/qY
        PisDAAA=
X-CMS-MailID: 20211126115446eucas1p2e377cf7718c6da6bfe40a016bc0191a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211126115446eucas1p2e377cf7718c6da6bfe40a016bc0191a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211126115446eucas1p2e377cf7718c6da6bfe40a016bc0191a8
References: <20211118230008.2679780-1-minchan@kernel.org>
        <CGME20211126115446eucas1p2e377cf7718c6da6bfe40a016bc0191a8@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19.11.2021 00:00, Minchan Kim wrote:
> The kernfs implementation has big lock granularity(kernfs_rwsem) so
> every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
> lock. It makes trouble for some cases to wait the global lock
> for a long time even though they are totally independent contexts
> each other.
>
> A general example is process A goes under direct reclaim with holding
> the lock when it accessed the file in sysfs and process B is waiting
> the lock with exclusive mode and then process C is waiting the lock
> until process B could finish the job after it gets the lock from
> process A.
>
> This patch switches the global kernfs_rwsem to per-fs lock, which
> put the rwsem into kernfs_root.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

This patch landed recently in linux-next (20211126) as commit 
393c3714081a ("kernfs: switch global kernfs_rwsem lock to per-fs lock"). 
In my tests I've found that it causes the following warning during the 
system reboot:

  =========================
  WARNING: held lock freed!
  5.16.0-rc2+ #10984 Not tainted
  -------------------------
  kworker/1:0/18 is freeing memory ffff00004034e200-ffff00004034e3ff, 
with a lock still held there!
  ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at: 
__kernfs_remove+0x310/0x37c
  3 locks held by kworker/1:0/18:
   #0: ffff000040107938 ((wq_completion)cgroup_destroy){+.+.}-{0:0}, at: 
process_one_work+0x1f0/0x6f0
   #1: ffff80000b55bdc0 
((work_completion)(&(&css->destroy_rwork)->work)){+.+.}-{0:0}, at: 
process_one_work+0x1f0/0x6f0
   #2: ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at: 
__kernfs_remove+0x310/0x37c

  stack backtrace:
  CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 5.16.0-rc2+ #10984
  Hardware name: Raspberry Pi 4 Model B (DT)
  Workqueue: cgroup_destroy css_free_rwork_fn
  Call trace:
   dump_backtrace+0x0/0x1ac
   show_stack+0x18/0x24
   dump_stack_lvl+0x8c/0xb8
   dump_stack+0x18/0x34
   debug_check_no_locks_freed+0x124/0x140
   kfree+0xf0/0x3a4
   kernfs_put+0x1f8/0x224
   __kernfs_remove+0x1b8/0x37c
   kernfs_destroy_root+0x38/0x50
   css_free_rwork_fn+0x288/0x3d4
   process_one_work+0x288/0x6f0
   worker_thread+0x74/0x470
   kthread+0x188/0x194
   ret_from_fork+0x10/0x20

Let me know if you need more information or help in reproducing this issue.

> ---
> from RFC - https://lore.kernel.org/lkml/20211116194317.1430399-1-minchan@kernel.org/
>   * move kernfs_rwsem to kernfs_root - tejun@
>
>   fs/kernfs/dir.c        | 110 ++++++++++++++++++++++++-----------------
>   fs/kernfs/file.c       |   6 ++-
>   fs/kernfs/inode.c      |  22 ++++++---
>   fs/kernfs/mount.c      |  15 +++---
>   fs/kernfs/symlink.c    |   5 +-
>   include/linux/kernfs.h |   2 +
>   6 files changed, 97 insertions(+), 63 deletions(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 8e0a1378a4b1..13cae0ccce74 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -17,7 +17,6 @@
>   
>   #include "kernfs-internal.h"
>   
> -DECLARE_RWSEM(kernfs_rwsem);
>   static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
>   static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
>   static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
> @@ -26,7 +25,7 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
>   
>   static bool kernfs_active(struct kernfs_node *kn)
>   {
> -	lockdep_assert_held(&kernfs_rwsem);
> +	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
>   	return atomic_read(&kn->active) >= 0;
>   }
>   
> @@ -457,14 +456,15 @@ void kernfs_put_active(struct kernfs_node *kn)
>    * return after draining is complete.
>    */
>   static void kernfs_drain(struct kernfs_node *kn)
> -	__releases(&kernfs_rwsem) __acquires(&kernfs_rwsem)
> +	__releases(&kernfs_root(kn)->kernfs_rwsem)
> +	__acquires(&kernfs_root(kn)->kernfs_rwsem)
>   {
>   	struct kernfs_root *root = kernfs_root(kn);
>   
> -	lockdep_assert_held_write(&kernfs_rwsem);
> +	lockdep_assert_held_write(&root->kernfs_rwsem);
>   	WARN_ON_ONCE(kernfs_active(kn));
>   
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   
>   	if (kernfs_lockdep(kn)) {
>   		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
> @@ -483,7 +483,7 @@ static void kernfs_drain(struct kernfs_node *kn)
>   
>   	kernfs_drain_open_files(kn);
>   
> -	down_write(&kernfs_rwsem);
> +	down_write(&root->kernfs_rwsem);
>   }
>   
>   /**
> @@ -718,11 +718,12 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
>   int kernfs_add_one(struct kernfs_node *kn)
>   {
>   	struct kernfs_node *parent = kn->parent;
> +	struct kernfs_root *root = kernfs_root(parent);
>   	struct kernfs_iattrs *ps_iattr;
>   	bool has_ns;
>   	int ret;
>   
> -	down_write(&kernfs_rwsem);
> +	down_write(&root->kernfs_rwsem);
>   
>   	ret = -EINVAL;
>   	has_ns = kernfs_ns_enabled(parent);
> @@ -753,7 +754,7 @@ int kernfs_add_one(struct kernfs_node *kn)
>   		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>   	}
>   
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   
>   	/*
>   	 * Activate the new node unless CREATE_DEACTIVATED is requested.
> @@ -767,7 +768,7 @@ int kernfs_add_one(struct kernfs_node *kn)
>   	return 0;
>   
>   out_unlock:
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   	return ret;
>   }
>   
> @@ -788,7 +789,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
>   	bool has_ns = kernfs_ns_enabled(parent);
>   	unsigned int hash;
>   
> -	lockdep_assert_held(&kernfs_rwsem);
> +	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
>   
>   	if (has_ns != (bool)ns) {
>   		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
> @@ -820,7 +821,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
>   	size_t len;
>   	char *p, *name;
>   
> -	lockdep_assert_held_read(&kernfs_rwsem);
> +	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
>   
>   	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
>   	spin_lock_irq(&kernfs_rename_lock);
> @@ -859,11 +860,12 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
>   					   const char *name, const void *ns)
>   {
>   	struct kernfs_node *kn;
> +	struct kernfs_root *root = kernfs_root(parent);
>   
> -	down_read(&kernfs_rwsem);
> +	down_read(&root->kernfs_rwsem);
>   	kn = kernfs_find_ns(parent, name, ns);
>   	kernfs_get(kn);
> -	up_read(&kernfs_rwsem);
> +	up_read(&root->kernfs_rwsem);
>   
>   	return kn;
>   }
> @@ -883,11 +885,12 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
>   					   const char *path, const void *ns)
>   {
>   	struct kernfs_node *kn;
> +	struct kernfs_root *root = kernfs_root(parent);
>   
> -	down_read(&kernfs_rwsem);
> +	down_read(&root->kernfs_rwsem);
>   	kn = kernfs_walk_ns(parent, path, ns);
>   	kernfs_get(kn);
> -	up_read(&kernfs_rwsem);
> +	up_read(&root->kernfs_rwsem);
>   
>   	return kn;
>   }
> @@ -912,6 +915,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
>   		return ERR_PTR(-ENOMEM);
>   
>   	idr_init(&root->ino_idr);
> +	init_rwsem(&root->kernfs_rwsem);
>   	INIT_LIST_HEAD(&root->supers);
>   
>   	/*
> @@ -1035,6 +1039,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
>   static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>   {
>   	struct kernfs_node *kn;
> +	struct kernfs_root *root;
>   
>   	if (flags & LOOKUP_RCU)
>   		return -ECHILD;
> @@ -1046,18 +1051,19 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>   		/* If the kernfs parent node has changed discard and
>   		 * proceed to ->lookup.
>   		 */
> -		down_read(&kernfs_rwsem);
>   		spin_lock(&dentry->d_lock);
>   		parent = kernfs_dentry_node(dentry->d_parent);
>   		if (parent) {
> +			spin_unlock(&dentry->d_lock);
> +			root = kernfs_root(parent);
> +			down_read(&root->kernfs_rwsem);
>   			if (kernfs_dir_changed(parent, dentry)) {
> -				spin_unlock(&dentry->d_lock);
> -				up_read(&kernfs_rwsem);
> +				up_read(&root->kernfs_rwsem);
>   				return 0;
>   			}
> -		}
> -		spin_unlock(&dentry->d_lock);
> -		up_read(&kernfs_rwsem);
> +			up_read(&root->kernfs_rwsem);
> +		} else
> +			spin_unlock(&dentry->d_lock);
>   
>   		/* The kernfs parent node hasn't changed, leave the
>   		 * dentry negative and return success.
> @@ -1066,7 +1072,8 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>   	}
>   
>   	kn = kernfs_dentry_node(dentry);
> -	down_read(&kernfs_rwsem);
> +	root = kernfs_root(kn);
> +	down_read(&root->kernfs_rwsem);
>   
>   	/* The kernfs node has been deactivated */
>   	if (!kernfs_active(kn))
> @@ -1085,10 +1092,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>   	    kernfs_info(dentry->d_sb)->ns != kn->ns)
>   		goto out_bad;
>   
> -	up_read(&kernfs_rwsem);
> +	up_read(&root->kernfs_rwsem);
>   	return 1;
>   out_bad:
> -	up_read(&kernfs_rwsem);
> +	up_read(&root->kernfs_rwsem);
>   	return 0;
>   }
>   
> @@ -1102,10 +1109,12 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>   {
>   	struct kernfs_node *parent = dir->i_private;
>   	struct kernfs_node *kn;
> +	struct kernfs_root *root;
>   	struct inode *inode = NULL;
>   	const void *ns = NULL;
>   
> -	down_read(&kernfs_rwsem);
> +	root = kernfs_root(parent);
> +	down_read(&root->kernfs_rwsem);
>   	if (kernfs_ns_enabled(parent))
>   		ns = kernfs_info(dir->i_sb)->ns;
>   
> @@ -1116,7 +1125,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>   		 * create a negative.
>   		 */
>   		if (!kernfs_active(kn)) {
> -			up_read(&kernfs_rwsem);
> +			up_read(&root->kernfs_rwsem);
>   			return NULL;
>   		}
>   		inode = kernfs_get_inode(dir->i_sb, kn);
> @@ -1131,7 +1140,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>   	 */
>   	if (!IS_ERR(inode))
>   		kernfs_set_rev(parent, dentry);
> -	up_read(&kernfs_rwsem);
> +	up_read(&root->kernfs_rwsem);
>   
>   	/* instantiate and hash (possibly negative) dentry */
>   	return d_splice_alias(inode, dentry);
> @@ -1254,7 +1263,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
>   {
>   	struct rb_node *rbn;
>   
> -	lockdep_assert_held_write(&kernfs_rwsem);
> +	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
>   
>   	/* if first iteration, visit leftmost descendant which may be root */
>   	if (!pos)
> @@ -1289,8 +1298,9 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
>   void kernfs_activate(struct kernfs_node *kn)
>   {
>   	struct kernfs_node *pos;
> +	struct kernfs_root *root = kernfs_root(kn);
>   
> -	down_write(&kernfs_rwsem);
> +	down_write(&root->kernfs_rwsem);
>   
>   	pos = NULL;
>   	while ((pos = kernfs_next_descendant_post(pos, kn))) {
> @@ -1304,14 +1314,14 @@ void kernfs_activate(struct kernfs_node *kn)
>   		pos->flags |= KERNFS_ACTIVATED;
>   	}
>   
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   }
>   
>   static void __kernfs_remove(struct kernfs_node *kn)
>   {
>   	struct kernfs_node *pos;
>   
> -	lockdep_assert_held_write(&kernfs_rwsem);
> +	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
>   
>   	/*
>   	 * Short-circuit if non-root @kn has already finished removal.
> @@ -1381,9 +1391,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
>    */
>   void kernfs_remove(struct kernfs_node *kn)
>   {
> -	down_write(&kernfs_rwsem);
> +	struct kernfs_root *root = kernfs_root(kn);
> +
> +	down_write(&root->kernfs_rwsem);
>   	__kernfs_remove(kn);
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   }
>   
>   /**
> @@ -1469,8 +1481,9 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
>   bool kernfs_remove_self(struct kernfs_node *kn)
>   {
>   	bool ret;
> +	struct kernfs_root *root = kernfs_root(kn);
>   
> -	down_write(&kernfs_rwsem);
> +	down_write(&root->kernfs_rwsem);
>   	kernfs_break_active_protection(kn);
>   
>   	/*
> @@ -1498,9 +1511,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
>   			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
>   				break;
>   
> -			up_write(&kernfs_rwsem);
> +			up_write(&root->kernfs_rwsem);
>   			schedule();
> -			down_write(&kernfs_rwsem);
> +			down_write(&root->kernfs_rwsem);
>   		}
>   		finish_wait(waitq, &wait);
>   		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
> @@ -1513,7 +1526,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
>   	 */
>   	kernfs_unbreak_active_protection(kn);
>   
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   	return ret;
>   }
>   
> @@ -1530,6 +1543,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
>   			     const void *ns)
>   {
>   	struct kernfs_node *kn;
> +	struct kernfs_root *root;
>   
>   	if (!parent) {
>   		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
> @@ -1537,13 +1551,14 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
>   		return -ENOENT;
>   	}
>   
> -	down_write(&kernfs_rwsem);
> +	root = kernfs_root(parent);
> +	down_write(&root->kernfs_rwsem);
>   
>   	kn = kernfs_find_ns(parent, name, ns);
>   	if (kn)
>   		__kernfs_remove(kn);
>   
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   
>   	if (kn)
>   		return 0;
> @@ -1562,6 +1577,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
>   		     const char *new_name, const void *new_ns)
>   {
>   	struct kernfs_node *old_parent;
> +	struct kernfs_root *root;
>   	const char *old_name = NULL;
>   	int error;
>   
> @@ -1569,7 +1585,8 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
>   	if (!kn->parent)
>   		return -EINVAL;
>   
> -	down_write(&kernfs_rwsem);
> +	root = kernfs_root(kn);
> +	down_write(&root->kernfs_rwsem);
>   
>   	error = -ENOENT;
>   	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
> @@ -1623,7 +1640,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
>   
>   	error = 0;
>    out:
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   	return error;
>   }
>   
> @@ -1694,11 +1711,14 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
>   	struct dentry *dentry = file->f_path.dentry;
>   	struct kernfs_node *parent = kernfs_dentry_node(dentry);
>   	struct kernfs_node *pos = file->private_data;
> +	struct kernfs_root *root;
>   	const void *ns = NULL;
>   
>   	if (!dir_emit_dots(file, ctx))
>   		return 0;
> -	down_read(&kernfs_rwsem);
> +
> +	root = kernfs_root(parent);
> +	down_read(&root->kernfs_rwsem);
>   
>   	if (kernfs_ns_enabled(parent))
>   		ns = kernfs_info(dentry->d_sb)->ns;
> @@ -1715,12 +1735,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
>   		file->private_data = pos;
>   		kernfs_get(pos);
>   
> -		up_read(&kernfs_rwsem);
> +		up_read(&root->kernfs_rwsem);
>   		if (!dir_emit(ctx, name, len, ino, type))
>   			return 0;
> -		down_read(&kernfs_rwsem);
> +		down_read(&root->kernfs_rwsem);
>   	}
> -	up_read(&kernfs_rwsem);
> +	up_read(&root->kernfs_rwsem);
>   	file->private_data = NULL;
>   	ctx->pos = INT_MAX;
>   	return 0;
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 60e2a86c535e..9414a7a60a9f 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -847,6 +847,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>   {
>   	struct kernfs_node *kn;
>   	struct kernfs_super_info *info;
> +	struct kernfs_root *root;
>   repeat:
>   	/* pop one off the notify_list */
>   	spin_lock_irq(&kernfs_notify_lock);
> @@ -859,8 +860,9 @@ static void kernfs_notify_workfn(struct work_struct *work)
>   	kn->attr.notify_next = NULL;
>   	spin_unlock_irq(&kernfs_notify_lock);
>   
> +	root = kernfs_root(kn);
>   	/* kick fsnotify */
> -	down_write(&kernfs_rwsem);
> +	down_write(&root->kernfs_rwsem);
>   
>   	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
>   		struct kernfs_node *parent;
> @@ -898,7 +900,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>   		iput(inode);
>   	}
>   
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   	kernfs_put(kn);
>   	goto repeat;
>   }
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index c0eae1725435..3d783d80f5da 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -99,10 +99,11 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
>   int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
>   {
>   	int ret;
> +	struct kernfs_root *root = kernfs_root(kn);
>   
> -	down_write(&kernfs_rwsem);
> +	down_write(&root->kernfs_rwsem);
>   	ret = __kernfs_setattr(kn, iattr);
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   	return ret;
>   }
>   
> @@ -111,12 +112,14 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>   {
>   	struct inode *inode = d_inode(dentry);
>   	struct kernfs_node *kn = inode->i_private;
> +	struct kernfs_root *root;
>   	int error;
>   
>   	if (!kn)
>   		return -EINVAL;
>   
> -	down_write(&kernfs_rwsem);
> +	root = kernfs_root(kn);
> +	down_write(&root->kernfs_rwsem);
>   	error = setattr_prepare(&init_user_ns, dentry, iattr);
>   	if (error)
>   		goto out;
> @@ -129,7 +132,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>   	setattr_copy(&init_user_ns, inode, iattr);
>   
>   out:
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   	return error;
>   }
>   
> @@ -184,13 +187,14 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
>   {
>   	struct inode *inode = d_inode(path->dentry);
>   	struct kernfs_node *kn = inode->i_private;
> +	struct kernfs_root *root = kernfs_root(kn);
>   
> -	down_read(&kernfs_rwsem);
> +	down_read(&root->kernfs_rwsem);
>   	spin_lock(&inode->i_lock);
>   	kernfs_refresh_inode(kn, inode);
>   	generic_fillattr(&init_user_ns, inode, stat);
>   	spin_unlock(&inode->i_lock);
> -	up_read(&kernfs_rwsem);
> +	up_read(&root->kernfs_rwsem);
>   
>   	return 0;
>   }
> @@ -274,19 +278,21 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
>   			  struct inode *inode, int mask)
>   {
>   	struct kernfs_node *kn;
> +	struct kernfs_root *root;
>   	int ret;
>   
>   	if (mask & MAY_NOT_BLOCK)
>   		return -ECHILD;
>   
>   	kn = inode->i_private;
> +	root = kernfs_root(kn);
>   
> -	down_read(&kernfs_rwsem);
> +	down_read(&root->kernfs_rwsem);
>   	spin_lock(&inode->i_lock);
>   	kernfs_refresh_inode(kn, inode);
>   	ret = generic_permission(&init_user_ns, inode, mask);
>   	spin_unlock(&inode->i_lock);
> -	up_read(&kernfs_rwsem);
> +	up_read(&root->kernfs_rwsem);
>   
>   	return ret;
>   }
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index f2f909d09f52..cfa79715fc1a 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -236,6 +236,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
>   static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
>   {
>   	struct kernfs_super_info *info = kernfs_info(sb);
> +	struct kernfs_root *kf_root = kfc->root;
>   	struct inode *inode;
>   	struct dentry *root;
>   
> @@ -255,9 +256,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
>   	sb->s_shrink.seeks = 0;
>   
>   	/* get root inode, initialize and unlock it */
> -	down_read(&kernfs_rwsem);
> +	down_read(&kf_root->kernfs_rwsem);
>   	inode = kernfs_get_inode(sb, info->root->kn);
> -	up_read(&kernfs_rwsem);
> +	up_read(&kf_root->kernfs_rwsem);
>   	if (!inode) {
>   		pr_debug("kernfs: could not get root inode\n");
>   		return -ENOMEM;
> @@ -334,6 +335,7 @@ int kernfs_get_tree(struct fs_context *fc)
>   
>   	if (!sb->s_root) {
>   		struct kernfs_super_info *info = kernfs_info(sb);
> +		struct kernfs_root *root = kfc->root;
>   
>   		kfc->new_sb_created = true;
>   
> @@ -344,9 +346,9 @@ int kernfs_get_tree(struct fs_context *fc)
>   		}
>   		sb->s_flags |= SB_ACTIVE;
>   
> -		down_write(&kernfs_rwsem);
> +		down_write(&root->kernfs_rwsem);
>   		list_add(&info->node, &info->root->supers);
> -		up_write(&kernfs_rwsem);
> +		up_write(&root->kernfs_rwsem);
>   	}
>   
>   	fc->root = dget(sb->s_root);
> @@ -371,10 +373,11 @@ void kernfs_free_fs_context(struct fs_context *fc)
>   void kernfs_kill_sb(struct super_block *sb)
>   {
>   	struct kernfs_super_info *info = kernfs_info(sb);
> +	struct kernfs_root *root = info->root;
>   
> -	down_write(&kernfs_rwsem);
> +	down_write(&root->kernfs_rwsem);
>   	list_del(&info->node);
> -	up_write(&kernfs_rwsem);
> +	up_write(&root->kernfs_rwsem);
>   
>   	/*
>   	 * Remove the superblock from fs_supers/s_instances
> diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
> index 19a6c71c6ff5..0ab13824822f 100644
> --- a/fs/kernfs/symlink.c
> +++ b/fs/kernfs/symlink.c
> @@ -113,11 +113,12 @@ static int kernfs_getlink(struct inode *inode, char *path)
>   	struct kernfs_node *kn = inode->i_private;
>   	struct kernfs_node *parent = kn->parent;
>   	struct kernfs_node *target = kn->symlink.target_kn;
> +	struct kernfs_root *root = kernfs_root(parent);
>   	int error;
>   
> -	down_read(&kernfs_rwsem);
> +	down_read(&root->kernfs_rwsem);
>   	error = kernfs_get_target_path(parent, target, path);
> -	up_read(&kernfs_rwsem);
> +	up_read(&root->kernfs_rwsem);
>   
>   	return error;
>   }
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 3ccce6f24548..9f650986a81b 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -16,6 +16,7 @@
>   #include <linux/atomic.h>
>   #include <linux/uidgid.h>
>   #include <linux/wait.h>
> +#include <linux/rwsem.h>
>   
>   struct file;
>   struct dentry;
> @@ -197,6 +198,7 @@ struct kernfs_root {
>   	struct list_head	supers;
>   
>   	wait_queue_head_t	deactivate_waitq;
> +	struct rw_semaphore	kernfs_rwsem;
>   };
>   
>   struct kernfs_open_file {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

