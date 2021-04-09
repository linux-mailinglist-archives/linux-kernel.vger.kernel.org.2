Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D245F35963A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhDIHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhDIHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617952788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IguW8kgGlzt9NZWLdeLXN2H9KrPyDih2gPl5AJIXHOs=;
        b=EoDtTLrIIAs4EtoIT2yEds7U0eudlzcVHZXrBoF2I8QOQZtqkeLboERhmzdPSAugalW3Fw
        PKsAJcb2HZ1EsCx4DdnmyyIJV/HISLfjLVW6zW3I7f98C1gG/RtkTHoJnGRfzragYRECcU
        tn9qcte8dSeD6mF2vzr9nspgGlr1ztU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-jdYd1lSRMCmk4_nYHZQ64g-1; Fri, 09 Apr 2021 03:19:46 -0400
X-MC-Unique: jdYd1lSRMCmk4_nYHZQ64g-1
Received: by mail-ej1-f70.google.com with SMTP id d6so1822061ejd.15
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 00:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IguW8kgGlzt9NZWLdeLXN2H9KrPyDih2gPl5AJIXHOs=;
        b=lPP5FuLYopF2i5Cp0COL9cwo3K4LxcYEgrVMVKTq56Z824Fosfm3tPHeZsMXYsty2Z
         GppFshGCjW43VE1Trtag9D4ANuDnpqY5GZRqXJchQ1CDcz1TY/lkYq/BYmtqkfyUoKQT
         ED0k0Cv3EVuydd9C9U1/jAZ3UXQfvso7de8F72Ks1oCnO8yK7c/SS+JrLPAmijeB1WzR
         eAXv/GeU6O8UpNgSrQNWjGZF8AycglicOHKBWFrlIrg5JRnmL1dYFXJ1JYKaDL2BYcFS
         3PZjg52GZ/TqrZ17urwkk/Mpc94TB2Rc3eaIYz4gaq//dTRgh3Iqp44HsiXejfYMWEA9
         VPSg==
X-Gm-Message-State: AOAM530827ZIxcCt+aj8bDAPac5Buo0P75ZE9rvibMUiNZuzAdlpicZl
        4zvQBaQZcIZpaG+IDcusQw5jxmtQCeOjl2Kz8P+3h/FBih8GpQUXDUF3tjRpBK6RqYp9y+43ooW
        G5+F+5tET5ANmDbdsllzyuqn8
X-Received: by 2002:a17:906:eb88:: with SMTP id mh8mr15162392ejb.74.1617952785056;
        Fri, 09 Apr 2021 00:19:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY41ap57CXKosvNll8nRWMmY6QVDsNdQ7fjAFZZMDSD1+l6HI7mJsboZvYJlWwIeVi4QOZ9g==
X-Received: by 2002:a17:906:eb88:: with SMTP id mh8mr15162378ejb.74.1617952784854;
        Fri, 09 Apr 2021 00:19:44 -0700 (PDT)
Received: from x1.bristot.me (host-79-56-201-31.retail.telecomitalia.it. [79.56.201.31])
        by smtp.gmail.com with ESMTPSA id x1sm791173eji.8.2021.04.09.00.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 00:19:44 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] tracing: Add the osnoise tracer
To:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     kcarcia@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1617889883.git.bristot@redhat.com>
 <3a69303b27bfc5d2274ab893b2cfbd0a8dbe31f7.1617889883.git.bristot@redhat.com>
 <87pmz422gj.fsf@meer.lwn.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b64b560f-09ab-e801-52bf-42a73d26b9bf@redhat.com>
Date:   Fri, 9 Apr 2021 09:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87pmz422gj.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 5:58 PM, Jonathan Corbet wrote:
> Daniel Bristot de Oliveira <bristot@redhat.com> writes:
> 
> A quick nit:
> 
>>  Documentation/trace/osnoise_tracer.rst |  149 ++
>>  include/linux/ftrace_irq.h             |   16 +
>>  include/trace/events/osnoise.h         |  141 ++
>>  kernel/trace/Kconfig                   |   34 +
>>  kernel/trace/Makefile                  |    1 +
>>  kernel/trace/trace.h                   |    9 +-
>>  kernel/trace/trace_entries.h           |   27 +
>>  kernel/trace/trace_osnoise.c           | 1714 ++++++++++++++++++++++++
>>  kernel/trace/trace_output.c            |   72 +-
>>  9 files changed, 2159 insertions(+), 4 deletions(-)
>>  create mode 100644 Documentation/trace/osnoise_tracer.rst
>>  create mode 100644 include/trace/events/osnoise.h
>>  create mode 100644 kernel/trace/trace_osnoise.c
> When you create a new RST file, you need to add it to an index.rst (or
> similar) file so that it gets incorporated into the docs build.


ack!

> 
> The document itself looks good on a quick read.  If you're making
> another pass over it, you might consider reducing the ``markup noise`` a
> bit; we try to keep that to a minimum in the kernel docs.  But otherwise
> thanks for writing it!

Thanks for the review, Jon. I will reduce the `` markup (on this, and on some
other docs that are about to come :-))

-- Daniel
> jon
> 

