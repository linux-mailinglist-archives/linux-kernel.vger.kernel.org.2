Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA63B84D2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhF3OPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235103AbhF3OPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625062389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pBbHaYzTF8tHlMP9sN+27KFJWraEHRhzABE2ErPcBg=;
        b=Ek92yLjHQ2K2oVksSXRyLkVBC8tgTuF7S3QkhAR0fqRZXFom+lE6kpbLxFqG3M+nR/1y5F
        qWuitEa7p0BrjFIWyxnUyAqu4nc9UOLoRG9mcdt+kpmlqPOQyEGPugZZk3U6zPif49FUVZ
        M/kXb7qGt1EA0RFwfITqwHPeyTjvI8w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-WK1WgZC_PaqjHH3lIlQVBw-1; Wed, 30 Jun 2021 10:13:08 -0400
X-MC-Unique: WK1WgZC_PaqjHH3lIlQVBw-1
Received: by mail-qt1-f197.google.com with SMTP id d26-20020ac847da0000b0290250c4d73502so1169056qtr.20
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3pBbHaYzTF8tHlMP9sN+27KFJWraEHRhzABE2ErPcBg=;
        b=SGLP2JWOm/Q7Vyi6h1aPcpFMxut6iDPDp79M+ewFAV9+0mYJKDCrGaoAtKP3pqy97R
         HsrJhguxl3JKUNCXEniiODqx3tb4w8/0tu4UZN6nH4saUC2gkNGKlaoiYh1XB2NaYCC3
         wF8rAawQ9beUWKdS/mSiyOpt6+y2dL7LTfVebl8TOGD0MFhvbY0MBPBNBVr6WeFD6ou2
         vYRdpc9eaAPqfjquH+FLt5HqnAeBkCevFeegX520fWFLT5V0ljMfArXQtUvrwm9UjKig
         Tb1WQ4EFDKlAaQyjsb48oG+oq8VgLpcRSoZt69SNHeRPZspxybGWtkttNf+5zFaJ3rCC
         R6/w==
X-Gm-Message-State: AOAM533cSlYFOCmUcPBufN7V1Ukbq95cW0Wgs9KgCD78bh1BKgKAEa2u
        6U428j0zJ8XDCBGqKSGjIAQSGX+WUJrQ0Yjxw2p7VLFKQ/R6Hc9k836Ok6Xu3gu+PjPgLyCqLbU
        djyAe3Iqi+0QmRWIhyrvBUPZH
X-Received: by 2002:a05:622a:d1:: with SMTP id p17mr31848920qtw.141.1625062388201;
        Wed, 30 Jun 2021 07:13:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrEgXHHKm7Tx3BnIDzaZvkmwsk0jtjAqJl0wkP0e5A4jlC2OjL92PY7FNMNuPJbtNH0fpy+w==
X-Received: by 2002:a05:622a:d1:: with SMTP id p17mr31848902qtw.141.1625062387970;
        Wed, 30 Jun 2021 07:13:07 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h1sm5355360qkm.50.2021.06.30.07.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 07:13:07 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/mutex: Reduce chance of setting HANDOFF bit on
 unlocked mutex
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <llong@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Xu, Yanfei" <yanfei.xu@windriver.com>
References: <20210629201138.31507-1-longman@redhat.com>
 <YNxFkD8qzex9MvQp@hirez.programming.kicks-ass.net>
 <ecc0cc97-23ca-5de3-2a12-ed50aa12548c@redhat.com>
 <YNx4IWfE/wpFFh0h@hirez.programming.kicks-ass.net>
Message-ID: <139a3dc2-1693-5e33-3d2d-77a5651d92e1@redhat.com>
Date:   Wed, 30 Jun 2021 10:13:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YNx4IWfE/wpFFh0h@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/21 9:56 AM, Peter Zijlstra wrote:
> On Wed, Jun 30, 2021 at 09:50:11AM -0400, Waiman Long wrote:
>
>> The code looks good to me. It is an even better approach to make sure that
>> the HANDOFF will never be set on an unlocked mutex.
>>
>> Reviewed-by: Waiman Long <longman@redhat.com>
> Thanks, what about that XXX? Should we not check sigpending before doing
> the optimistic spinning thing?
>
Sorry, I missed the XXX comment:-)

This is a generic problem as other waiters that go into the spinning 
loop also don't check for sigpending. On the other hand, I am fine with 
doing the pending signal check before doing the optimistic spinning.

Cheers,
Longman

