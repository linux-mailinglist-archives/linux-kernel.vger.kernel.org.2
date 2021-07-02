Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D23D3B9A2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 02:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhGBArQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 20:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbhGBArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 20:47:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA05C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 17:44:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u20so10942508ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 17:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAFBHiNSZwKerU1t63V8e2H+JwkRhVjzTJjD0e6PoSw=;
        b=ZYxIP1QsQJOofaF+2clUty0T1Lhs1wjmljMk5X/1TqPaMbGngtWbuzlUinFBRUI/Vw
         T6H/oVRETBU5E8BNhMLHjhRROCntkKWIe4IXLBd32rPUXuOif4u9OM91D+vt/nvJxrJu
         CqtEtrlRMfDxo9x8MLGh6DlDPpBI22MIbMUyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAFBHiNSZwKerU1t63V8e2H+JwkRhVjzTJjD0e6PoSw=;
        b=UCqjTceA9tYAgkdX+SugeGoR6pQ5b3r9Easfz8hsGJVA9ha135tZJvBzYC9blo7A45
         RKqfkKnjKqJHA5RTxN8u7A7XWSbvWPVU5NBWWQJCEZSvQ303i6SohzabFlCiUd2i4c6Q
         2Fz3GzVtX4w4OjgyeJit47D1dCTzkR9ZICGpABRSE3KHx+iYNXeT+eS0Dbh+a2Zmwfch
         S8cl1zwZGVuJB7Fm4fKFrDmzY7EIc6JG5MHEJvFqSMcZ+mEENSa9FPXNdUXaealbq9w8
         GRdATSBq+4wEewi1d9a1vasBFOAAfxnu0qv40RMba2R5NHnBCGdWsciMYRGzQDhBNCAd
         xf2w==
X-Gm-Message-State: AOAM533N5H4Py73b+IuKZ3XOSygAQl2RRnfMom7SfOnSAwlbc2JoWUUr
        dwWVjZZVMrd8g5miUvcqZUjnCFu7e07KTFKGmaU=
X-Google-Smtp-Source: ABdhPJxWqIyPA75CY4hBHYQKyBHXnuQZQrNz4YvoHsLsAe5MzHHtSVq1TIrD9pRHjn25dmr8A2StqQ==
X-Received: by 2002:a05:651c:546:: with SMTP id q6mr1681136ljp.73.1625186682135;
        Thu, 01 Jul 2021 17:44:42 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s21sm175405lji.57.2021.07.01.17.44.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 17:44:40 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u13so15148867lfk.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 17:44:40 -0700 (PDT)
X-Received: by 2002:a05:6512:15a2:: with SMTP id bp34mr1715559lfb.40.1625186680318;
 Thu, 01 Jul 2021 17:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210701204246.2037142-1-agruenba@redhat.com> <CAHk-=wjk6KP3vSLFNPMjoaZ4xY4u=DjTM+C+hCS3QKt+XAE6OA@mail.gmail.com>
 <CAHc6FU5XMfTOBW1a0OnMaPSmgWECvO-KYAo8HeVNsCyd-HyV3g@mail.gmail.com> <CAHk-=whaRsSuUeVBn_rLECWyG6h9RGuF9idsT_S+==vnsT8org@mail.gmail.com>
In-Reply-To: <CAHk-=whaRsSuUeVBn_rLECWyG6h9RGuF9idsT_S+==vnsT8org@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jul 2021 17:44:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnHfghvfLAteVeOTyDbypZ=Y7WBHfYByoVZa9SMxKe1w@mail.gmail.com>
Message-ID: <CAHk-=whnHfghvfLAteVeOTyDbypZ=Y7WBHfYByoVZa9SMxKe1w@mail.gmail.com>
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

On Thu, Jul 1, 2021 at 5:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> Of course, if you ask for more data than the file has, that's another
> thing, but who really does that with direct-IO? And if they do, why
> should we care about their silly behavior?

Now, if the issue is that people do IO for bigger areas than you have
memory for, then I think that's a chunking issue. I don't think the
ITER_IOVEC necessarily needs to be converted to an ITER_BVEC in one
single go. That would indeed be painful if somebody tries to do some
huge direct-IO when they just don't have the memory for it.

But the fact is, direct-IO has been an incredible pain-point for
decades, because it's (a) unusual, (b) buggy and (c) has very little
overall design and common code.

The three issues are likely intimately tied together.

The iomap code at least has tried to make for much more common code,
but I really think some direct-IO people should seriously reconsider
how they are doing things when there are fundamental deadlocks in the
design.

And I do think that a ITER_IOVEC -> ITER_BVEC conversion function
might be a really really good idea to solve this problem. There's even
a very natural chunking algorithm: try to do as much as possible with
get_user_pages_fast() - so that if you already *have* the memory, you
can do the full IO (or at least a big part of it).

And if get_user_pages_fast() only gives you a small area - or nothing
at all - you chunk it down aggressively, and realize that "oh, doing
direct-IO when user space is paged out might not be the most optimal
case".

              Linus
