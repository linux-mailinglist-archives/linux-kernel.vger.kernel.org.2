Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21B73E08E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbhHDThy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231195AbhHDThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628105858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ksnx6CHFwn6pJOfE3ztxCcBHzcflsnEfby4xYHR0oTU=;
        b=DGdy0r6atGyLhQZIh0qfF9sNPTrC4z8UeRvwiPEwwiKvyEutGWbsM91MWBQihqR45ZJvuc
        KJQ6K+rLbdpDKBp/lry7LDxQzbMI50AFBj+F8071IY/q8cVAU+GsQAmBcQupBR2agqscEX
        Z0tbqnaZLeEuVnICGMPP4tEI+CFfwEA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-28cyDZYCN8ikCD6pBfpRwg-1; Wed, 04 Aug 2021 15:37:37 -0400
X-MC-Unique: 28cyDZYCN8ikCD6pBfpRwg-1
Received: by mail-qk1-f199.google.com with SMTP id e11-20020a05620a208bb02903b854c43335so2641848qka.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 12:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ksnx6CHFwn6pJOfE3ztxCcBHzcflsnEfby4xYHR0oTU=;
        b=ogEsubyYxiR6g2zEyyVkascyVsfXupP1lPOjPZdDB7AZxTbEw3wwcLUZ4LBjF7lIXh
         QFC1zhbRTYpK8hXIVXMv/9UgTNdSgKY+Y8ZaAd7OS8blH1607zISCMq55zomGL23C5h4
         t92BmRA96oGUzfrWdLmpql2LwW6/evfY1KXhOk5pvvLCkOhmuK0uKUgE+mn0VWTAnZDY
         OJ6OdM8dg5HGHJKO0E86b+/9uTXQNA9QZJPilEuTKwlMuOMtuxn3fVC9/Z46KnL9uyM2
         CsEVY2+M5PCzJSlZcXQ0xEJXGO3AXqV7dU6ev1rbIcObrTK2ota2zFZygNl5vWJmBH6L
         HmnQ==
X-Gm-Message-State: AOAM530Cp3t/Nmawvo/gtAuYPUknXfmoorx+eTPq6XWg24+BGLGnYxEF
        5QFIxdI3+6I5SalmJ7i+vJNi26sYS2yY/0opkST4yWeA6WAVngJF3p2gKsNS68xxuB/njnw7YeF
        aMRyG2HcZ+Md8SuO9DFRKQ+lH
X-Received: by 2002:a37:e4f:: with SMTP id 76mr1091003qko.44.1628105857140;
        Wed, 04 Aug 2021 12:37:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyES2OgkWswAO3hMKw5RlLcEt2kS2n05ZHJWjW0ITp3UJHYctqa1lS2Ts+0fLSiofg671ACdg==
X-Received: by 2002:a37:e4f:: with SMTP id 76mr1090981qko.44.1628105856840;
        Wed, 04 Aug 2021 12:37:36 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b21sm1209730qte.38.2021.08.04.12.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 12:37:36 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [patch 15/63] locking: Add base code for RT rw_semaphore and
 rwlock
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135206.018846923@linutronix.de>
Message-ID: <710fff58-1db3-d0c2-21db-b1837d37bfee@redhat.com>
Date:   Wed, 4 Aug 2021 15:37:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730135206.018846923@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 9:50 AM, Thomas Gleixner wrote:
> +static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> +				     unsigned int state)
> +{
> +	struct rt_mutex_base *rtm = &rwb->rtmutex;
> +	unsigned long flags;
> +
> +	/* Take the rtmutex as a first step */
> +	if (rwbase_rtmutex_lock_state(rtm, state))

This function is used here before it was defined in next patch (patch 16).

Cheers,
Longman


