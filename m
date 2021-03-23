Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD05345BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCWK1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbhCWK0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616495209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1EVILgqN9eA2HDPMaXw6IaWbPaZYV9gku0uNytAiDc=;
        b=TePDuk/T3Q4pQT9YksXU/iShCPKATtNsyz3j3G5tBV3c0xW4NFsj/Ceuxiou83qzKZMAu5
        1R5NwUpCR/2h59WL1D0yT8Gvz6UNL+MYL95w2j+L7LvJvbk3rvMKwqB3N4XrsTUROmnUPe
        NVpv8BR5u2U4veeBWPA1g9GPBBIGNuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-PDZt6JGdOoCUdWrE5Fv-7A-1; Tue, 23 Mar 2021 06:26:47 -0400
X-MC-Unique: PDZt6JGdOoCUdWrE5Fv-7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7E481007467;
        Tue, 23 Mar 2021 10:26:45 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D26521ECB;
        Tue, 23 Mar 2021 10:26:44 +0000 (UTC)
Subject: Re: [PATCH 3/5] mm/migrate.c: fix potential indeterminate pte entry
 in migrate_vma_insert_page()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     jglisse@redhat.com, shy828301@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210320093701.12829-1-linmiaohe@huawei.com>
 <20210320093701.12829-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0bee2243-5771-4969-7b92-aaca67abc90c@redhat.com>
Date:   Tue, 23 Mar 2021 11:26:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210320093701.12829-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.21 10:36, Miaohe Lin wrote:
> If the zone device page does not belong to un-addressable device memory,
> the variable entry will be uninitialized and lead to indeterminate pte
> entry ultimately. Fix this unexpectant case and warn about it.

s/unexpectant/unexpected/

> 
> Fixes: df6ad69838fc ("mm/device-public-memory: device memory cache coherent with CPU")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/migrate.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 20a3bf75270a..271081b014cb 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2972,6 +2972,13 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
>   
>   			swp_entry = make_device_private_entry(page, vma->vm_flags & VM_WRITE);
>   			entry = swp_entry_to_pte(swp_entry);
> +		} else {
> +			/*
> +			 * For now we only support migrating to un-addressable
> +			 * device memory.
> +			 */
> +			WARN_ON(1);
> +			goto abort;

Fix it by crashing the kernel with panic_on_warn? :)

If this case can actual happen, than no WARN_ON() - rather a 
pr_warn_once(). If this case cannot happen, why do we even care (it's 
not a fix then)?


-- 
Thanks,

David / dhildenb

