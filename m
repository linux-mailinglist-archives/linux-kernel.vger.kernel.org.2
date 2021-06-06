Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3339D1C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFFWH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFFWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:07:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C28C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 15:06:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n17so2237348ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 15:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eGtWkwWWGDXI21CkuDMMSLw5Gc1lJC2kR0D4ld5ZGg=;
        b=LEj+IKrRQ0scv2+Br71d7ciCd4fD22am5FBHDRGmPLC3eAFbHHPv7xQbps835br5/s
         CK9kEDIJ1NHhZkNdsF35UWgoI8iyVhWTCANfTxhUglm8IsrjGQ+v3yR/JFbDETkIAFZf
         TI6uaMTQizrAqtjq5qUl0+wzWJfCcwRWmPkxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eGtWkwWWGDXI21CkuDMMSLw5Gc1lJC2kR0D4ld5ZGg=;
        b=dSgiVb+2h1QHiuqU5BIaIezv5FBTL99Az4Z9MdzmSGbXPy7E5yPXwMRG6RGoBn97We
         OFrQMjUSilBJaeC7WGFCZs3e09OHa9o0yhZ0A9ZBkDM/JzXCUruXGIhWfBIkWEoY7VgZ
         x54sKMkyOzqk6yPWKNiUYjZ86q627mxOBY7Xx/79QnEOEqDq67EmBtzyIA7cPnMnYE/Q
         EvA+b682QB2AH/s+JZR56wBa3c2klku2vTcmi0t71+JbnXrVMxuloUOtI/v1l5+zecyJ
         wCmmbiWpyJNOJ1ZTdTX3uMMzFRJrJfXfYsichWtS8hvhi/NGgQBvO1cDaBOx3mSQvsux
         KuLg==
X-Gm-Message-State: AOAM531VCyID6IJs3OWtUL5RjAXFJ2YeMBlApYZRDsdCizs8mvsU4+Kc
        USTEoDejnFEkAtLx+N69KIKNiq2vCN02CjIuVs0=
X-Google-Smtp-Source: ABdhPJyRO7v5qU7sPwdDS3I/8V2ivKhTeiXYoRUT5cu+GZ5Otqv8JmTGnamdj+390AAcWBS/7q+Wpw==
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr79987ljo.417.1623017166169;
        Sun, 06 Jun 2021 15:06:06 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id s19sm1601754lji.79.2021.06.06.15.06.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 15:06:05 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id p17so22089736lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 15:06:05 -0700 (PDT)
X-Received: by 2002:a05:6512:987:: with SMTP id w7mr9762019lft.41.1623017165048;
 Sun, 06 Jun 2021 15:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
In-Reply-To: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 15:05:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
Message-ID: <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 12:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         It really needs to be cleaned up, without performance loss -
> this stuff *does* sit on performance-critical paths.  We also need to
> fix a bunch of corner cases in there.
>
>         The series attempting to do so {...}

Hmm. Each individual patch looks sensible to me. Not that I tested
them - just from reading through them. So I might well have missed
something.

The end result certainly looks cleaner than before, although I can't
say that it's pretty. It's still haitry and grotty, but at least
_some_ of the hairiness has been removed (yay for
_copy_from_iter_full() being *much* simpler now, and
iterate_all_kinds() being gone).

I also have to admit to despising what iov_iter_init() ends up looking
like. Not because I think that using those initializer assignments to
set it is wrong, but simply because the initializers are basically
identical except for "iter_type".

Yeah, yeah, there is also the kvec/iov" difference, but those fields
are actually a union, and you're assigning the same value to them in
both cases, and the way you do it now requires a cast for the kvec
case.

So I think iov_iter_init() would actually be better off just being

        *i = (struct iov_iter) {
                .iter_type = uaccess_kernel() ? ITER_KVEC : ITER_IOVEC,
                .data_source = direction,
                .iov = iov,
                .nr_segs = nr_segs,
                .iov_offset = 0,
                .count = count
        };

with possibly a big comment about that ".opv = iov" thing being a
union member assignment, and being either a iovec or a kvec.

That makes the code simpler, and avoids the cast that is otherwise necessary.

Hmm?

         Linus
