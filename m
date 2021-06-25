Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43AD3B3C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhFYGUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 02:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230192AbhFYGT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 02:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624601856;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DluuXyEXbo7ekrnZZANuEGrKYi0ROoHqwgYQSQdvpuQ=;
        b=RVUaJV4rW6V+BEUS0KXAumu2wlqOwuoydDDp+F1qhbl4fVCMvA12nm8xeNvDclOUUrSVeX
        ZPe/urX/qEQujRi1J+L9p5KvTmrEjRDehZiSxFyReHVyhyOI/0D4yRBD1KTHnfPVRdm43a
        dPRlSd6ciX/LEYO0cZnUKhvgEH/dCdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-o31io9nmNeWVMxnLQIIOMA-1; Fri, 25 Jun 2021 02:17:34 -0400
X-MC-Unique: o31io9nmNeWVMxnLQIIOMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 261F0804140;
        Fri, 25 Jun 2021 06:17:33 +0000 (UTC)
Received: from [10.64.54.233] (vpn2-54-233.bne.redhat.com [10.64.54.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BAC05D6AB;
        Fri, 25 Jun 2021 06:17:25 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 0/4] mm/page_reporting: Make page reporting work on
 arm64 with 64KB page size
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.duyck@gmail.com, david@redhat.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20210625042150.46964-1-gshan@redhat.com>
 <20210625015826-mutt-send-email-mst@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <f5f3a7df-6a20-2835-7d49-9c3f10ef8978@redhat.com>
Date:   Fri, 25 Jun 2021 16:17:22 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210625015826-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 3:58 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 25, 2021 at 12:21:46PM +0800, Gavin Shan wrote:
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
> 
> I sent comments on v4. They still apply I think. Want me to repeat them
> here?
> 

Thanks for your comments, Michael. I've replied to your comments
through v4. There are some future work as Alex and David pointed
out before: In order to remove the hack in virtio-memballoon, the
VMM needs to report the page reporting order. I will keep working
on this when I have spare time.

Thanks,
Gavin

>> Changelog
>> =========
>> v5:
>>     * Restore @page_reporting_order to @pageblock_order when
>>       device is registered in PATCH[2/4] to keep "git bisect"
>>       friendly at least.                                           (Alex)
>> v4:
>>     * Set @page_reporting_order to MAX_ORDER. Its value is
>>       specified by the driver or falls back to @pageblock_order
>>       when page reporting device is registered.                    (Alex)
>>     * Include "module.h" in page_reporting.c                       (Andrew)
>> v3:
>>     * Avoid overhead introduced by function all                    (Alex)
>>     * Export page reporting order as module parameter              (Gavin)
>> v2:
>>     * Rewrite the patches as Alex suggested                        (Alex)
>>
>> Gavin Shan (4):
>>    mm/page_reporting: Fix code style in __page_reporting_request()
>>    mm/page_reporting: Export reporting order as module parameter
>>    mm/page_reporting: Allow driver to specify reporting
>>    virtio_balloon: Specify page reporting order if needed
>>
>>   .../admin-guide/kernel-parameters.txt         |  6 +++++
>>   drivers/virtio/virtio_balloon.c               | 17 ++++++++++++++
>>   include/linux/page_reporting.h                |  3 +++
>>   mm/page_reporting.c                           | 22 +++++++++++++++----
>>   mm/page_reporting.h                           |  5 ++---
>>   5 files changed, 46 insertions(+), 7 deletions(-)
>>
>> -- 
>> 2.23.0
> 

