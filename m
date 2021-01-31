Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5058309F28
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhAaWAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhAaVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 16:55:41 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D15AC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:54:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h7so20138681lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zO34/3ZA+CkltKNl2PpcDzP0GsqnpE1ZCLqi6BG92QU=;
        b=fm0+aCk6BtxQfENltWf1/RlYYfNSq33QZP19XEtxgizJvi+9kwVDkOqVVWinTr8RKt
         SMgtjPJoGnPPICls/VnOBpyTeAZQ56+t8B0P7lBi1Sb5xkEFZ8v/DcfPkmDm+RSlyxn2
         zTKGghgExi53SRZc+2/rWDFy6trOmHD7O1mZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zO34/3ZA+CkltKNl2PpcDzP0GsqnpE1ZCLqi6BG92QU=;
        b=V+Evi0jKgXQEpYBpvqsrw5jGSyptIXhKJARtv5ka2cVgykvlm0QkK3u/46DruN5YVu
         /nN5oDEASOnwmqlRSrCoysFchzpLx6baSoG5HpsR3v+olaldcbeaIkAq2vkEBOX8wudx
         bpc7suOdJdeJcmnBK800ziNoUTP2w1RWpYhQNVccs6pR3BPNd7hd5+OtE1hLRkR9/vrq
         j4UHkwbjVOvRgshYC4Hso3jRIhrw0DQPdh9+PWz7ryTNgh28odQu0L76URwt0Sc+79c4
         CnIQ2r2PkWM1z1RDU0SboitHu28nfonX3hKd0pitcLEDKWtLVOR9fyZh7HsxhvZVzSKI
         IyEA==
X-Gm-Message-State: AOAM531mLT1WJIXAOYOkRUzX7vY+vNy+5Eij0Rof5EP7SoDUV5oxo+io
        60YwsJEjWAxrWC1GRz4kuWieq5fg02sxeg==
X-Google-Smtp-Source: ABdhPJxmdwLOkjRda3oXP5f8S98hmRJNTfDzqkGcAbYQaMJcAjLamOhycO3EKWz0faE81+siN2ICjA==
X-Received: by 2002:a05:6512:33cb:: with SMTP id d11mr6913683lfg.24.1612130097248;
        Sun, 31 Jan 2021 13:54:57 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id x14sm33141lfg.165.2021.01.31.13.54.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 13:54:57 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id a8so20117406lfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:54:56 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr6756270lff.201.1612129783707;
 Sun, 31 Jan 2021 13:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20210130221035.4169-1-rppt@kernel.org> <20210130221035.4169-2-rppt@kernel.org>
 <CAHk-=wjJLdjqN2W_hwUmYCM8u=1tWnKsm46CYfdKPP__anGvJw@mail.gmail.com> <20210131080356.GE242749@kernel.org>
In-Reply-To: <20210131080356.GE242749@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 13:49:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-qT41Q1WgPUZPC9UmCi6xquk1KE3_yvxORbmDV3os0g@mail.gmail.com>
Message-ID: <CAHk-=wg-qT41Q1WgPUZPC9UmCi6xquk1KE3_yvxORbmDV3os0g@mail.gmail.com>
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

On Sun, Jan 31, 2021 at 12:04 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> >
> > That's *particularly* true when the very line above it did a
> > "memblock_reserve()" of the exact same range that the memblock_add()
> > "adds".
>
> The most correct thing to do would have been to
>
>         memblock_add(0, end_of_first_memory_bank);
>
> Somewhere at e820__memblock_setup().

You miss my complaint.

Why does the memblock code care about this magical "memblock_add()",
when we just told it that the SAME REGION is reserved by doing a
"memblock_reserve()"?

IOW, I'm not interested in "the correct thing to do would have been
[another memblock_add()]". I'm saying that the memblock code itself is
being confused, and no additional thing should have been required at
all, because we already *did* that memblock_reserve().

See?

Honestly, I'm not seeing it being a good thing to move further towards
memblock code as the primary model for memory initialization, when the
memblock code is so confused.

              Linus
