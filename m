Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44123814E9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhEOBZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:25:38 -0400
Received: from mail.hallyn.com ([178.63.66.53]:50432 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhEOBZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:25:37 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 926C3AAB; Fri, 14 May 2021 20:24:24 -0500 (CDT)
Date:   Fri, 14 May 2021 20:24:24 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, serge@hallyn.com, dwalsh@redhat.com,
        christian.brauner@ubuntu.com, ebiederm@xmission.com
Subject: Re: [RFC PATCH 3/3] proc: hide unknown groups in status
Message-ID: <20210515012424.GA2845@mail.hallyn.com>
References: <20210510130011.1441834-1-gscrivan@redhat.com>
 <20210510130011.1441834-4-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510130011.1441834-4-gscrivan@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 03:00:11PM +0200, Giuseppe Scrivano wrote:
> when the "shadow" mode is enabled for the user namespace, do not copy
> to userspace the groups that are not mapped.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  fs/proc/array.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 7ec59171f197..81dc733773d4 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -202,9 +202,17 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
>  
>  	seq_puts(m, "\nGroups:\t");
>  	group_info = cred->group_info;
> -	for (g = 0; g < group_info->ngroups; g++)
> +	for (g = 0; g < group_info->ngroups; g++) {
> +		gid_t gid = from_kgid(user_ns, group_info->gid[g]);
> +
> +		if (gid == (gid_t)-1) {
> +			if (user_ns->flags & USERNS_SETGROUPS_SHADOW)
> +				continue;
> +			gid = overflowgid;
> +		}
>  		seq_put_decimal_ull(m, g ? " " : "",
> -				from_kgid_munged(user_ns, group_info->gid[g]));
> +				gid);
> +	}
>  	put_cred(cred);
>  	/* Trailing space shouldn't have been added in the first place. */
>  	seq_putc(m, ' ');
> -- 
> 2.31.1
