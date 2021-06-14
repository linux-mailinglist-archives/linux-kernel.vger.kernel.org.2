Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687A43A61DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhFNKwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234428AbhFNKpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623667399;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zy+b/kZGPc49gDDzmNIOC/bmP2Wuxxr/mBO3XiN3c14=;
        b=I/T9tz/++/Rq0qsH7Ul0uPduGops6PBeK59GydDrRDHDG7PscyTs5gxg70DGcTsDPfNuOh
        ppTlBbL5IV7tdXBz5koA3iZ3FmFzPZ+y4cRrkmHYtbhgRlj9KGXAZyhNx569yzhZwkHWVP
        jipB+ktZ+yuKQi87WTeY05mUGCgeVBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-7TtOCIlBM7Sy4OCb8P09mw-1; Mon, 14 Jun 2021 06:43:16 -0400
X-MC-Unique: 7TtOCIlBM7Sy4OCb8P09mw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DD76108E564;
        Mon, 14 Jun 2021 10:43:15 +0000 (UTC)
Received: from [10.64.54.47] (vpn2-54-47.bne.redhat.com [10.64.54.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A32F85D6D5;
        Mon, 14 Jun 2021 10:43:13 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/mm: Use CONT_PMD_SHIFT for ARM64_MEMSTART_SHIFT
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <1623663755-8949-1-git-send-email-anshuman.khandual@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <3d0bdd54-ea21-8300-83e6-6d8f258df4b3@redhat.com>
Date:   Mon, 14 Jun 2021 22:44:18 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1623663755-8949-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 7:42 PM, Anshuman Khandual wrote:
> ARM64_MEMSTART_SIZE needs to be aligned with CONT_PMD_SIZE on 16K page size
> config. Hence just directly use CONT_PMD_SHIFT.
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
>   arch/arm64/include/asm/kernel-pgtable.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Yes, It makes the code a bit more understandable.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index 88b8d681ad91..a848da2b4d90 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -125,7 +125,7 @@
>   #if defined(CONFIG_ARM64_4K_PAGES)
>   #define ARM64_MEMSTART_SHIFT		PUD_SHIFT
>   #elif defined(CONFIG_ARM64_16K_PAGES)
> -#define ARM64_MEMSTART_SHIFT		(PMD_SHIFT + 5)
> +#define ARM64_MEMSTART_SHIFT		CONT_PMD_SHIFT
>   #else
>   #define ARM64_MEMSTART_SHIFT		PMD_SHIFT
>   #endif
> 

