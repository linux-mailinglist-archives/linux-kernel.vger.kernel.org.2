Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B06232F146
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCEReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhCEReb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614965670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkT378Zv4yJUHyZkLieQ0MFza1QZzhTcL7Qc6lCNQpE=;
        b=AN/t33H1qc/GK38/jf6gBhihWv+lgX9l8srdRRD8pGYMHPfqXYOSz59qK8EZK0Xwp2MKvv
        IudIYlRgqPt3m48+P21nm1jmkDGPVJXn1PkKaGgQQy4CPU3xmFFisVGuO0CQEcpwEDREtu
        0eIS80jrGWCcHWjQxzdugOml6VAjWQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-rR0fVLToMFWODHO-JJAveQ-1; Fri, 05 Mar 2021 12:34:26 -0500
X-MC-Unique: rR0fVLToMFWODHO-JJAveQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7048108BD08;
        Fri,  5 Mar 2021 17:34:24 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB77B19D7D;
        Fri,  5 Mar 2021 17:34:22 +0000 (UTC)
Subject: Re: [PATCH v4] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org
References: <20210304161704.3056806-1-minchan@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <98637abc-3b64-5bbc-f270-55619e12dccd@redhat.com>
Date:   Fri, 5 Mar 2021 18:34:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304161704.3056806-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.21 17:17, Minchan Kim wrote:
> Since CMA is getting used more widely, it's more important to
> keep monitoring CMA statistics for system health since it's
> directly related to user experience.
> 
> This patch introduces sysfs statistics for CMA, in order to provide
> some basic monitoring of the CMA allocator.
> 
>   * the number of CMA page allocation attempts
>   * the number of CMA page allocation failures
> 
> These two values allow the user to calcuate the allocation
> failure rate for each CMA area.
> 
> e.g.)
>    /sys/kernel/mm/cma/WIFI/cma_alloc_pages_[attempts|fails]
>    /sys/kernel/mm/cma/SENSOR/cma_alloc_pages_[attempts|fails]
>    /sys/kernel/mm/cma/BLUETOOTH/cma_alloc_pages_[attempts|fails]
> 
> The cma_stat was intentionally allocated by dynamic allocation
> to harmonize with kobject lifetime management.
> https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  From v3 - https://lore.kernel.org/linux-mm/20210303205053.2906924-1-minchan@kernel.org/
>   * kmalloc_array - akpm
>   * add why cma_stat was implemented by dynamic allocation - akpm
>   * use !__GFP_NOWARN facility to print error - akpm
> 
>  From v2 - https://lore.kernel.org/linux-mm/20210208180142.2765456-1-minchan@kernel.org/
>   * sysfs doc and description modification - jhubbard
> 
>  From v1 - https://lore.kernel.org/linux-mm/20210203155001.4121868-1-minchan@kernel.org/
>   * fix sysfs build and refactoring - willy
>   * rename and drop some attributes - jhubbard
> 
>   Documentation/ABI/testing/sysfs-kernel-mm-cma |  25 ++++
>   mm/Kconfig                                    |   7 ++
>   mm/Makefile                                   |   1 +
>   mm/cma.c                                      |   6 +-
>   mm/cma.h                                      |  18 +++
>   mm/cma_sysfs.c                                | 110 ++++++++++++++++++
>   6 files changed, 166 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-cma
>   create mode 100644 mm/cma_sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> new file mode 100644
> index 000000000000..f518af819cee
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> @@ -0,0 +1,25 @@
> +What:		/sys/kernel/mm/cma/
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		/sys/kernel/mm/cma/ contains a subdirectory for each CMA
> +		heap name (also sometimes called CMA areas).
> +
> +		Each CMA heap subdirectory (that is, each
> +		/sys/kernel/mm/cma/<cma-heap-name> directory) contains the
> +		following items:
> +
> +			cma_alloc_pages_attempts
> +			cma_alloc_pages_fails

Nit: why "cma_" again when we are already under "/cma/" ?

I'd simply go with something like

"total_alloc_attempts"
"failed_alloc_attempts"

But maybe this has been discussed already.

> +
> +What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_pages_attempts
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		the number of pages CMA API tried to allocate
> +
> +What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_pages_fails
> +Date:		Feb 2021
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		the number of pages CMA API failed to allocate

This will be useful.

-- 
Thanks,

David / dhildenb

