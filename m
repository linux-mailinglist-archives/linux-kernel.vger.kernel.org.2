Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7E34DE18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhC3CNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231334AbhC3CNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617070399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uZvmLOyjGxiylwkLXr7HOZ2Iiu1GbVS4JDzxWUEai60=;
        b=Wf0fIcnKXxqMxCG9QlPlYO/yqgQQo+v9f1PCCT+bmAspJJsigSBzPRqaWXCiZgbchtM6Tl
        oDgR3oFCWZONEt9JciLwh+5VtWuNELUj2TY9TuDLfEm31ejSLsSl50YUQDY/vOb1mxE8/S
        Q99FnkkRYVn6jToQY2Mn6960LIE6xKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372--97ETBwDOvaICFQ7C-yWWA-1; Mon, 29 Mar 2021 22:13:17 -0400
X-MC-Unique: -97ETBwDOvaICFQ7C-yWWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59ADD8030BB;
        Tue, 30 Mar 2021 02:13:16 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-139.rdu2.redhat.com [10.10.118.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E8E66BC2D;
        Tue, 30 Mar 2021 02:13:15 +0000 (UTC)
Subject: Re: [PATCH -tip] locking: Move CONFIG_LOCK_EVENT_COUNTS into Kernel
 hacking section
To:     Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org,
        mingo@redhat.com
Cc:     will@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20210330020636.112594-1-dave@stgolabs.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9c703d99-c08c-ad9d-e60d-d786737cfd6f@redhat.com>
Date:   Mon, 29 Mar 2021 22:13:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330020636.112594-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 10:06 PM, Davidlohr Bueso wrote:
> It's a lot more intuitive to have it in the locking section of the kernel
> hacking part rather than under "General architecture-dependent options".
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>   arch/Kconfig      | 9 ---------
>   lib/Kconfig.debug | 9 +++++++++
>   2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ecfd3520b676..d6f9aeaaf9f2 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1113,15 +1113,6 @@ config HAVE_ARCH_PREL32_RELOCATIONS
>   config ARCH_USE_MEMREMAP_PROT
>   	bool
>   
> -config LOCK_EVENT_COUNTS
> -	bool "Locking event counts collection"
> -	depends on DEBUG_FS
> -	help
> -	  Enable light-weight counting of various locking related events
> -	  in the system with minimal performance impact. This reduces
> -	  the chance of application behavior change because of timing
> -	  differences. The counts are reported via debugfs.
> -
>   # Select if the architecture has support for applying RELR relocations.
>   config ARCH_HAS_RELR
>   	bool
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2779c29d9981..76639ff5998c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1401,6 +1401,15 @@ config DEBUG_LOCKING_API_SELFTESTS
>   	  The following locking APIs are covered: spinlocks, rwlocks,
>   	  mutexes and rwsems.
>   
> +config LOCK_EVENT_COUNTS
> +	bool "Locking event counts collection"
> +	depends on DEBUG_FS
> +	help
> +	  Enable light-weight counting of various locking related events
> +	  in the system with minimal performance impact. This reduces
> +	  the chance of application behavior change because of timing
> +	  differences. The counts are reported via debugfs.
> +
>   config LOCK_TORTURE_TEST
>   	tristate "torture tests for locking"
>   	depends on DEBUG_KERNEL

It looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

