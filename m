Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAF6451C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356896AbhKPASt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350267AbhKPAMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 19:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637021350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXgjncosTx8zgXxE2PwFJSLftRVb39BhlOKGx0R0jdg=;
        b=Zwn6DawtlzRu8Qe5BOWZjqkgVOuwA8ADuCJilFlRNBmi55ZLDHBKjkYeEeuH9bCTbypmgN
        DY/xhz/7qzVd92uzxQvFp2O65BRTjfHZYIYcRUhPykFyTvPJJmlDIutAu8ZnZ8hi59FXy0
        IMh8jrajCgZlByw7D6NzyIATzh0Um2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-aR4EiHeNMY-5it6Uhqbdbw-1; Mon, 15 Nov 2021 19:09:07 -0500
X-MC-Unique: aR4EiHeNMY-5it6Uhqbdbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 849751006AA1;
        Tue, 16 Nov 2021 00:09:05 +0000 (UTC)
Received: from [10.22.16.105] (unknown [10.22.16.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45DBC19724;
        Tue, 16 Nov 2021 00:09:04 +0000 (UTC)
Message-ID: <fd999d01-167b-3233-d527-def3a1c79913@redhat.com>
Date:   Mon, 15 Nov 2021 19:09:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>
References: <20211112040753.389380-1-longman@redhat.com>
 <YY5Z009P2jJ4X484@hirez.programming.kicks-ass.net>
 <a141b93d-1945-a44d-467f-54b648cbf4d0@redhat.com>
 <YZKEc+SgijOcB+0W@hirez.programming.kicks-ass.net>
 <ce034084-364b-e30f-cb7c-d6434afe3a7d@redhat.com>
 <20211115230728.GS174703@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211115230728.GS174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/21 18:07, Peter Zijlstra wrote:
> On Mon, Nov 15, 2021 at 05:29:10PM -0500, Waiman Long wrote:
>> The handoff_set flag can only be true for a first waiter. A random waiter in
>> the middle of a wait queue will never has this flag set.
>>
>> This flag is set in two places in rwsem_try_write_lock():
> Bah, I thought it would unconditionally propagate the bit from @count. I
> missed the early exit :/
>
I am going to restructure the code there to make it easier to see that 
only the first waiter will have this bit set to avoid this confusion.

Cheers,
Longman

