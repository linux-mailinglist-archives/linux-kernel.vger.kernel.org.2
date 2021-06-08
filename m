Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4354F39FD68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhFHRTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232007AbhFHRTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623172680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bssjvJCOOtaBsaDrUCIXuaHK4qoeEtQGFAqlYwnZh7Y=;
        b=DXoihOlM4k0cIxDceHYFZe52MVo92HWY5JoWJexVHOyzVgMI5X2mp7iObUqEGkM0fHjj0s
        twkeGxGLQh60vkmrl+8JrzVWGz2k17NmVLMrhMUbtyY76ZTsgLa4sVYg7S1wglx3R3gpt9
        7p28SLytJ48lAXbrek4XhOmv6dwtxdM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-qyRuzcHUMQGaxh_Pb1MAWw-1; Tue, 08 Jun 2021 13:17:59 -0400
X-MC-Unique: qyRuzcHUMQGaxh_Pb1MAWw-1
Received: by mail-ed1-f71.google.com with SMTP id q7-20020aa7cc070000b029038f59dab1c5so11219246edt.23
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bssjvJCOOtaBsaDrUCIXuaHK4qoeEtQGFAqlYwnZh7Y=;
        b=otAUp9cR8SE08hJv03Z/jW1LPNjbpv/9g5qU1t8h8OpqD4dDSJRLRU/t0t6U3nnHZb
         s5767A06qeiQm83X+9GY0wVPx/ODZOluJxjhRB7RS6KgFWc3uhymsT42S0kKefGo6w0g
         XvwJqUMTm7pbghDG/bT/3E+WydmCKhdDFDbj4C8gRGgqJMrR+uQ8aND11pJVjK3/Gxrr
         WHMjjT6JICS+nA9vimVGKuufIEas48JNRxK7yb9ugnjD1AWr4IR6z5QpfDcn4IeyDdSP
         ECIXGw46I1zFSJlaiUrkSovKYY9/Lc5bYJ9+nXb6JMfxRTFF/twy1pA0lURbpiej3nUP
         rCcA==
X-Gm-Message-State: AOAM533AqotwD8DDIhO/2UiRMoxGXvwnN/CupYwKTqoervcQb9viAsQW
        z0c4WizZjsFVOi476Sr9aQyUIjb/r5nH/pjfgf2zc7E09NLeDcoirT+9AxRJbfrqWLBCLp1ziZF
        Tc0AdHafzAw2yMTtufnsngKt/
X-Received: by 2002:a17:906:5299:: with SMTP id c25mr24668733ejm.85.1623172677215;
        Tue, 08 Jun 2021 10:17:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+devpDUVOZ/gnRqFvK5mBebjxlTJ1dtDEIHMbLTtRSuW0/CDBhaUz+0XcvFk0CwLGnX/5Gg==
X-Received: by 2002:a17:906:5299:: with SMTP id c25mr24668702ejm.85.1623172676924;
        Tue, 08 Jun 2021 10:17:56 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id rl12sm114523ejb.94.2021.06.08.10.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 10:17:56 -0700 (PDT)
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
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <abf38ca3-3c14-c00a-ff74-f1a75e3ec2e5@redhat.com>
Date:   Tue, 8 Jun 2021 19:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604172803.527aa070@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 11:28 PM, Steven Rostedt wrote:
>> +	/*
>> +	 * This is an evidence of race conditions that cause
>> +	 * a value to be "discounted" too much.
>> +	 */
>> +	if (duration < 0)
>> +		pr_err("int safe negative!\n");
> Probably want to have this happen at most once a run. If something were
> to break, I don't think we want this to live lock the machine doing
> tons of prints. We could have a variable stored on the
> osnoise_variables that states this was printed. Check that variable to
> see if it wasn't printed during a run (when current_tracer was set),
> and print only once if it is.

I created a "bool tainted" variable, that is set true if any problem with time()
related functions happen. I will pr_warn that there is a problem on _start(),
but also print this info at the top of the tracer header, so it is clear also
from the trace output.

Thoughts?

-- Daniel


