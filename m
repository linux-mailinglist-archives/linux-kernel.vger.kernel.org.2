Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071DC32558A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhBYScq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233632AbhBYSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614277755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfzGu+zHWg2p+i66XPZV3ks1aV9WmLz08lBS5TZiOC0=;
        b=h20ll75XJleBtMOo//lxcS7hjuJ9G7Ys3TEZhmJ/zt9lxkR6RpI/O33oUCzutHy2XjfvO/
        7VLXkfx0H26q+SMBouxXIy0dCOS2IoYGNo2a88GMYNeRdiKe5ymN836wyjxV2splHDSoO7
        9k0ycXD/uzAtTTJhCsuNfGCO4ojBJnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-1wvELkEBMYypicKMm78Ucg-1; Thu, 25 Feb 2021 13:29:11 -0500
X-MC-Unique: 1wvELkEBMYypicKMm78Ucg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB6D191270;
        Thu, 25 Feb 2021 18:29:09 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE1E19C79;
        Thu, 25 Feb 2021 18:29:08 +0000 (UTC)
Subject: Re: [PATCH v2 6/7] x86/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-7-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <dc044ae2-efce-0639-87de-3a3167c07a06@redhat.com>
Date:   Thu, 25 Feb 2021 19:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209133854.17399-7-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 14:38, Oscar Salvador wrote:
> Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   arch/x86/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 72663de8b04c..81046b7adb10 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2440,6 +2440,10 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>   	def_bool y
>   	depends on MEMORY_HOTPLUG
>   
> +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> +	def_bool y
> +	depends on X86_64 && MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP_ENABLE

It depends on SPARSEMEM_VMEMMAP, no?

I think we could have

SPARSEMEM_VMEMMAP_ENABLE=y
and
SPARSEMEM_VMEMMAP=n

on manually tuned configs.

-- 
Thanks,

David / dhildenb

