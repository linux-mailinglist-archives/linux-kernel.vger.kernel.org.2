Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF07F3B9A17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 02:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhGBAdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 20:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhGBAdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 20:33:19 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5CC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 17:30:47 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id k21so10985180ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 17:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJvQk/Alftrz3YVUjbu29T6DoGupesSg/dDRXRbYPhA=;
        b=SVvtIYIAvKTDQpKRfVjOwCnujyR61TBG4yZhipigFvuTp/YCXE7jq5gzL82D5wXtaR
         oKMWIB/FCXm9SO0cNEVgkmR+UUPX/6lGNbi3IB6xg4QgUjXFrN1WXgqfM9F9sFMs8Ugs
         6LvKysEba7oWQnlYRe7QpDHGvX47PEmkHCEXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJvQk/Alftrz3YVUjbu29T6DoGupesSg/dDRXRbYPhA=;
        b=qqFetWXOffh86NwI5GwmJVxA5fhoAcW4yfwMbdDwyVyv+3wwkOCw3RXth9nt4bVfQV
         NAuoBTlslqPfa45Uz7yNJtDBnFqV7piC70h1fT1UyHwhN/E9Eau+zNFEAUrkI6cN1pXY
         rTaQ7zgNDepz0ep9aX2QWSf4k8uouQHxszKGXO9EuBjIrBtzFRvGIrX0szPv3WorQKzF
         GDzXOtmu2w5UFgUciUJMGwH1Uirqg6z/gS2/RhI/KJTB62etAovieQz7rDB6RuFa8lXm
         +n2S1kl4HgKbEAQnhy2BvdvX19O/f4U7SPxTIndvc+yDGVZY/RWQq1ZP1RZyR21En8Hi
         1ztA==
X-Gm-Message-State: AOAM533xJOu7YiZXP0Cqm6pImbxGi8W01kHwXiaN3SHJdzHAIOflXEaD
        ios4DQrRfbo5+GgsfBfenzwP/YijlD/HkNfLY90=
X-Google-Smtp-Source: ABdhPJwmeGHjpbvTNhuZ4iiNhxZmMTOVwWV+AZrwu2xu2fx0x/7G5PlvnH6zf+Y5/K7Ka0kLN2gHeQ==
X-Received: by 2002:a2e:8248:: with SMTP id j8mr1659040ljh.300.1625185845491;
        Thu, 01 Jul 2021 17:30:45 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l20sm168997ljb.139.2021.07.01.17.30.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 17:30:44 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id bq39so2417468lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 17:30:44 -0700 (PDT)
X-Received: by 2002:ac2:4903:: with SMTP id n3mr551418lfi.487.1625185844416;
 Thu, 01 Jul 2021 17:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210701204246.2037142-1-agruenba@redhat.com> <CAHk-=wjk6KP3vSLFNPMjoaZ4xY4u=DjTM+C+hCS3QKt+XAE6OA@mail.gmail.com>
 <CAHc6FU5XMfTOBW1a0OnMaPSmgWECvO-KYAo8HeVNsCyd-HyV3g@mail.gmail.com>
In-Reply-To: <CAHc6FU5XMfTOBW1a0OnMaPSmgWECvO-KYAo8HeVNsCyd-HyV3g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jul 2021 17:30:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaRsSuUeVBn_rLECWyG6h9RGuF9idsT_S+==vnsT8org@mail.gmail.com>
Message-ID: <CAHk-=whaRsSuUeVBn_rLECWyG6h9RGuF9idsT_S+==vnsT8org@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 5:20 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> On Thu, Jul 1, 2021 at 11:41 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Also, I have to say that I think the direct-IO code is fundamentally
> > mis-designed. Why it is doing the page lookup _during_ the IO is a
> > complete mystery to me. Why wasn't that done ahead of time before the
> > filesystem took the locks it needed?
>
> That would be inconvenient for reads, when the number of bytes read is
> much smaller than the buffer size and we won't need to page in the
> entire buffer.

What?

A file read will READ THE WHOLE BUFFER.

We're not talking pipes or ttys here. If you ask for X bytes, you'll
get X bytes.

Of course, if you ask for more data than the file has, that's another
thing, but who really does that with direct-IO? And if they do, why
should we care about their silly behavior?

Face it, right now direct-IO is *BUGGY* because of this, and you can
deadlock filesystems with it.

So tell me again how it's "inconvenient" to fix this bug, and fix the
bad direct-IO design?

              Linus
