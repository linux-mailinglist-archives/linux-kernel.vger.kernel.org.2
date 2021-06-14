Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1197C3A60AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhFNKgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232755AbhFNKd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623666713;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6nGrqiW9FYJJEgVuL413WY5/v8GKOF9AwrYzHSE1BA=;
        b=FK5EQjIaaV2uxB7yJbtN8maysC33qHFDSSSkD8sYuHRKM1NTYWYafMd1cq4QNFB3QASdP5
        JHrUj5Eew7yoBXp1d4pSvdA8tbSF52MSUzMQY2b4ihz0joxK5/B9VnEVWc38TuTapoJ+GF
        ojjE27yNKco6bVsM89W5JO7fyRv7TwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-69Z-a6sxPNCpcwaqGwybNg-1; Mon, 14 Jun 2021 06:31:52 -0400
X-MC-Unique: 69Z-a6sxPNCpcwaqGwybNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EE378B7CE8;
        Mon, 14 Jun 2021 10:31:37 +0000 (UTC)
Received: from [10.64.54.47] (vpn2-54-47.bne.redhat.com [10.64.54.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B31FE5C290;
        Mon, 14 Jun 2021 10:31:34 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/mm: Drop SWAPPER_INIT_MAP_SIZE
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <1623665411-20055-1-git-send-email-anshuman.khandual@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <d4af3ec0-2e2f-af1e-f536-e27aa62b876e@redhat.com>
Date:   Mon, 14 Jun 2021 22:32:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1623665411-20055-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 8:10 PM, Anshuman Khandual wrote:
> The commit cdef5f6e9e0e ("arm64: mm: allocate pagetables anywhere") had
> dropped the last reference to SWAPPER_INIT_MAP_SIZE. Hence just clean up.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.13-rc6.
> 
>   arch/arm64/include/asm/kernel-pgtable.h | 3 ---
>   1 file changed, 3 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index a848da2b4d90..1260187adb31 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -100,9 +100,6 @@
>   #define SWAPPER_TABLE_SHIFT	PMD_SHIFT
>   #endif
>   
> -/* The size of the initial kernel direct mapping */
> -#define SWAPPER_INIT_MAP_SIZE	(_AC(1, UL) << SWAPPER_TABLE_SHIFT)
> -
>   /*
>    * Initial memory map attributes.
>    */
> 

