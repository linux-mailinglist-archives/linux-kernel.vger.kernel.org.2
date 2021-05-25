Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6511C38FAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhEYGWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhEYGWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:22:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98273C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:21:06 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id c3so29296464oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6hrdkIi6HZbv/fsV6gwWuvm7eu0V5FUlGVdsdNzIS4U=;
        b=Fd71g9BWhbHuaTOFPZyr9FzEnxjVg48QdxjA2/puRQvVw/39VC0RaV7IBKU/NNmT1U
         zM/+lnF4q4Xx8PhJ40wLWtMsvcHcxkfkAGjgbVm2laysHvwy0Vgvhyyb0QES85Oq4KS3
         +DDSziglHK1qcz99dCPpVk/4oooEPSYBS2ud0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6hrdkIi6HZbv/fsV6gwWuvm7eu0V5FUlGVdsdNzIS4U=;
        b=jywdATl41uw1YJAGfoAZH2e4vB5ENLaSNhc1+IEmZ27XgUJotwZALllAhmm7434qYB
         1voNrMGni8SF0QT7LnlkJ+BrZSLR2MBP4w/wS1FRqwD4DhJMb9rZV1AZDFoNgC+3dWhh
         9h1qss7oiX0V5jG5bDEdpDFMusyF6sHNDRKiO/DSP07btatQx+xYsXpvCz1Vh6mgcNAp
         MOjX37UOZdSz1O+OMQIy+SJK1SD0csZL6k+Hyyt6PzTj3lrCNxp7Jp9kv5C1l8U1xHrg
         K5I+BafuKVt2y0K/bz9Bd+xTZC7wmaJuDoO6OS4+N2ucyqjCTAD4xOF1Jx6b0YfofYbA
         SCTA==
X-Gm-Message-State: AOAM531/0R6fqpJ/8kgKiJFrgiDQ/1ttj3KcdTSF7vkxo4PrJfPaJzxp
        pg5PY/hLo2rByeORSiOX1PzhZtFoqAsjOBwKOd7R+9LnRQY=
X-Google-Smtp-Source: ABdhPJxwSLxKwzgc29+eiNZA9mbQbwLwZgXC13/0DCOF35H/4VxBqBPhfG164Xhvm4C/2RmOaGbUJ50j3XkJRFxxIH0=
X-Received: by 2002:a05:6808:144e:: with SMTP id x14mr1855471oiv.166.1621923665992;
 Mon, 24 May 2021 23:21:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 May 2021 06:21:05 +0000
MIME-Version: 1.0
In-Reply-To: <20210524113213.h33k3t2exr5rlwin@pathway.suse.cz>
References: <20210520013539.3733631-1-swboyd@chromium.org> <20210520013539.3733631-3-swboyd@chromium.org>
 <20210524113213.h33k3t2exr5rlwin@pathway.suse.cz>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 25 May 2021 06:21:05 +0000
Message-ID: <CAE-0n53b64jzKimxFp1EtzS152048B7kbpQvaEzn-g9uytmQww@mail.gmail.com>
Subject: Re: [PATCH 2/3] slub: Print raw pointer addresses when debugging
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-05-24 04:32:13)
> On Wed 2021-05-19 18:35:38, Stephen Boyd wrote:
> > Obscuring the pointers that slub shows when debugging makes for some
> > confusing slub debug messages:
> >
> >  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> >
> > Those addresses are hashed for kernel security reasons. If we're trying
> > to be secure with slub_debug on the commandline we have some big
> > problems given that we dump whole chunks of kernel memory to the kernel
> > logs. Let's use %px here and dump buffers with the actual address for
> > the buffer instead of the hashed version so that the logs are
> > meaningful. This also helps if a kernel address is in some slub debug
> > report so we can figure out that the object is referencing itself.
>
> Please, do not do this!
>
> Use "no_hash_pointers" commandling option when you want to see
> raw pointers. It will make it clear when the kernel logs are save
> and when not.
>
> If "slub_debug" is useless with hashed pointers then it might enable
> "no_hash_pointers". But make sure that it prints the fat warning.

Ok I'll try to make slub_debug force on no_hash_pointers.

>
> This patch is the worst approach. We have to keep the number of "%px"
> callers at minimum to keep it maintainable. The only safe use-case is
> when the system is in panic() [*]. If the pointers might be printed
> at any time then users should be warned by the fat message printed
> by "no_hash_pointers".
>
>
> [*] Raw pointers are currently printed also by Oops/WARN messages.
>     It is from historic reasons. Anyway, they are fat warnings
>     on its own. The system often need to get reported anyway.
>

Got it. The slub debug messages are usually followed by stuff blowing up
and the system crashing but it's possible that the automatic fixup code
will save us. When you have things scribbling all over the place it
doesn't end well.
