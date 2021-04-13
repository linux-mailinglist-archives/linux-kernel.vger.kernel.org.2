Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5AF35E478
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346980AbhDMQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:58:42 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:43545 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346974AbhDMQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:58:40 -0400
Received: by mail-yb1-f182.google.com with SMTP id o10so18870952ybb.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZIb1ppB5Vw0K0ah9GL/sCPeLYwov/sRo9mNSJgD/ts=;
        b=r2rebxpMV26LN+easkWpoOosTIX01D42v9Qy88wQexpW7daWyeeyE7RVOn3FCGpjPc
         IxfwEQdGCQ1xYo9hsBVXCk//NafP1z9EUTJUOzePILV7q5O1U1qd/oVriCCX3qkbCgUH
         Z3T7JWcXdQUOxaYxQKjfbUDAEiTt4zc5UfbShq1dZZVdkbcdYWG6IZVZiCZka2BlgAuc
         cUEfGtODzJMuDzYUa2LblWkb4g84TOAGMmStIuI5EsRBX9ETYQ528gmq5ywuPxd7kBYc
         NyklAgCb5ii1mnG6YySdYNloCGk5eRGP+VC+aC2qarfbeVCNlNqXiTKofUfrbMGTZISt
         c4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZIb1ppB5Vw0K0ah9GL/sCPeLYwov/sRo9mNSJgD/ts=;
        b=feyKCC+HaV35yLbXJPpsYSajLlmK8ErYcbaSp6/O+kgqwCSUtnVUkDaT8zpuYiXPJP
         65bvNCX8XpZSaJ4OkKXsNsEMofjjLOs3BFqNovTw4C9PAATwYMIz+ipGvK8PbLDiK8eD
         d+UKxJcKvnVmKS1fdTNLyGsp8CtjKHtsBwLpg89ySFThHnwqz5+p0MkvhgKm4GCAtZrY
         KWmfqWutfem0mh4XMhTanjnnq2eJy7DCWTb90Ln5TqvEyVNMs7nCcsayH+B3KRYQ1tl2
         MN8Rwtn/TVLi40RUiO3VJkqG3R0ZaSSw0h4UbHifNbxbRCET3FezD5u8eHzN125p6IJ9
         EuOA==
X-Gm-Message-State: AOAM530kHsfEIrDkPch5Quj59t//sIPzrFpgddYprAy1wmTBErRsXzWw
        7m8R01N0+/mk0HiV8RrtKpwCiT02VkB7o8cOHIk+JQ==
X-Google-Smtp-Source: ABdhPJxCwgXkpZyBDTR8IDvkKx5iCJFF4GR2NQHQEdHWnx857r7TljcuILvxs+jevktZxaraPOii+jLdaJhgG0lvG5M=
X-Received: by 2002:a25:7650:: with SMTP id r77mr18961159ybc.446.1618333040102;
 Tue, 13 Apr 2021 09:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
In-Reply-To: <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 13 Apr 2021 18:57:08 +0200
Message-ID: <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 6:54 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Apr 13, 2021, at 12:22 PM, Eric Dumazet eric.dumazet@gmail.com wrote:
>
> > From: Eric Dumazet <edumazet@google.com>
> >
> > Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
> > update includes") added regressions for our servers.
> >
> > Using copy_from_user() and clear_user() for 64bit values
> > is suboptimal.
> >
> > We can use faster put_user() and get_user().
> >
> > 32bit arches can be changed to use the ptr32 field,
> > since the padding field must always be zero.
> >
> > v2: added ideas from Peter and Mathieu about making this
> >    generic, since my initial patch was only dealing with
> >    64bit arches.
>
> Ah, now I remember the reason why reading and clearing the entire 64-bit
> is important: it's because we don't want to allow user-space processes to
> use this change in behavior to figure out whether they are running on a
> 32-bit or in a 32-bit compat mode on a 64-bit kernel.
>
> So although I'm fine with making 64-bit kernels faster, we'll want to keep
> updating the entire 64-bit ptr field on 32-bit kernels as well.
>
> Thanks,
>

So... back to V1 then ?
