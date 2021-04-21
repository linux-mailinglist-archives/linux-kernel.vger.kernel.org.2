Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B94A367443
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbhDUUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 16:46:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:53730 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240376AbhDUUqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 16:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=D6uUhADjC6LU6MbgKADZIizPtViaFackH1IQC8VDEqM=; b=uU+27TpiWd+htOW4O
        tw/gHkfOHeXQgJhnht0TV6MhJyWKEEmfFDm6hDh+yw/VF17Pn/W1FipY9Ak7WD6aNR1X3BVDdUs0Y
        1MzmWB1BQbQWCgJwzWevNiMdnqEAo1jJ2qCQRHSIVBiGtaflSWGrQAW/zJExwMOsxQE8R0X4sb8EM
        =;
Received: from [192.168.15.132]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1lZJiw-0018k7-P7; Wed, 21 Apr 2021 23:45:26 +0300
Subject: Re: [PATCH 176/190] Revert "net/net_namespace: Check the return value
 of register_pernet_subsys()"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-177-gregkh@linuxfoundation.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c4cdd3fe-0fd1-c328-14f4-e428eee1d02c@virtuozzo.com>
Date:   Wed, 21 Apr 2021 23:45:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-177-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.2021 16:00, Greg Kroah-Hartman wrote:
> This reverts commit 0eb987c874dc93f9c9d85a6465dbde20fdd3884c.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/core/net_namespace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 43b6ac4c4439..9ae0b275238e 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -1101,8 +1101,7 @@ static int __init net_ns_init(void)
>  	init_net_initialized = true;
>  	up_write(&pernet_ops_rwsem);
>  
> -	if (register_pernet_subsys(&net_ns_ops))
> -		panic("Could not register network namespace subsystems");
> +	register_pernet_subsys(&net_ns_ops);

Nacked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

This patch does not have any problem, since it has been already carefully reviewed.
Kernel panics here only, if we can't allocate ns_common::inum for init_net.
This can be only a result of a critical deficiency of memory during boot.
