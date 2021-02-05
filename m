Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF8B310FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhBEQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhBEQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:45:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777DBC0617A9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:27:35 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id q12so11163573lfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhfCHagI1sqqpf6f51+Hwn9ljjzG7Pktd2A52iAON7E=;
        b=a43ocwMCwZeo+3MGlYdg1zDoiFF7DJJOFXNomaVtcvC8cInQQD1hj2yMwIl4iNZLUD
         EJ8zjjoyTQONpuBCXbKs+ADXfo7RaoOqx0WZ/sggeC66H6qVljAubJzJu8yFWNZDl/Cn
         cArQYXLJCHtQnELcmBMDI9yUOfs0zb3ulbXyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhfCHagI1sqqpf6f51+Hwn9ljjzG7Pktd2A52iAON7E=;
        b=Lat+3LDBvyznyZ+bB63FROYHeUQvBVdA+tG+GZdtodHRZimIyhr8k8HhN8+kAmwUvv
         f83Lx3aDVfgRMFALLmCa7/5syGTcgLEGacakUtgBCno/QnAfjKBP5PoyvpI1PycZ2ybc
         /Y1zJAevdDUE1Ii0wAMdCuXnxhvlvG77W8CYJkFKcyIsasWfHQZQv7Bzrw9sBIQeXf3w
         d8h6Pl7NQ+kZeGU1ehiOKRvjrwm/3PgeCZbVS1Rmkb2DnnBx/BuMa1kEQyQhhYslttQ1
         k9qEFEZfvrUgsKAwCaUfDgdjs0ZkGRqHjJU85gEQwlMD7XlWNiIbTOcZqMVyLaaxCvHb
         FWSw==
X-Gm-Message-State: AOAM533yJYRRgkZL40FstiiGUmS1+kGMTtkyk5CW3a98+NR1imSMwPDo
        MCm1onNAabfWNxjt4YmRslKf/hHhpq7IcaI7mWVarQ==
X-Google-Smtp-Source: ABdhPJyTYL9fMonnT8BhMIeFUlj9I+74ycMzbMV4QGm4w4YUVnU4ryM8D0bpDxgeFjGgDtTPf8nLKFJp+ICwr092XOM=
X-Received: by 2002:a19:750b:: with SMTP id y11mr3261168lfe.479.1612549653814;
 Fri, 05 Feb 2021 10:27:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612534649.git.jpoimboe@redhat.com> <9583327904ebbbeda399eca9c56d6c7085ac20fe.1612534649.git.jpoimboe@redhat.com>
In-Reply-To: <9583327904ebbbeda399eca9c56d6c7085ac20fe.1612534649.git.jpoimboe@redhat.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 5 Feb 2021 10:27:22 -0800
Message-ID: <CABWYdi0Dh7DJZGHX+1P-Huu=dBCwCxaf_WuyXmMLueVg9eomcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/unwind/orc: Disable KASAN checking in the ORC
 unwinder, part 2
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 6:24 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> KASAN reserves "redzone" areas between stack frames in order to detect
> stack overruns.  A read or write to such an area triggers a KASAN
> "stack-out-of-bounds" BUG.
>
> Normally, the ORC unwinder stays in-bounds and doesn't access the
> redzone.  But sometimes it can't find ORC metadata for a given
> instruction.  This can happen for code which is missing ORC metadata, or
> for generated code.  In such cases, the unwinder attempts to fall back
> to frame pointers, as a best-effort type thing.
>
> This fallback often works, but when it doesn't, the unwinder can get
> confused and go off into the weeds into the KASAN redzone, triggering
> the aforementioned KASAN BUG.
>
> But in this case, the unwinder's confusion is actually harmless and
> working as designed.  It already has checks in place to prevent
> off-stack accesses, but those checks get short-circuited by the KASAN
> BUG.  And a BUG is a lot more disruptive than a harmless unwinder
> warning.
>
> Disable the KASAN checks by using READ_ONCE_NOCHECK() for all stack
> accesses.  This finishes the job started by commit 881125bfe65b
> ("x86/unwind: Disable KASAN checking in the ORC unwinder"), which only
> partially fixed the issue.
>
> Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> Reported-by: Ivan Babrou <ivan@cloudflare.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

I haven't seen any previously observed issues with this after a day of uptime.

Tested-by: Ivan Babrou <ivan@cloudflare.com>
