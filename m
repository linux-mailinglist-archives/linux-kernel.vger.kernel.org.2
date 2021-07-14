Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCAA3C8A41
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbhGNR5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGNR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:57:48 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB2C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:54:56 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so3363165otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrD1pQ3OBKYY3c2yMtsYHqlgwFHdU07pE4enP3uNpXI=;
        b=mXM94q6eWDzYOpyvImS9eQ8zAI6VTBDihi0v+PaVTA5xcwni6yfsr0CBel81joQIRn
         Q3hUzE22kWqcLiDc4JlAEcGtcdb5S9kPy+j31Gp1WtEr0WAmWNx2HPDqIb2gSkqQHuK5
         Der90yY3k7Zkx0r9eOiJHqODovoA9o0IazPSJDb8s8GWIovenhp/mW/sgXWbzTuULAgf
         sCMU8qPGcJRE56C/FqFhbq75MZtp+k6tDxx3W/qsykU4t2PJxQ04XFnmb+Zt5QcJt6ZN
         CfEAm8JTEF3euTOoMi7Ze9GgckUYgwNjdLDqCfNwYl3N2KXoiMIztLE2X9pYi3v0gTOX
         Rjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrD1pQ3OBKYY3c2yMtsYHqlgwFHdU07pE4enP3uNpXI=;
        b=mkccA5p5gdGbwTIgRcCgZQ/gCoGfVFnCH+6Nkq0VunOGOdAx/ZAIt94t/AqoOp/jzF
         oRT2c7Kj6TSmGfYbZhdYdYL1pXDYVWzER7pXCAqjbKcRdoMWbLppEz0QRYImwo61g56p
         +E+33eXQiI0l0ibQw+rQarbQMkRJtrIciIoHJqDi2NDkW4+d39ovc54EesfXnlvvfD8c
         6lKIcokkGJEgw2ri+O8PvAerL2nT4UhlNwPlw+bp/IaK/celeV02YtcrJ7lzJqSbW4OA
         mMfFQXlCRFGjqgryGznKhekJy7EjvyRG6oRDJQ/rExQWoEdz+8/MMtUesangLImFR7Jz
         +0cQ==
X-Gm-Message-State: AOAM531pk1u2yOFdk+azGNztKdgdAVXuf0M1WOP5t1LGfZlNXGALTlvF
        BpspPg6o0k5SsH9uQW5cfTV13xZ+kJouphOf1em4JQ==
X-Google-Smtp-Source: ABdhPJyNOpkHIq1v8InV3LUaESTWKz/ywm13RR9OPuJloAv8GjTzcdQMHnmKgIa8CcW2pyfhzJ6x9nq5gr20/dRpi/Q=
X-Received: by 2002:a9d:650e:: with SMTP id i14mr9109289otl.233.1626285295243;
 Wed, 14 Jul 2021 10:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210714082145.2709233-1-elver@google.com> <20210714173755.1083-1-yzhong@purestorage.com>
In-Reply-To: <20210714173755.1083-1-yzhong@purestorage.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 14 Jul 2021 19:54:34 +0200
Message-ID: <CANpmjNNBjD3KnNCu+9nF8bKDyrjpkZMwkWiZOe83FgZomcb_3w@mail.gmail.com>
Subject: Re: [PATCH mm v2] kfence: show cpu and timestamp in alloc/free info
To:     Yuanyuan Zhong <yzhong@purestorage.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, dvyukov@google.com,
        glider@google.com, joern@purestorage.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 at 19:38, 'Yuanyuan Zhong' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> > +     /* Timestamp matches printk timestamp format. */
> > +     seq_con_printf(seq, "%s by task %d on cpu %d at %lu.%06lus:\n",
> > +                    show_alloc ? "allocated" : "freed", meta->alloc_track.pid,
> > +                    meta->alloc_track.cpu, (unsigned long)ts_sec, rem_nsec / 1000);
>
> s/meta->alloc_track\./track->/

Thanks for spotting this!

v3: https://lkml.kernel.org/r/20210714175312.2947941-1-elver@google.com
