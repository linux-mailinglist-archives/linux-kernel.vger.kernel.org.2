Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972FD37A086
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhEKHQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:16:48 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:33642 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhEKHQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:16:42 -0400
Received: by mail-vs1-f49.google.com with SMTP id x17so5398423vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UzqGBEnMFGPXHaRr6PfDxH2kRj2bejhyjTaWq+GqQo=;
        b=ry0LNwzkmTCbUDuOFyo3vsuh6y259DrrFxr9aOlgrG7oH8RiRDMcdvNNy5xNVDz2uj
         jGXs+HzIfgT9HZDyYQmtnbALxm9JABMOuLTGDB5dPE/VtQsqlghqqNyPnf6Fx1iRZPff
         wlfIqvAPvgxmTcQ+dIVaLEcifAwOviMbJt1J09Mg8cCXMGGh4QpQHReEMckdypBb/E/j
         MVeKaBgSRuMzuG6WvaFnSSCW20mYwrlckxNcHC8CDQSIdnLmeoDaq9CM7KYNnwkawy+2
         clV/Aw8B99Jv5YFi1dq84RqOoPG6VMK9SNYzsNDx1BGynz0FSAPUqVAp1oZpZnuRjEG0
         SiLw==
X-Gm-Message-State: AOAM531YT+Gs7xMJFYsa3THMb3xbT0CwVxtwoSTm+nrIHXQ9+HrWnMss
        tHew7UnBsYo2AGBMjgrHF3re06cg4N+zmS7+ALQ=
X-Google-Smtp-Source: ABdhPJxVsF1sOuRSPzrf3UBF75hf4R7rdt7jGNl25prcZyh14Bv8oTFBMR2uDPDLfIhHo1EZP7Yi9mZbpj4Gz9F3MQo=
X-Received: by 2002:a67:3113:: with SMTP id x19mr17588832vsx.40.1620717335728;
 Tue, 11 May 2021 00:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com> <20210510165839.2692974-9-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-9-Liam.Howlett@Oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 May 2021 09:15:24 +0200
Message-ID: <CAMuHMdViObRA1H-yggx5M-dn2j+7rrMR1Z_SFBYJE2cHmX2=zQ@mail.gmail.com>
Subject: Re: [PATCH 08/22] arch/m68k/kernel/sys_m68k: Use vma_lookup() in sys_cacheflush()
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 7:04 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
> will return NULL if the address is not within any VMA, the start address
> no longer needs to be validated.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
