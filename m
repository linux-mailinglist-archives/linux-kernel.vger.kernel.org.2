Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D435402FD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbhIGUjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbhIGUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:39:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED17EC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:38:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k4so264704lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mb0TuFOIR8PlovfW8+umjV2TU0jRDvx59KT7lZQ01W4=;
        b=Fn3o+Nyl736I/j8KbStSCoygow4y4ag/Z9/G1wv/qED3nS4bwNU+MH0E2RY+jKFKSj
         lolZKJjYN3TW++Wi8kSspi9hGh10n2bBXAPzi7tOP9lIX5D82DawS5j9wJyzxFdG37eX
         XU4IHOyr8LVLl2O+mDEma7S+wboVf0sgS9vu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mb0TuFOIR8PlovfW8+umjV2TU0jRDvx59KT7lZQ01W4=;
        b=p4Sji9n9jJIwLzXWuEGp46h2q8c4oluQZhwu2Zua/1AlNZ9yMl0q3fX+Uyo12lOIGq
         g2yitAqSpI8/7VplNLyIFhBXFYiNex9KPWu3MpOKqn8LHnSam+QC1FKSSrareCwORzTo
         tmDVrP3yBaUnJWymDZSNcGuo4piNlqInZDQpnlxNz1R2pPSzULzhn9N0jaooF3pMZxuB
         9yKlgE/67fS5wUrmgkeAoOKjBuMXRR1u/7mYjokV+5JB6vQPl9WZQt0DkJJv/tP3hoWK
         iTMrX5DLuQx9lKXJy+VNd11n9QacLUkFuQOOU63HB6ZIcoiFji99/7a9nv+h6+yAcaVW
         yICA==
X-Gm-Message-State: AOAM530Zb09ebch6sCRrewwCrVs6mJHgAzPrQoykNXWiVWy33btWrUR4
        Xuci9bgOJe6s6qYEd59mXKOVlQFLvMiQRBtBDCk=
X-Google-Smtp-Source: ABdhPJzdrOCWLr/6ziVVSHcUgoeCErtODsOoBB4h+WoBZzlox8j/qwyC5q+FY8mIbhZYwlA6cyJLAA==
X-Received: by 2002:a05:6512:3d28:: with SMTP id d40mr182513lfv.474.1631047082062;
        Tue, 07 Sep 2021 13:38:02 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t11sm683lfc.54.2021.09.07.13.38.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:38:01 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id f2so637368ljn.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:38:01 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr82863ljp.494.1631047081065;
 Tue, 07 Sep 2021 13:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210907200722.067068005@linutronix.de> <20210907200848.528317169@linutronix.de>
In-Reply-To: <20210907200848.528317169@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 13:37:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBRQeSROGjfRDY-wRuFfa=NVo57xLeHD2Dv1v0Ra+RLg@mail.gmail.com>
Message-ID: <CAHk-=wjBRQeSROGjfRDY-wRuFfa=NVo57xLeHD2Dv1v0Ra+RLg@mail.gmail.com>
Subject: Re: [patch V2.1 05/20] x86/extable: Rework the exception table mechanics
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 1:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Rework the exception fixup mechanics by storing a fixup type number instead
> of the handler address and invoke the proper handler for each fixup
> type. Also teach the extable sort to leave the type field alone.

I see why you do this, but it does make the exception handlers less
flexible. It used to be that you could just make up any exception
handler without having to inform some centralized place about it.

But I guess that's also a downside, and maybe we don't want the extra
flexibility.

The bpf case was an example where somebody was able to add their own
specialized handler, and didn't need to serialize with anybody else.

So I don't hate this, I'm just ambivalent about it. On the one hand I
like the more strict format, on the other hand it's kind of sad.

The other reaction I have is that the handler type is now wasteful and
pointless. I think you could make it be about which *section* the
exception thing is in, and not need that extra ".long" argument to
hold a couple of bits of data.

So _ASM_EXTABLE_TYPE() could instead do something like this:

  # define _ASM_EXTABLE_TYPE(from, to, type)                     \
          .pushsection "__ex_table." #type ,"a" ;                         \
          .balign 4 ;                                             \
          .long (from) - . ;                                      \
          .long (to) - . ;                                        \
          .popsection

and we'd not have any 'type' field in there at all, because the type
would be determined by the section is is in.

Hmm?

                Linus
