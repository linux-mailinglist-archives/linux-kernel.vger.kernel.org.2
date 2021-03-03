Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B32332C3E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354425AbhCDAIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:08:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51086 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390503AbhCCWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:08:49 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lHZeb-0001P3-JQ; Wed, 03 Mar 2021 22:07:37 +0000
Date:   Wed, 3 Mar 2021 22:07:36 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, hch@lst.de, stgraber@ubuntu.com,
        alban@kinvolk.io, serge@hallyn.com,
        James Morris <jamorris@linux.microsoft.com>,
        luto@amacapital.net
Subject: Re: [GIT PULL] idmapped mounts for v5.12
Message-ID: <20210303220736.x3qwzrfdhttdwacn@wittgenstein>
References: <20210213130042.828076-1-christian.brauner@ubuntu.com>
 <m18s7481xc.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m18s7481xc.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:36:31PM -0600, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > Hi Linus,

Hi Eric,

> 
> > This series comes with an extensive xfstests suite covering both ext4 and xfs
> > https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
> > It covers truncation, creation, opening, xattrs, vfscaps, setid execution,
> > setgid inheritance and more both with idmapped and non-idmapped mounts.
> > It already helped to discover an unrelated xfs setgid inheritance bug which has
> > since been fixed in mainline. It will be sent for inclusion with the xfstests
> > project should you decide to merge this.
> 
> And yet chown is broken (details below), and in a very predictable way.

This is increadibly poor timing, there were 6 versions of this patchset
published over several months and you were Cced on all of them. All that
came from you during that time were a couple of odd comments.

If chown is broken please give us a specific reproducer for when it
yields the wrong ownership so we can fix it and add this as a test-case
to the testsuite so it never breaks again.

> 
> This is not considering that the entire concept is giving people a
> loaded footgun, that is very difficult to use safely.

The concept has seen a lot of interest by a lot of users during
development of this patchset and is already being integrated in
container runtimes and other tools by people who understand its behavior
and implication.
And fwiw, by this argument we simply should have never done user
namespaces or unprivileged filesystem mounts too.

> 
> 
> When the user namespace was implemented the two kinds of uids were very
> carefully separated from each other by type, so it would be take
> deliberate action to mix them.  These changes introduces a third type
> of uid and does not use the type system to keep them separate.  In just

I don't agree. This causes more confusion then it solves imho and is the
whole basis for your argument. This reads a bit confusing to me.

> a little bit of looking since I realized this problem I have found two
> bugs in chown where the wrong values are compared.
> 
> We now have the following types of uids and gids:
> - The userspace values.
> - The kernel values that are used for comparisons.
>   (The old fashioned kuid_t and kgid_t)
> - The values used for interfacing with the filesystems
>   underneath a mount.
>   (The beneath mount kuid_t and kgid_t)

I don't see why we would need yet another type for this. It is simply a
remapped or shifted kuid. A third type would introduce more confusion
most likely but I'm open to it if you have a clear idea what you want
and why you want it. It slightly feels like a strawman distinction to
push for the revert.

> - The values stored in the filesystem.
> 
> The third type is new, and the code mixes old fashioned kuid_t and
> kgid_t with the below mount kuid_t and kgid_t.
> 
> Starting with chown_common the code does:
> 
> int chown_common(const struct path *path, uid_t user, gid_t group)
> {
> 	...
> 	uid = make_kuid(current_user_ns(), user);
> 	gid = make_kgid(current_user_ns(), group);
> 
> 	mnt_userns = mnt_user_ns(path->mnt);
> 	uid = kuid_from_mnt(mnt_userns, uid);
> 	gid = kgid_from_mnt(mnt_userns, gid);
> 
> retry_deleg:
> 	newattrs.ia_valid =  ATTR_CTIME;
> 	if (user != (uid_t) -1) {
> 		if (!uid_valid(uid))
> 			return -EINVAL;
> 		newattrs.ia_valid |= ATTR_UID;
> 		newattrs.ia_uid = uid;
> 	}
> 	if (group != (gid_t) -1) {
> 		if (!gid_valid(gid))
> 			return -EINVAL;
> 		newattrs.ia_valid |= ATTR_GID;
> 		newattrs.ia_gid = gid;
> 	}
> 	if (!S_ISDIR(inode->i_mode))
> 		newattrs.ia_valid |=
> 			ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_KILL_PRIV;
> 	inode_lock(inode);
> 	error = security_path_chown(path, uid, gid);
> 	if (!error)
> 		error = notify_change(mnt_userns, path->dentry, &newattrs,
> 				      &delegated_inode);
> 	inode_unlock(inode);
> 	...
> }
> 
> Here security_path_chown is expecting the old fashioned kuid_t and
> kgid_t but looking at the top of the function we can see that
> security_path_chown is getting the kuid_t and kgid_t from below the
> mount.

As it should. The idmapping of the mount is authorative. This attack
only makes sense if you assume that there is a third type.

> 
> The Tomoyo lsm cares.

Please explain or send a patch to fix Tomoyo.

> 
> 
> Notice that ia_uid and ia_gid in struct newattrs are below mount values.
> 
> 
> Now looking in notify_change:
> 
> int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
> 		  struct iattr *attr, struct inode **delegated_inode)
> {
> 	...
>        	if (inode->i_op->setattr)
> 		error = inode->i_op->setattr(mnt_userns, dentry, attr);
> 	else
> 		error = simple_setattr(mnt_userns, dentry, attr);
>         ...
> }
> 
> 
> int simple_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> 		   struct iattr *iattr)
> {
> 	...
> 	error = setattr_prepare(mnt_userns, dentry, iattr);
> 	if (error)
> 		return error;
> 	...
> }
> 
> 
> int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
> 		    struct iattr *attr)
> {
> 	...
> 	/* Make sure a caller can chown. */
> 	if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, inode, attr->ia_uid))
> 		return -EPERM;
> 
> 	/* Make sure caller can chgrp. */
> 	if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, inode, attr->ia_gid))
> 		return -EPERM;
> 	...
> }
> 
> static bool chown_ok(struct user_namespace *mnt_userns,
> 		     const struct inode *inode,
> 		     kuid_t uid)
> {
> 	kuid_t kuid = i_uid_into_mnt(mnt_userns, inode);
> 	if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, kuid))
>                                              ^^^^^^^^^^^^^^^^^^
> 		return true;
>  	....               
> }
> 
> The comparison of uid and kuid in chown_ok is nonsense.  As the kuid is
> the old fashioned kuid.  While the uid is attr->ia_uid is the below
> mount value.

I don't follow. Both are idmapped kuids. If we missed a conversion then
it's a bug we'll fix. I don't see it yet though. All I see is that your
third type already introduces more confusion than it solves.

> 
> I found these both within just a couple of minutes by creating
> a type vfsuid_t and vfsgid_t and using it for the values stored in
> struct inode and struct iattr.

I don't see code for what you want or mean so I have no clue what this is.

> 
> There are probably more cases of inappropriate mixing.  I stopped as I
> don't have the energy or the inclination to dig through and find more.
> 
> Unfortunately what I found was that the current design of using kuid_t
> and kgid_t for both the old fashioned kuids and for the new below mount
> values is so error prone that even the author of the change while
> performing a lot of testing can not get it right.
> 
> Christian do you think you can add a type for the below mount values
> and separate everything by type quickly?
> 
> Otherwise I think the better part of valor would be to revert this code
> and come back it has made not error prone.

I don't see a reason to rush adding another id type and no fundamental
flaw in the patchset as it stands. If there is a strong case for adding
another id type, it can be done at a later time with no userspace
impact.

Christian
