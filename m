Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59B309973
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhAaAi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhAaAiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:38:55 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9DC061756
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:38:14 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f19so15051597ljn.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DD6WrpWIFpx8OEBcyiuO6A2SCACjFJeGyauo7ybABPI=;
        b=ed5CVkLyOKnKHx2gOTRhmFxU2q6FKrW0udikjcX7cpa463TD+QKnWktODVSFA6jFSs
         bVmfFtQ0V5LVryuIy+tzPrvF8xQCaThasnQECTTtFo+FSJLo2Q6KNKIVtQC6ATrvDjF1
         q4Owka2JEFQ+CCivfQ0SQ8QO0QcFVbvhsbmlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DD6WrpWIFpx8OEBcyiuO6A2SCACjFJeGyauo7ybABPI=;
        b=i8rfYraGdNyns2CL+qXhA6nROUxsJ0teTMM/lXHWuLDuc6nqXKBbXY+rnmCi5ReMCm
         Z+iAg9KtZiij8VK9oS5qNfiSJnpc8By2dxkIRCXoGbNSS/tyyamOI7z3vzqtxRk4hXmp
         PzAlyXWceKapVXlrgmLndQM3F8/FJJVOCc9LP6SfiDaLEMLgy+4vQC/LXi2LNNGqp4r5
         7peukp8R4Q8vyVtlfp2+kUhvjhIPwQVIsSci1I5nLeyyYlAEE/Izn6nyIl8jVcsHsXxy
         V6GjWAzVlJRYaJq1ue3jogSWhNkqhp4NPB7wYsu1KVh/VvqFV+jQBaWBbJ4QtX+ceTuu
         SThA==
X-Gm-Message-State: AOAM533LpAOnsGPPeaCwWQuy17kvry+e/rPlRpMz6fxyRoqbfU1USRTH
        1VkjayrBrNX0eTtwbhxf+FeG54ebfSgDsw==
X-Google-Smtp-Source: ABdhPJzUIx8PnO4b9i81QO44+itsxHw1pI7vAcHlxmHyOteNM9+A43ET9S47H0Q8a+hHuUp0h488Bg==
X-Received: by 2002:a05:651c:489:: with SMTP id s9mr6317135ljc.188.1612053492711;
        Sat, 30 Jan 2021 16:38:12 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n4sm470576ljg.101.2021.01.30.16.38.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 16:38:11 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id f2so15035298ljp.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:38:10 -0800 (PST)
X-Received: by 2002:a2e:8116:: with SMTP id d22mr6026940ljg.48.1612053490367;
 Sat, 30 Jan 2021 16:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20210130221035.4169-1-rppt@kernel.org> <20210130221035.4169-2-rppt@kernel.org>
In-Reply-To: <20210130221035.4169-2-rppt@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jan 2021 16:37:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJLdjqN2W_hwUmYCM8u=1tWnKsm46CYfdKPP__anGvJw@mail.gmail.com>
Message-ID: <CAHk-=wjJLdjqN2W_hwUmYCM8u=1tWnKsm46CYfdKPP__anGvJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86/setup: always add the beginning of RAM as memblock.memory
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, stable <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 2:10 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> In either case, e820__memblock_setup() won't add the range 0x0000 - 0x1000
> to memblock.memory and later during memory map initialization this range is
> left outside any zone.

Honestly, this just sounds like memblock being stupid in the first place.

Why aren't these zones padded to sane alignments?

This patch smells like working around the memblock code being fragile
rather than a real fix.

That's *particularly* true when the very line above it did a
"memblock_reserve()" of the exact same range that the memblock_add()
"adds".

              Linus
