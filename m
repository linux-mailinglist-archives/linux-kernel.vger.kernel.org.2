Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9C32EEDE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCEPc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbhCEPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614958336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70RyegRvPNC5pqq3VCTZet1dFoqmMfpUZ7l9Sl1Rv8M=;
        b=SgpK7zPFQhuIIHUtkQmp+68N7untLbKzxPEduyBcz2PCrXnHo4L53xHekPlDnRQdOguOti
        ZlVWAUhaE/83pMJJfOi9Xi77XPCMpUzZMWOomGmeYNwiImvs9SjxVouud6X+YDxYO+BBnt
        2pDC1Dz7eh0LYMmHZmopCKzJx27g8co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-cyFLjhXiOq2jvpPgZvvDEg-1; Fri, 05 Mar 2021 10:32:12 -0500
X-MC-Unique: cyFLjhXiOq2jvpPgZvvDEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D7DF26862;
        Fri,  5 Mar 2021 15:32:10 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1A5319934;
        Fri,  5 Mar 2021 15:32:08 +0000 (UTC)
Subject: Re: [PATCH v3 4/5] x86/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210304100002.7740-1-osalvador@suse.de>
 <20210304100002.7740-5-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a1df6c58-dab6-3eea-fbd9-3b25c887fc73@redhat.com>
Date:   Fri, 5 Mar 2021 16:32:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304100002.7740-5-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.21 11:00, Oscar Salvador wrote:
> Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   arch/x86/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2792879d398e..6d716d8bce1e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2433,6 +2433,10 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>   	def_bool y
>   	depends on MEMORY_HOTPLUG
>   
> +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> +	def_bool y
> +	depends on X86_64 && MEMORY_HOTPLUG

Was wondering if the MEMORY_HOTPLUG would also best be part of the 
generic MHP_MEMMAP_ON_MEMORY.

Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

