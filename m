Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805D33E49BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhHIQXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233166AbhHIQW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628526155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1yqMzotXdaIuS2tTPp/KkEXEHPTAsVcYdV4F9XOEmM=;
        b=QjE+B5jTr8h0KhZoJvZRPEh+N743RUPRucMNXO/lZ7Vi33ofZAZAkgjeysSo59RVHehPCJ
        NLomMIP8qqyx3MonNRQaoQXxlWOTOfhUu09xMz7XMYD/6Vpi9GBCMbXVYGSslSvLm/zSNf
        14N3VQQYktIHnPB/dBt6YGx5inXwluM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-Hx8TqExcMGChaTFHTRWbDg-1; Mon, 09 Aug 2021 12:22:34 -0400
X-MC-Unique: Hx8TqExcMGChaTFHTRWbDg-1
Received: by mail-qt1-f199.google.com with SMTP id m22-20020a05622a1196b029026549e62339so8224351qtk.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I1yqMzotXdaIuS2tTPp/KkEXEHPTAsVcYdV4F9XOEmM=;
        b=PtCIadXD/bx37pfyL5VmxzZtTK/ea9g3cux2C/SmKMLGRDggb19gTd0Wa5Q59pqTr+
         Kg7rIPEgTKQAEyBj6Dm/u+8JkzSRlLLynTtPf+zJf0YuxWGvQTONfJ/fuAGhLYLx4HyU
         HLQI4VMT06QWkI8vE35IqnRE7nvn2uSTY4T403+vS37UnoT9lPAB4XdFm+2FjqCmxw6W
         cjlUgRDvr/9PGQeh4TsooUIFMp4mknN9E9TPL8Cra6RdgwPwSL5HIx5EVYTKSskMJY4m
         uh7mizLx6xX2rv4sYKn9cgLiT4fZfy//d6lR7qMtiDfQwAOKEbL1oIJVu23qQekGgM4J
         4pHA==
X-Gm-Message-State: AOAM530hjO8HI8bJA6isuE/G8M5A3oros/KIePJC3xQAwqCPLBdyznMu
        WA09I0QfCIQFJ8+t1yWRViMBF+bVzAo3t5C2perlcqvCks4JLq6qRZcICbzBDg82SPtvJAp5FRq
        4EwIi5C5jApmtcCLM365F+0+h1NlHbdKORUmX0jTJ5elv1/E8C1Hg8hkqu++6dEtt/cq+kSzC
X-Received: by 2002:ad4:4e50:: with SMTP id eb16mr10696457qvb.14.1628526153230;
        Mon, 09 Aug 2021 09:22:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtbZfPq8QS28bUBJP5WI/l80AFgMAmnOu1GGLoGa+Rl+rqO6RjHOd1m1doCxd+qyI+3ZLxGw==
X-Received: by 2002:ad4:4e50:: with SMTP id eb16mr10696439qvb.14.1628526153026;
        Mon, 09 Aug 2021 09:22:33 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b11sm4087938qtt.42.2021.08.09.09.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 09:22:32 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/qspinlock: Fix typo of lock word transition in
 the uncontended case
To:     Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, boqun.feng@gmail.com,
        wanghaibin.wang@huawei.com, linux-kernel@vger.kernel.org
References: <20210715030847.2038-1-yuzenghui@huawei.com>
 <20210809134047.GB1207@willie-the-truck>
Message-ID: <7e71b365-e204-d9d6-39ef-ef4f08f2af18@redhat.com>
Date:   Mon, 9 Aug 2021 12:22:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809134047.GB1207@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 9:40 AM, Will Deacon wrote:
> On Thu, Jul 15, 2021 at 11:08:47AM +0800, Zenghui Yu wrote:
>> If the queue head is the only one in the queue and nobody is concurrently
>> setting PENDING bit, the uncontended transition should be n,0,0 -> 0,0,1.
>>
>> Fix the typo.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   kernel/locking/qspinlock.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index cbff6ba53d56..591835415698 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -355,7 +355,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>   	 * If we observe contention, there is a concurrent locker.
>>   	 *
>>   	 * Undo and queue; our setting of PENDING might have made the
>> -	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
>> +	 * n,0,0 -> 0,0,1 transition fail and it will now be waiting
>>   	 * on @next to become !NULL.
>>   	 */
> I think this is an important typo fix as you're right that we don't
> transition directly from having a waitqueue installed in the tail straight
> to an unlocked state.
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Then again, I acked the patch introducing this comment so what do I know?

We usually focus more on the actual code than the associated comment. I 
am not surprise we may miss that. I do agree that the proposed change is 
better.

Acked-by: Waiman Long <longman@redhat.com>

