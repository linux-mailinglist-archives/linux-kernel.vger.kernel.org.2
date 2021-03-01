Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5D32793A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhCAI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233035AbhCAI30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614587279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6BWB/6MTFHEZzLnhkBzHDsgptsKf2mTXGDz7ZBdy00=;
        b=YhcatIJaB2bt8rVplH+Bchebq4+bJJDx7/1sC8S1QzG7tGk6gZEBjza1hYq2zIUNbuRDLU
        dcz6qxjLfZDuQc+ns+JI00pqzJYLX9fCfXJft1qbENEAERTSHzObOZs/067ue3N8CmHhkH
        0RIQHuzO80JGv5ixwGCEx0qEwZqd7QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-IP8ITgmqM9SwDyKEzO1g6g-1; Mon, 01 Mar 2021 03:27:39 -0500
X-MC-Unique: IP8ITgmqM9SwDyKEzO1g6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E108804038;
        Mon,  1 Mar 2021 08:27:37 +0000 (UTC)
Received: from [10.36.114.87] (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A98391F463;
        Mon,  1 Mar 2021 08:27:35 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] mm,memory_hotplug: Add kernel boot option to
 enable memmap_on_memory
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-4-osalvador@suse.de>
 <02041ab3-dcbd-9056-5571-48b84f527e42@redhat.com>
 <20210226121440.GE3661@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0265788a-087a-567d-09a9-b90d48d71996@redhat.com>
Date:   Mon, 1 Mar 2021 09:27:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226121440.GE3661@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> module_param(memmap_on_memory, bool, 0444);
>>
>> moving the IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) into the
>> runtime check.
> 
> You mean moving this check into mhp_supports_memmap_on_memory() check
> from patch#1 right?
> 
> Makes sense.

Yep.


-- 
Thanks,

David / dhildenb

