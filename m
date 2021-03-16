Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704FE33DB42
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhCPRqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239087AbhCPRqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615916773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0Rc9AlR5VZpjh6F9+qzo94812lXmZf2NLEz1UriYA8=;
        b=Dj3POwKlgtKjWLOvFG/y7TJcJkdIM1LewuyUIKyKQNVMIZmljCJLLTg+SleNQa4NFyvU0f
        7n5ADa5+r8dET1BX5eaG6j4hvjrErUe+zy0bn8uZevWaOKxGzPsIQvOK5CGjy920LnNEYj
        tdObM/EgAxrHL3LJPU2jHdmVJyG12l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-nWhwtQY0MxqdtWFpKlBVrg-1; Tue, 16 Mar 2021 13:46:09 -0400
X-MC-Unique: nWhwtQY0MxqdtWFpKlBVrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 508B4192D78B;
        Tue, 16 Mar 2021 17:46:07 +0000 (UTC)
Received: from [10.36.114.203] (ovpn-114-203.ams2.redhat.com [10.36.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B328A5D9C0;
        Tue, 16 Mar 2021 17:46:04 +0000 (UTC)
Subject: Re: [PATCH] memblock: fix section mismatch warning again
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>
References: <20210316171347.14084-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f47fe1eb-aecf-d12c-ae30-76331227f9dc@redhat.com>
Date:   Tue, 16 Mar 2021 18:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316171347.14084-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.21 18:13, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Commit 34dc2efb39a2 ("memblock: fix section mismatch warning") marked
> memblock_bottom_up() and memblock_set_bottom_up() as __init, but they could
> be referenced from non-init functions like memblock_find_in_range_node() on
> architectures that enable CONFIG_ARCH_KEEP_MEMBLOCK.
> 
> For such builds kernel test robot reports:
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> WARNING: modpost: vmlinux.o(.text+0x74fea4): Section mismatch in reference from the function memblock_find_in_range_node() to the function .init.text:memblock_bottom_up()
> The function memblock_find_in_range_node() references
> the function __init memblock_bottom_up().
> This is often because memblock_find_in_range_node lacks a __init
> annotation or the annotation of memblock_bottom_up is wrong.
> 
> Replace __init annotations with __init_memblock annotations so that the
> appropriate section will be selected depending on
> CONFIG_ARCH_KEEP_MEMBLOCK.
> 
> Link: https://lore.kernel.org/lkml/202103160133.UzhgY0wt-lkp@intel.com
> Fixes: 34dc2efb39a2 ("memblock: fix section mismatch warning")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> @Andrew, please let me know if you'd prefer this merged via memblock tree.
> 
>   include/linux/memblock.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index d13e3cd938b4..5984fff3f175 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -460,7 +460,7 @@ static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
>   /*
>    * Set the allocation direction to bottom-up or top-down.
>    */
> -static inline __init void memblock_set_bottom_up(bool enable)
> +static inline __init_memblock void memblock_set_bottom_up(bool enable)
>   {
>   	memblock.bottom_up = enable;
>   }
> @@ -470,7 +470,7 @@ static inline __init void memblock_set_bottom_up(bool enable)
>    * if this is true, that said, memblock will allocate memory
>    * in bottom-up direction.
>    */
> -static inline __init bool memblock_bottom_up(void)
> +static inline __init_memblock bool memblock_bottom_up(void)
>   {
>   	return memblock.bottom_up;
>   }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

