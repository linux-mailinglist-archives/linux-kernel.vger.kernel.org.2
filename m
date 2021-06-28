Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57BC3B5B88
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhF1JsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230256AbhF1JsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624873556;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1ltTZwTcbRKQ9iE5O3Ko5LzXJiJvdzX6/FepyBCXnQ=;
        b=ZCUO8laIvt9WYNqeI9uv2xixeGwcmYzqB2QnFaE4FrBHGGEWpslAvDy+BV7I1XMjkS7ADm
        Svmijl50vKgq3bCxiueUkkSD8gFeMMAEDg/dpJ+G9RJ5YdfS2VgW4GBJrPnNADTG0ORaud
        7diq2toeL3MuEkMrEWyYyUj+8+BUbI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-tIm5qfhbPlig-mhyNGBaqA-1; Mon, 28 Jun 2021 05:45:53 -0400
X-MC-Unique: tIm5qfhbPlig-mhyNGBaqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98568804143;
        Mon, 28 Jun 2021 09:45:51 +0000 (UTC)
Received: from [10.64.54.204] (vpn2-54-204.bne.redhat.com [10.64.54.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A5F65D9C6;
        Mon, 28 Jun 2021 09:45:33 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 0/4] mm/page_reporting: Make page reporting work on
 arm64 with 64KB page size
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
References: <20210625042150.46964-1-gshan@redhat.com>
 <CAKgT0UdVjW_kfeARo3Vsf6fZGPv4r_DEN7+NVp8PN4figkrJmA@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <cfe870da-89a4-cac7-814b-0c3a540d25c0@redhat.com>
Date:   Mon, 28 Jun 2021 19:45:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdVjW_kfeARo3Vsf6fZGPv4r_DEN7+NVp8PN4figkrJmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/21 12:18 AM, Alexander Duyck wrote:
> On Thu, Jun 24, 2021 at 7:20 PM Gavin Shan <gshan@redhat.com> wrote:
>>
>> The page reporting threshold is currently equal to @pageblock_order, which
>> is 13 and 512MB on arm64 with 64KB base page size selected. The page
>> reporting won't be triggered if the freeing page can't come up with a free
>> area like that huge. The condition is hard to be met, especially when the
>> system memory becomes fragmented.
>>
>> This series intends to solve the issue by having page reporting threshold
>> as 5 (2MB) on arm64 with 64KB base page size. The patches are organized as:
>>
>>     PATCH[1/4] Fix some coding style in __page_reporting_request().
>>     PATCH[2/4] Represents page reporting order with variable so that it can
>>                be exported as module parameter.
>>     PATCH[3/4] Allows the device driver (e.g. virtio_balloon) to specify
>>                the page reporting order when the device info is registered.
>>     PATCH[4/4] Specifies the page reporting order to 5, corresponding to
>>                2MB in size on ARM64 when 64KB base page size is used.
>>
>> Changelog
>> =========
>> v5:
>>     * Restore @page_reporting_order to @pageblock_order when
>>       device is registered in PATCH[2/4] to keep "git bisect"
>>       friendly at least.                                           (Alex)
> 
> These latest changes address the concerns I had.
> 

Thanks again for your review, Alex. However, v4 was merged and it's fine
since v5 only resolves 'git-bisect' friendly issue on PATCH[v4 2/4].

Thanks,
Gavin

