Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953ED344E02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhCVSBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhCVSA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616436058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20BQI+v76FGYKrR9SYXiHB1x/TtE4NUd6bjBJmSu1sw=;
        b=i4aqPDxFVfGdc5tAlyyKiRd8uYvLSNvq/S6ftRmJrVN9dj+kotJ35Q4pzg5phJ1okb15kb
        sxLEBBz4GQ45FzkFt21ttzfTc9Eltfa0ipWbKEfKoL0uu1CxsYy05LZpZLqBBljcr/oU5n
        xEPX6Vrmp03qlhncAhuML4YKrg6aKrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-rzJ6FkYRMQi6SHbp6P78Ug-1; Mon, 22 Mar 2021 14:00:54 -0400
X-MC-Unique: rzJ6FkYRMQi6SHbp6P78Ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 282161922022;
        Mon, 22 Mar 2021 18:00:53 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D88FF19C9B;
        Mon, 22 Mar 2021 18:00:45 +0000 (UTC)
Date:   Mon, 22 Mar 2021 14:00:43 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jules Irenge <jbi.octave@gmail.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] audit: avoid -Wempty-body warning
Message-ID: <20210322180043.GP3141668@madcap2.tricolour.ca>
References: <20210322162807.679370-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322162807.679370-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-22 17:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about an empty statement when audit_remove_mark is defined to
> nothing:
> 
> kernel/auditfilter.c: In function 'audit_data_to_entry':
> kernel/auditfilter.c:609:51: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   609 |                 audit_remove_mark(entry->rule.exe); /* that's the template one */
>       |                                                   ^
> 
> Change the macros to use the usual "do { } while (0)" instead, and change a
> few more that were (void)0, for consistency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Richard Guy Briggs <rgb@redhat.com>

> ---
> v2: convert two more macros
> ---
>  kernel/audit.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 3b9c0945225a..1522e100fd17 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -292,8 +292,8 @@ extern void audit_filter_inodes(struct task_struct *tsk,
>  extern struct list_head *audit_killed_trees(void);
>  #else /* CONFIG_AUDITSYSCALL */
>  #define auditsc_get_stamp(c, t, s) 0
> -#define audit_put_watch(w) {}
> -#define audit_get_watch(w) {}
> +#define audit_put_watch(w) do { } while (0)
> +#define audit_get_watch(w) do { } while (0)
>  #define audit_to_watch(k, p, l, o) (-EINVAL)
>  #define audit_add_watch(k, l) (-EINVAL)
>  #define audit_remove_watch_rule(k) BUG()
> @@ -302,8 +302,8 @@ extern struct list_head *audit_killed_trees(void);
>  
>  #define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
>  #define audit_mark_path(m) ""
> -#define audit_remove_mark(m)
> -#define audit_remove_mark_rule(k)
> +#define audit_remove_mark(m) do { } while (0)
> +#define audit_remove_mark_rule(k) do { } while (0)
>  #define audit_mark_compare(m, i, d) 0
>  #define audit_exe_compare(t, m) (-EINVAL)
>  #define audit_dupe_exe(n, o) (-EINVAL)
> @@ -311,8 +311,8 @@ extern struct list_head *audit_killed_trees(void);
>  #define audit_remove_tree_rule(rule) BUG()
>  #define audit_add_tree_rule(rule) -EINVAL
>  #define audit_make_tree(rule, str, op) -EINVAL
> -#define audit_trim_trees() (void)0
> -#define audit_put_tree(tree) (void)0
> +#define audit_trim_trees() do { } while (0)
> +#define audit_put_tree(tree) do { } while (0)
>  #define audit_tag_tree(old, new) -EINVAL
>  #define audit_tree_path(rule) ""	/* never called */
>  #define audit_kill_trees(context) BUG()
> -- 
> 2.29.2
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

