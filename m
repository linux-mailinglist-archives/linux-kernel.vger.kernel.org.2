Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB59370E67
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhEBSQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 14:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhEBSQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 14:16:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89360C06138B
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 11:15:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o16so4245687ljp.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKGSHz+GYDfcENA6Ac4ygnxXuVBRs93FmwEKOWqoqr4=;
        b=cnE3uPTRMjbmL0b+HkiLAC485nJ3E0M5Z5UZYaA+5h8MwQBLmy+lW+oi6tfS8VpEhM
         QzpiEyUMFEoml/rFFfVbUNAKzRL07l0DToPsR9Oow9p9qkew6epr5bmCA28f2oGK1QI3
         OgPje87MMhas0HS1bT0NeDvRQ4HuuciRIl+9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKGSHz+GYDfcENA6Ac4ygnxXuVBRs93FmwEKOWqoqr4=;
        b=mZk1pfgpp0WOr97iMh7w13OGd9kq3dvUGhH2QrQQUOrqXq3URE2UgdsrWEw0NBzKFU
         HVwJInw9Ljy/2VRDoWJiimyWNBrvfcnR5k0Oj0nfwwt/5HauN1zKH5iIq8coIv9wjIST
         3KNPjnzfHnCXykYj0dV7XoECwdTMNfIdxe3GjBnNrwqeZ9QOzk46mVM4pI0D7sW9aboP
         HGDcmGnBvpqnqdGX2rcW3REYcOqoFXQuWv3q1NpAzWECFjaclKBxK8AfvTpXzH1FkCK4
         +BP9uwTJhsq+Aj4Ho8jJ3lcGv0kjnNh6siGK0GxNjfyUwEd/H8lMVNBhlx+GVBy/nm5t
         rNVw==
X-Gm-Message-State: AOAM530yBydIHuVeea+PMZYRuB3sR3A73q9bn8XPkaJBZn5tPA5kwO6U
        64afM/uLtQ3CRnuQfxBZAB3nx2llRxBu5FTo
X-Google-Smtp-Source: ABdhPJyZa1DiwOczmpUR3izJ8YRfEOdpV6KH5ssRI3iYN2qulIjkFs4BYfb6xtmYBDZD206lomKosA==
X-Received: by 2002:a2e:9c87:: with SMTP id x7mr175800lji.316.1619979310744;
        Sun, 02 May 2021 11:15:10 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u12sm758931lfr.192.2021.05.02.11.15.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 11:15:10 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z9so336894lfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 11:15:10 -0700 (PDT)
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr10837945lfe.253.1619979309776;
 Sun, 02 May 2021 11:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <YI4AwgZaFSGsTDR9@zeniv-ca.linux.org.uk> <CAHk-=whWm_a5hHr7Xnx8NNQPq5xjs6cS+APE5k_K1K6F8Wq7eQ@mail.gmail.com>
 <20210502175946.GY1847222@casper.infradead.org>
In-Reply-To: <20210502175946.GY1847222@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 May 2021 11:14:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=33579pjCosU6QSEu-=HZo+=mnDdQi7zFLskhi-B-mg@mail.gmail.com>
Message-ID: <CAHk-=wi=33579pjCosU6QSEu-=HZo+=mnDdQi7zFLskhi-B-mg@mail.gmail.com>
Subject: Re: [git pull] work.misc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 2, 2021 at 11:00 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> I think we have checks that the hw blocksize is a power-of-two (maybe
> just in SCSI?  see sd_read_capacity())

Not the hardware block size: our own fs/buffer.c block size.

I could imagine some fs corruption that causes a filesystem to ask for
something like a 1536-byte block size, and I don't see __bread() for
example checking that 'size' is actually a power of 2.

And if it isn't a power of two, then I see __find_get_block() and
__getblk_slow() doing insane things and possibly even overflowing the
allocated page.

Some filesystems actually start from the blocksize on disk (xfs looks
to do that), and do things like

        sb->s_blocksize = mp->m_sb.sb_blocksize;
        sb->s_blocksize_bits = ffs(sb->s_blocksize) - 1;

and just imagine what happens if the blocksize on disk is 1536... Now,
xfs has a check in the SB validation routine:

            sbp->sb_blocksize != (1 << sbp->sb_blocklog)

and if that fails, it will return -EFSCORRUPTED. But what about other
random filesystems?

Hopefully everybody checks it. But my point is, that passing in "size"
instead of "bits" not only caused this ffs() optimization, it's also a
potential source of subtle problems..

(But it goes back to the dark ages, I'm not blaming anybody but myself).

             Linus
