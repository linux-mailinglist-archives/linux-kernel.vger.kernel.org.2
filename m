Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3E36B546
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhDZOzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233573AbhDZOza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619448888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9UTXyk2M14I21Jw3vr4hDE1rWWYeF0hkxGl0oIMXCk=;
        b=Rt7rk8mellIu9RLxwraWpWmkD08lIcaOZegSZ+4F2SpsH3IV3zD5TthVsUD0Fhls1Uv208
        AYhYzmPLYjQ0ZZrOXmyM87YfCJtDe+lBv2jykOyNBO35zVHdnjSKwlOOsnR2Dgq73reZPN
        9knZXfgzRNLEjYLFSid4gF7T3JZmiZA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-AH_Z-v5iMxqKPEiX3RipMQ-1; Mon, 26 Apr 2021 10:54:43 -0400
X-MC-Unique: AH_Z-v5iMxqKPEiX3RipMQ-1
Received: by mail-qv1-f70.google.com with SMTP id g26-20020a0caada0000b02901b93eb92373so2569554qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 07:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w9UTXyk2M14I21Jw3vr4hDE1rWWYeF0hkxGl0oIMXCk=;
        b=UYbxPyEK4ThDVgxEl43kmlqb15g7784ySsTHjxAuWMp2V/CVgd84+UxrG/C7SAtMV8
         Ft5xEsz3I1d7ZI55ZKJRpQCZPSVl3DcNEMtzz+Sni8A7TZpzRmobQHpZR1pmZh8n1Xo0
         uAb9kOZYpryIbY60/EG6DHXcYDa4Su69wCyRba/QOBR+3xaKj8mdwiiNMz9SR//YuepS
         VvEaPdvocDpcclex6jfHqgIURtf3SEmbVP7wn1cxlIME/G5MjwYP+ILDquLqn25o+OM7
         9/sJRfz5b8BplHPWehPKlN6KZAiPB9asjndCTnRwIICvaMKA9wVu+rXuUqyBPUcrgBSs
         w0FQ==
X-Gm-Message-State: AOAM531U+ayA5LsMrupVGbWjn9T0iGpL7FXQMn2Q6y2tnM7yyMIrX1dV
        h0QlwCxfd/FEllBw658sYGe1F5WNDUrFVrxUBXHvX9q9PeUZ4hv94StkT97QWi8bcfc5ASpl4Ac
        kWW0hSQflkUGsR9REWt9C7+XI
X-Received: by 2002:a05:6214:1866:: with SMTP id eh6mr18332196qvb.29.1619448883534;
        Mon, 26 Apr 2021 07:54:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsWEP8fC3dgspTWzi5Ga+C9oNrZBLQ9l1ajgSW+1LglvD3uIOBFGaVsOgD9DYyuKrM+4h41w==
X-Received: by 2002:a05:6214:1866:: with SMTP id eh6mr18332174qvb.29.1619448883340;
        Mon, 26 Apr 2021 07:54:43 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b9sm155207qkc.98.2021.04.26.07.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 07:54:42 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/qrwlock: queued_write_lock_slowpath() cleanup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>
References: <20210425200637.31298-1-longman@redhat.com>
 <YIZ0+hNh0SMQoOkh@hirez.programming.kicks-ass.net>
Message-ID: <d8b2bc8a-3788-6cba-ffa9-2985d7a278d4@redhat.com>
Date:   Mon, 26 Apr 2021 10:54:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YIZ0+hNh0SMQoOkh@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 4:08 AM, Peter Zijlstra wrote:
> On Sun, Apr 25, 2021 at 04:06:37PM -0400, Waiman Long wrote:
>
>>   void queued_write_lock_slowpath(struct qrwlock *lock)
>>   {
>> -	int cnts;
>> +	int cnts = 0;
>>   
>>   	/* Put the writer into the wait queue */
>>   	arch_spin_lock(&lock->wait_lock);
>>   
>>   	/* Try to acquire the lock directly if no reader is present */
>>   	if (!atomic_read(&lock->cnts) &&
>> -	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
>> +	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
>>   		goto unlock;
> Would not something like:
>
> 	if (!(cnts = atomic_read(&lock->cnts)) &&
> 	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)
> 		goto unlock;
>
> Be clearer?
That works for me too. It is equivalent anyway.
>
>>   
>> -	/* Set the waiting flag to notify readers that a writer is pending */
>> -	atomic_add(_QW_WAITING, &lock->cnts);
>> +	/*
>> +	 * Set the waiting flag to notify readers that a writer is pending
>> +	 *
>> +	 * As only one writer who is the wait_lock owner can set the waiting
>> +	 * flag which will be cleared later on when acquiring the write lock,
>> +	 * we can easily replace atomic_or() by an atomic_add() if there is
>> +	 * an architecture where an atomic_add() performs better than an
>> +	 * atomic_or().
> That might be a little overboard on the comment, but sure :-) I don't
> think there's any arch that doesn't have atomic_or(), like I wrote
> elsewhere, the one that's often an issue is atomic_fetch_or().
>
I was not sure as I didn't look at other archs that hadn't used qrwlock 
yet. Given what you said, I will remove the comment.

Cheers,
Longman

