Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D96C32F137
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhCERa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhCERaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614965452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIcI4XmSyhV3bcodrCp6fMxhqE+Fukoi2l+B2lVpPNM=;
        b=QvxkdE8AyHlgQfsa3h6LfxVtTM4TkOl94ZXjxtno5nmrIDYExrRu5+3YLpWX3M7KQR6hP9
        JRLaVZuFLHHfPhT5sVR+v7Omz69PlDWSo5M7UI7qmzqmgycTviicfawxwGw9QQtElRa9OZ
        /uUsSx7oYmtwPdpqxKjGezki2L4+byo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-ULOg9lD1NTWHI9SY6G9XgA-1; Fri, 05 Mar 2021 12:30:50 -0500
X-MC-Unique: ULOg9lD1NTWHI9SY6G9XgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79388101F7B4;
        Fri,  5 Mar 2021 17:30:47 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D105319C66;
        Fri,  5 Mar 2021 17:30:45 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4c52bb7e-54c3-3972-8ada-6bb4ae6c36cc@redhat.com>
Date:   Fri, 5 Mar 2021 18:30:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210222135137.25717-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.21 14:51, Oscar Salvador wrote:
> alloc_contig_range() will fail if it finds a HugeTLB page within the range,
> without a chance to handle them. Since HugeTLB pages can be migrated as any
> LRU or Movable page, it does not make sense to bail out without trying.
> Enable the interface to recognize in-use HugeTLB pages so we can migrate
> them, and have much better chances to succeed the call.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

LGTM as far as I can tell, I am only wondering if it wouldn't even be 
cleaner to squash both patches.

-- 
Thanks,

David / dhildenb

