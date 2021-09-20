Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8FC412B88
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347080AbhIUCTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244155AbhIUCIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:08:09 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BF0C08ED3D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:23:02 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id p22-20020a4a8156000000b002a8c9ea1858so2225140oog.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=tUl0N7JwVVzwh8vmJFHcen+ugTff4BJQWnKbA8C2sGQ=;
        b=WL7KTgSgQdD4mWA/uxOomR2ggibcvCU/Jf/KkqFuVK3lDZhansu3cwyn1bhzND4EqI
         ZdSH+RDpeGG9YhS8XhFcP7w5ClIUE9dgoLHcihi0c7ERmcxeKLtVFYHyBvKqE3A5zcmK
         D4t59cyRsA/SaOAXKKERjcAsi5CVVE6i3NHVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=tUl0N7JwVVzwh8vmJFHcen+ugTff4BJQWnKbA8C2sGQ=;
        b=NGE9pPRooZW28JlYCGCZXMt78DBeX7A5duLD5CkF31hfwxC4jMuJ8fNfMA940NbfAa
         ZcEUgHL5Ue42tkhY5XHQGBTjHBeKMWHBeQZd1WPiSfNT+z6Pnw7DypgJf5oyDfjP7VHl
         rg9XR/pTokYbgvnsOTYHWv/BZA0SJu1cpsJ/qgMEzAnBkEFoLkxlUIzL1K3gMT8EN4LB
         ok/oSYfjm/SA8NiLpFHn0kuN7IsCjnBuB1q3o3Q5kxrCw3JNWJwB8SqYqLlzgjv+7wEG
         HnW/4hZdtqawiK072/0Es2+ZKZq7RXzkYmSlsAWVhFrcscVzWECY77RZV9cHeT3jGyW8
         GUEQ==
X-Gm-Message-State: AOAM533TQRXHxAu8lRBVXUBRGePyqNNQeeaK7mGOTBBSrB4+sUUZru+b
        XUj2Li+PqCaTCnuKXcR+eOHtFLEIzg5pFVZKE1lZig==
X-Google-Smtp-Source: ABdhPJxePw3aN2/L9BQ+Z8QzkjjkGEoHTnunl3+blHjNgWcCGnoaLJb4mRGBhIkGow8ZsudDBW4V9noBFI73pNQvHLo=
X-Received: by 2002:a4a:c3c2:: with SMTP id e2mr7906145ooq.8.1632162182196;
 Mon, 20 Sep 2021 11:23:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Sep 2021 11:23:01 -0700
MIME-Version: 1.0
In-Reply-To: <202109200726.2EFEDC5@keescook>
References: <20210601182202.3011020-1-swboyd@chromium.org> <20210601182202.3011020-5-swboyd@chromium.org>
 <202109200726.2EFEDC5@keescook>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 20 Sep 2021 11:23:01 -0700
Message-ID: <CAE-0n50v6Wm2OBsy5-Q3B9VrNhH+_uyDDa8Ps3MeXsCLZczW3w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug is enabled
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kees Cook (2021-09-20 07:29:54)
> On Tue, Jun 01, 2021 at 11:22:02AM -0700, Stephen Boyd wrote:
> > Obscuring the pointers that slub shows when debugging makes for some
> > confusing slub debug messages:
> >
> >  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> >
> > Those addresses are hashed for kernel security reasons. If we're trying
> > to be secure with slub_debug on the commandline we have some big
> > problems given that we dump whole chunks of kernel memory to the kernel
> > logs. Let's force on the no_hash_pointers commandline flag when
> > slub_debug is on the commandline. This makes slub debug messages more
> > meaningful and if by chance a kernel address is in some slub debug
> > object dump we will have a better chance of figuring out what went
> > wrong.
> >
> > Note that we don't use %px in the slub code because we want to reduce
> > the number of places that %px is used in the kernel. This also nicely
> > prints a big fat warning at kernel boot if slub_debug is on the
> > commandline so that we know that this kernel shouldn't be used on
> > production systems.
>
> Eeeek. I missed this patch. NAK NAK. People use slub_debug for
> production systems to gain redzoning, etc, as a layer of defense, and
> they absolutely do not want %p-hashing disabled. %p hashing is
> controlled by the no_hash_pointers boot param (since v5.12), and needs to stay
> separate from slub_debug.
>
> Can we please revert this in Linus's tree and in v5.14?
>

This is fine with me as long as debugging with slub_debug on the
commandline is possible. Would you prefer v1 of this patch series[1]
that uses the printk format to print unhashed pointers in slub debugging
messages?

[1] https://lore.kernel.org/r/20210520013539.3733631-1-swboyd@chromium.org
