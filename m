Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42C532556C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhBYS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232310AbhBYS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614277566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45c6m4WbZCO0Bg89FJQVNFjxCGLWSobx/9ATf/zrYMM=;
        b=BXaZli4iOMaFZ5Bnr4XvI+x1Js8BqodxqVxYy9ZZtAf/uj996Bldqn44iyxreohErsmmGv
        Em4//GjMKmWzZAmo59IobVprhlwstKYgBGuuvphtlUr973+cuU2hGR4LVTrmtQnbjlmIUg
        hBEY7yIpZutkklFaoxtj8jx2hMinogA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-NoCWPi4jPs6Qqiz8EuT6PQ-1; Thu, 25 Feb 2021 13:26:02 -0500
X-MC-Unique: NoCWPi4jPs6Qqiz8EuT6PQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A18A018B9EC3;
        Thu, 25 Feb 2021 18:26:00 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE1395C224;
        Thu, 25 Feb 2021 18:25:58 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] mm,memory_hotplug: Add kernel boot option to
 enable memmap_on_memory
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <02041ab3-dcbd-9056-5571-48b84f527e42@redhat.com>
Date:   Thu, 25 Feb 2021 19:25:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209133854.17399-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9bcc460e8bfe..95695483a622 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -42,7 +42,31 @@
>   #include "internal.h"
>   #include "shuffle.h"
>   
> -static bool memmap_on_memory_enabled;
> +/*
> + * memory_hotplug.memmap_on_memory parameter
> + */
> +static bool memmap_on_memory_enabled __ro_after_init;
> +
> +static int memmap_on_memory_show(char *buffer, const struct kernel_param *kp)
> +{
> +	return sprintf(buffer, "%s\n",
> +		       memmap_on_memory_enabled ? "on" : "off");
> +}
> +
> +static __meminit int memmap_on_memory_store(const char *val,
> +					    const struct kernel_param *kp)
> +{
> +	/*
> +	 * Fail silently in case we cannot enable it due to platform constraints.
> +	 * User can always check whether it is enabled or not via /sys/module.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE))
> +		return 0;
> +
> +	return param_set_bool(val, kp);
> +}
> +module_param_call(memmap_on_memory, memmap_on_memory_store,
> +		  memmap_on_memory_show, &memmap_on_memory_enabled, 0400);

Why are other users not allowed to read?

>   

Might want to add a MODULE_PARM_DESC().


As we fail silently already, I'd keep it simple and use a

module_param(memmap_on_memory, bool, 0444);

moving the IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) into the 
runtime check.


Apart from that LGTM.

-- 
Thanks,

David / dhildenb

