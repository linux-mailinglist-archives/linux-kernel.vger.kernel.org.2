Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A173422B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhJEPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbhJEPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:00:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B880C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 07:58:34 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s11so20002275pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bgoHCxSMWvrI+zzIWEUSO5wxgiEm1xpuQV4K1NeO+Fo=;
        b=n2VxdJdbtIt7YREvkC5LomLZ+1AYzH92N+DmBobCEQ++KbLOQ8yWMf95N4fS11aFkC
         zNijFy/PhpP4oXtf82j8SMrtpMxI6+JjjR8Ar9xP6xG+CnKLSYEaS1eGtVzSxxUp/A3a
         +BrhTp99Mh8EZQ6jnxN7BZCQu/VMjcGoA93pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bgoHCxSMWvrI+zzIWEUSO5wxgiEm1xpuQV4K1NeO+Fo=;
        b=5j7nrQnkfLpcxfDnPsAC64dse6KYe5SrX6aAIPslQN8oTLKjCRvuRzuA/Mf/fw3Zaj
         Qbt0J9EP+4+214dD/JC641B7V5RS5YLzi9xBrZjznkXn2zmjyMyKPUStCc+6EFOVOGxV
         VXMIcKOjCTNc/s7hi5p0dA8TzgKX2kJzjifOvE63IaiGElENYyFXzHJys6a6Gj0ztG/A
         ikKSOn4umfLY1FxCkz5t0oyXNBI5KXV+MEH5GmV9ZCn+JNTLAj2BtVspD7RamYe8bdas
         +ZgqouT460x3UAM1WevhyCK4+OD1ih927cfMwlVpKnKf4Bm1tdIoeCpHJNfCEIX57ljE
         KhfQ==
X-Gm-Message-State: AOAM532Z8nj0COMVwqZtTI66NkezLl01PZJf4qYKpj/idGuYFj4GJ9Ft
        xGru+BtwikJoeHiB9gsxHOcNOQ==
X-Google-Smtp-Source: ABdhPJwiCrol/8Yn1vfrch619l1Kejw3+LZHyiDtgtNjkiBiVAGbNI4qLOTTVNP5HnHCXg70FEGGbw==
X-Received: by 2002:a63:3549:: with SMTP id c70mr13028802pga.179.1633445913710;
        Tue, 05 Oct 2021 07:58:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mt5sm2512942pjb.12.2021.10.05.07.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 07:58:33 -0700 (PDT)
Date:   Tue, 5 Oct 2021 07:58:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] docs: Explain the desired position of function
 attributes
Message-ID: <202110050758.E7470639D@keescook>
References: <20210930235754.2635912-1-keescook@chromium.org>
 <87h7dw75gh.fsf@meer.lwn.net>
 <CANiq72mTmYCJ4_7KVRMMKCDTMrnE9wCXBKViCMzkW1ErpdZKHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mTmYCJ4_7KVRMMKCDTMrnE9wCXBKViCMzkW1ErpdZKHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:28:40AM +0200, Miguel Ojeda wrote:
> On Tue, Oct 5, 2021 at 1:57 AM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > In this case I think we're as close as to consensus as things get.  In
> > the absence of a strong reason to the contrary, I'll apply this before
> > too long.
> 
> No strong reason, but there was the question about the `__malloc` in a
> separate line in the second example which seems to contradict the
> declaration and it is not explained otherwise (+ clang-format does it
> differently).

I'll send a v5 -- the "extern" also needs to be dropped.

-- 
Kees Cook
