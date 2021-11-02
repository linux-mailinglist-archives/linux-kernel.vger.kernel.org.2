Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD587442A01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhKBJBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhKBJBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:01:16 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9739DC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:58:41 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id ay21so16127485uab.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0FWFvooRQ3BCwiPpGESwloG7M4vgQJZw1xUg3WsuB0=;
        b=UulFceFSyolVQHNdc74HQV97H9vMH1jLPyOScQRdjH8pnMQHkXEpkKACTveEWW1i/P
         QelI8WHY8JoDNXa8Jd6oz6xhK/mLJoWSy1gpx5WZLn3GzCr01mYqnvI1tgazlkl6ywve
         6zPQ4ps0+XRPgwhfZtzV1vGj1qcEim9Kh6ZcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0FWFvooRQ3BCwiPpGESwloG7M4vgQJZw1xUg3WsuB0=;
        b=d1Bhnog19G+aiMeecOwtmzt4qhAIJpLYrY3F3tBDHlnhO29mstWsE3bQ0lRgNof64u
         gOzfGFqPfgFIfM3wpEEvIGwkDQIy+1NNDdXSDt3Gwju63t0jX85d5ArGTIO/oOqoRk9/
         PvD1dtUG6nPfcleHYOQad3tZzUVt9Zvm5MdkXhJxqzBNJ3QOA5Hu6sQyb2xkjlFn3FBr
         33A5CmBWQz5WarAD9YCgcORzKg6WnlEoFjKzE7+k27HKchDyGWt5d5ROPPs+R1Vqraxx
         VIb16mCEJhbHS6Mob0owjkmQpVubPJJNar7WWVm6woZEmOQ3ldVlgJScAQqCNxFuhcw3
         mNxA==
X-Gm-Message-State: AOAM531BrQ4IEqrpl6U3Ts2N/x0ne5IwfUIFipKPLxh7xcT2/WgDs/Yj
        zSE7wgIviJxaPWDGOM971wf8BL+oCBvvQbHEhflxjQ==
X-Google-Smtp-Source: ABdhPJxAcIRp5bCsboq/PHYTKXzOWFkcsHz8w/RuffGqkbIhOtm2luASGgkXadtOCQo26oyx2n0EEQnk1jbsY8EYL4Q=
X-Received: by 2002:ab0:3d07:: with SMTP id f7mr14584946uax.11.1635843520868;
 Tue, 02 Nov 2021 01:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211028094724.59043-1-lmb@cloudflare.com> <20211028094724.59043-2-lmb@cloudflare.com>
In-Reply-To: <20211028094724.59043-2-lmb@cloudflare.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 2 Nov 2021 09:58:30 +0100
Message-ID: <CAJfpeguhq69y5jxDfV7pCeTJHbrqvBw-9-=YRzVJeGYL9gS+gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] libfs: move shmem_exchange to simple_rename_exchange
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        network dev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 at 11:48, Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Move shmem_exchange and make it available to other callers.
>
> Suggested-by: <mszeredi@redhat.com>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
