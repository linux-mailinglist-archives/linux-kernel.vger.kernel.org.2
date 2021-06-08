Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E8339F9D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhFHPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233747AbhFHPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623164541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Dzn+cPsGoR9HL9Ks0Iy6sPe041zFK35ddq5OYs2tdA=;
        b=RXWdpp1xAjJ9Do4Yovqb+WyaVrh9dGTdVnzcYWTrixXIrn0nbs1lFFkttmrDqnHzPYRA33
        48YvDKtp+jJ4oLTrktW6/eufwzFCB/tbgX9nXAaCNpPvjqZrHp1MhCtnXJzxPybq47eVMR
        4a2Af3fFUGIZToiH2SDVv6FeA9+0b4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-4wvNu7_PPZqcPp38yU7LXA-1; Tue, 08 Jun 2021 11:02:16 -0400
X-MC-Unique: 4wvNu7_PPZqcPp38yU7LXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56D751936B60;
        Tue,  8 Jun 2021 15:02:15 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34C0D19C45;
        Tue,  8 Jun 2021 15:02:06 +0000 (UTC)
Date:   Tue, 8 Jun 2021 11:02:03 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org, yuehaibing@huawei.com,
        yangjihong1@huawei.com, linux-audit@redhat.com, yukuai3@huawei.com,
        weiyongjun1@huawei.com
Subject: Re: [PATCH -next] audit: Use list_move instead of list_del/list_add
Message-ID: <20210608150203.GB2268484@madcap2.tricolour.ca>
References: <20210608031150.2821712-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608031150.2821712-1-libaokun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-08 11:11, Baokun Li wrote:
> Using list_move() instead of list_del() + list_add().

This should be slightly more efficient since there is no need to poison
the pointers.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Acked-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  kernel/audit_tree.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 6c91902f4f45..b2be4e978ba3 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -689,8 +689,7 @@ void audit_trim_trees(void)
>  
>  		tree = container_of(cursor.next, struct audit_tree, list);
>  		get_tree(tree);
> -		list_del(&cursor);
> -		list_add(&cursor, &tree->list);
> +		list_move(&cursor, &tree->list);
>  		mutex_unlock(&audit_filter_mutex);
>  
>  		err = kern_path(tree->pathname, 0, &path);
> @@ -899,8 +898,7 @@ int audit_tag_tree(char *old, char *new)
>  
>  		tree = container_of(cursor.next, struct audit_tree, list);
>  		get_tree(tree);
> -		list_del(&cursor);
> -		list_add(&cursor, &tree->list);
> +		list_move(&cursor, &tree->list);
>  		mutex_unlock(&audit_filter_mutex);
>  
>  		err = kern_path(tree->pathname, 0, &path2);
> @@ -925,8 +923,7 @@ int audit_tag_tree(char *old, char *new)
>  		mutex_lock(&audit_filter_mutex);
>  		spin_lock(&hash_lock);
>  		if (!tree->goner) {
> -			list_del(&tree->list);
> -			list_add(&tree->list, &tree_list);
> +			list_move(&tree->list, &tree_list);
>  		}
>  		spin_unlock(&hash_lock);
>  		put_tree(tree);
> @@ -937,8 +934,7 @@ int audit_tag_tree(char *old, char *new)
>  
>  		tree = container_of(barrier.prev, struct audit_tree, list);
>  		get_tree(tree);
> -		list_del(&tree->list);
> -		list_add(&tree->list, &barrier);
> +		list_move(&tree->list, &barrier);
>  		mutex_unlock(&audit_filter_mutex);
>  
>  		if (!failed) {
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

