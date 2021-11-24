Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A767A45CD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbhKXUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:09:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233616AbhKXUJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637784370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3FNTmsc1SXTLd0gvUMImMwzqQbvxssx/fBfDABEpVI=;
        b=Ld90LOpU7/QT4jA7Xp33c68XKUck1A25oOVbg58OUeU8JAVYxPysZKSa7YhbmOyFYZGly1
        2JhpKgsHMphKp5IOrbQPnzmKYPSMiTkFNhI9dO0KwZXagNM8H9EvPJoqsJZlq2qOb3J1qq
        p1YU49H+qB+Qe0QqkhmTzY2zHIRSY3Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-Qisw6VKQM9i_3LZ0InGrgA-1; Wed, 24 Nov 2021 15:06:08 -0500
X-MC-Unique: Qisw6VKQM9i_3LZ0InGrgA-1
Received: by mail-ed1-f72.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so3382553edq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g3FNTmsc1SXTLd0gvUMImMwzqQbvxssx/fBfDABEpVI=;
        b=rMOU2P10rOVdB0aPw9USaAGeEVJZoIS29NLrXHjJkebZC8BpaC7nKMLtZ/KsOtXvW5
         BXafPAhgikjpMGxEtcpLRI8KonWQvy6raV/JeFT0QUQesLlnRXMTfNwqsc4rCiNHmEa9
         3PHfOl8EumBtacVpmMkB6PdTGt652x3OKg3UGT+bgShtutsnZA3crYgHSDXTlRRdIt7l
         TTMgIfGzrVjPXhDawH5knkWR4beoVXppGDCFXj7JM6hFyrHxbo24YxbnGP02Y9mNUAWs
         OJndc+tF574ES+x5a0qWmSII9ZubC4Qy1fOxkq5VfQ2i+huvq7ziSCDKRn1/aRExBzIw
         yKZA==
X-Gm-Message-State: AOAM533XFcQtCneXtiBkFKmWI96K8P7vRWpRM58FWY5kA/iMHdf27H8M
        fkDJngqDA3W1cQq77Q/xh5holU0jvb3by32CbFyHReeeYpV8EhJCP5ZSvf/SHDh9gJ3BHTmgQ36
        7rDjqxECoYy7p2E+8HEPCa84T
X-Received: by 2002:a17:906:1f14:: with SMTP id w20mr23379438ejj.365.1637784367441;
        Wed, 24 Nov 2021 12:06:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7eywc3pFLa+vnFIIagMLyxPXF3qzpHEqeQHc2f64JABQ0cFFptRXuwAGlA4wEZKHT1aIARA==
X-Received: by 2002:a17:906:1f14:: with SMTP id w20mr23379419ejj.365.1637784367302;
        Wed, 24 Nov 2021 12:06:07 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id p13sm586571eds.38.2021.11.24.12.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:06:06 -0800 (PST)
Date:   Wed, 24 Nov 2021 21:06:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [GIT PULL] tracing/uprobe: Fix uprobe_perf_open probes iteration
Message-ID: <YZ6bLc81ZBeRUG+U@krava>
References: <20211124100956.6905a198@gandalf.local.home>
 <CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com>
 <CAHk-=whYWvdKrFY3-xcRFqyxAMnhMGsmU=0gYWYWuRrR7mFV-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whYWvdKrFY3-xcRFqyxAMnhMGsmU=0gYWYWuRrR7mFV-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:30:24AM -0800, Linus Torvalds wrote:
> On Wed, Nov 24, 2021 at 10:27 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Instead, you should do something like
> >
> >         list_for_each_entry(pu, trace_probe_probe_list(tp), tp.list) {
> 
> That 'pu' is a typo, it should be 'tu'.
> 
> The patch itself got it right, I think.
> 
> HOWEVER. Despite the patch itself getting it right, I want to point
> out that that was mostly by luck than anything else.
> 
> The patch is ENTIRELY UNTESTED.

I put your patch to the test and.. it passed ;-)

there are several other places like this around and also in trace_kprobe.c
I can send the follow up fix tomorrow

thanks,
jirka

> 
> Because that's how I roll, as you should all know by now.
> 
>                   Linus
> 

