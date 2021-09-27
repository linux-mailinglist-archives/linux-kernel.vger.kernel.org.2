Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0647418D54
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 02:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhI0Asm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 20:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231593AbhI0Asl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 20:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632703623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVw85k2snfak8ZbeQRTcOmFBsIUpFb7SW/aKWyErre0=;
        b=RnJzr2coh59tr8qY2zaTHoebcS1hMN6UAI/A9w6qslkQc8xaPtT8Z6U6c20V2XZ29vi2tC
        ft6SYY63SYjSRtb6ncnVY/l64W5pyWQFBZAcJGsb+JTNlK3OBsUBQYnQJ3VqajwUePwE7R
        iuE5GH0UzYh13xvd8d1tzEPba7OpSqQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-X0lAW2b4Pn6IWqAlswwLzQ-1; Sun, 26 Sep 2021 20:47:02 -0400
X-MC-Unique: X0lAW2b4Pn6IWqAlswwLzQ-1
Received: by mail-qk1-f197.google.com with SMTP id r5-20020a05620a298500b0045dac5fb940so49811995qkp.17
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 17:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cVw85k2snfak8ZbeQRTcOmFBsIUpFb7SW/aKWyErre0=;
        b=3zfN4nzXVllWNLHVg7sEI6fdLZL2KI23vmbrLbNsoyBCyNOl5PqzumR0aop0B55S6K
         c4UygyvYyP9VQz/wIXpV13+Daun0k3sQdRUyFbjT9GE5lo/TQ/wPajcezpcvklP2zbBC
         uX9YMUyJJkbSsYgONJYrj9KXCmgs7agWBCKDxrFooNtMeoB2YEwKcW1LcFQFn9Dwn9qd
         0DCSqJGVRaUbshEBSrBv5Rd74xz4SixXdCaiPPde6thJPML1fHFi9Xli9PU3lAv5Qihn
         9Iqcu9cjNQakjlkFzkn4tLKNtVnYOemBjOD9T8hhjrdKEuq3e2HeGBm0IIE2WWbrYyAS
         Ddtg==
X-Gm-Message-State: AOAM531iEgS2B9r2M+zJJLD4Q3AWu2OdW3XDS+jSJyhFAmTP8qiV470L
        G5oRQUsd/90dGJpvrEb8dRNFE83x3AG7qub57TCfhvkR2CI8Mad43nFEDOobqFLxitlCs8l4GJK
        u7CAd33D9ucToLP1rSI9Zvamj5hTJXxsPeTpAXp9vc1H9A/Ep252FSysIignZbAKwN8cesLVk
X-Received: by 2002:ac8:7d46:: with SMTP id h6mr16620902qtb.162.1632703621367;
        Sun, 26 Sep 2021 17:47:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze3ThFZW7I8e8WmDukK2teTxlFyW3+TzKk0aDZgbd2TOtSe1cd8NQRUN9AybWqFSZz3BGTVA==
X-Received: by 2002:ac8:7d46:: with SMTP id h6mr16620890qtb.162.1632703621116;
        Sun, 26 Sep 2021 17:47:01 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h2sm11955344qkf.106.2021.09.26.17.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 17:47:00 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/2] locking/mutex: remove rcu_read_lock/unlock as we
 already disabled preemption
To:     Yanfei Xu <yanfei.xu@windriver.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210926101624.2460704-1-yanfei.xu@windriver.com>
 <9569eee4-266f-d83b-2af6-194a1a8b165c@redhat.com>
Message-ID: <70424003-1b4a-bb92-1123-7820d6321717@redhat.com>
Date:   Sun, 26 Sep 2021 20:46:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9569eee4-266f-d83b-2af6-194a1a8b165c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/21 3:16 PM, Waiman Long wrote:
> On 9/26/21 6:16 AM, Yanfei Xu wrote:
>> preempt_disable/enable() is equal to RCU read-side crital section,
>> and the mutex lock slowpath disable the preemption throughout the
>> entire slowpath. Let's remove the rcu_read_lock/unlock for saving
>> some cycles in hot codes.
>
> The description is wrong. Preemption is disabled only in the 
> optimistic spinning code which is not the complete slowpath. Even 
> though it may sound reasonable that disable preemption is likely to 
> prevent reaching quiescent state, but I am not totally sure that will 
> always be the case as there are different RCU favors. 

It does look like that disable preemption can serve as a substitute for 
rcu_read_lock(). However, I will suggest that you also insert a comment 
saying so and the task structure won't go away during the spinning period.

Cheers,
Longman

