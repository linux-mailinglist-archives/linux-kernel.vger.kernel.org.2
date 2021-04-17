Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015A6362CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 04:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhDQCUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 22:20:13 -0400
Received: from mail.hallyn.com ([178.63.66.53]:33870 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhDQCUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 22:20:12 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 97A0A787; Fri, 16 Apr 2021 21:19:45 -0500 (CDT)
Date:   Fri, 16 Apr 2021 21:19:45 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH] capabilities: require CAP_SETFCAP to map uid 0 (v3)
Message-ID: <20210417021945.GA687@mail.hallyn.com>
References: <20210416045851.GA13811@mail.hallyn.com>
 <20210416150501.zam55gschpn2w56i@wittgenstein>
 <20210416213453.GA29094@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416213453.GA29094@mail.hallyn.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 04:34:53PM -0500, Serge E. Hallyn wrote:
> On Fri, Apr 16, 2021 at 05:05:01PM +0200, Christian Brauner wrote:
> > On Thu, Apr 15, 2021 at 11:58:51PM -0500, Serge Hallyn wrote:
> > > (Eric - this patch (v3) is a cleaned up version of the previous approach.
> > > v4 is at https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git/log/?h=2021-04-15/setfcap-nsfscaps-v4
> > > and is the approach you suggested.  I can send it also as a separate patch
> > > if you like)
> > > 
> > > A process running as uid 0 but without cap_setfcap currently can simply
> > > unshare a new user namespace with uid 0 mapped to 0.  While this task
> > > will not have new capabilities against the parent namespace, there is
> > > a loophole due to the way namespaced file capabilities work.  File
> > > capabilities valid in userns 1 are distinguised from file capabilities
> > > valid in userns 2 by the kuid which underlies uid 0.  Therefore
> > > the restricted root process can unshare a new self-mapping namespace,
> > > add a namespaced file capability onto a file, then use that file
> > > capability in the parent namespace.
> > > 
> > > To prevent that, do not allow mapping uid 0 if the process which
> > > opened the uid_map file does not have CAP_SETFCAP, which is the capability
> > > for setting file capabilities.
> > > 
> > > A further wrinkle:  a task can unshare its user namespace, then
> > > open its uid_map file itself, and map (only) its own uid.  In this
> > > case we do not have the credential from before unshare,  which was
> > > potentially more restricted.  So, when creating a user namespace, we
> > > record whether the creator had CAP_SETFCAP.  Then we can use that
> > > during map_write().
> > > 
> > > With this patch:
> > > 
> > > 1. unprivileged user can still unshare -Ur
> > > 
> > > ubuntu@caps:~$ unshare -Ur
> > > root@caps:~# logout
> > > 
> > > 2. root user can still unshare -Ur
> > > 
> > > ubuntu@caps:~$ sudo bash
> > > root@caps:/home/ubuntu# unshare -Ur
> > > root@caps:/home/ubuntu# logout
> > > 
> > > 3. root user without CAP_SETFCAP cannot unshare -Ur:
> > > 
> > > root@caps:/home/ubuntu# /sbin/capsh --drop=cap_setfcap --
> > > root@caps:/home/ubuntu# /sbin/setcap cap_setfcap=p /sbin/setcap
> > > unable to set CAP_SETFCAP effective capability: Operation not permitted
> > > root@caps:/home/ubuntu# unshare -Ur
> > > unshare: write failed /proc/self/uid_map: Operation not permitted
> > > 
> > > Signed-off-by: Serge Hallyn <serge@hallyn.com>
> > > 
> > > Changelog:
> > >    * fix logic in the case of writing to another task's uid_map
> > >    * rename 'ns' to 'map_ns', and make a file_ns local variable
> > >    * use /* comments */
> > >    * update the CAP_SETFCAP comment in capability.h
> > >    * rename parent_unpriv to parent_can_setfcap (and reverse the
> > >      logic)
> > >    * remove printks
> > >    * clarify (i hope) the code comments
> > >    * update capability.h comment
> > >    * renamed parent_can_setfcap to parent_could_setfcap
> > >    * made the check its own disallowed_0_mapping() fn
> > >    * moved the check into new_idmap_permitted
> > > ---
> > 
> > Thank you for working on this fix!
> > 
> > I do prefer your approach of doing the check at user namespace creation
> > time instead of moving it into the setxattr() codepath.
> > 
> > Let me reiterate that the ability to write through fscaps is a valid
> > usecase and this should continue to work but that for locked down user
> > namespace as Andrew wants to use them your patch provides a clean
> > solution.
> > We've are using identity mappings in quite a few scenarios partially
> > when performing tests but also to write through fscaps.
> > We also had reports of users that use identity mappings. They create
> > their rootfs by running image extraction in an identity mapped userns
> > where fscaps are written through.
> > Podman has use-cases for this feature as well and has been affected by
> > the regression of the first fix.
> 
> Thanks for reviewing.
> 
> I'm not sure what your point above is, so just to make sure - the
> alternative implementation also does allow fscaps for cases where
> root uid is remapped, only disallowing it if it would violate the
> ancestor's lack of cap_setfcap.
> 
> 
> > >  include/linux/user_namespace.h  |  3 ++
> > >  include/uapi/linux/capability.h |  3 +-
> > >  kernel/user_namespace.c         | 61 +++++++++++++++++++++++++++++++--
> > >  3 files changed, 63 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> > > index 64cf8ebdc4ec..f6c5f784be5a 100644
> > > --- a/include/linux/user_namespace.h
> > > +++ b/include/linux/user_namespace.h
> > > @@ -63,6 +63,9 @@ struct user_namespace {
> > >  	kgid_t			group;
> > >  	struct ns_common	ns;
> > >  	unsigned long		flags;
> > > +	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
> > > +	 * in its effective capability set at the child ns creation time. */
> > > +	bool			parent_could_setfcap;
> > >  
> > >  #ifdef CONFIG_KEYS
> > >  	/* List of joinable keyrings in this namespace.  Modification access of
> > > diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> > > index c6ca33034147..2ddb4226cd23 100644
> > > --- a/include/uapi/linux/capability.h
> > > +++ b/include/uapi/linux/capability.h
> > > @@ -335,7 +335,8 @@ struct vfs_ns_cap_data {
> > >  
> > >  #define CAP_AUDIT_CONTROL    30
> > >  
> > > -/* Set or remove capabilities on files */
> > > +/* Set or remove capabilities on files.
> > > +   Map uid=0 into a child user namespace. */
> > >  
> > >  #define CAP_SETFCAP	     31
> > >  
> > > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > > index af612945a4d0..8c75028a9aae 100644
> > > --- a/kernel/user_namespace.c
> > > +++ b/kernel/user_namespace.c
> > > @@ -106,6 +106,7 @@ int create_user_ns(struct cred *new)
> > >  	if (!ns)
> > >  		goto fail_dec;
> > >  
> > > +	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
> > >  	ret = ns_alloc_inum(&ns->ns);
> > >  	if (ret)
> > >  		goto fail_free;
> > > @@ -841,6 +842,56 @@ static int sort_idmaps(struct uid_gid_map *map)
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * If mapping uid 0, then file capabilities created by the new namespace will
> > > + * be effective in the parent namespace.  Adding file capabilities requires
> > > + * CAP_SETFCAP, which the child namespace will have, so creating such a
> > > + * mapping requires CAP_SETFCAP in the parent namespace.
> > > + */
> > > +static bool disallowed_0_mapping(const struct file *file,
> > > +				 struct user_namespace *map_ns,
> > > +				 struct uid_gid_map *new_map)
> > > +{
> > > +	int idx;
> > > +	bool zeromapping = false;
> > > +	const struct user_namespace *file_ns = file->f_cred->user_ns;
> > > +
> > > +	for (idx = 0; idx < new_map->nr_extents; idx++) {
> > 
> > I think having that loop is acceptable here since it's only called once
> > at map creation time even though the forward array is not yet sorted.
> > 
> > > +		struct uid_gid_extent *e;
> > > +		u32 lower_first;
> > > +
> > > +		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> > > +			e = &new_map->extent[idx];
> > > +		else
> > > +			e = &new_map->forward[idx];
> > > +		if (e->lower_first == 0) {
> > > +			zeromapping = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (!zeromapping)
> > > +		return false;
> > > +
> > > +	if (map_ns == file_ns) {
> > > +		/* The user unshared first and is writing to
> > > +		 * /proc/self/uid_map.  User already has full
> > > +		 * capabilites in the new namespace, so verify
> > > +		 * that the parent has CAP_SETFCAP. */
> > > +		if (!file_ns->parent_could_setfcap)
> > > +			return true;
> > > +	} else {
> > > +		/* Process p1 is writing to uid_map of p2, who
> > > +		 * is in a child user namespace to p1's.  So
> > > +		 * we verify that p1 has CAP_SETFCAP to its
> > > +		 * own namespace */
> > > +		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
> > > +			return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > 
> > Maybe we can tweak this a tiny bit to get rid of the "zeromapping"?:
> > 
> > static bool disallowed_0_mapping(const struct file *file,
> > 				 struct user_namespace *map_ns,
> > 				 struct uid_gid_map *new_map)
> > {
> > 	int idx;
> > 	const struct user_namespace *file_ns = file->f_cred->user_ns;
> > 	struct uid_gid_extent *extent0 = NULL;
> > 
> > 	for (idx = 0; idx < new_map->nr_extents; idx++) {
> > 		u32 lower_first;
> > 
> > 		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> > 			extent0 = &new_map->extent[idx];
> > 		else
> > 			extent0 = &new_map->forward[idx];
> > 		if (extent0->lower_first == 0)
> > 			break;
> > 
> > 		extent0 = NULL;
> > 	}
> > 
> > 	if (!extent0)
> > 		return false;
> 
> Feels a little less clear to me, but that's probably just me, so I'll
> switch it over, thanks.
> 
> > 
> > 	if (map_ns == file_ns) {
> > 		/* 
> > 		 * The user unshared first and is writing to
> > 		 * /proc/self/uid_map.  User already has full
> > 		 * capabilites in the new namespace, so verify
> > 		 * that the parent has CAP_SETFCAP.
> > 		 */
> > 		if (!file_ns->parent_could_setfcap)
> > 			return true;
> > 	} else {
> > 		/* 
> > 		 * Process p1 is writing to uid_map of p2, who
> > 		 * is in a child user namespace to p1's. So
> > 		 * we verify that p1 has CAP_SETFCAP to its
> > 		 * own namespace.
> > 		 */
> > 		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
> > 			return true;
> > 	}
> > 
> > 	return false;
> > }
> > 
> > In addition I would think that expressing the logic the other way around
> > is more legible. I'm not too keen on having negations in function names.
> > We should probably also tweak the comment a bit and make it kernel-doc
> > clean:
> > 
> > /**
> >  * verify_root_map() - check the uid 0 mapping
> 
> Hm.  restrict_root_map() ?  "verify" sounds like we should sometimes reject
> it.

yes please ignore that :)
