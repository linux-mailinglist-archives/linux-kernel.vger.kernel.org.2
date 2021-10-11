Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5864289A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhJKJ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235443AbhJKJ3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B70560EB6;
        Mon, 11 Oct 2021 09:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633944441;
        bh=361wF0ts4s/b4c9Mi+UY36X5l5csekZIjvRo6UEfjWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPVYbzXdqcWIGa3ZJ2ntg+Id9meXu2sa9R86p3FL+IohNRgLQiOiaNzjMiNVKCt5m
         cls7LhHU3OyziiCtsNTSD59IG4CZ4bhoubq5utmdsP6ol7XtEYImW4ZWrcR/kDEnLv
         jNlncvxHoe+4xLPbuXVsyA+0uthrIPe4osTQBrNyO3baXu9iTJg2wLw+s5tO6JAw+2
         OdDZ+G0lO8fYtIGjAt/upma4MVFX2zeM9VkWpVWuQrcnZRY4wmmSxRvH9pW0wkvZxu
         MeOfOh4gtF7uK5Qb93fuvoCa3fdVNthrpuW0EwBsPqDyzBoPCotAfziTr1UZHGskMT
         xQHCm+qwRBdQQ==
Date:   Mon, 11 Oct 2021 12:27:13 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] memory-hotplug.rst: fix two instances of
 "movablecore" that should be "movable_node"
Message-ID: <YWQDcROoBoreeiHZ@kernel.org>
References: <20211011082058.6076-1-david@redhat.com>
 <20211011082058.6076-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011082058.6076-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:20:56AM +0200, David Hildenbrand wrote:
> We really want to refer to the "movable_node" kernel command line
> parameter here.
> 
> Fixes: ac3332c44767 ("memory-hotplug.rst: complete admin-guide overhaul")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/admin-guide/mm/memory-hotplug.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 03dfbc925252..27d748cb6ee0 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -166,7 +166,7 @@ Or alternatively::
>  	% echo 1 > /sys/devices/system/memory/memoryXXX/online
>  
>  The kernel will select the target zone automatically, usually defaulting to
> -``ZONE_NORMAL`` unless ``movablecore=1`` has been specified on the kernel
> +``ZONE_NORMAL`` unless ``movable_node`` has been specified on the kernel
>  command line or if the memory block would intersect the ZONE_MOVABLE already.
>  
>  One can explicitly request to associate an offline memory block with
> @@ -393,7 +393,7 @@ command line parameters are relevant:
>  ======================== =======================================================
>  ``memhp_default_state``	 configure auto-onlining by essentially setting
>                           ``/sys/devices/system/memory/auto_online_blocks``.
> -``movablecore``		 configure automatic zone selection of the kernel. When
> +``movable_node``	 configure automatic zone selection in the kernel. When
>  			 set, the kernel will default to ZONE_MOVABLE, unless
>  			 other zones can be kept contiguous.
>  ======================== =======================================================
> -- 
> 2.31.1
> 

-- 
Sincerely yours,
Mike.
