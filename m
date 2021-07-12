Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D933C5CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhGLNHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229779AbhGLNHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626095086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Xzr/PxJTHli7gStkLTvKYZ4Bn0EjRlrcWIQGxurGYk=;
        b=WB5ONaE5ZFVWEzUJWt+CBYqhYwYqKsU1Jmn0NNT0wf5UO2coL/kAlMP3ExV6tRMDybh0Ny
        HCPIY41FSgJdHyjFfx2Y574h3EZdY9scvGoxD9OZpFh+x2T9fY1BwpBf2KIuXZ5+nnPTgh
        8QHeQxUTqfWP+LMXvGYZFsH/dGvZErI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-Aua7yD7QMcqb80qhrI2enQ-1; Mon, 12 Jul 2021 09:04:45 -0400
X-MC-Unique: Aua7yD7QMcqb80qhrI2enQ-1
Received: by mail-qk1-f197.google.com with SMTP id 81-20020a370b540000b02903b854c43335so3431819qkl.21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6Xzr/PxJTHli7gStkLTvKYZ4Bn0EjRlrcWIQGxurGYk=;
        b=JVjncaOQ0Q+rsI+97MgPQtZTTCB8Xjs4A7BJmiHz7/4SIicoliHxuJ4hHR5C1h4F3f
         0UPQDs0vydQgrqaxb2Fcszp1NxJuCRC4M4AVQg2c7ObJmVrxADnO/t3stF0QddXB2XLQ
         qJum7kJciIfaK5AqHiqJ8fzdEdz4BcVjVak5O3Dt+5U0LntInDt9Y6GEM1SDDufprnDW
         7xopcX1NMEeCqn0tod4c27Dha3ZQRkQ5lwfQFa2yTMBrGSEMeQnzoK5079mJvn+o+3BQ
         fFyTDrm0JrY8vKupBulqCEBjGXwKbdB9DYr9C4wiecld3JDkhFxnljpBO7fvXcN6n255
         ToCg==
X-Gm-Message-State: AOAM531HLUafycEHxYP80GfhVTfmubQ5y4wrbhcKjjkmYcd5SYDVs2aG
        WB1HwNt8XEvieFUCfVhsEjQmR5EXBOg3hKY7NoA1vHueIBOFoQmzuTQsM5EslTpgnvL2fkfVc42
        6xg3BdqcATq99rMG/73aoMe1Kcvd4F1EDoRHTCxggWopwxTNLRty5wTbyX/2qv1vYA+Xh1VXS
X-Received: by 2002:a0c:db01:: with SMTP id d1mr36806364qvk.38.1626095084084;
        Mon, 12 Jul 2021 06:04:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/CrRvK7+Bje8dTwwkykiBc4zZEKrfFb1NjO2pUVQnlbhrNI0tyU5UePJC6g5QN9qRV0qCVw==
X-Received: by 2002:a0c:db01:: with SMTP id d1mr36806333qvk.38.1626095083830;
        Mon, 12 Jul 2021 06:04:43 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id z22sm2996262qki.54.2021.07.12.06.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 06:04:42 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH v1 1/3] locking/lockdep: Fix false warning of
 check_wait_context()
To:     Xiongwei Song <sxwjean@gmail.com>, Waiman Long <llong@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210711141430.896595-1-sxwjean@me.com>
 <07878d21-fa4d-fbf5-a292-b71c48847a5e@redhat.com>
 <CAEVVKH_95TMa8RRChzG0ZzMdzx3gp7wWmbPnbUst3+mi8wFnBg@mail.gmail.com>
Message-ID: <1c4c058b-3745-5586-4961-79d83fb5b049@redhat.com>
Date:   Mon, 12 Jul 2021 09:04:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAEVVKH_95TMa8RRChzG0ZzMdzx3gp7wWmbPnbUst3+mi8wFnBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/21 4:18 AM, Xiongwei Song wrote:
> On Mon, Jul 12, 2021 at 12:43 AM Waiman Long <llong@redhat.com> wrote:
>> On 7/11/21 10:14 AM, Xiongwei Song wrote:
>>> From: Xiongwei Song <sxwjean@gmail.com>
>>>
>>> We now always get a "Invalid wait context" warning with
>>> CONFIG_PROVE_RAW_LOCK_NESTING=y, see the full warning below:
>>>
>>>        [    0.705900] =============================
>>>        [    0.706002] [ BUG: Invalid wait context ]
>>>        [    0.706180] 5.13.0+ #4 Not tainted
>>>        [    0.706349] -----------------------------
>> I believe the purpose of CONFIG_PROVE_RAW_LOCK_NESTING is experimental
>> and it is turned off by default. Turning it on can cause problem as
>> shown in your lockdep splat. Limiting it to just PREEMPT_RT will defeat
>> its purpose to find potential spinlock nesting problem in non-PREEMPT_RT
>> kernel.
> As far as I know, a spinlock can nest another spinlock. In
> non-PREEMPT_RT kernel
> spin_lock and raw_spin_lock are same , so here acquiring a spin_lock in hardirq
> context is acceptable, the warning is not needed. My knowledge on this
> is not enough,
> Will dig into this.
>
>> The point is to fix the issue found,
> Agree. I thought there was a spinlock usage issue, but by checking
> deactivate_slab context,
> looks like the spinlock usage is well. Maybe I'm missing something?

Yes, spinlock and raw spinlock are the same in non-RT kernel. They are 
only different in RT kernel. However, non-RT kernel is also more heavily 
tested than the RT kernel counterpart. The purpose of this config option 
is to expose spinlock nesting problem in more areas of the code. If you 
look at the config help text of PROVE_RAW_LOCK_NESTING:

         help
          Enable the raw_spinlock vs. spinlock nesting checks which ensure
          that the lock nesting rules for PREEMPT_RT enabled kernels are
          not violated.

          NOTE: There are known nesting problems. So if you enable this
          option expect lockdep splats until these problems have been fully
          addressed which is work in progress. This config switch allows to
          identify and analyze these problems. It will be removed and the
          check permanentely enabled once the main issues have been fixed.

          If unsure, select N.

So lockdep splat is expected. It will take time to address all the 
issues found.

Cheers,
Longman

