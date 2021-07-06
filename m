Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27E3BDDD2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhGFTLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhGFTLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:11:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F73C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 12:09:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q18so40104037lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bblXDMrkPj0WWGrmwBaP0HLTmXGY97GGo32bm2AWA6s=;
        b=DjhWCm4aDH0zEYmLfOJo1okuvcgaAHzFxOjEbpYjm45ymD3/J2b6rId2pW6BjrPzJu
         j7/mKjkMRvnAaJN0v5DJWzmvVZge9UamdHsIkO13B6oxK4CHh6qXhc9bxFk19fazMBUa
         iJR0JD8ffoE7jQjBTlX48QdfhTVe5ndw5p6fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bblXDMrkPj0WWGrmwBaP0HLTmXGY97GGo32bm2AWA6s=;
        b=nZGvvHPqWCzkQOxsYTIo+wvB1OMRt0zZld7ZaKRZaSvuy6hHkW51FhAjDnA46X8VBL
         /iipwUoGnvfYb4TmgZXETBAQFsbugkl8edM7/p0DdlF7OeWownKFzEsYq9aqdjXZUOxP
         nRkf1/x2f3f5BYHe9Qqu0IdbpF2TsdxLNprfuXNEeMso5/9NF45RAwc7460srqN/ksf+
         PCQhzRDcc7YqEWXF2ubMRBZ32KdQRUNg2icpQdPj7+gXzSLrAEnXH5sKNpe7MjtQHcri
         N1M4RqhTyBjIZ1F41TNwph5H795SpSD96vRAByn57F0dMAHqWJC2wjaKjmPDU9nSj9Il
         gYMA==
X-Gm-Message-State: AOAM533ebGUo0IUEDam5rsmSaOnQrrr3ARkxRoNQHk+pvS1HyBzaMVYU
        EFNlrQm5aAiYP66rumem6dhBTdzf7M6D7xXA
X-Google-Smtp-Source: ABdhPJz522qSSy0UVe8RHZ2XbyLBbzL/9+nUpxI03aipXEYg6eLX9u85hjJ0f3+hrMDg8Zd+4Gr6cA==
X-Received: by 2002:a05:6512:c12:: with SMTP id z18mr11649208lfu.230.1625598539538;
        Tue, 06 Jul 2021 12:08:59 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id bu41sm1474765lfb.116.2021.07.06.12.08.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 12:08:58 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id q18so40103849lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 12:08:58 -0700 (PDT)
X-Received: by 2002:ac2:4903:: with SMTP id n3mr15542492lfi.487.1625598538362;
 Tue, 06 Jul 2021 12:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210704150025.GC21572@xsang-OptiPlex-9020> <20210705125756.GA25141@lst.de>
 <CAHk-=wj_Gfqkdp+K3iCiqMjAZQK_BrRWDs2eOS_BAw=bB=CdRw@mail.gmail.com> <20210706143647.GA28289@lst.de>
In-Reply-To: <20210706143647.GA28289@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jul 2021 12:08:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPyx7tHFNaO2N6bsaB_E6gL+t1uDAmrD91jJw+hiTvrQ@mail.gmail.com>
Message-ID: <CAHk-=wgPyx7tHFNaO2N6bsaB_E6gL+t1uDAmrD91jJw+hiTvrQ@mail.gmail.com>
Subject: Re: [ide] b7fb14d3ac: EIP:ioread32_rep
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 7:36 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Yeah, there's usually a huge offset into the page.  The otherwise
> similar ATAPI code actually has checks to chunk it up and not cross
> page boundaries, and copying that over fixes the problem.

Ok.

Your patch made me go "I think it should loop until it has transferred
the full 512 bytes", but maybe the caller loops properly?

Or should it just discard the end?

HOWEVER.

Even if the caller does loop/discard properly, your patch still worries me:

> +       /* don't cross page boundaries */
> +       count = min(count, (unsigned int)PAGE_SIZE - offset);

Is the offset guaranteed to be 4-byte aligned?

Because I'm looking at ata_sff_data_xfer32(), and I think it
fundamentally would fail the "retry after partial 4-byte transfer".

Let's imagine that "offset" is 511 bytes off the end of the page, and
so you'd first do a 511-byte transfer, and then a 1-byte transfer.

That's not how ata_sff_data_xfer32() works. It would actually first do
a 508-byte transfer (using that "rep insl" to do 4 bytes at a time),
and then it would do a 4-byte transfer into a temporary buffer, and
copy the first three bytes to fill out the 511 bytes in the first
page.

If you then loop back to do the last byte, it would do another 4-byte
transfer into a temporary buffer, and copy the remaining byte - ending
up with 512 bytes result as asked for.

Except they wouldn't be the *RIGHT* 512 bytes. It would have done 516
bytes worth of "inl", and from those 516 bytes it would have filled
the last 4 bytes with basically random garbage (ok, the first three
bytes would be ok, but the last byte would not be).

So I think that ap->ops->sff_data_xfer fundamentally cannot handle a
page crosser correctly - at least not if it's not 4-byte aligned.

How does IO to a non-sector-aligned buffer eevr happen? Because I
think that's broken, and your patch is only hiding further bugs.

                    Linus
