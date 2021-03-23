Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C834550C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhCWBjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231516AbhCWBj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616463566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nu+yoWMzzgGr1gCDRbvEmZk3Z9T6e6oSH4qrWWkWJtw=;
        b=OGnN1hQ5/YsrwhcunNW6Re/I1gdPX4izceCJAVMTtjg+tBzkNwNeI/+S36XpJEoExurf2d
        H4PN3vO1ZnkK6WuOXzKi+U8pWsNe6Qhe6TqrCuyA11JH8JecDEjyn8ALGBOuTLe4Jbnvsn
        00txOpUCqkPjutBA+gavkDm3prblY10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-SQ1GQ4yAM0izyxevZ022VQ-1; Mon, 22 Mar 2021 21:39:24 -0400
X-MC-Unique: SQ1GQ4yAM0izyxevZ022VQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00C011084C83;
        Tue, 23 Mar 2021 01:39:23 +0000 (UTC)
Received: from llong.remote.csb (ovpn-114-80.rdu2.redhat.com [10.10.114.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B70B5946D;
        Tue, 23 Mar 2021 01:39:21 +0000 (UTC)
Subject: Re: [PATCH] locking/mutex: Remove repeated declaration
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <1616461774-18644-1-git-send-email-zhangshaokun@hisilicon.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d73b1039-c05d-c153-644e-ed260a57e4f1@redhat.com>
Date:   Mon, 22 Mar 2021 21:39:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1616461774-18644-1-git-send-email-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 9:09 PM, Shaokun Zhang wrote:
> Commit 0cd39f4600ed ("locking/seqlock, headers: Untangle the spaghetti monster")
> introduces 'struct ww_acquire_ctx' again, remove the repeated declaration.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>   include/linux/mutex.h | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 0cd631a19727..d80c0e22c822 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -20,8 +20,6 @@
>   #include <linux/osq_lock.h>
>   #include <linux/debug_locks.h>
>   
> -struct ww_acquire_ctx;
> -
>   /*
>    * Simple, straightforward mutexes with strict semantics:
>    *

Yes, it is duplicated.

Acked-by: Waiman Long <longman@redhat.com>

