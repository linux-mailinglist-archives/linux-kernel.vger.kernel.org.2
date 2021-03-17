Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1733F11B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCQNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231154AbhCQNWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615987368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSnnG24IL66GaSFjDi7U5DCQjtxnKgGm2JKqvViBmIc=;
        b=TgixGFY0oLaLak3skEIMUAbCkPyggNZUMbGVB4sk6D6QdfK8EdPqk7DuYt3CCuey+rjuir
        E/ic6NtltyrVjAsgTcArQGXsnZxi/1aq8+HkH1kjontG2rJpwfw7PioTHSJSzqrjM1Qd0p
        UhB2S7A15DA5l6dYvW2VkbeN39td6RY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-09nPzWmOMKuiqSUwbxBybg-1; Wed, 17 Mar 2021 09:22:46 -0400
X-MC-Unique: 09nPzWmOMKuiqSUwbxBybg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEBF7107ACCD;
        Wed, 17 Mar 2021 13:22:44 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DDCA5D9C0;
        Wed, 17 Mar 2021 13:22:43 +0000 (UTC)
Subject: Re: [PATCH] mm: Remove default DISCONTIGMEM_MANUAL
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210312141208.3465520-1-geert@linux-m68k.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <96c306db-ac18-cf35-76fa-0e122c01bc0f@redhat.com>
Date:   Wed, 17 Mar 2021 14:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312141208.3465520-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.21 15:12, Geert Uytterhoeven wrote:
> Commit 214496cb18700fd7 ("ia64: make SPARSEMEM default and disable
> DISCONTIGMEM") removed the last enabler of ARCH_DISCONTIGMEM_DEFAULT,
> hence the memory model can no longer default to DISCONTIGMEM_MANUAL.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> DISCONTIGMEM_MANUAL depends on ARCH_DISCONTIGMEM_ENABLE, which in turns
> depends on BROKEN, so probably all discontig memory support can be
> removed, too?
> ---
>   mm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 24c045b24b95069b..579254f10fb1bac6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -9,7 +9,6 @@ config SELECT_MEMORY_MODEL
>   choice
>   	prompt "Memory model"
>   	depends on SELECT_MEMORY_MODEL
> -	default DISCONTIGMEM_MANUAL if ARCH_DISCONTIGMEM_DEFAULT
>   	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT
>   	default FLATMEM_MANUAL
>   	help
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

