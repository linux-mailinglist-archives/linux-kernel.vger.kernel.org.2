Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF1325590
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhBYSdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232767AbhBYSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614277771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbqWUVMY6tSaL9bDCxH6oMgHNdGbX5cYM1a/vpwBq1U=;
        b=FlSsvI6CZZ6R+4Ik8cqFyXboV/wE1whcpPxJv8P8Q70Wfg9n+IRab8AW95XylTSiHN3lyd
        sdx4miCgX1AjaA+1ieTnyTSLKFpReopWjwzO33+H8yMOy+Kd62GGScaBkM1UvgB0UGxeYI
        MrjYyTVxxQDqKrnkJsyBtVCk2lrdupc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-_fhxkUAAOdaEmE-rjriH8Q-1; Thu, 25 Feb 2021 13:29:27 -0500
X-MC-Unique: _fhxkUAAOdaEmE-rjriH8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9211E9126D;
        Thu, 25 Feb 2021 18:29:25 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0157019C79;
        Thu, 25 Feb 2021 18:29:23 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] arm64/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-8-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <126fa740-c163-1463-ff48-dbec4ad17ed7@redhat.com>
Date:   Thu, 25 Feb 2021 19:29:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209133854.17399-8-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 14:38, Oscar Salvador wrote:
> Enable arm64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   arch/arm64/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 87fd02a7a62f..d4fb29779cd4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -309,6 +309,10 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
>   config ARCH_ENABLE_MEMORY_HOTREMOVE
>   	def_bool y
>   
> +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> +	def_bool y
> +	depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP_ENABLE
> +

Same comment as for x86-64 variant.


-- 
Thanks,

David / dhildenb

