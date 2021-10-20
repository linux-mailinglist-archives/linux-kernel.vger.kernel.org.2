Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B03434CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhJTOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhJTOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634738397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bILV1h5Bey/d05SVdo4Rk3tisTSU2oOWUvSWASvQCHY=;
        b=X5ln92o0/EJ99U9TIYcoV1dKVydd+0NZc0SyGeINg34q9g+/nf4mUopfjFxCXMn2/jQ9EM
        fbKGrwvtF2CEPUmAy6CSjRfOlyQfaDgk3kOtLITgkyiZ3trTyOYaHVTtpkIUizAwkB9l7Z
        r/E4U+hJ+8Shyr+krzjXyNhHVOBX/uI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-f9ysZXM5PtWHuHf6auRcog-1; Wed, 20 Oct 2021 09:59:54 -0400
X-MC-Unique: f9ysZXM5PtWHuHf6auRcog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E63948042D4;
        Wed, 20 Oct 2021 13:59:52 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.17.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B8EB709AF;
        Wed, 20 Oct 2021 13:59:30 +0000 (UTC)
Subject: Re: [PATCH] locking/test-ww_mutex: use swap()
To:     cgel.zte@gmail.com
Cc:     mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211020091545.1039063-1-deng.changcheng@zte.com.cn>
From:   Waiman Long <longman@redhat.com>
Message-ID: <caa4e95c-7992-526e-83d5-db154681c57b@redhat.com>
Date:   Wed, 20 Oct 2021 09:59:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211020091545.1039063-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 5:15 AM, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> Use swap() in order to make code cleaner. Issue found by coccinelle.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   kernel/locking/test-ww_mutex.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 353004155d65..fa021b8a9edc 100644
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
> @@ -400,11 +400,8 @@ static int *get_random_order(int count)
>   
>   	for (n = count - 1; n > 1; n--) {
>   		r = get_random_int() % (n + 1);
> -		if (r != n) {
> -			tmp = order[n];
> -			order[n] = order[r];
> -			order[r] = tmp;
> -		}
> +		if (r != n)
> +			swap(order[n], order[r]);
>   	}
>   
>   	return order;

Acked-by: Waiman Long <longman@redhat.com>

