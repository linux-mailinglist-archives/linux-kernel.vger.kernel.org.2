Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C283D436C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 01:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhGWXAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhGWXAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:00:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F7EC061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 16:40:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a26so4573880lfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 16:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xkMQPx7Z/4PMvWsEiJNAXvxh1Yr4z8dYX5ZnaiIDS4=;
        b=XXoy1TPU1apSD7knzLgEhQnUUASvLsESNRi3ne6s4RCN746cE5c/oLewHe1ah7OJWX
         zX+tmIau5y44orzHmGjm9NcWL+vLn4r2ubesRM6O+2Iy+N+vnUOQl9FVjsbt1NtSVWKo
         b0f0DH3eFHCHJGwwrCVmMzWiBYZqlieI0j0Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xkMQPx7Z/4PMvWsEiJNAXvxh1Yr4z8dYX5ZnaiIDS4=;
        b=eCo7Lk6n9z0WL1MnJHoYFNIDmIf6ofzjysByaTnaP9EEYPhL5u7HEKGbcGsh9quqdH
         xpKUMo3u5A3rdEcZwF2bEgkPKn6umIMrnNzaGDflr9lLzWzc8VwiZkdGtck/uPgNlK4i
         9CG96xkB85GLVnMlGLpnAT+m4kz553Ng68S47B5dHniJmv1buN7Bab4SEvYKIrsJwKpw
         SGwjhQInaxHWRgBD9VCCbniE5F1cVNz5ONsgnEW+Ih16g7wb+0acvilcy1D0ob8ZeaHx
         FTHXyf5wcWMT8KJPGCEMETkMlnccxHlCEUL6J0D7HEukQOHfqKuttp2HGh3swYE0JDyI
         3C2A==
X-Gm-Message-State: AOAM531Bqw5j9FJElYsUaAHh8R1KW5lG+SdZVjwZbs0ItGt68Eb4Ca84
        pj6CLOHwY8dwoUOsNlposvpWdVWFMNOwA79G
X-Google-Smtp-Source: ABdhPJzJJpaBHUukOYVhXp0thKNz3hFzdLKFF90W4WH2K+AFXV34vv4M7TxeaphzFBU0/YgHjgzotQ==
X-Received: by 2002:ac2:5dc3:: with SMTP id x3mr4739281lfq.514.1627083640449;
        Fri, 23 Jul 2021 16:40:40 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j21sm2350950lfg.56.2021.07.23.16.40.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 16:40:39 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id r23so458954lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 16:40:39 -0700 (PDT)
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr4693434ljg.465.1627083638619;
 Fri, 23 Jul 2021 16:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210723205840.299280-1-agruenba@redhat.com> <20210723205840.299280-2-agruenba@redhat.com>
In-Reply-To: <20210723205840.299280-2-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jul 2021 16:40:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1n8yVeKABgfx7itM5o1jXVx6WXRF5PxHx+uqeFBmsmQ@mail.gmail.com>
Message-ID: <CAHk-=wg1n8yVeKABgfx7itM5o1jXVx6WXRF5PxHx+uqeFBmsmQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] iov_iter: Introduce fault_in_iov_iter helper
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 1:58 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Introduce a new fault_in_iov_iter helper for manually faulting in an iterator.
> Other than fault_in_pages_writeable(), this function is non-destructive.

Again, as I pointed out in the previous version, "Other than" is not
sensible language.

You mean "Unlike".

Same issue in the comment:

> + * Other than fault_in_pages_writeable(), this function is non-destructive even
> + * when faulting in pages for writing.

It really should be

  "Unlike fault_in_pages_writeable(), this function .."

to parse correctly.

I understand what you mean, but only because I know what
fault_in_pages_writeable() does and what the issue was.

And in a year or two, I might have forgotten, and wonder what you meant.

             Linus
