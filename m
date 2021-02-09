Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21AB31536A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhBIQIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:08:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232615AbhBIQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612886805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xwffJWUIzQSXf4SOdpUxpvUWn/I4bujEit2lpJS4OA=;
        b=Pr+F0OBWiphRpJEmLWkaLrsb/8RSMWb9wJBaeuUmkuTMQSMRwwQk9bNW/Br/J4DVKOi7AA
        4aoMluMxthIDQizTy7ADlrMXKazEyfb56sB/i5O40h+spQwPJjQ6V6AXfQc8Nykq+9iuNA
        V1xB5H9PSIOYofy4j7Ig6x1N30hzVW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-AGQhXGytM82fBZdCh1c2Tw-1; Tue, 09 Feb 2021 11:06:42 -0500
X-MC-Unique: AGQhXGytM82fBZdCh1c2Tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A710192D785;
        Tue,  9 Feb 2021 16:06:40 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1D90100239A;
        Tue,  9 Feb 2021 16:06:38 +0000 (UTC)
Subject: Re: [PATCH v2] mm: cma: Print region name on failure
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     rdunlap@infradead.org, pdaly@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <20210209142414.12768-1-georgi.djakov@linaro.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <37be751f-8c11-fd5a-a57f-a5e0599e2420@redhat.com>
Date:   Tue, 9 Feb 2021 17:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210209142414.12768-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 15:24, Georgi Djakov wrote:
> From: Patrick Daly <pdaly@codeaurora.org>
> 
> Print the name of the CMA region for convenience. This is useful
> information to have when cma_alloc() fails.
> 
> Signed-off-by: Patrick Daly <pdaly@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v2:
>   * Print the "count" variable, as it was originally in the code. (Randy)
>   * Fix spelling s/convienience/convenience/ in the commit text (Randy)
> 
> v1: https://lore.kernel.org/r/20210208115200.20286-1-georgi.djakov@linaro.org/
> 
>   mm/cma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 23d4a97c834a..54eee2119822 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -500,8 +500,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	}
>   
>   	if (ret && !no_warn) {
> -		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
> -			__func__, count, ret);
> +		pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
> +		       __func__, cma->name, count, ret);
>   		cma_debug_show_areas(cma);
>   	}
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

