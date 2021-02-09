Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D90314DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhBILHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:07:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232299AbhBILCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612868438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ifbx9nIqRn7LlNK27PJEsCYzKJr0fEzLeJSH+NkfLB0=;
        b=VjDaxD9a8bpsP7AbrUNO2Bsn+CBLJu18JcyP7W0Ub8PwMTabBQ0bpuX8pu2nQI/UQO8PC0
        17gOWyEQGutCPiU2wwq+C0KdxZsR52QnxNIc77oNAwcWjVdlZFVnvaAdsL1j1dtlctdOmA
        0i5XL8NixoPJqgq91wi7Xg/K69o8cvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-9_VWYtS5MXmem_hG6Akytg-1; Tue, 09 Feb 2021 06:00:34 -0500
X-MC-Unique: 9_VWYtS5MXmem_hG6Akytg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECAAB804023;
        Tue,  9 Feb 2021 11:00:31 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0501C60C04;
        Tue,  9 Feb 2021 11:00:28 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] vsprintf: dump full information of page flags in
 pGp
To:     Yafang Shao <laoar.shao@gmail.com>, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, linmiaohe@huawei.com,
        vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210209105613.42747-1-laoar.shao@gmail.com>
 <20210209105613.42747-4-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a448afd5-16e5-1744-54d2-142be05b0313@redhat.com>
Date:   Tue, 9 Feb 2021 12:00:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210209105613.42747-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 11:56, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
> 
> To be compitable with the existed format of pGp, the new introduced ones
> also use '|' as the separator, then the user tools parsing pGp won't
> need to make change, suggested by Matthew. The new information is
> tracked onto the end of the existed one.
> 
> On example of the output in mm/slub.c as follows,
> - Before the patch,
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)

Did not review in detail, but LGTM.

Thanks, this will be very helpful!


-- 
Thanks,

David / dhildenb

