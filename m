Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D731EFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhBRTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232198AbhBRSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613672199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/532FGiDmXNyi77yaEvYqqbu5TAEWf0X1UPW7xyxBCc=;
        b=hlR7xbV24UmP9nVzbT17+n7WFWSwc1+FGHlSe3CDdhyS9oa/Hw5fyfDRpMDNdEjawxWRXL
        KYMJI6bIga92/9y5KdlxO2dQsDVfoiPwYXUiVNHQG+Sak7mHxiYSDNIDfIK88GG2KXYuZQ
        vRTxESZJMoggLQhDL83km2AmShWPaNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-p5q90FIUPO--_3QHzV_axQ-1; Thu, 18 Feb 2021 13:16:35 -0500
X-MC-Unique: p5q90FIUPO--_3QHzV_axQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC4921935780;
        Thu, 18 Feb 2021 18:16:33 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AECC360BE5;
        Thu, 18 Feb 2021 18:16:31 +0000 (UTC)
Subject: Re: [PATCH RFC 0/1] mm: balancing the node zones occupancy
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, rientjes@google.com, vbabka@suse.cz,
        mhocko@suse.com, mgorman@techsingularity.net, linux-mm@kvack.org
Cc:     vinmenon@codeaurora.org, sudaraja@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <cover.1613661472.git.charante@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <82e0e9c2-8187-8e2f-0d5e-304dafcda017@redhat.com>
Date:   Thu, 18 Feb 2021 19:16:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1613661472.git.charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.21 18:24, Charan Teja Reddy wrote:
> I would like to start discussion about  balancing the occupancy of
> memory zones in a node in the system whose imabalance may be caused by
> migration of pages to other zones during hotremove and then hotadding
> same memory. In this case there is a lot of free memory in newly hotadd
> memory which can be filled up by the previous migrated pages(as part of
> offline/hotremove) thus may free up some pressure in other zones of the
> node.

Why is this specific to memory hot(un)plug? I think the problem is more 
generic:

Assume

1. Application 1 allocates a lot of memory and gets ZONE_MOVABLE.
2. Application 2 allocates a lot of memory and gets ZONE_NORMAL.
3. Application 1 quits.

Same problem, no?

-- 
Thanks,

David / dhildenb

