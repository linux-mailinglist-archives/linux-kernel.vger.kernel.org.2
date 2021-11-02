Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646324434D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhKBRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhKBRxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:53:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6142C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 10:50:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq11so168954lfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Evjqo5x9nTSOUDyDFPn5FDtubzC/QO/xYkyrR/MU7Oc=;
        b=Kwy1ytoYq54MS/sS+JM7LrEQZYxzXLwsTaOhT+yG6ODxpfxYJvJDjPZJQxggwhvQjs
         6o25zhDLZzQIsBnztTL4lbh9mOPtPVaFamnTA87r9F1w8GD8QJAKQn0NvrCT9Wfx9tu0
         UdE7RcIwDlCsl6LAUFmlYSAPFKEFpQbbObMfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Evjqo5x9nTSOUDyDFPn5FDtubzC/QO/xYkyrR/MU7Oc=;
        b=43LRMuJzPXjkIFrBNIOgTr1JajEhVimO6yv31qot/b5lm2VE7HjRuQVhMT/cepjvG7
         Gct0OPQ7iqCXqabaI1oDeiowZr7nBye+MK1yaIaRUlqRmWYKeCOqCQB8uPdTudOqC+Bw
         Z080fRufIo6RlMqrw8mTCmrxm/GIL/iyJSmgBDArAYNSXj5p4kr9bdKNBSHfsKP88vDK
         3xx74u8ruM/cMp4SdxAgfFMSxvgyff8ZEXwzv4vxc42Lm0GgF5HMjWSkm7ixesF2KDRS
         BkTQBvxPpa8OvekThQGe2weu6rP91QjfWw66Sq5rr+/olf2zjmTz9VCgJN2w77DnQWvt
         5zAg==
X-Gm-Message-State: AOAM532UiSptAnna+Gho+aBY7gMixSZY9l6qyQZRc3WRaKjoUHcYuj7w
        SrG/7fkYDQ1QBJkDEUrwrHJuCotT6owgyZuH
X-Google-Smtp-Source: ABdhPJzIYVexB23FYasiGgRAV/9UsNpWUbH+NHDgOuuxGAS14J4m1XpcBuQIM/SzcoRrIB11A4TRVA==
X-Received: by 2002:a19:384b:: with SMTP id d11mr6843853lfj.312.1635875439812;
        Tue, 02 Nov 2021 10:50:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c15sm1739426lft.244.2021.11.02.10.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 10:50:38 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id i3so231656lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 10:50:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3993:: with SMTP id j19mr33110123lfu.402.1635875438251;
 Tue, 02 Nov 2021 10:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864563.3357115.8793939214537874196.tglx@xen13> <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
 <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net> <YYD/bpLabfumrvL+@hirez.programming.kicks-ass.net>
 <YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net>
In-Reply-To: <YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Nov 2021 10:50:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghWC3B6tFpQChL=q+HdUKN6R3OohPt53VsEOcKASKrRQ@mail.gmail.com>
Message-ID: <CAHk-=wghWC3B6tFpQChL=q+HdUKN6R3OohPt53VsEOcKASKrRQ@mail.gmail.com>
Subject: Re: Stackleak vs noinstr (Was: [GIT pull] objtool/core for v5.16-rc1)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 3:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Having the plugin gate on section name seems a lot hacky, but given it's
> already doing that, one more doesn't hurt.

Looks sane to me.

Some of the other warnings are just odd.

Why is mce_setup() 'noinst'? I'm not seeing any reason for it, but
maybe I'm just blind. That one complains about the memcpy() call.

Of course, I suspect memcpy/memset might be better off noinstr anyway,
exactly because they can happen for very regular C code (struct
assignments etc). But mce_setup() doesn't really seem to have much
reason to not be instrumented.

             Linus
