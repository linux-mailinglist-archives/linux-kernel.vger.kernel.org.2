Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F33874E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbhERJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242530AbhERJSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:18:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2278C61042;
        Tue, 18 May 2021 09:16:47 +0000 (UTC)
Date:   Tue, 18 May 2021 11:16:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        dwalsh@redhat.com, ebiederm@xmission.com
Subject: Re: [RFC PATCH 1/3] setgroups: new mode 'shadow' for
 /proc/PID/setgroups
Message-ID: <20210518091645.ncozjfjo5s6nlykv@wittgenstein>
References: <20210510130011.1441834-1-gscrivan@redhat.com>
 <20210510130011.1441834-2-gscrivan@redhat.com>
 <20210515015157.GB2845@mail.hallyn.com>
 <87y2cdqyhj.fsf@redhat.com>
 <20210517143321.en2jy2gaxrhdhvub@wittgenstein>
 <87tun1qj6d.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tun1qj6d.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 09:00:58PM +0200, Giuseppe Scrivano wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Mon, May 17, 2021 at 03:30:16PM +0200, Giuseppe Scrivano wrote:
> >> Hi Serge,
> >> 
> >> thanks for the review.
> >> 
> >> "Serge E. Hallyn" <serge@hallyn.com> writes:
> >> 
> >> > On Mon, May 10, 2021 at 03:00:09PM +0200, Giuseppe Scrivano wrote:
> >> >> add a new mode 'shadow' to the /proc/PID/setgroups file.
> >> >> 
> >> >> When the 'shadow' string is written to the file, the current process
> >> >> groups are inherited from the process and stored into the user
> >> >> namespace.  These groups will be silently added on each setgroups(2)
> >> >> call.  A child user namespace won't be able to drop these groups
> >> >> anymore.
> >> >> 
> >> >> It enables using setgroups(2) in user namespaces on systems where
> >> >> negative ACLs are used.
> >> >> 
> >> >> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> >> >
> >> > Thanks for re-sending.
> >> >
> >> > Two closely related questions (and one comment) below.
> >> >
> >> >> ---
> >> >>  include/linux/cred.h           |  4 ++-
> >> >>  include/linux/user_namespace.h | 11 +++++--
> >> >>  kernel/groups.c                | 60 +++++++++++++++++++++++++---------
> >> >>  kernel/uid16.c                 | 38 ++++++++++++++++-----
> >> >>  kernel/user_namespace.c        | 34 +++++++++++++++----
> >> >>  5 files changed, 114 insertions(+), 33 deletions(-)
> >> >> 
> >> >> diff --git a/include/linux/cred.h b/include/linux/cred.h
> >> >> index 14971322e1a0..f3e631293532 100644
> >> >> --- a/include/linux/cred.h
> >> >> +++ b/include/linux/cred.h
> >> >> @@ -63,7 +63,9 @@ extern int groups_search(const struct group_info *, kgid_t);
> >> >>  
> >> >>  extern int set_current_groups(struct group_info *);
> >> >>  extern void set_groups(struct cred *, struct group_info *);
> >> >> -extern bool may_setgroups(void);
> >> >> +extern bool may_setgroups(struct group_info **shadowed_groups);
> >> >> +extern void add_shadowed_groups(struct group_info *group_info,
> >> >> +				struct group_info *shadowed);
> >> >>  extern void groups_sort(struct group_info *);
> >> >>  #else
> >> >>  static inline void groups_free(struct group_info *group_info)
> >> >> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> >> >> index 1d08dbbcfe32..cb003172de20 100644
> >> >> --- a/include/linux/user_namespace.h
> >> >> +++ b/include/linux/user_namespace.h
> >> >> @@ -32,6 +32,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
> >> >>  };
> >> >>  
> >> >>  #define USERNS_SETGROUPS_ALLOWED 1UL
> >> >> +#define USERNS_SETGROUPS_SHADOW  2UL
> >> >>  
> >> >>  #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
> >> >>  
> >> >> @@ -93,6 +94,9 @@ struct user_namespace {
> >> >>  #endif
> >> >>  	struct ucounts		*ucounts;
> >> >>  	int ucount_max[UCOUNT_COUNTS];
> >> >> +
> >> >> +	/* Supplementary groups when setgroups "shadow" mode is enabled.   */
> >> >> +	struct group_info *shadow_group_info;
> >> >>  } __randomize_layout;
> >> >>  
> >> >>  struct ucounts {
> >> >> @@ -138,7 +142,8 @@ extern ssize_t proc_gid_map_write(struct file *, const char __user *, size_t, lo
> >> >>  extern ssize_t proc_projid_map_write(struct file *, const char __user *, size_t, loff_t *);
> >> >>  extern ssize_t proc_setgroups_write(struct file *, const char __user *, size_t, loff_t *);
> >> >>  extern int proc_setgroups_show(struct seq_file *m, void *v);
> >> >> -extern bool userns_may_setgroups(const struct user_namespace *ns);
> >> >
> >> > I realize there's not a single other comment in this file, but I
> >> > think userns_may_setgroups() could use a comment to explain what
> >> > shadowed_groups is.
> >> 
> >> sure, I'll add some comments to the code.
> >> 
> >> >> +extern bool userns_may_setgroups(const struct user_namespace *ns,
> >> >> +				 struct group_info **shadowed_groups);
> >> >>  extern bool in_userns(const struct user_namespace *ancestor,
> >> >>  		       const struct user_namespace *child);
> >> >>  extern bool current_in_userns(const struct user_namespace *target_ns);
> >> >> @@ -167,8 +172,10 @@ static inline void put_user_ns(struct user_namespace *ns)
> >> >>  {
> >> >>  }
> >> >>  
> >> >> -static inline bool userns_may_setgroups(const struct user_namespace *ns)
> >> >> +static inline bool userns_may_setgroups(const struct user_namespace *ns,
> >> >> +					struct group_info **shadowed_groups)
> >> >>  {
> >> >> +	*shadowed_groups = NULL;
> >> >>  	return true;
> >> >>  }
> >> >>  
> >> >> diff --git a/kernel/groups.c b/kernel/groups.c
> >> >> index 787b381c7c00..f0c3b49da19e 100644
> >> >> --- a/kernel/groups.c
> >> >> +++ b/kernel/groups.c
> >> >> @@ -52,11 +52,10 @@ static int groups_to_user(gid_t __user *grouplist,
> >> >>  
> >> >>  /* fill a group_info from a user-space array - it must be allocated already */
> >> >>  static int groups_from_user(struct group_info *group_info,
> >> >> -    gid_t __user *grouplist)
> >> >> +			    gid_t __user *grouplist, int count)
> >> >>  {
> >> >>  	struct user_namespace *user_ns = current_user_ns();
> >> >>  	int i;
> >> >> -	unsigned int count = group_info->ngroups;
> >> >>  
> >> >>  	for (i = 0; i < count; i++) {
> >> >>  		gid_t gid;
> >> >> @@ -169,12 +168,24 @@ SYSCALL_DEFINE2(getgroups, int, gidsetsize, gid_t __user *, grouplist)
> >> >>  	return i;
> >> >>  }
> >> >>  
> >> >> -bool may_setgroups(void)
> >> >> +bool may_setgroups(struct group_info **shadowed_groups)
> >> >>  {
> >> >>  	struct user_namespace *user_ns = current_user_ns();
> >> >>  
> >> >>  	return ns_capable_setid(user_ns, CAP_SETGID) &&
> >> >> -		userns_may_setgroups(user_ns);
> >> >> +		userns_may_setgroups(user_ns, shadowed_groups);
> >> >> +}
> >> >> +
> >> >> +void add_shadowed_groups(struct group_info *group_info, struct group_info *shadowed)
> >> >> +{
> >> >> +	int i, j;
> >> >> +
> >> >> +	for (i = 0; i < shadowed->ngroups; i++) {
> >> >> +		kgid_t kgid = shadowed->gid[i];
> >> >> +
> >> >> +		j = group_info->ngroups - i - 1;
> >> >> +		group_info->gid[j] = kgid;
> >> >> +	}
> >> >>  }
> >> >>  
> >> >>  /*
> >> >> @@ -184,27 +195,44 @@ bool may_setgroups(void)
> >> >>  
> >> >>  SYSCALL_DEFINE2(setgroups, int, gidsetsize, gid_t __user *, grouplist)
> >> >>  {
> >> >> -	struct group_info *group_info;
> >> >> +	struct group_info *shadowed_groups = NULL;
> >> >> +	struct group_info *group_info = NULL;
> >> >> +	unsigned int arraysize = gidsetsize;
> >> >>  	int retval;
> >> >>  
> >> >> -	if (!may_setgroups())
> >> >> -		return -EPERM;
> >> >> -	if ((unsigned)gidsetsize > NGROUPS_MAX)
> >> >> +	if (arraysize > NGROUPS_MAX)
> >> >>  		return -EINVAL;
> >> >>  
> >> >> -	group_info = groups_alloc(gidsetsize);
> >> >> -	if (!group_info)
> >> >> -		return -ENOMEM;
> >> >> -	retval = groups_from_user(group_info, grouplist);
> >> >> -	if (retval) {
> >> >> -		put_group_info(group_info);
> >> >> -		return retval;
> >> >> +	if (!may_setgroups(&shadowed_groups))
> >> >> +		return -EPERM;
> >> >> +
> >> >> +	if (shadowed_groups) {
> >> >> +		retval = -EINVAL;
> >> >> +		if (shadowed_groups->ngroups + gidsetsize > NGROUPS_MAX)
> >> >> +			goto out;
> >> >> +		arraysize += shadowed_groups->ngroups;
> >> >>  	}
> >> >>  
> >> >> +	group_info = groups_alloc(arraysize);
> >> >> +	retval = -ENOMEM;
> >> >> +	if (!group_info)
> >> >> +		goto out;
> >> >> +
> >> >> +	retval = groups_from_user(group_info, grouplist, gidsetsize);
> >> >> +	if (retval)
> >> >> +		goto out;
> >> >> +
> >> >> +	if (shadowed_groups)
> >> >> +		add_shadowed_groups(group_info, shadowed_groups);
> >> >> +
> >> >>  	groups_sort(group_info);
> >> >>  	retval = set_current_groups(group_info);
> >> >> -	put_group_info(group_info);
> >> >>  
> >> >> +out:
> >> >> +	if (group_info)
> >> >> +		put_group_info(group_info);
> >> >> +	if (shadowed_groups)
> >> >> +		put_group_info(shadowed_groups);
> >> >>  	return retval;
> >> >>  }
> >> >>  
> >> >> diff --git a/kernel/uid16.c b/kernel/uid16.c
> >> >> index af6925d8599b..cb1110f083ce 100644
> >> >> --- a/kernel/uid16.c
> >> >> +++ b/kernel/uid16.c
> >> >> @@ -130,14 +130,14 @@ static int groups16_to_user(old_gid_t __user *grouplist,
> >> >>  }
> >> >>  
> >> >>  static int groups16_from_user(struct group_info *group_info,
> >> >> -    old_gid_t __user *grouplist)
> >> >> +			      old_gid_t __user *grouplist, int count)
> >> >>  {
> >> >>  	struct user_namespace *user_ns = current_user_ns();
> >> >>  	int i;
> >> >>  	old_gid_t group;
> >> >>  	kgid_t kgid;
> >> >>  
> >> >> -	for (i = 0; i < group_info->ngroups; i++) {
> >> >> +	for (i = 0; i < count; i++) {
> >> >>  		if (get_user(group, grouplist+i))
> >> >>  			return  -EFAULT;
> >> >>  
> >> >> @@ -177,25 +177,47 @@ SYSCALL_DEFINE2(getgroups16, int, gidsetsize, old_gid_t __user *, grouplist)
> >> >>  SYSCALL_DEFINE2(setgroups16, int, gidsetsize, old_gid_t __user *, grouplist)
> >> >>  {
> >> >>  	struct group_info *group_info;
> >> >> +	struct group_info *shadowed_groups = NULL;
> >> >>  	int retval;
> >> >> +	unsigned int arraysize = gidsetsize;
> >> >>  
> >> >> -	if (!may_setgroups())
> >> >> -		return -EPERM;
> >> >> -	if ((unsigned)gidsetsize > NGROUPS_MAX)
> >> >> +	if (arraysize > NGROUPS_MAX)
> >> >>  		return -EINVAL;
> >> >>  
> >> >> -	group_info = groups_alloc(gidsetsize);
> >> >> -	if (!group_info)
> >> >> +	if (!may_setgroups(&shadowed_groups))
> >> >> +		return -EPERM;
> >> >> +
> >> >> +	if (shadowed_groups) {
> >> >> +		if (shadowed_groups->ngroups + gidsetsize > NGROUPS_MAX) {
> >> >> +			put_group_info(shadowed_groups);
> >> >> +			return -EINVAL;
> >> >> +		}
> >> >> +		arraysize += shadowed_groups->ngroups;
> >> >> +	}
> >> >> +
> >> >> +	group_info = groups_alloc(arraysize);
> >> >> +	if (!group_info) {
> >> >> +		if (shadowed_groups)
> >> >> +			put_group_info(shadowed_groups);
> >> >>  		return -ENOMEM;
> >> >> -	retval = groups16_from_user(group_info, grouplist);
> >> >> +	}
> >> >> +
> >> >> +	retval = groups16_from_user(group_info, grouplist, gidsetsize);
> >> >>  	if (retval) {
> >> >> +		if (shadowed_groups)
> >> >> +			put_group_info(shadowed_groups);
> >> >>  		put_group_info(group_info);
> >> >>  		return retval;
> >> >>  	}
> >> >>  
> >> >> +	if (shadowed_groups)
> >> >> +		add_shadowed_groups(group_info, shadowed_groups);
> >> >> +
> >> >>  	groups_sort(group_info);
> >> >>  	retval = set_current_groups(group_info);
> >> >>  	put_group_info(group_info);
> >> >> +	if (shadowed_groups)
> >> >> +		put_group_info(shadowed_groups);
> >> >>  
> >> >>  	return retval;
> >> >>  }
> >> >> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> >> >> index 8d62863721b0..b1940b63f7ac 100644
> >> >> --- a/kernel/user_namespace.c
> >> >> +++ b/kernel/user_namespace.c
> >> >> @@ -123,6 +123,7 @@ int create_user_ns(struct cred *new)
> >> >>  		ns->ucount_max[i] = INT_MAX;
> >> >>  	}
> >> >>  	ns->ucounts = ucounts;
> >> >> +	ns->shadow_group_info = get_current_groups();
> >> >
> >> > If userns u1 unshares u2 with shadow set, then when u2 unshares
> >> > u3, should u3 get the same shadowed set that u2 has, or should it
> >> > get all of u2's groups as u3's initial shadow set?
> >> 
> >> good question.  Thinking more of it, I think a reasonable interface is
> >> to expect a child userns to inherit the same shadow groups as its parent
> >> userns.  If "shadow" is written again to the /proc/PID/setgroups file
> >> then it grows shadow groups set to include the ones the userns had at
> >> creation time (which includes the parent shadow groups).  What do you
> >> think of it?  I'll play more with this idea and see if it works.
> >
> > So when I initially looked at that proposal I was neither "yay" or "nay"
> > since it seemed useful to people and it looked somewhat straightforward
> > to implement.
> >
> > But I do have concerns now after seeing this. The whole
> > /proc/<pid>/setgroups API is terrible in the first place and causes even
> > more special-casing in container runtimes then there already is. But it
> > fixes a security issue so ok we'll live with it.
> >
> > But I'm not happy about extending its format to include more options. I
> > really don't want the precedent of adding magic keywords into this file.
> >
> > Which brings me to my second concern. I think starting to magically
> > inherit group ids isn't a great idea. It's got a lot of potential for
> > confusion.
> >
> > The point Serge here made makes this pretty obvious imho. I don't think
> > introducing the complexities of magic group inheritance is something we
> > should do.
> >
> > Alternative proposal, can we solve this in userspace instead?
> >
> > As has been pointed out there is a solution to this problem already
> > which is to explicitly map those groups through, i.e. punch holes for
> > the groups to be inherited.
> 
> That is an useful feature and I think we should also have, but IMO it
> solves a different problem.
> 
> It can be used by unprivileged users to maintain their additional gids
> inside a user namespace through the setgid helper, but it won't be
> enough to safely use setgroups when negative "groups" are involved.

Imho negative acls are a misconfiguration and as such a problem that
needs to be fixed in userspace. It's not that they are the default,
encouraged or widely used. Frankly, using negative acls as an argument
makes me more suspicious that this is the wrong way to go. :)
I'm very reluctant to see negative acls as a valid argument for
introducing more magic into the kernel to accommodate such userspace
configurations. It's not the kernel's job to fix this. Especially as we
did have that discussion in 2017 related to another bug, e.g. see:
https://bugs.launchpad.net/ubuntu/+source/shadow/+bug/1729357/comments/9

> 
> > So can't we introduce a new mode for newgidmap by e.g. introducing
> > another /etc/setgroups file or something similar that can be configured
> > by the administrator. It could take options, e.g. "shadow=always" which
> > could mean "everyone must inherit their groups" so newgidmap will punch
> > holes for the caller's groups when writing the gid mapping. We could
> > also extend this by making newgidmap take a command line switch so it's
> > on a case-by-case basis.
> >
> > This is even more flexible since you could extend the new /etc/setgroups
> > file to specify a list of groups that must always be preserved. I'd
> > rather see something like this rather than a magic inheritance switch.
> 
> This is helpful and tracked upstream: https://github.com/shadow-maint/shadow/issues/135
> 
> But how can we enforce the shadow=always at runtime when setgroups is
> enabled?

Enforcement only seems to be needed in the face of negative acls to
which the correct answer seems to me to not use them for container
users.
(But in general, this is a management problem similar to the selection of
id mappings and so isn't really different from reserving id ranges in
userspace across container runtimes.)

I also looked at Podman/crun and you do already have logic today to
handle setgroups inheritance under the
--group-add keep-groups
flag. Even featured on the project's website
https://github.com/containers/podman/blob/9788289f942ff7a79c214446047d0f943c66f409/troubleshooting.md#solution-18
and with a blog about it
https://www.redhat.com/sysadmin/supplemental-groups-podman-containers

That fixes most of your itch.
So this patch, apart from the accommodation of negative acls, is mostly
a convenience and in general I do really sympathize with that as I've
mentioned before to you.
But then there should be a good trade-off between cost and benefit. Not
just in terms of complexity for the kernel itself but also for api
useability and how understandable it is for userspace developers. And I
don't think we're hitting the mark with a change like this.

First, because it is solveable in userspace as --group-add clearly
shows. Second, because we're introducing this whole inheritance and
expansion mechanism alongside "shadow" in nested scenarios. And third,
if one looks at man user_namespaces and reads the section about
/etc/setgroups with the eye of a moderately experienced (container)
administrator it's already pretty confusing. Now we need to add yet
another section explaining that new "shadow" mode, how it relates to
"setgroups={allow,deny}" and to negative acls, and how it is inherited
and expanded when creating nested userns.
All this mostly motivated by a barely used concept with the potential to
muddy the semantics of user namespaces further. I generally don't like
to be so discouraging but I'm not at all convinced we want to do this.

Christian
