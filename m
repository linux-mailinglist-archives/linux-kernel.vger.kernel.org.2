Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBFF3814E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhEOBWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:22:35 -0400
Received: from mail.hallyn.com ([178.63.66.53]:50380 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhEOBWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:22:34 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 1EC9A67F; Fri, 14 May 2021 20:21:21 -0500 (CDT)
Date:   Fri, 14 May 2021 20:21:21 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, serge@hallyn.com, dwalsh@redhat.com,
        christian.brauner@ubuntu.com, ebiederm@xmission.com
Subject: Re: [RFC PATCH 2/3] getgroups: hide unknown groups
Message-ID: <20210515012121.GA2325@mail.hallyn.com>
References: <20210510130011.1441834-1-gscrivan@redhat.com>
 <20210510130011.1441834-3-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510130011.1441834-3-gscrivan@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 03:00:10PM +0200, Giuseppe Scrivano wrote:
> do not copy to userspace the groups that are not known in the
> namespace.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  kernel/groups.c | 40 +++++++++++++++++++--------------------
>  kernel/uid16.c  | 50 ++++++++++++++++++++++++-------------------------
>  2 files changed, 44 insertions(+), 46 deletions(-)
> 
> diff --git a/kernel/groups.c b/kernel/groups.c
> index f0c3b49da19e..97fa9faa7813 100644
> --- a/kernel/groups.c
> +++ b/kernel/groups.c
> @@ -35,19 +35,30 @@ EXPORT_SYMBOL(groups_free);
>  
>  /* export the group_info to a user-space array */
>  static int groups_to_user(gid_t __user *grouplist,
> -			  const struct group_info *group_info)
> +			  const struct group_info *group_info,
> +			  int gidsetsize)
>  {
>  	struct user_namespace *user_ns = current_user_ns();
> -	int i;
>  	unsigned int count = group_info->ngroups;
> +	int i, ngroups = 0;
>  
>  	for (i = 0; i < count; i++) {
>  		gid_t gid;
> -		gid = from_kgid_munged(user_ns, group_info->gid[i]);
> -		if (put_user(gid, grouplist+i))
> -			return -EFAULT;
> +		gid = from_kgid(user_ns, group_info->gid[i]);
> +		if (gid == (gid_t)-1) {
> +			if (user_ns->flags & USERNS_SETGROUPS_SHADOW)
> +				continue;
> +			gid = overflowgid;
> +		}
> +		if (gidsetsize) {
> +			if (ngroups == gidsetsize)
> +				return -EINVAL;
> +			if (put_user(gid, grouplist + ngroups))
> +				return -EFAULT;
> +		}
> +		ngroups++;
>  	}
> -	return 0;
> +	return ngroups;
>  }
>  
>  /* fill a group_info from a user-space array - it must be allocated already */
> @@ -146,26 +157,13 @@ EXPORT_SYMBOL(set_current_groups);
>  
>  SYSCALL_DEFINE2(getgroups, int, gidsetsize, gid_t __user *, grouplist)
>  {
> +	/* no need to grab task_lock here; it cannot change */
>  	const struct cred *cred = current_cred();
> -	int i;
>  
>  	if (gidsetsize < 0)
>  		return -EINVAL;
>  
> -	/* no need to grab task_lock here; it cannot change */
> -	i = cred->group_info->ngroups;
> -	if (gidsetsize) {
> -		if (i > gidsetsize) {
> -			i = -EINVAL;
> -			goto out;
> -		}
> -		if (groups_to_user(grouplist, cred->group_info)) {
> -			i = -EFAULT;
> -			goto out;
> -		}
> -	}
> -out:
> -	return i;
> +	return groups_to_user(grouplist, cred->group_info, gidsetsize);
>  }
>  
>  bool may_setgroups(struct group_info **shadowed_groups)
> diff --git a/kernel/uid16.c b/kernel/uid16.c
> index cb1110f083ce..6f2dc793b5f8 100644
> --- a/kernel/uid16.c
> +++ b/kernel/uid16.c
> @@ -112,21 +112,33 @@ SYSCALL_DEFINE1(setfsgid16, old_gid_t, gid)
>  }
>  
>  static int groups16_to_user(old_gid_t __user *grouplist,
> -    struct group_info *group_info)
> +			    struct group_info *group_info,
> +			    int gidsetsize)
>  {
>  	struct user_namespace *user_ns = current_user_ns();
> -	int i;
> -	old_gid_t group;
> -	kgid_t kgid;
> +	unsigned int count = group_info->ngroups;
> +	int i, ngroups = 0;
>  
> -	for (i = 0; i < group_info->ngroups; i++) {
> -		kgid = group_info->gid[i];
> -		group = high2lowgid(from_kgid_munged(user_ns, kgid));
> -		if (put_user(group, grouplist+i))
> -			return -EFAULT;
> +	for (i = 0; i < count; i++) {
> +		gid_t gid;
> +		old_gid_t group;
> +
> +		gid = from_kgid(user_ns, group_info->gid[i]);
> +		if (gid == (gid_t)-1) {
> +			if (user_ns->flags & USERNS_SETGROUPS_SHADOW)
> +				continue;
> +			gid = overflowgid;
> +		}
> +		group = high2lowgid(gid);
> +		if (gidsetsize) {
> +			if (ngroups == gidsetsize)
> +				return -EINVAL;
> +			if (put_user(group, grouplist + ngroups))
> +				return -EFAULT;
> +		}
> +		ngroups++;
>  	}
> -
> -	return 0;
> +	return ngroups;
>  }
>  
>  static int groups16_from_user(struct group_info *group_info,
> @@ -153,25 +165,13 @@ static int groups16_from_user(struct group_info *group_info,
>  
>  SYSCALL_DEFINE2(getgroups16, int, gidsetsize, old_gid_t __user *, grouplist)
>  {
> +	/* no need to grab task_lock here; it cannot change */
>  	const struct cred *cred = current_cred();
> -	int i;
>  
>  	if (gidsetsize < 0)
>  		return -EINVAL;
>  
> -	i = cred->group_info->ngroups;
> -	if (gidsetsize) {
> -		if (i > gidsetsize) {
> -			i = -EINVAL;
> -			goto out;
> -		}
> -		if (groups16_to_user(grouplist, cred->group_info)) {
> -			i = -EFAULT;
> -			goto out;
> -		}
> -	}
> -out:
> -	return i;
> +	return groups16_to_user(grouplist, cred->group_info, gidsetsize);
>  }
>  
>  SYSCALL_DEFINE2(setgroups16, int, gidsetsize, old_gid_t __user *, grouplist)
> -- 
> 2.31.1
