Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0890335A673
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhDIS7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234759AbhDIS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617994776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6z5k9pvR2eM8TAQJhvmPMLc2M+kDJxe7m6egiFSE+Y=;
        b=ByYf9gtdNNj92bTPnUnt5jBeA96mLz/v0DKnPlDCNvBd9DAaQLyKosJJRsx3Xa7LRKfN7l
        3nOyUcMRbq7C7jGXRcJDEqdzXhMz+3PVtvuyivRniBg/b5R9vqUXFDyEojx3YYPO3PDTJW
        lOBVPtg2CJX6V0vwPWzf3HxtFeHfx2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-wr-qbaoQN4yd8r-ArWGbWg-1; Fri, 09 Apr 2021 14:59:33 -0400
X-MC-Unique: wr-qbaoQN4yd8r-ArWGbWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E39BB1922962;
        Fri,  9 Apr 2021 18:59:31 +0000 (UTC)
Received: from [10.36.115.11] (ovpn-115-11.ams2.redhat.com [10.36.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D975660C0F;
        Fri,  9 Apr 2021 18:59:24 +0000 (UTC)
Subject: Re: [PATCH 03/10] mm/migrate: update node demotion order during on
 hotplug events
To:     Oscar Salvador <osalvador@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shy828301@gmail.com, weixugc@google.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183221.977831DE@viggo.jf.intel.com>
 <YG7Sc3i54IV6KyPn@localhost.localdomain> <20210409101400.GA32159@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fb51273c-12e5-f47f-064b-86f5b30b1072@redhat.com>
Date:   Fri, 9 Apr 2021 20:59:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210409101400.GA32159@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.21 12:14, Oscar Salvador wrote:
> On Thu, Apr 08, 2021 at 11:52:51AM +0200, Oscar Salvador wrote:
>> I am not really into PMEM, and I ignore whether we need
>> CONFIG_MEMORY_HOTPLUG in order to have such memory on the system.
>> If so, the following can be partly ignored.
> 
> Ok, I refreshed by memory with [1].
>  From that, it seems that in order to use PMEM as RAM we need CONFIG_MEMORY_HOTPLUG.
> But is that always the case? Can happen that in some scenario PMEM comes ready
> to use and we do not need the hotplug trick?

The only way to add more System RAM is via add_memory() and friends like 
add_memory_driver_managed(). These all require CONFIG_MEMORY_HOTPLUG.

Memory ballooning is a different case, but there we're only adjusting 
the managed page counters.

-- 
Thanks,

David / dhildenb

