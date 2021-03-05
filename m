Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264D732EEE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhCEPdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhCEPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614958360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgJ8sxY8HCi5m5r2jK4tmD3EXmrb51uSM7CkDCsQMfk=;
        b=VRk65q+f0cLm60M0wY3xqMBKTT9bfQ7wpKOHrDZ9T16nK56y99C6c0LA3RbxOMG5VFIxUl
        dX2zwynY4/Gsxknewx5rVFVsejZMdNO+UDD1ei8d9QJJlaNsXqEKkauz2mDkVUrXM+5HLP
        /CZwOOHL626HOuajAIiu16nocMuvBds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-rqJ_-S0xPWu-0WePjtFsEA-1; Fri, 05 Mar 2021 10:32:36 -0500
X-MC-Unique: rqJ_-S0xPWu-0WePjtFsEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAC3987A844;
        Fri,  5 Mar 2021 15:32:34 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EF815D9C6;
        Fri,  5 Mar 2021 15:32:32 +0000 (UTC)
Subject: Re: [PATCH v3 5/5] arm64/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210304100002.7740-1-osalvador@suse.de>
 <20210304100002.7740-6-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6bb2917b-ae84-9706-358b-7a6c4f529039@redhat.com>
Date:   Fri, 5 Mar 2021 16:32:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304100002.7740-6-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.21 11:00, Oscar Salvador wrote:
> Enable arm64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   arch/arm64/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1f212b47a48a..3c5380c626df 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -309,6 +309,10 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
>   config ARCH_ENABLE_MEMORY_HOTREMOVE
>   	def_bool y
>   
> +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> +	def_bool y
> +	depends on MEMORY_HOTPLUG
> +

Same thoughts regarding MEMORY_HOTPLUG

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

