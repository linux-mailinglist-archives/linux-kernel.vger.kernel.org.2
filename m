Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B38344D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhCVRTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbhCVRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616433556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifg8UBnvcv2ogQmlttPjHjavoKNWZ5bFson4LyffFw4=;
        b=cVwPQDme4tZ1KQ56tFIuQYumozejhuEEPrFTiMtgg+iQEYbXY0xqroCYoPLjDyXz7UdUXM
        Tx55X2DH+2ljrBku6m1fpXR9cs9anbD1OYZxcYXw5NuzCwpxtnufHxcXCHBrUlP5Dg6jYG
        1NnaO3eqLWhu6HpYH1+8k0D7OTvWpcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-uk3y9XgZMXq7xwyU-icxnw-1; Mon, 22 Mar 2021 13:19:14 -0400
X-MC-Unique: uk3y9XgZMXq7xwyU-icxnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1041B107BEF7;
        Mon, 22 Mar 2021 17:19:13 +0000 (UTC)
Received: from llong.remote.csb (ovpn-114-80.rdu2.redhat.com [10.10.114.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5187160BE5;
        Mon, 22 Mar 2021 17:19:12 +0000 (UTC)
Subject: Re: [PATCH] lockdep: add a hint for "INFO: trying to register
 non-static key." message
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20210321064913.4619-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9add0c6f-d75e-388f-5a34-5633f5829fc1@redhat.com>
Date:   Mon, 22 Mar 2021 13:19:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210321064913.4619-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/21 2:49 AM, Tetsuo Handa wrote:
> Since this message is printed when dynamically allocated spinlocks (e.g.
> kzalloc()) are used without initialization (e.g. spin_lock_init()),
> suggest developers to check whether initialization functions for objects
> are called, before making developers wonder what annotation is missing.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>   kernel/locking/lockdep.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c6d0c1dc6253..44c549f5c061 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -931,6 +931,7 @@ static bool assign_lock_key(struct lockdep_map *lock)
>   		debug_locks_off();
>   		pr_err("INFO: trying to register non-static key.\n");
>   		pr_err("the code is fine but needs lockdep annotation.\n");
> +		pr_err("maybe you didn't initialize this object before you use?\n");
>   		pr_err("turning off the locking correctness validator.\n");
>   		dump_stack();
>   		return false;

The only way this message is written is when the appropriate lock init 
function isn't called for locks in dynamically allocated objects. I 
think you can just say so without the word "maybe". Like "the code is 
fine but needs lockdep annotation by calling appropriate lock 
initialization function.".

Cheers,
Longman

