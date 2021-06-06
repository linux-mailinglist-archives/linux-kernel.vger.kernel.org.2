Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4608439D1FF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhFFWtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFFWtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:49:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B0C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 15:46:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m21so7258452lfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 15:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XAmrqQtetCdv1FWiIQ6avH4N6kog0uzfOlUbx+cm4I=;
        b=Lz7Upx6XUMuJW+XLGSZogswa/KETZouaABh1tibWpMUD9XpdbA7tkyroipFnJcQCwr
         hSc8h+cSYX3kKRjuvTMivkaywluOPG8adH9/2RgODGBnxFMIWgZNKb86xRGbxKou0TOu
         Zszi4YN8hNOR3UKIBW9WBQaowozt7Ab7LPaiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XAmrqQtetCdv1FWiIQ6avH4N6kog0uzfOlUbx+cm4I=;
        b=X44K7XjE21Wc4NZaAJaZGz+9O41T2OxAxySLClm3/0Kq3Y7Hmw2sC7Kw63PheCwj5v
         +8E6aBZQdusyVoUUDZ79uM90YvOW/zOn9i/Tx6xKRoN1AWM6SUJsQX2fWqfPCbhTfTH2
         zWYDfE9rhu6KffmJB67tr7maTFzplru5IlHb1I62Ip/A0DJe7AA5gO4nM7AtkfBkfE6b
         iGFpzGg1rLCaS7hbnwUYWqcljkR8S980i3rLpfFtTBSoRREylQHnEAvLjVRllc4uOBYU
         enUJXNHwrYog2+ym2PGRdg7G6cjxkXpR0UU1Pv8jbPjibn+2wikatzb6cw2N+tESKYvO
         z7YQ==
X-Gm-Message-State: AOAM530VQcnjl8fWyfM9pNhdtNNSpRrSrUs68jpH8NJpTetHjjP9cRtS
        faBLq9l3MC3twKNnTBZ62DZs/Qqo1QKx52mUB/U=
X-Google-Smtp-Source: ABdhPJy/hcvMomaXr65G4o0BZykO4GM0sOrJ0umlwG0quxivBdUWAzp79v/Xl4Cl2047LORS2LUCHA==
X-Received: by 2002:a19:4810:: with SMTP id v16mr9848869lfa.254.1623019613638;
        Sun, 06 Jun 2021 15:46:53 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id b44sm1549914ljr.68.2021.06.06.15.46.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 15:46:53 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id m21so7258424lfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 15:46:53 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr9989167lfl.253.1623019612906;
 Sun, 06 Jun 2021 15:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk> <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 15:46:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
Message-ID: <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
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

On Sun, Jun 6, 2021 at 3:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think iov_iter_init() would actually be better off just being
>
>         *i = (struct iov_iter) {
>                 .iter_type = uaccess_kernel() ? ITER_KVEC : ITER_IOVEC,
>                 .data_source = direction,
>                 .iov = iov,
>                 .nr_segs = nr_segs,
>                 .iov_offset = 0,
>                 .count = count
>         };
>
> with possibly a big comment about that ".opv = iov" thing being a
> union member assignment, and being either a iovec or a kvec.

I don't know what kind of mini-stroke I had, but ".opv" is obviously
supposed to be ".iov". Fingers just off by a small amount.

And yes, I realize that 'uaccess_kernel()' is hopefully always false
on any architectures we care about and so the compiler would just pick
one at compile time rather than actually having both those
initializers.

But I think that "the uaccess_kernel() KVEC case is legacy for
architectures that haven't converted to the new world order yet" thing
is just even more of an argument for not duplicating and writing the
code out in full on a source level (and making that normal case be
".iov = iov").

               Linus
