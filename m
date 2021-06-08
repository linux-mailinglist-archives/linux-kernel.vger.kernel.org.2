Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E4839FA2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFHPUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230330AbhFHPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623165504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBcRBpcOo4L3CDuJBbhXspjotNiL1vJl7/gggLr39a4=;
        b=Pm/5mTNZMuew7XpGzwsFCGYyaMrQLfHRPvwFNpjwH6LlwA61GhM+j2CsK+KuQorY9s5IAS
        1Vm2mXCF54IiP+JYuoZGsnCbZAYTzOGmofEtQbGybgFHcxXwNkw9meH8N4t74VMWFZ/26K
        JEVdpOixEMO+2mbJlaxs/P/DfgTYX0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-6vId1EbSOUqak21Bki-ksw-1; Tue, 08 Jun 2021 11:18:23 -0400
X-MC-Unique: 6vId1EbSOUqak21Bki-ksw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60B94801B1D;
        Tue,  8 Jun 2021 15:17:52 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48B3619C45;
        Tue,  8 Jun 2021 15:17:47 +0000 (UTC)
Date:   Tue, 8 Jun 2021 11:17:44 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit <linux-audit@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] audit: remove trailing spaces and tabs
Message-ID: <20210608151744.GD2268484@madcap2.tricolour.ca>
References: <20210608075437.13120-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608075437.13120-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-08 15:54, Zhen Lei wrote:
> Run the following command to find and remove the trailing spaces and tabs:
> 
> sed -r -i 's/[ \t]+$//' kernel/audit*

The api header include/uapi/linux/audit.h should probably be included.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/audit.h   | 2 +-
>  kernel/auditsc.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
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

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

