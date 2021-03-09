Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE66A332EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCITCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229916AbhCITBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615316497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIbVIf9JgfgLSsPGEjdt6SxaKG5D+REVg0Jf8YIfVe8=;
        b=UJ3RUbIzk+V51YQAmJHoYEdI07ytzPDGxzwDj+c9YQy4SElGrT2W5scIzU+ppDwbivqq79
        tVUgYNhsK3E8ckvI4QFDcV+QtE3sH6nniQvg9itflivjCnusXELuUim0j3/nXPbvLee9Y/
        3+f8d9VOFmOe5efAWYOAgZrIn10u4vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-S_x2j83NOwmjLJUpsZSR-A-1; Tue, 09 Mar 2021 14:01:34 -0500
X-MC-Unique: S_x2j83NOwmjLJUpsZSR-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6113A26869;
        Tue,  9 Mar 2021 19:01:32 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF04760C13;
        Tue,  9 Mar 2021 19:01:30 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
 <29cb78c5-4fca-0f0a-c603-0c75f9f50d05@redhat.com>
 <ebb19eb5-ae9e-22f1-4e19-e5fce32c695c@oracle.com>
 <6c66c265-c9b9-ffe9-f860-f96f3485477e@redhat.com>
 <777d3771-7d2f-8e88-8496-56440e195a43@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <dfd59d83-7916-518d-23ce-a9a4e6781918@redhat.com>
Date:   Tue, 9 Mar 2021 20:01:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <777d3771-7d2f-8e88-8496-56440e195a43@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I need to take a close look at Oscar's patches.  Too many thing to look
> at/review :)
> 
> This series does take into account gigantic pages allocated in CMA.
> Such pages can be demoted, and we need to track that they need to go
> back to CMA.  Nothing super special for this, mostly a new hugetlb
> specific flag to track such pages.

Ah, just spotted it - patch #2 :)

Took me a while to figure out that we end up calling 
cma_declare_contiguous_nid() with order_per_bit=0 - would have thought 
we would be using the actual smallest allocation order we end up using 
for huge/gigantic pages via CMA. Well, this way it "simply works".

-- 
Thanks,

David / dhildenb

