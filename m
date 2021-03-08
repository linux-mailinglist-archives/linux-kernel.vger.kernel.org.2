Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EED331099
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhCHORQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCHOQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:16:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:16:47 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x7so3807969pfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEz/5tRpd1vxpBiKzm6wcWNrysLEXvrjN5n42Rt2ppk=;
        b=o+U3uLj/MTWI/WnVGPqlD6bxQPjQLWYNbYeWyg5OtXhJZtnF5QsfwC6uq/PN/KqSBv
         L89RvIDZAM3pr6p4HBVvuwVIxP30I6MI2oVGpDIPZ4MWGA4EIUD/DYBLe1G/DlhbyyO0
         GAQGMqfv8JxfVGyUqE/fRYcXPD2hKSNZvHR7MaBPuVCBR781NmjLLKKeCoNyuvxEIunj
         TkOz4nN/4iO7zf1Xg/osQmzUIG/2foVQ9VdONOGwCBPMVykxqhDI/kjKkaxXB2dMjaEw
         FJCBnL7b6tevkBWuzSrS300s5XtR62ewi1NA3iF1wlsx10TEtAwiv0pY4sJN1+xcXi7W
         Su5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEz/5tRpd1vxpBiKzm6wcWNrysLEXvrjN5n42Rt2ppk=;
        b=S1n2UAKqEimNbXF48+O9lbK9Um2274sPQtFMNTCuxQZ10iL98DFFUFNMRjaRdZ6jnp
         w+wfwDiGb0v6KacOqPN3h5oiyTo25Vy8OVAwdx5dvQDgh94yHn6QfEMPlCMdlXgsYzQY
         DH6o6a/rgLoFHr4pjx/s2RZ1sL7M+IGxd/vV+a4n+B8XvdIj4oieRLvjv0iqWC9UVM6v
         QWSUVqZKkL+OTAdRbY33jKPITeHI86Hg0UHyYxbxCPtVoD1Moovfoig7BEXVDRQ7C41N
         kN/1bUVT4A6xtlQqFJ3xkFVTflxV1kMOKWuLiqqpp8AoHyK+sHoSMn4USIXD5+zwrcCQ
         NYPg==
X-Gm-Message-State: AOAM531dc6vxAoI9jbHZB3QdvXh50R/1KwC9FOk/2JUMbN7ciX5hO0hG
        /J+6q8/4OfNKD8XzpoLMXzLLwcOUVnOpBqxMy3v/Ew==
X-Google-Smtp-Source: ABdhPJyAp/P5kFJMxbcLsevox5U3CG3+Kx9o3JHlkHdZvbegTiBwdTL3Q4As4bAkrSTLq5PRYZOymxznMF9dggO3H3U=
X-Received: by 2002:a63:f14b:: with SMTP id o11mr20763989pgk.440.1615213006419;
 Mon, 08 Mar 2021 06:16:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614989433.git.andreyknvl@google.com> <a313f27d68ad479eda7b36a114bb2ffd56d80bbb.1614989433.git.andreyknvl@google.com>
 <YEYOaR5jQXe6imp0@elver.google.com>
In-Reply-To: <YEYOaR5jQXe6imp0@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 8 Mar 2021 15:16:35 +0100
Message-ID: <CAAeHK+x-V+VqGGpjFL8wSSNazOUjJ_OMq=nk0O1mTJoZwG8XmA@mail.gmail.com>
Subject: Re: [PATCH 5/5] kasan, mm: integrate slab init_on_free with HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 12:45 PM Marco Elver <elver@google.com> wrote:
>
> >
> > -     if (unlikely(slab_want_init_on_free(cachep)))
> > +     /*
> > +      * As memory initialization is integrated with hardware tag-based
>
> This may no longer be true if the HW-tags architecture doesn't support
> init (although currently it is certainly true).
>
> Perhaps: "As memory initialization may be accelerated by some KASAN
> implementations (such as some HW_TAGS architectures) ..."
>
> or whatever else is appropriate.

Will change the comment here and in other patches, thanks!
