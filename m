Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F503FAFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 05:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbhH3DIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 23:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbhH3DGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 23:06:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01C2C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 20:06:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t4so14156011qkb.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=XyC3eMjyvzy2h5NQGE3juzyJQqXKCxwrrVIRyLgJvIY=;
        b=eKpoBqxUECQpQuZb+Bv1OimWe3irD0+Kev7GuuwE0HUmvH15iHKWOMhUCC+r9252Ns
         GLZJaF+1Qf/jvevCJpYrsmAgZw+S2IE2r19DV5eNdubyJWl+yfRXMsZuXuTZI47QdVLX
         AAfHvU+yNqjVxQUagePECrjV60CIaH5bZb4+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=XyC3eMjyvzy2h5NQGE3juzyJQqXKCxwrrVIRyLgJvIY=;
        b=bOuB41RYI+xQYpJ5zvAHlJDJ7DLBRaTTnmIX7vEZDjg5uKurDQZzh3sOc91yAiTRpS
         pCXe9m4WKDMnhMbvrzyUO4AMbUm3KgTptAiJ8omUEPTc4SJ/tTLYULey6VhGK9nzLMDq
         c/X/4tav1Y8Qx9Vk7Dt+kKqk5Qzs4hhnQNmS2dIkNLlMhVVUZH4DvdcM9k25kqbn4tfP
         yQ2mwE7LWkZ+HirC347J0Kvz2i/Js2bbdO8mEy+rjzWNB7wXdO2pEKAWbvlk40Ak8CJL
         NL0X4U7UVq6S+SOWR/V4yHHQst5OCVhx85XnEWk1JHfIcbS58fUqCgFeaqlvSbAUQLuY
         qCMg==
X-Gm-Message-State: AOAM53285MWTgCjrXdKbKVQqtR4cG7Y8NSgUs8nUBgk5wGt4OV+gjLvl
        F7ofOJYXlDiaj8U4/MjRlB+Aag==
X-Google-Smtp-Source: ABdhPJyE4cvBoiTsM+hBXavMpRxyUsm9/d41wR+wBWfKIs4lkvJamE9UWEpJnUdOsAHJucw1a63RKA==
X-Received: by 2002:a05:620a:4106:: with SMTP id j6mr20608763qko.392.1630292760363;
        Sun, 29 Aug 2021 20:06:00 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id g2sm9994223qki.42.2021.08.29.20.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 20:05:59 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Sun, 29 Aug 2021 23:05:55 -0400 (EDT)
To:     Andy Lutomirski <luto@kernel.org>
cc:     Rob Herring <robh@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
In-Reply-To: <43b3a838-da8a-4733-9832-f3d5f990ec13@www.fastmail.com>
Message-ID: <f3b72c71-f9c9-e1a8-4542-e248e8a5d769@maine.edu>
References: <20210728230230.1911468-1-robh@kernel.org> <20210728230230.1911468-3-robh@kernel.org> <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org> <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com> <de97454b-9b4d-492f-a435-6a5e33889219@www.fastmail.com>
 <CAL_JsqKpT93W6nBj68DykEJzjFYOPG=8PGShsh2QZVzHq5N3fQ@mail.gmail.com> <43b3a838-da8a-4733-9832-f3d5f990ec13@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463802360-918619477-1630292759=:154341"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463802360-918619477-1630292759=:154341
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 27 Aug 2021, Andy Lutomirski wrote:

> On Thu, Aug 26, 2021, at 12:09 PM, Rob Herring wrote:

> > After testing some scenarios and finding perf_event_tests[1], this
> > series isn't going to work for x86 unless rdpmc is restricted to task
> > events only or allowed to segfault on CPU events when read on the
> > wrong CPU rather than just returning garbage. It's been discussed
> > before here[2].
> > 
> > Ultimately, I'm just trying to define the behavior for arm64 where we
> > don't have an existing ABI to maintain and don't have to recreate the
> > mistakes of x86 rdpmc ABI. Tying the access to mmap is messy. As we
> > explicitly request user access on perf_event_open(), I think it may be
> > better to just enable access when the event's context is active and
> > ignore mmap(). Maybe you have an opinion there since you added the
> > mmap() part?
> 
> That makes sense to me. The mmap() part was always a giant kludge.
> 
> There is fundamentally a race, at least if rseq isn’t used: if you check 
> that you’re on the right CPU, do RDPMC, and throw out the result if you 
> were on the wrong CPU (determined by looking at the mmap), you still 
> would very much prefer not to fault.
> 
> Maybe rseq or a vDSO helper is the right solution for ARM.

as the author of those perf_event tests for rdpmc, I have to say if ARM 
comes up with a cleaner implementation I'd be glad to have x86 transition 
to something better.

The rdpmc code is a huge mess and has all kinds of corner cases.  I'm not 
sure anyone besides the PAPI library tries to use it, and while it's a 
nice performance improvement to use rdpmc it is really hard to get things 
working right.

As a PAPI developer we actually have run into the issue where the CPU 
switches and we were reporting the wrong results.  Also if I recall (it's 
been a while) we were having issues where the setup lets you attach to a 
process on another CPU for monitoring using the rdpmc interface and it 
returns results even though I think that will rarely ever work in 
practice.

Vince
---1463802360-918619477-1630292759=:154341--
