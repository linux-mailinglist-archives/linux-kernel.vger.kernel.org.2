Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4939FA77
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhFHP0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232123AbhFHP0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623165856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SWhXW32LM4aSTFZsVWrxfiohXsy3YiiDSsHHQqT3Qo=;
        b=NCECLLnh4n6COX83rhf2YUZ3Gy1p5sWwMUbPIaM4nQ56uhiZ5r2QiZio9N2cgij7odw+Ds
        Xb7vwrPVe04BgIMQGTksLdDnb/fGG5wMCynqwInaDg0n0eif1LkB79+DsF9kjZb9yxWemF
        NscjHd/LOGTv0OYcdMdQGLN59VpQNeY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-vluza8VpPpmX_Tq6frz0Qw-1; Tue, 08 Jun 2021 11:24:15 -0400
X-MC-Unique: vluza8VpPpmX_Tq6frz0Qw-1
Received: by mail-ed1-f71.google.com with SMTP id h23-20020aa7c5d70000b029038fed7b27d5so10931445eds.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0SWhXW32LM4aSTFZsVWrxfiohXsy3YiiDSsHHQqT3Qo=;
        b=tJigcT4HBeC7oT17xOen3MNgYS/PfJJMwFPvB6sP8Thefx6FAgju6xo+eW2TZ6f3jD
         uw7FP20+RXsswlTh3bk68UhEBSulCLij3o083aHM5+Y+uR5itU3n4KT9lwjkBH5d9jks
         LQxVRNLFG+iWdsWnDJ5XBUIh5TX0tJmdsPlqV8/NfS4+9dkaiNHp3NvEvvMxf2JSj1++
         8Fazm2SsI2qqxrO1cp1Gb5ij7etQf0C1JFmkHtg/IPUZW1GNISRu+sp6GF5GJDms2YO2
         V+AsrN7gERDyNETfrlBIdVePgmoUPKyv3znasLE8i37qYwvvjPwfS7CocdzTYXfJKYEM
         NYgg==
X-Gm-Message-State: AOAM531/2P5hSW0DEUSsi1MBezpMStQvCAW3Z1oSHewFGp/7tE4nUSTP
        NujtqZSwklqhHQnCuZjOy3W4cywaW2ghssUmDeMgI7yiwgo1Yl6q89K7eU8tg96H/ZqueeB65dX
        4xI76wd6P6c1qpzL6Mfcoz04E
X-Received: by 2002:a50:fe81:: with SMTP id d1mr26363109edt.219.1623165853947;
        Tue, 08 Jun 2021 08:24:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC6C5Tx3uDIdMvvPG9wL842nf7FOA9Lo3qGoHvimoy8PFYx9YyYZWBjethUIUsBnl/9uUpGg==
X-Received: by 2002:a50:fe81:: with SMTP id d1mr26363086edt.219.1623165853759;
        Tue, 08 Jun 2021 08:24:13 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id m12sm21051ejc.65.2021.06.08.08.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:24:13 -0700 (PDT)
Subject: Re: [PATCH V3 8/9] tracing: Add osnoise tracer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1621024265.git.bristot@redhat.com>
 <bd09a2be9cd0cecee86374dbb49235dd2ef9d750.1621024265.git.bristot@redhat.com>
 <20210604172803.527aa070@oasis.local.home>
 <f4426022-b388-55bf-669f-74f53b91efba@redhat.com>
 <20210607114718.5f8d6c38@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <5941f878-c523-5324-bf24-62da6f11ea9a@redhat.com>
Date:   Tue, 8 Jun 2021 17:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607114718.5f8d6c38@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 5:47 PM, Steven Rostedt wrote:
>> I am using these more "generic terms" because they are also used by the timerlat
>> tracer.
>>
>> In the timerlat tracer, the "in" file is used to stop the tracer for a given IRQ
>> latency (so, the "inside" operation), while the "out" is used to stop the tracer
>> in the thread latency (hence the outside operation).
>>
>> The total sounds good for the "out"! But the single does not work fine for the
>> IRQ... how about: stop_tracing_partial_us ?
>>
>> It is hard to find a good shared name :-/
> What about:
> 
> stop_tracing_us and stop_tracing_total_us, and not have anything
> special for the first one?
I cannot find a better name... and it makes sense: if an "in" value on osnoise
or an IRQ latency on timerlat is higher than "stop_tracing_us"... it is more
important than the total... so it indeed deserves the more intuitive name.

(working on osnoise changes now...)

-- Daniel
> -- Steve
> 

