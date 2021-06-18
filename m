Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36EF3AD3EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhFRUzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbhFRUzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:55:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08848C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:53:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so18756051lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7mevbUgr3RCVzXux42b3N2xAphxAT+zbkeqT9c1pc0=;
        b=QnOg9hEpzwYDkgbeB18VAZPpyaKsXlB8pgO8LGFvc40lkbKeUnvRWKmOpOuu2Dq89C
         GOA3Dw+cME79YQRp1MTd58mG6Hf9u8y33ysWyJB+KHEcJC+mfKVB/dRPt2ehsxJcJqeP
         qNhZhmZOPrJf2cbe5gHdGfEyc6X/QX93uk++w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7mevbUgr3RCVzXux42b3N2xAphxAT+zbkeqT9c1pc0=;
        b=Zi1qkfdfVhIA3wGxP1Rl442T5G0JvU5AnOZRsFVAzwsr2uGiVUzoxQjQ/ZxxqUkmKg
         qIPDP2kwiw4yt1KPfBmrVMN0alJLSDVDk5iTAeA8hOWi9oxB0bQ3M6jh7VGQWfPeg491
         oZQ4uxLziopXhYstk/uzKar3BqAcCr3qABCcaPX6KU4tMdCyq2L6qbDe03Ft3qAsQVYI
         TouC2KhDllQvvAySdA1SQjNuyvm/4f8OX3e3W+EhMc6wn0rYKIExPql6qgGH5nbTKFMj
         dYIjjoUSYPFM0jhlbzWYfyLTyzharrfTr6UZRKGlzjbywSv+Mv0GT5vElMjdd7nd9P1U
         t97w==
X-Gm-Message-State: AOAM5322uMfMtckBdiVK99IjdDFZcskyVFZAOjeboAczCcgHoh/G/2XX
        sRnPWIvSZZI/CSWf5vTBoakoEwxQ8thmMgku
X-Google-Smtp-Source: ABdhPJxUSczH9r9JMFpzlHLVdqkcRTQKjzX6z4TMyvjtTshdllfg8X/+16Qbo/rZOubh+vmdg3QgSg==
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr4622988lfl.253.1624049579182;
        Fri, 18 Jun 2021 13:52:59 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id u5sm1012427lfs.196.2021.06.18.13.52.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 13:52:58 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k8so15622141lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:52:58 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr10901542ljh.507.1624049578156;
 Fri, 18 Jun 2021 13:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <162387854886.1035841.15139736369962171742.stgit@warthog.procyon.org.uk>
In-Reply-To: <162387854886.1035841.15139736369962171742.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jun 2021 13:52:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRiXMUEtyeHVCT7hp0ZZV-VLAG00Osw6qbUEyi7sWpuw@mail.gmail.com>
Message-ID: <CAHk-=whRiXMUEtyeHVCT7hp0ZZV-VLAG00Osw6qbUEyi7sWpuw@mail.gmail.com>
Subject: Re: [PATCH] afs: Re-enable freezing once a page fault is interrupted
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 2:22 PM David Howells <dhowells@redhat.com> wrote:
>
> If a task is killed during a page fault, it does not currently call
> sb_end_pagefault(), which means that the filesystem cannot be frozen
> at any time thereafter.  This may be reported by lockdep like this:

I've applied this patch.

Everything in my screams "the sb_start/end_pagefault() code is
completely broken", but in the meantime this patch fixes the immediate
bug.

I suspect that the whole sb_start/end_pagefault thing should just go
away entirely, and the freezer should be re-examined. Alternatively,
it should just be done by generic code, not by the filesystem.

But it is what it is.

           Linus
