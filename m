Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907D644DD41
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhKKVt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:49:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229868AbhKKVt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636667196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4B2+S+sS+dA+s8eZYUDQfV6YT/HMAJWKwhPACRy94Q=;
        b=SGRMFXTLp864OWK8Lj6YUG7f8YynvxwowD7B6O/GHL+ga2A+gYim3tiySiYAOUchSRIKnZ
        Z/DK7Sq+wjM7QWIBMXdZdfKGH65C0VeTsgCvYllEu7NXiX8FDBqfn2rsNb2ftu5VE/eam4
        QaW+5gHlbAdSb1iy8ObDqO1RCw4482E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-A3iCEw42OXqOCDNxws-IOA-1; Thu, 11 Nov 2021 16:46:35 -0500
X-MC-Unique: A3iCEw42OXqOCDNxws-IOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD1A804140;
        Thu, 11 Nov 2021 21:46:33 +0000 (UTC)
Received: from [10.22.8.202] (unknown [10.22.8.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1533F60C05;
        Thu, 11 Nov 2021 21:46:31 +0000 (UTC)
Message-ID: <88037962-a31b-913e-7903-68fac7e3329d@redhat.com>
Date:   Thu, 11 Nov 2021 16:46:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?UTF-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
 <20211111202647.GH174703@worktop.programming.kicks-ass.net>
 <be3dc705-494a-913e-230f-9533c7404ac2@redhat.com>
 <YY2NRpg1q6hLIqpK@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YY2NRpg1q6hLIqpK@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/21 16:38, Peter Zijlstra wrote:
> On Thu, Nov 11, 2021 at 04:01:16PM -0500, Waiman Long wrote:
>
>>>> +			if (has_handoff || (!waiter->rt_task &&
>>>> +					    !time_after(jiffies, waiter->timeout)))
>>> Does ->rt_task really help over rt_task(current) ? I suppose there's an
>>> argument for locality, but that should be pretty much it, no?
>> Waiting for the timeout may introduce too much latency for RT task. That is
>> the only reason I am doing it. I can take it out if you think it is not
>> necessary.
> I meant simply calling rt_task(waiter->task) here, instead of mucking about
> with the extra variable.

OK, that make sense.

Cheers,
Longman

