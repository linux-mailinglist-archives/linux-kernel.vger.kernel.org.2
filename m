Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B233478CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhCXMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhCXMqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:46:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A506C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:46:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u21so14661662ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i+VYNNsUhwNP8yoe1kFexaTYLiNv7t3QiYT3Nd2kONs=;
        b=O/19JYrO28UArZ88Lfx7hgoqLqTG2gwaPMrF16nOtlBbHFOsstM6Jlut2VPd/ftSiG
         kzJN3dptmLeeMgvdzmMnYM8rDKMHnG4rsnI51cJUxYmRhPlZ7FzxtqX2VHOGZqNAjkFI
         PxhoB7mqOz3UzX2NQg4lvNkLWvvQk8v4q1h6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+VYNNsUhwNP8yoe1kFexaTYLiNv7t3QiYT3Nd2kONs=;
        b=dhVyE7U3Ezck6QjuSeF+aP6ic2OPHip8TzpunW1cGKpVne7C3fgQsLGLCgHSZ7he9J
         yDrBTQtTQKWYOq5IX+PXkpns44zRMUdYptQR1yc8+yrKw0XXgMnSHZ3NmaOTZDpcWiRB
         ZVt34XuQPD6WtrGdQnkQkej1ooj2EvxPFQkyts4bUjIDmDH68n9FjEPyazNrZYAsf3sh
         Yp+PAchNkyuE5+FtYug92nNZGrDYOXEyOl02s5vMJBIgNmMBYLEJc/qlaHaAInmpW0eO
         h0PZUsy8oYJSi+vGIcHMFtogc/XYBn5KHD2JUVGScgz+O6lWyKYO6QNTyMawOvIE+R5X
         w5Gg==
X-Gm-Message-State: AOAM533+i32CQ7FUgNcWTx9ioMvWN/rsnDIDle8ujjgD1bpxfXo4vlCL
        wUhlhm/mf8f9bZi9UBUlukbyjA==
X-Google-Smtp-Source: ABdhPJxuoI5rYTpNVMVK2zEcda7BaNF+gchsTWi1BYrbXTLurn0LkgD5amalQYgCFdhvOGwbz3vAwg==
X-Received: by 2002:a17:907:76ed:: with SMTP id kg13mr3295566ejc.99.1616589968067;
        Wed, 24 Mar 2021 05:46:08 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id de17sm881523ejc.16.2021.03.24.05.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 05:46:07 -0700 (PDT)
Subject: Re: [PATCH] static_call: fix function type mismatch
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
References: <20210322170711.1855115-1-arnd@kernel.org>
 <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net>
 <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
 <20210322172921.56350a69@gandalf.local.home>
 <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 13:46:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 08.47, Peter Zijlstra wrote:
> On Mon, Mar 22, 2021 at 05:29:21PM -0400, Steven Rostedt wrote:
>> On Mon, 22 Mar 2021 22:18:17 +0100
>> Arnd Bergmann <arnd@kernel.org> wrote:
>>
>>> I think the code works correctly on all architectures we support because
>>> both 'int' and 'long' are returned in a register with any unused bits cleared.
>>> It is however undefined behavior in C because 'int' and 'long' are not
>>> compatible types, and the calling conventions don't have to allow this.
>>
>> Static calls (and so do tracepoints) currently rely on these kind of
>> "undefined behavior" in C. This isn't the only UB that it relies on.
> 
> Right, most of the kernel lives in UB. That's what we have -fwrapv
> -fno-strict-aliassing and lots of other bits for, to 'fix' the stupid C
> standard.
> 
> This is one more of them, so just ignore the warning and make it go
> away:
> 
>  -Wno-cast-function-type
> 
> seems to be the magic knob.
> 

That can be done for now, but I think something has to be done if CFI is
to become a thing.

Sami, what happens if you try to boot a
CONFIG_CFI_CLANG+CONFIG_PREEMPT_DYNAMIC kernel?

Rasmus
