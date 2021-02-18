Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A07B31E8A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhBRKK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhBRJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613638970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ugCbqPb9oy0RzBcGGyZx8mxEAfNFimnPKtTNa7iXdU=;
        b=SrwZ+ck/PnZ1Lz1W8YPFEbPi7QI7NSWkJ+/WRFR5qTz6MkwtobXBQExvXdeYXwfgWJHFoE
        +QpwuOzHPLeL1BvAsUQn/N2T5N5+vf5FDPcBJYPOaz8Q2ZLQlthG3KXmyxO+IjsrtGEyGl
        4QqtAahONfMbSNbM1KpwTR+hBFhHBkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-TI3-VbojPyWyyGO_gc9zOg-1; Thu, 18 Feb 2021 04:02:46 -0500
X-MC-Unique: TI3-VbojPyWyyGO_gc9zOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92D80107ACED;
        Thu, 18 Feb 2021 09:02:45 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A59A6F7EC;
        Thu, 18 Feb 2021 09:02:44 +0000 (UTC)
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
To:     Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
Date:   Thu, 18 Feb 2021 10:02:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.21 09:56, Michal Hocko wrote:
> On Wed 17-02-21 08:36:03, Minchan Kim wrote:
>> alloc_contig_range is usually used on cma area or movable zone.
>> It's critical if the page migration fails on those areas so
>> dump more debugging message like memory_hotplug unless user
>> specifiy __GFP_NOWARN.
> 
> I agree with David that this has a potential to generate a lot of output
> and it is not really clear whether it is worth it. Page isolation code
> already has REPORT_FAILURE mode which currently used only for the memory
> hotplug because this was just too noisy from the CMA path - d381c54760dc
> ("mm: only report isolation failures when offlining memory").
> 
> Maybe migration failures are less likely to fail but still.

Side note: I really dislike that uncontrolled error reporting on memory 
offlining path we have enabled as default. Yeah, it might be useful for 
ZONE_MOVABLE in some cases, but otherwise it's just noise.

Just do a "sudo stress-ng --memhotplug 1" and see the log getting 
flooded ...

-- 
Thanks,

David / dhildenb

