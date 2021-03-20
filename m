Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9251A3429A1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCTB3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCTB3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:29:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD8C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lZ72DR0JBriXOEy1p12Xse5hT6u7MvojIma09GLzZPw=; b=RyZmlt1HYn0MVJvK0168mX7AZb
        aDZXmw46BPSEAmY9KCgpOJANACBZ6SToP+bbYx1jvgvTmwIQMMS4YsR2wGg7yMfzE3vAW+jSLODrF
        k3ay/rME+DykOZDsDasViNkxA22y9uROX5SNnEBauGQpVpbilNZoFUrO659Le/EZNNJbWAzkp54LX
        fJZRHdb+ST+05ZJWLPnX74mCey7yn7mgSUyKVS+Y0eyDyoUNFkbqRDnhPNLoZ14vh+kmZ0p5BUNCu
        kR2qy6zv3mlhmmnkV0cG9lzNVASQfjCvA70w7/LK0CMn4UyS8SVuRDZYLq3JNxicE/J5zMIpkLqPp
        VrKEYC4g==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNQQs-001dzW-66; Sat, 20 Mar 2021 01:29:39 +0000
Date:   Fri, 19 Mar 2021 18:29:38 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     akpm@linux-foundation.org, gustavoars@kernel.org,
        adobriyan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/sem.c: Couple of spelling fixes
In-Reply-To: <20210319221432.26631-1-unixbhaskar@gmail.com>
Message-ID: <9a2e73f8-44ae-68b2-b588-b3dc5accaf12@bombadil.infradead.org>
References: <20210319221432.26631-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_182938_246484_6C28927F 
X-CRM114-Status: GOOD (  12.32  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote: > > s/purpuse/purpose/
    > s/seperately/separately/ > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
    Acked-by: Randy Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/purpuse/purpose/
> s/seperately/separately/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> ipc/sem.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index f6c30a85dadf..780d75eff8c6 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -786,7 +786,7 @@ static inline void wake_up_sem_queue_prepare(struct sem_queue *q, int error,
> {
> 	get_task_struct(q->sleeper);
>
> -	/* see SEM_BARRIER_2 for purpuse/pairing */
> +	/* see SEM_BARRIER_2 for purpose/pairing */
> 	smp_store_release(&q->status, error);
>
> 	wake_q_add_safe(wake_q, q->sleeper);
> @@ -821,7 +821,7 @@ static inline int check_restart(struct sem_array *sma, struct sem_queue *q)
>
> 	/* It is impossible that someone waits for the new value:
> 	 * - complex operations always restart.
> -	 * - wait-for-zero are handled seperately.
> +	 * - wait-for-zero are handled separately.
> 	 * - q is a previously sleeping simple operation that
> 	 *   altered the array. It must be a decrement, because
> 	 *   simple increments never sleep.
> --
> 2.26.2
>
>
