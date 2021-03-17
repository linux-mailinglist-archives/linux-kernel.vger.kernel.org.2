Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18C33FBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 00:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCQXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 19:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhCQXbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616023905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdcDu4uEmb1eSK2V7bwyocTRQ2MzFIdiB9GCAFGjzXY=;
        b=GFqEVycq97/TC37T0slLAq1picJL063hLWrjwAJoXkagfTrlu1euuXY8lscxrtKCNRBprw
        wICE43KA5DGZnENQLX5OUza98JlExZcbBPg1+7IVexGXWRbje2kiPs6NUO2ZfBb9Kb8eb1
        LmxbgS8MbcSz9ZouIYtDVQP6JKE2Z4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-kG8db3gKNZmR9BlA4P7Wlg-1; Wed, 17 Mar 2021 19:31:41 -0400
X-MC-Unique: kG8db3gKNZmR9BlA4P7Wlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F184081431C;
        Wed, 17 Mar 2021 23:31:39 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-171.rdu2.redhat.com [10.10.117.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14948648A1;
        Wed, 17 Mar 2021 23:31:38 +0000 (UTC)
Subject: Re: [PATCH] kernel: locking: Mundane typo fix in the file rwsem.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210317041806.4096156-1-unixbhaskar@gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <590c6465-b825-5b8c-5457-24f334e8423e@redhat.com>
Date:   Wed, 17 Mar 2021 19:31:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317041806.4096156-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 12:18 AM, Bhaskar Chowdhury wrote:
> s/folowing/following/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>   kernel/locking/rwsem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index abba5df50006..fe9cc65cd522 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -632,7 +632,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>   }
>
>   /*
> - * The rwsem_spin_on_owner() function returns the folowing 4 values
> + * The rwsem_spin_on_owner() function returns the following 4 values
>    * depending on the lock owner state.
>    *   OWNER_NULL  : owner is currently NULL
>    *   OWNER_WRITER: when owner changes and is a writer
> --
> 2.30.2
>
Acked-by: Waiman Long <longman@redhat.com>

