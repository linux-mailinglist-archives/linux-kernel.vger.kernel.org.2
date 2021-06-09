Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0863A15DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhFINpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229947AbhFINpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623246229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rV8ZGl7nOVrwTAD0AfXkO6/3osdPkBnmuwDq6GdUck=;
        b=fbLNGvKx8jXO8P+mTitGV78U4MjmkLCCFcsPNueQs2GaSncXZRBlNaq/MkQz+YzlNVFACy
        aw09vPF3XIwb8tStgALneydIkyEeQp8/bapDHfXG0DBxgBhbwtsO+2JnLURmeOX0c8gH/Z
        gy+NgBogwNKvJHrSoJC8ZY7wjKWW0cY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-pXnEspSfMJaFB5-VM_cLKQ-1; Wed, 09 Jun 2021 09:43:48 -0400
X-MC-Unique: pXnEspSfMJaFB5-VM_cLKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F355F80ED8B;
        Wed,  9 Jun 2021 13:43:46 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F9EA60BD8;
        Wed,  9 Jun 2021 13:43:39 +0000 (UTC)
Date:   Wed, 9 Jun 2021 09:43:36 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit <linux-audit@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] audit: remove trailing spaces and tabs
Message-ID: <20210609134336.GA323137@madcap2.tricolour.ca>
References: <20210609022701.13768-1-thunder.leizhen@huawei.com>
 <20210609022701.13768-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609022701.13768-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-09 10:27, Zhen Lei wrote:
> Run the following command to find and remove the trailing spaces and tabs:
> 
> sed -r -i 's/[ \t]+$//' <audit_files>
> 
> The files to be checked are as follows:
> kernel/audit*
> include/linux/audit.h
> include/uapi/linux/audit.h
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  include/uapi/linux/audit.h | 4 ++--
>  kernel/audit.h             | 2 +-
>  kernel/auditsc.c           | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index cd2d8279a5e4..daa481729e9b 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -48,7 +48,7 @@
>   * 2500 - 2999 future user space (maybe integrity labels and related events)
>   *
>   * Messages from 1000-1199 are bi-directional. 1200-1299 & 2100 - 2999 are
> - * exclusively user space. 1300-2099 is kernel --> user space 
> + * exclusively user space. 1300-2099 is kernel --> user space
>   * communication.
>   */
>  #define AUDIT_GET		1000	/* Get status */
> @@ -78,7 +78,7 @@
>  #define AUDIT_LAST_USER_MSG	1199
>  #define AUDIT_FIRST_USER_MSG2	2100	/* More user space messages */
>  #define AUDIT_LAST_USER_MSG2	2999
> - 
> +
>  #define AUDIT_DAEMON_START      1200    /* Daemon startup record */
>  #define AUDIT_DAEMON_END        1201    /* Daemon normal stop record */
>  #define AUDIT_DAEMON_ABORT      1202    /* Daemon error stop record */
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 1522e100fd17..cab3e2652dab 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -/* audit -- definition of audit_context structure and supporting types 
> +/* audit -- definition of audit_context structure and supporting types
>   *
>   * Copyright 2003-2004 Red Hat, Inc.
>   * Copyright 2005 Hewlett-Packard Development Company, L.P.
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 0a9a1569f1ea..679a43fd342a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -343,13 +343,13 @@ static int audit_compare_uid(kuid_t uid,
>  {
>  	struct audit_names *n;
>  	int rc;
> - 
> +
>  	if (name) {
>  		rc = audit_uid_comparator(uid, f->op, name->uid);
>  		if (rc)
>  			return rc;
>  	}
> - 
> +
>  	if (ctx) {
>  		list_for_each_entry(n, &ctx->names_list, list) {
>  			rc = audit_uid_comparator(uid, f->op, n->uid);
> @@ -367,13 +367,13 @@ static int audit_compare_gid(kgid_t gid,
>  {
>  	struct audit_names *n;
>  	int rc;
> - 
> +
>  	if (name) {
>  		rc = audit_gid_comparator(gid, f->op, name->gid);
>  		if (rc)
>  			return rc;
>  	}
> - 
> +
>  	if (ctx) {
>  		list_for_each_entry(n, &ctx->names_list, list) {
>  			rc = audit_gid_comparator(gid, f->op, n->gid);
> -- 
> 2.25.1
> 
> 
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

