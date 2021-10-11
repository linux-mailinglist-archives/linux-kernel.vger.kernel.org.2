Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AF84289A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhJKJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235430AbhJKJ3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:29:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACE8160F43;
        Mon, 11 Oct 2021 09:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633944466;
        bh=Dt5MeX2tT1X7mBUmN5a3zMu9srwH129Bf7E2NwAV4tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NT2X+4iOykQXYJO6z9x3ivxqEMpu/hzXy1UXKCidXgwsN8qQW82ABb3hVprUA1/y0
         7UkDnD0MjrJN7tpd/R2VvpiL/sjW7q6hDD9mogla2VguGHLcAWBbPmCDExJ3LwkkqF
         NAtSsN+XMymuj5hRjGcGmotuJDd66uItYy0/MpHaH7OikNYHgzWwRpusjUW/r4AYpv
         gt790QgNtEdXM6G9U2BfTeSyM5e1ObCRg7ag4YfCICWQG4FfNP/BsFyjUMOp7/C08X
         bLDi6AUxuoaGUclAZO+6idkt8GA4KK52oaDsciAGw0+ICWi6uLZJ2lb6BFiXnnhp/8
         uDDrPlhOExQYg==
Date:   Mon, 11 Oct 2021 12:27:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] memory-hotplug.rst: fix wrong
 /sys/module/memory_hotplug/parameters/ path
Message-ID: <YWQDjBi7EFtxMJ+1@kernel.org>
References: <20211011082058.6076-1-david@redhat.com>
 <20211011082058.6076-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011082058.6076-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:20:57AM +0200, David Hildenbrand wrote:
> We accidentially added a superfluous "s".
> 
> Fixes: ac3332c44767 ("memory-hotplug.rst: complete admin-guide overhaul")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/admin-guide/mm/memory-hotplug.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 27d748cb6ee0..ee00b70dedde 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -410,7 +410,7 @@ them with ``memory_hotplug.`` such as::
>  
>  and they can be observed (and some even modified at runtime) via::
>  
> -	/sys/modules/memory_hotplug/parameters/
> +	/sys/module/memory_hotplug/parameters/
>  
>  The following module parameters are currently defined:
>  
> -- 
> 2.31.1
> 

-- 
Sincerely yours,
Mike.
