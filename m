Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0185B433800
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhJSOGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235925AbhJSOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634652275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d0rCoMfKMS7zIWycLSzJt3KGBTI8Jx5jkCltwYJxBTw=;
        b=Xt2LX0ltxMg8oUApwEN/xXpDJGKzCXixxG3Fo/Va1tnCm8UcuoolAy+cx+/CajrRcQ7iOM
        Ad+1jzM2TrEXpHHZkwEpQsEqSvj1SV8l8q8/9WUv8nvBAsaEDS1E///muf3xfNlMA93rAl
        zttd+mZ4832cUuf4N7VJ8m/cimtqui0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-_67lwXdhMgO5edrPfwolEw-1; Tue, 19 Oct 2021 10:04:31 -0400
X-MC-Unique: _67lwXdhMgO5edrPfwolEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D8510A8E00;
        Tue, 19 Oct 2021 14:04:29 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.10.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CCAB5C3E0;
        Tue, 19 Oct 2021 14:04:28 +0000 (UTC)
Subject: Re: [PATCH] locking/ww-mutex: use swap()
To:     cgel.zte@gmail.com, mingo@redhat.com
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211019032239.974296-1-deng.changcheng@zte.com.cn>
From:   Waiman Long <longman@redhat.com>
Message-ID: <a24c716b-258e-f698-c03e-e81b86b1dcf8@redhat.com>
Date:   Tue, 19 Oct 2021 10:04:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019032239.974296-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 11:22 PM, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> Use swap() in order to make code cleaner. Issue found by coccinelle.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   kernel/locking/test-ww_mutex.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 353004155d65..daad819fcd16 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -389,7 +389,7 @@ struct stress {
>   static int *get_random_order(int count)
>   {
>   	int *order;
> -	int n, r, tmp;
> +	int n, r;
>   
>   	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
>   	if (!order)
> @@ -401,9 +401,7 @@ static int *get_random_order(int count)
>   	for (n = count - 1; n > 1; n--) {
>   		r = get_random_int() % (n + 1);
>   		if (r != n) {
> -			tmp = order[n];
> -			order[n] = order[r];
> -			order[r] = tmp;
> +			swap(order[n], order[r]);
>   		}
>   	}
>   

You can also get rid of the {} as well. I will also suggest clarifying 
in the patch title that you are cleaning up WW mutex selftest instead of 
the WW mutex code itself as that was my initial assumption when I saw 
the subject line.

Cheers,
Longman

