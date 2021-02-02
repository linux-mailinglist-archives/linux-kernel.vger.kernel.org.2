Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155A030BB4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhBBJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhBBJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612258948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ux0wb0Aaa8WBRcdg61WJ5IJSuoJkBlCKlUQLGc1hQ0E=;
        b=NVi8fqBrKueQsyWWLVfjp2Fa1Yke6dXXl1qClu+PqSSQY2DsSNys/5VZADCFBHjPt7hSPL
        kAmZKCgSpAHxEMvyRZhSwPi7Tt9VYrzqAY3fKaGBxM6rAlfPLRtkGkqMaN4vO51sSBJQGn
        3wCXzpXwOchCS85ZVcUnlWHgKFVI6t0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-nbS6OL-fMTyF7AZcSkKwaQ-1; Tue, 02 Feb 2021 04:42:26 -0500
X-MC-Unique: nbS6OL-fMTyF7AZcSkKwaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E02E107ACE4;
        Tue,  2 Feb 2021 09:42:25 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF245F9C9;
        Tue,  2 Feb 2021 09:42:23 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb.c: Fix typos in comments
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1612255593-8451-1-git-send-email-daizhiyuan@phytium.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4027b34b-4407-91cd-2b9c-3065044a31d0@redhat.com>
Date:   Tue, 2 Feb 2021 10:42:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1612255593-8451-1-git-send-email-daizhiyuan@phytium.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.21 09:46, Zhiyuan Dai wrote:
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> ---
>   mm/hugetlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18f6ee3..35db386 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3990,7 +3990,7 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
>   
>   /*
>    * This is called when the original mapper is failing to COW a MAP_PRIVATE
> - * mappping it owns the reserve page for. The intention is to unmap the page
> + * mapping it owns the reserve page for. The intention is to unmap the page
>    * from other VMAs and let the children be SIGKILLed if they are faulting the
>    * same region.
>    */
> 

I'm really sorry, but sending four times the same patch with different 
things messed up just for fixing a simple typo is absolutely annoying.

Please exercise sending patches somewhere else. This is just unnecessary 
noise on linux-mm.

-- 
Thanks,

David / dhildenb

