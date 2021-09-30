Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907AF41D0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347430AbhI3BDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346416AbhI3BDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632963724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9UdvZG0YEJVZClWq53eAG02FCtxvmE6sqFoeosFyqE=;
        b=D4yNfFEbaz5GytgCUXA3IL2MYxr+ZZTAfAl7y2HGyMtg+0za8JVAEs0Q09V6z3Qk/6JZzD
        W/hL8QUtWUmILJID1NqWbD4H+ZP5bePJm6/rCumYvQXYQW64Wj2nMLdLds7qWtbRWwJhIX
        Z38e4PE9M7/dd1VH5i9WK/XIiIefaVo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-XE9TTIkQP7a8ZTPDHb8geQ-1; Wed, 29 Sep 2021 21:02:03 -0400
X-MC-Unique: XE9TTIkQP7a8ZTPDHb8geQ-1
Received: by mail-oi1-f199.google.com with SMTP id w26-20020a056808091a00b0027630e0f24aso3222943oih.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9UdvZG0YEJVZClWq53eAG02FCtxvmE6sqFoeosFyqE=;
        b=qbqjOpOtjkrXQfgtiOfxS8x4dvB4AcLswG4XfIicQTF38JHzJQpFnBGEcjnc9lI4Vl
         ZwtVXl4Ka9nXwjRdvxQJecU+qPE3HWhzIicLCiI0kLqfdwKo2bfUfeGGRsIfhcIULBs2
         ex+frMVRx5Yciwc+KHP0G0DGWYj5tnsrQ4mu6spq6uR3ugUOPZrkq3SIipTsJCXrkZOE
         lNGbBIyxBaMzV342wettQUAlohdfjLYQUgVDTG4qjZ6Q8Q6SCtIj43VjQCRYiAnI1RkC
         aXhs6EyHZmCBZwZUSszTCkgS5gK9QzFP2JvoZ6DKly+YNzUjAps6ijgc/8nVYWyzHqaa
         fRlw==
X-Gm-Message-State: AOAM531RS/9DY9UKiOPSRmK4qwDJdNNF8U/vsMZoLAtHntTNGUZTNKSC
        obC7vma1morPIIwODL6GPuPmyJEnOH0PziEJIvQBQQ4hdalXC+Thmp/L+AgfrRaGCJ/jJ0doG6o
        k5DglLvfyZXxze6rPSap/XCjR
X-Received: by 2002:aca:c087:: with SMTP id q129mr529086oif.135.1632963722693;
        Wed, 29 Sep 2021 18:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0Tw4Fp0MMhT/H3V+Dn5VteSAFCUkXlIdi80tvmOHj5l49S0YmJu4v/9X8jLPdZyJiM/wNWw==
X-Received: by 2002:aca:c087:: with SMTP id q129mr529059oif.135.1632963722411;
        Wed, 29 Sep 2021 18:02:02 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id g12sm300036oof.6.2021.09.29.18.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 18:02:02 -0700 (PDT)
Date:   Wed, 29 Sep 2021 18:01:57 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 0/6] wchan: Fix ORC support and leaky fallback
Message-ID: <20210930010157.mtn7pjyxkxokzmyh@treble>
References: <20210929220218.691419-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210929220218.691419-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:02:12PM -0700, Kees Cook wrote:
> Hi,
> 
> This attempts to solve the issues from the discussion here[1]. Specifically:
> 
> 1) wchan leaking raw addresses since 152c432b128c (v5.12).
> 
> patch 1 fixes this with a revert.
> 
> 2) wchan has been broken under ORC, seen as a failure to stack walk
>    resulting in _usually_ a 0 value, since ee9f8fce9964 (v4.14).
> 
> patches 2-5 fixes this with Qi Zheng's new get_wchan() and changes to
> the /proc code to use the new helper suggested by Peter to do the stack
> walk only if the process can be kept blocked:
> https://lore.kernel.org/lkml/20210929194026.GA4323@worktop.programming.kicks-ass.net/
> 
> Peter, can you take this via -tip?

It all looks sane to me.  Thanks for cleaning up this mess.

- Should we use a similar sched wrapper for /proc/$pid/stack to make its
  raciness go away?

- At the risk of triggering a much larger patch set, I suspect
  get_wchan() can be made generic ;-)  It's just a glorified wrapper
  around stack_trace_save_tsk().

Regardless:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

