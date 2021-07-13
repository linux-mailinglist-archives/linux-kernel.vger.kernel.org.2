Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBE3C745D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGMQWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhGMQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:22:35 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B418C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:19:44 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id c197so1483402oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dp68kZ8Q63rdtMpfnAuQFhGyVZFwXtaAN9MVU2dhJVw=;
        b=s2qdVmQAPUyIBQcU3gCySim/cqyPncxJAVDUWDUvCgsIEL+CQ1ZkQehIXEZJxuY0F+
         X4qgCZkoVkznKYHOxjxy9r284xl3LpkqXYyw4hJs1eHnvd2s36b3AFZWLddq/BY+orVp
         gjAUDeJVmGjC+iw2uEPJFhfPbm1IU1jdO2BZOdiCwMNfSaJgUHh7gLc0/ID/r2qK3qPB
         4xLUlZU66ARXHNShMS3KvakwXv23Wl+UgjNefUR1JT6MzYfAX3oIwZhihmBq7i+c/g0s
         keZc2VhfQVdvQTNMpOVtDvmYA/J+h5xV5pHr94Dq5zp+OERqVerbwiIfmaCCQKp/3WsM
         Un/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dp68kZ8Q63rdtMpfnAuQFhGyVZFwXtaAN9MVU2dhJVw=;
        b=M5y3fuE8DfObiIDkD0zNuq6jmaB69DFYgyU4PogUWthSft2brcDNm0aW6Aw6c2LRul
         xc9Bm/emeA48s5fINUvwFigUazXonB1/CH/fS86W/hbAnmnEJPcAL6eBeQRzy/n2li4n
         6XwMIWDi0GFkxW6iEMgj2H2F9nMHQ4sSlq0jnmSZ1m3dEUKGe9/Idu1rZqKjqSc4vq8o
         O03mnaQ4Vc/9EthCNTPD3ujikkwTrBCFUKlzJ7miTpxvxwSVPWSeWeXao0pot8halpSR
         BzRJPpC5Y8Y7MdxsCe8FGm+4CKFkd0LmPwUQyM9BiJc0iVZ2OE6wIcNV1vwZJJbYFf1O
         f4vg==
X-Gm-Message-State: AOAM533gHe/mjDszVIMg2W30Nz654rjgN5GxyE90JhY8gagDChigKomG
        8Vo2OclnxF/OI2dG3e0B3Vo7ng3uAHoKpwooReiC3g==
X-Google-Smtp-Source: ABdhPJw/q3Dy4tg96XptFz5EoeVdiGFEQ3Tnai+h5w17+Fq3JI7KCm873IrohB6qpItS4PKvWiUqNWIzaJAelsRIhj4=
X-Received: by 2002:a05:6808:1286:: with SMTP id a6mr3772723oiw.121.1626193183652;
 Tue, 13 Jul 2021 09:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210629113323.2354571-1-elver@google.com> <CAG_fn=V2H7UX8YQYqsQ08D_xF3VKUMCUkafTMVr-ywtki6S0wA@mail.gmail.com>
 <YNsGnyHJL6i1OZFl@cork>
In-Reply-To: <YNsGnyHJL6i1OZFl@cork>
From:   Marco Elver <elver@google.com>
Date:   Tue, 13 Jul 2021 18:19:32 +0200
Message-ID: <CANpmjNOif53i2zx5hZCN97U9Hb_BPv15dchSTfg9qpJa8iZ3rA@mail.gmail.com>
Subject: Re: [PATCH] kfence: show cpu and timestamp in alloc/free info
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew,

This patch is ready to be picked up.

Many thanks,
-- Marco

On Tue, 29 Jun 2021 at 13:40, 'J=C3=B6rn Engel' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> On Tue, Jun 29, 2021 at 01:34:27PM +0200, Alexander Potapenko wrote:
> > On Tue, Jun 29, 2021 at 1:33 PM Marco Elver <elver@google.com> wrote:
> > >
> > > Record cpu and timestamp on allocations and frees, and show them in
> > > reports. Upon an error, this can help correlate earlier messages in t=
he
> > > kernel log via allocation and free timestamps.
> > >
> > > Suggested-by: Joern Engel <joern@purestorage.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Acked-by: Alexander Potapenko <glider@google.com>
> Acked-by: Joern Engel <joern@purestorage.com>
