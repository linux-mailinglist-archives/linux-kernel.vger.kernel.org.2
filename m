Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD98349309
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCYN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbhCYN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616678817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7dXEhzDM8nht06maXaxbRAGJ8eg/xNLTmKGD4z3kwA=;
        b=EK18sTDaBj39PI23U13KMS80VoDglDlrpAVmVX/n0AIYSplsbp/giS6UjaXCmI5Ui2JcoB
        XBDRp70gXE7lRSKt1R9D/ZDrEYQEdpN8U+N+9gu0sJ1vQBGpDB0p3ZD+3vfMACzsKdK00f
        5SkM1WURnmJzSYtZjsL+/6dhkeMv78E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-YCoyq08tM3i3hKt7da7ltA-1; Thu, 25 Mar 2021 09:26:53 -0400
X-MC-Unique: YCoyq08tM3i3hKt7da7ltA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 121D8108BD07;
        Thu, 25 Mar 2021 13:26:52 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0217269112;
        Thu, 25 Mar 2021 13:26:36 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] mm/migrate.c: fix potential indeterminate pte
 entry in migrate_vma_insert_page()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     jglisse@redhat.com, shy828301@gmail.com, aquini@redhat.com,
        apopple@nvidia.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210325131524.48181-1-linmiaohe@huawei.com>
 <20210325131524.48181-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b0cdddeb-c790-082b-810a-77c79de48557@redhat.com>
Date:   Thu, 25 Mar 2021 14:26:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325131524.48181-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 14:15, Miaohe Lin wrote:
> If the zone device page does not belong to un-addressable device memory,
> the variable entry will be uninitialized and lead to indeterminate pte
> entry ultimately. Fix this unexpected case and warn about it.
> 
> Fixes: df6ad69838fc ("mm/device-public-memory: device memory cache coherent with CPU")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/migrate.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dacbdc9710ac..87bbad578127 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2968,6 +2968,13 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
>   
>   			swp_entry = make_device_private_entry(page, vma->vm_flags & VM_WRITE);
>   			entry = swp_entry_to_pte(swp_entry);
> +		} else {
> +			/*
> +			 * For now we only support migrating to un-addressable
> +			 * device memory.
> +			 */
> +			pr_warn_once("Unsupported ZONE_DEVICE page type.\n");
> +			goto abort;
>   		}
>   	} else {
>   		entry = mk_pte(page, vma->vm_page_prot);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

