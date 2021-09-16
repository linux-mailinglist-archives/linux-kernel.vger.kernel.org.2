Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61840D167
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 03:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhIPBuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 21:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhIPBux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:50:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 18:49:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so5183062pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 18:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=f0/QK1o+gvWxtxoAUGedYxwXsOT74fLZOER0gJzWwz8=;
        b=XOpjAHfBjNzWBHVgn8O4OXdsy3YYTkI9Q06UiblClszE7sQQrSO900ZGW6bChlDNI3
         Hn7pAAjkGdKfr3E6QEr5LnxlPHEzRG/fD3GHjTvl4P/WB3txGrddXrlpuDAf/Rzj/wk0
         Puj3mWNQjD2bT+kgq+PD38+68m2szNu37/4G6So8FgOjH6O8Rubx7I/XoI88cTTpV0RT
         Vt7d8nj30gNpCQEpTnhTmi0s3hFxGb1BRV1flqnvpscG6Ph/A5md+dLpI5LvnTqxCQwS
         kOtxTNS0cSLdHQ4FlyfUrqjsah2adaaIvWj42eqymBv9474aQYhX6XFIE2PzK9MrKVn5
         45/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=f0/QK1o+gvWxtxoAUGedYxwXsOT74fLZOER0gJzWwz8=;
        b=Uj1Z8wdfmclitbCV1wEYhaoZq7WLkCop4KqQOZkO8DjKE+oAb4wWEGkb00Ydo6ddWc
         cvO3kn04n4SjNmKE2FDDQlkAl2gBTR/a8iqTyXJWSWwHq33wTE+FiRtAy/FfIh1D8S+O
         XJo9/FUzGpWlkh1dfteYgy7i69FK/D8xqAvnPMQOF7iiwqF36SjpCIRJz/vMwUnyrwO3
         0VN6Fa8H7hm2kjR8bL15iPW7Ykw7h3kV5oJ5zUwelzjiu0qk4F81kHL88fPPeszS9AFD
         4UoY9/mgvW66YvAEHCogqgXgd34iID4pwlqe5GMr+QeLMqz15Vp4k5uHxISdmFJbPMt8
         T/sw==
X-Gm-Message-State: AOAM533kNDWL0OJ9DGODVIWqxztFrsM0Ec4Ngf8wL67hFVxsJLdKnIlU
        AYSTwogtppx8yD4VJvBibfs=
X-Google-Smtp-Source: ABdhPJwJ0r/oJd5lZL4IwFPC9NLT97RDSvE3wn03ji05+avpgHv8N2jaCox0xDfVq6bWoUZaBDDgOA==
X-Received: by 2002:a17:90b:80a:: with SMTP id bk10mr2978516pjb.127.1631756973318;
        Wed, 15 Sep 2021 18:49:33 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a15sm1167384pgn.25.2021.09.15.18.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 18:49:32 -0700 (PDT)
Message-ID: <6142a2ac.1c69fb81.6dcc6.61f8@mx.google.com>
X-Google-Original-Message-ID: <20210916014931.GA180558@cgel.zte@gmail.com>
Date:   Thu, 16 Sep 2021 01:49:31 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dbueso@suse.de, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: Re: [PATCH V2] ipc: add set_ownership() and permissions() callbacks
 for posix mqueue sysctl
References: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
 <20210827101206.5810-1-ran.xiaokai@zte.com.cn>
 <20210913144047.4v5jquhyysnnlfvh@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913144047.4v5jquhyysnnlfvh@wittgenstein>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

esOn Mon, Sep 13, 2021 at 04:40:47PM +0200, Christian Brauner wrote:
> On Fri, Aug 27, 2021 at 03:12:06AM -0700, CGEL wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > 
> > When a non-root user process creates a user namespace and ipc namespace
> > with command "unshare -Ur -i", and map the root user inside
> > the user namesapce to the global owner of user namespace.
> > The newly created user namespace OWNS the ipc namespace,
> > So the root user inside the user namespace should have full access
> > rights to the ipc namespace resources and should be writable to
> > the ipc mqueue sysctls.
> > 
> > v2:
> >   - update commit msg.
> >   - fix the coding style issue.
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
> 
> David,
> 
> are you happy with this too? If so I'd pick this up.
> 

Hi Christian,

Is there a xx-next branch for this kind patch?
We will try to fixes other issues like this, so we could tag the follow-up
patches with the branch name.

> >  include/linux/ipc_namespace.h |  14 +++++
> >  ipc/mq_sysctl.c               | 118 ++++++++++++++++++++++++++++++++++++------
> >  ipc/mqueue.c                  |  10 +++-
> >  ipc/namespace.c               |   2 +
> >  4 files changed, 126 insertions(+), 18 deletions(-)
> > 
> > diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> > index 05e2277..3e8e340 100644
> > --- a/include/linux/ipc_namespace.h
> > +++ b/include/linux/ipc_namespace.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/ns_common.h>
> >  #include <linux/refcount.h>
> >  #include <linux/rhashtable-types.h>
> > +#include <linux/sysctl.h>
> >  
> >  struct user_namespace;
> >  
> > @@ -67,6 +68,11 @@ struct ipc_namespace {
> >  	struct user_namespace *user_ns;
> >  	struct ucounts *ucounts;
> >  
> > +#ifdef CONFIG_POSIX_MQUEUE_SYSCTL
> > +	struct ctl_table_set	mq_set;
> > +	struct ctl_table_header	*sysctls;
> > +#endif
> > +
> >  	struct llist_node mnt_llist;
> >  
> >  	struct ns_common ns;
> > @@ -155,7 +161,10 @@ static inline void put_ipc_ns(struct ipc_namespace *ns)
> >  #ifdef CONFIG_POSIX_MQUEUE_SYSCTL
> >  
> >  struct ctl_table_header;
> > +extern struct ctl_table_header *mq_sysctl_table;
> >  extern struct ctl_table_header *mq_register_sysctl_table(void);
> > +bool setup_mq_sysctls(struct ipc_namespace *ns);
> > +void retire_mq_sysctls(struct ipc_namespace *ns);
> >  
> >  #else /* CONFIG_POSIX_MQUEUE_SYSCTL */
> >  
> > @@ -163,6 +172,11 @@ static inline struct ctl_table_header *mq_register_sysctl_table(void)
> >  {
> >  	return NULL;
> >  }
> > +static inline bool setup_mq_sysctls(struct ipc_namespace *ns)
> > +{
> > +	return true;
> > +}
> > +static inline void retire_mq_sysctls(struct ipc_namespace *ns) { }
> >  
> >  #endif /* CONFIG_POSIX_MQUEUE_SYSCTL */
> >  #endif
> > diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
> > index 72a92a0..8d6b8ff 100644
> > --- a/ipc/mq_sysctl.c
> > +++ b/ipc/mq_sysctl.c
> > @@ -8,6 +8,11 @@
> >  #include <linux/nsproxy.h>
> >  #include <linux/ipc_namespace.h>
> >  #include <linux/sysctl.h>
> > +#include <linux/slab.h>
> > +#include <linux/user_namespace.h>
> > +#include <linux/capability.h>
> > +#include <linux/cred.h>
> > +#include <linux/stat.h>
> >  
> >  #ifdef CONFIG_PROC_SYSCTL
> >  static void *get_mq(struct ctl_table *table)
> > @@ -96,25 +101,106 @@ static struct ctl_table mq_sysctls[] = {
> >  	{}
> >  };
> >  
> > -static struct ctl_table mq_sysctl_dir[] = {
> > -	{
> > -		.procname	= "mqueue",
> > -		.mode		= 0555,
> > -		.child		= mq_sysctls,
> > -	},
> > -	{}
> > -};
> > +static int set_is_seen(struct ctl_table_set *set)
> > +{
> > +	return &current->nsproxy->ipc_ns->mq_set == set;
> > +}
> >  
> > -static struct ctl_table mq_sysctl_root[] = {
> > -	{
> > -		.procname	= "fs",
> > -		.mode		= 0555,
> > -		.child		= mq_sysctl_dir,
> > -	},
> > -	{}
> > +static struct ctl_table_set *
> > +set_lookup(struct ctl_table_root *root)
> > +{
> > +	return &current->nsproxy->ipc_ns->mq_set;
> > +}
> > +
> > +static int set_permissions(struct ctl_table_header *head,
> > +				struct ctl_table *table)
> > +{
> > +	struct ipc_namespace *ipc_ns =
> > +		container_of(head->set, struct ipc_namespace, mq_set);
> > +	struct user_namespace *user_ns = ipc_ns->user_ns;
> > +	int mode;
> > +
> > +	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
> > +	if (ns_capable(user_ns, CAP_SYS_RESOURCE))
> > +		mode = (table->mode & S_IRWXU) >> 6;
> > +	else {
> > +		/* Allow all others at most read-only access */
> > +		mode = table->mode & S_IROTH;
> > +	}
> > +
> > +	return (mode << 6) | (mode << 3) | mode;
> > +}
> > +
> > +static void set_ownership(struct ctl_table_header *head,
> > +				struct ctl_table *table,
> > +				kuid_t *uid, kgid_t *gid)
> > +{
> > +	struct ipc_namespace *ipc_ns =
> > +		container_of(head->set, struct ipc_namespace, mq_set);
> > +	struct user_namespace *user_ns = ipc_ns->user_ns;
> > +	kuid_t ns_root_uid;
> > +	kgid_t ns_root_gid;
> > +
> > +	ns_root_uid = make_kuid(user_ns, 0);
> > +	if (uid_valid(ns_root_uid))
> > +		*uid = ns_root_uid;
> > +
> > +	ns_root_gid = make_kgid(user_ns, 0);
> > +	if (gid_valid(ns_root_gid))
> > +		*gid = ns_root_gid;
> > +}
> > +
> > +static struct ctl_table_root mq_sysctl_root = {
> > +	.lookup = set_lookup,
> > +	.permissions = set_permissions,
> > +	.set_ownership = set_ownership,
> >  };
> >  
> > +bool setup_mq_sysctls(struct ipc_namespace *ns)
> > +{
> > +	struct ctl_table *tbl;
> > +
> > +	if (!mq_sysctl_table)
> > +		return false;
> > +
> > +	setup_sysctl_set(&ns->mq_set, &mq_sysctl_root, set_is_seen);
> > +	tbl = kmemdup(mq_sysctls, sizeof(mq_sysctls), GFP_KERNEL);
> > +	if (!tbl)
> > +		goto out;
> > +
> > +	ns->sysctls = __register_sysctl_table(&ns->mq_set, "fs/mqueue", tbl);
> > +	if (!ns->sysctls)
> > +		goto out1;
> > +
> > +	return true;
> > +
> > +out1:
> > +	kfree(tbl);
> > +	retire_sysctl_set(&ns->mq_set);
> > +out:
> > +	return false;
> > +}
> > +
> > +void retire_mq_sysctls(struct ipc_namespace *ns)
> > +{
> > +	struct ctl_table *tbl;
> > +
> > +	if (!ns->sysctls)
> > +		return;
> > +
> > +	tbl = ns->sysctls->ctl_table_arg;
> > +	unregister_sysctl_table(ns->sysctls);
> > +	retire_sysctl_set(&ns->mq_set);
> > +	kfree(tbl);
> > +}
> > +
> >  struct ctl_table_header *mq_register_sysctl_table(void)
> >  {
> > -	return register_sysctl_table(mq_sysctl_root);
> > +	static struct ctl_table empty[1];
> > +
> > +	/*
> > +	 * Register the fs/mqueue directory in the default set so that
> > +	 * registrations in the child sets work properly.
> > +	 */
> > +	return register_sysctl("fs/mqueue", empty);
> >  }
> > diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> > index 4e4e611..3b68564 100644
> > --- a/ipc/mqueue.c
> > +++ b/ipc/mqueue.c
> > @@ -163,7 +163,7 @@ static void remove_notification(struct mqueue_inode_info *info);
> >  
> >  static struct kmem_cache *mqueue_inode_cachep;
> >  
> > -static struct ctl_table_header *mq_sysctl_table;
> > +struct ctl_table_header *mq_sysctl_table;
> >  
> >  static inline struct mqueue_inode_info *MQUEUE_I(struct inode *inode)
> >  {
> > @@ -1713,6 +1713,10 @@ static int __init init_mqueue_fs(void)
> >  
> >  	/* ignore failures - they are not fatal */
> >  	mq_sysctl_table = mq_register_sysctl_table();
> > +	if (mq_sysctl_table && !setup_mq_sysctls(&init_ipc_ns)) {
> > +		unregister_sysctl_table(mq_sysctl_table);
> > +		mq_sysctl_table = NULL;
> > +	}
> >  
> >  	error = register_filesystem(&mqueue_fs_type);
> >  	if (error)
> > @@ -1729,8 +1733,10 @@ static int __init init_mqueue_fs(void)
> >  out_filesystem:
> >  	unregister_filesystem(&mqueue_fs_type);
> >  out_sysctl:
> > -	if (mq_sysctl_table)
> > +	if (mq_sysctl_table) {
> > +		retire_mq_sysctls(&init_ipc_ns);
> >  		unregister_sysctl_table(mq_sysctl_table);
> > +	}
> >  	kmem_cache_destroy(mqueue_inode_cachep);
> >  	return error;
> >  }
> > diff --git a/ipc/namespace.c b/ipc/namespace.c
> > index 7bd0766..c891cc1 100644
> > --- a/ipc/namespace.c
> > +++ b/ipc/namespace.c
> > @@ -58,6 +58,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
> >  	err = mq_init_ns(ns);
> >  	if (err)
> >  		goto fail_put;
> > +	setup_mq_sysctls(ns);
> >  
> >  	sem_init_ns(ns);
> >  	msg_init_ns(ns);
> > @@ -121,6 +122,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
> >  	 * uses synchronize_rcu().
> >  	 */
> >  	mq_put_mnt(ns);
> > +	retire_mq_sysctls(ns);
> >  	sem_exit_ns(ns);
> >  	msg_exit_ns(ns);
> >  	shm_exit_ns(ns);
> > -- 
> > 2.15.2
> > 
