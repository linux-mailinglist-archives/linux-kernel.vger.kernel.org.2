Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092C3323A31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhBXKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234739AbhBXKIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614161239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ct8hFxvmCySJqlX+fRfODC3NtSCfV+aDErfoZFPlly0=;
        b=WX1hOQyIAtTtru1g0KuYfLDGX5ZJOQZ66N7dZrwDFHa4wf1PmeQNSuZ1bGzbv+uQ5aUE83
        cVXOB9iSFP/WYf2zzSkEACCBZKXDWEg4pZk0y6VpGnGOQ2E0/kZ9RS6azJtE58Ey/GVCU3
        2s1wc0iI2TB3BNW1aS7+MmHhwO/ZCMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-TV1x0vLNOuCwnqxCkZhXiQ-1; Wed, 24 Feb 2021 05:06:43 -0500
X-MC-Unique: TV1x0vLNOuCwnqxCkZhXiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1B64193579C;
        Wed, 24 Feb 2021 10:06:41 +0000 (UTC)
Received: from [10.36.114.83] (ovpn-114-83.ams2.redhat.com [10.36.114.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F11C10016F7;
        Wed, 24 Feb 2021 10:06:40 +0000 (UTC)
Subject: Re: [PATCH] hugetlb: document the new location of page subpool
 pointer
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210223180820.ee39f1544f2630d0eecf3a57@linux-foundation.org>
 <20210224040439.351882-1-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c34d52f9-1e77-7ed4-2209-df8af9f2e96d@redhat.com>
Date:   Wed, 24 Feb 2021 11:06:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210224040439.351882-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.21 05:04, Mike Kravetz wrote:
> Expand comments, no functional change.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   include/linux/hugetlb.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index cccd1aab69dd..c0467a7a1fe0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -476,6 +476,9 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>    * huegtlb page specific state flags.  These flags are located in page.private
>    * of the hugetlb head page.  Functions created via the below macros should be
>    * used to manipulate these flags.
> + * Note: The hugetlb page subpool pointer previously located at page.private
> + * was moved to page[1].private to make room for flags in the head page.  See
> + * hugetlb_page_subpool().
>    *
>    * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
>    *	allocation time.  Cleared when page is fully instantiated.  Free
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

