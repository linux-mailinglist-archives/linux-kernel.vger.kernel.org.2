Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7934A37C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCZI6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhCZI6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616749080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xL+hmA+1dMAwVs4hHRMU+2pFBDMDHNw6rI7EfiN366c=;
        b=WfaO1OSIpY1txJRHWv08huEoFn1N/vgFJhNIegKrUUYjSnxgYCGirzJjDI0NCDEr2zBj0O
        ZGPKlSe4CYrRNMKnJRvuiWr6WkL3yLmpGuDijUVBBXevd/dxIJOvAK/UN8hRlx7m3we5vc
        7R2TLW7UHlBbneyqeBqBxjm2yb9zu1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-QI9WO7IHPYmX_fsr6UJNjw-1; Fri, 26 Mar 2021 04:57:56 -0400
X-MC-Unique: QI9WO7IHPYmX_fsr6UJNjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6696018C89CC;
        Fri, 26 Mar 2021 08:57:54 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 255B388F0E;
        Fri, 26 Mar 2021 08:57:51 +0000 (UTC)
Subject: Re: [PATCH v2] kernel/resource: Fix locking in
 request_free_mem_region
To:     Alistair Popple <apopple@nvidia.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, daniel.vetter@ffwll.ch,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jhubbard@nvidia.com, jglisse@redhat.com, linux-mm@kvack.org
References: <20210326012035.3853-1-apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9eef1283-28a3-845e-0e3e-80b763c9ec59@redhat.com>
Date:   Fri, 26 Mar 2021 09:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210326012035.3853-1-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.21 02:20, Alistair Popple wrote:
> request_free_mem_region() is used to find an empty range of physical
> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
> over the range of possible addresses using region_intersects() to see if
> the range is free.

Just a high-level question: how does this iteract with memory 
hot(un)plug? IOW, how defines and manages the "range of possible 
addresses" ?

> 
> region_intersects() obtains a read lock before walking the resource tree
> to protect against concurrent changes. However it drops the lock prior
> to returning. This means by the time request_mem_region() is called in
> request_free_mem_region() another thread may have already reserved the
> requested region resulting in unexpected failures and a message in the
> kernel log from hitting this condition:

I am confused. Why can't we return an error to the caller and let the 
caller continue searching? This feels much simpler than what you propose 
here. What am I missing?



-- 
Thanks,

David / dhildenb

