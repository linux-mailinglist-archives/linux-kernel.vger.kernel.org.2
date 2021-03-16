Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD233DCE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCPSuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCPSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:49:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B41C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:49:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4039633pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ywai4YPe6URsofe8kbvRJ5BLerohwMgOUz2A+yTu1V8=;
        b=Gi/mZifZtaRGM1hAEWLLYtHoNGjeBYezFLY4Ub3n4u88qoaWqF2dg8531Bz2gbABn6
         FO4WtNeX0KhGduNg1GnpbY9Y/CIeAnzjNt9lLhqJ3bQiOEJ4BtAToC4VblibmRyuvANn
         uwgAnFSNL24Cp92te+97NTCIADTkE1HxM61l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ywai4YPe6URsofe8kbvRJ5BLerohwMgOUz2A+yTu1V8=;
        b=ggipdjTh8LoB67efEa0TJct7kC5OO/AZofPXFNHj/lmVIvi7+siUSjbz1vFKWlGgqM
         GCk9NLeeG4L1bDt363lS/OsVoSAfJ4RiVfnAQw86Yxwg8mQJz2SeQH0zLM1sN9lzKPx1
         RXPoRXJOgP4Yk5u5tfLwYCZOxUmJESridiJ2ETlw8MkQnk263p/EEySenl8Klg2EL6We
         2WMf2YrzEdzTNQK60Bw1e45N1tkIPBO9DeRuTwHxTTEgJCdDzw8aLKxNpKO8wYHUqfz/
         Jk8ZVYpKiZt0Aqq8Qy9yhmLZY1n/V/skI1dJV8kAPHhS2PZ6A+0PUny5eS/0yuphoMxf
         pZJA==
X-Gm-Message-State: AOAM533nTV2TG5nVTfYZJ6xDBroJeWRdnVKM1A6s8+1hbTHPvzrx3Xc0
        NrQ+ASbJ5BKqgOPz5GwKS/3XFA==
X-Google-Smtp-Source: ABdhPJz3uNdO8WaSSFDiiPWSz3MOZAP5SYHuuEd9I+bSp0sGeAPb9gjvi+a+I3tMUX5HzOo1dk+55Q==
X-Received: by 2002:a17:902:7612:b029:e5:f0dd:8667 with SMTP id k18-20020a1709027612b02900e5f0dd8667mr739777pll.59.1615920562658;
        Tue, 16 Mar 2021 11:49:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a30sm2800263pfr.66.2021.03.16.11.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:49:21 -0700 (PDT)
Date:   Tue, 16 Mar 2021 11:49:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v8 3/8] Use atomic_t for ucounts reference counting
Message-ID: <202103161146.E118DE5@keescook>
References: <cover.1615372955.git.gladkov.alexey@gmail.com>
 <59ee3289194cd97d70085cce701bc494bfcb4fd2.1615372955.git.gladkov.alexey@gmail.com>
 <202103151426.ED27141@keescook>
 <CAHk-=wjYOCgM+mKzwTZwkDDg12DdYjFFkmoFKYLim7NFmR9HBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjYOCgM+mKzwTZwkDDg12DdYjFFkmoFKYLim7NFmR9HBg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 03:19:17PM -0700, Linus Torvalds wrote:
> It just saturates, and doesn't have the "don't do this" case, which
> the ucounts case *DOES* have.

Right -- I saw that when digging through the thread. I'm honestly
curious, though, why did the 0-day bot find a boot crash? (I can't
imagine ucounts wrapped in 0.4 seconds.) So it looked like an
increment-from-zero case, which seems like it would be a bug?

> I know you are attached to refcounts, but really: they are not only
> more expensive, THEY LITERALLY DO THE WRONG THING.

Heh, right -- I'm not arguing that refcount_t MUST be used, I just didn't
see the code path that made them unsuitable: hitting INT_MAX - 128 seems
very hard to do. Anyway, I'll go study it more to try to understand what
I'm missing.

-- 
Kees Cook
