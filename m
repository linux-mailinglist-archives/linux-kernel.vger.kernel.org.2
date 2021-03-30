Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445AE34F490
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhC3Wqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhC3Wqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:46:30 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF725C061574;
        Tue, 30 Mar 2021 15:46:29 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v107so14077978ybi.9;
        Tue, 30 Mar 2021 15:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejqbwz/4EkB7cjA6s77zDBNNeHlW7Gc17XQkwT+jGR0=;
        b=QZHm3lIoa3bbuGYkTKiqOXnNOEwBUO0+4Go0DX4ebrfg62LFwPNDBR8Xl1Y6MyoKH0
         YoQSDLayToitnhPDOCFVo8PFceArYaSoHSH4z98GoBGuCKpQhggnHYW/2VagdMuaOqgB
         WemxDfM/YWX6235a3pg387TOjCH50xCzhxwVWa5eXzTxouQAoeULYvD0KEPgA3O42cXP
         LefUsow8u6yutZIAKypyHQyufMaxT4fDGk3NDgjenArm7ikZpHwjI141jOY/y0P4E2TG
         NdL7gBfT9fyz7h+pi4q+NHmsz9gUZotlqTEzDfskj45r1217aDQJQWXaFGH1AgVn1FbY
         gVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejqbwz/4EkB7cjA6s77zDBNNeHlW7Gc17XQkwT+jGR0=;
        b=i8vwsaCpT0qX9A8eFv/jXWa5snszSqhkq43XLjlGEB5XAZUUBX4UbesaRHsx+Y4oQR
         +VYGaR1G3vvbiS+LbnVV9+kq6VNLnzaVq+sYSl6XoE1SM5uuyI0l+jj4hxPgDASTGf3X
         s3cQ/aHrXytgEsvDMznvjQVXAZoQ6f5pVjc+dVNsYUvyvTdn479UtmiQ16KuGMQC36me
         ysTEhapgl38snNiZIbEm0AF5g4O4Rw5Vt2Ibbnpi34nLJcr8JVDIuCJ1ftco86cEJxhb
         9mw67vpG1TWZ4ESTfLApFXLcaSw5ekseIKqAgHJI4OgAZIW9H+ODGAkKslg42Gx5QnNX
         OPlg==
X-Gm-Message-State: AOAM531/HXY1C0iP7fSfQLFh73tEa+wzQBFqXLYaaxqLCFZXaCBKwAyQ
        qIejgSc3sbRbQRTL9HlaOT4QUOP3A7Xv5ZWSelhbN/PP6rojQg==
X-Google-Smtp-Source: ABdhPJw7PK2aABOUCuU4cuQR6dMOXs8J0854fsME58H+idy86dsavoSqa9LYuZpibc3jH3aZH0mf2Xo8tsiPz6E2qbA=
X-Received: by 2002:a25:3cc6:: with SMTP id j189mr597494yba.247.1617144389096;
 Tue, 30 Mar 2021 15:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210325184615.08526aed@coco.lan> <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net> <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net> <20210325221437.GA1719932@casper.infradead.org>
 <CANiq72=kRzBQsjgUeuVNXRmRVN8zXzMvMn+yTWt=YhR+r2wNEg@mail.gmail.com> <87wntooq71.fsf@intel.com>
In-Reply-To: <87wntooq71.fsf@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 Mar 2021 00:46:18 +0200
Message-ID: <CANiq72kd+=LrWZEAN=eu9O49Vi+4bMBCjCN=uH6bs130kF9U9A@mail.gmail.com>
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 1:07 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> FWIW, and this should be obvious, I think going with what's natural for
> documenting Rust source code is the right choice. Markdown as parsed by
> rustdoc. People will expect Rust documentation comments to just work,
> without some kernel specific gotchas. Don't try to reinvent the wheel
> here, it's a dead end.

Agreed!

> The interesting question is, I think, figuring out if rustdoc output
> could be incorporated into Sphinx documentation, and how. It would be
> pretty disappointing if we ended up with two documentation silos based
> on the module implementation language.

I want to have the Rust docs linked from Sphinx and uploaded as usual
to kernel.org etc.

However, please note that the implementation language implies a lot of
things, not just the "implementation language", if that makes sense.

For instance, if you write your module in Rust, the idea is that you
use the Rust infrastructure and exposed abstractions -- not that you
call C kernel functions on your own.

> At the moment it seems to me rustdoc can only output HTML, and that
> seems pretty deeply ingrained in the tool. AFAICT, there isn't an
> intermediate phase where it would be trivial to output the documentation
> in Markdown (though I don't really know Rust and I only had a cursory
> look at librustdoc). And even if it were possible, with Markdown you'd
> have the issues with conflicting Markdown flavours, what's supported by
> rustdoc vs. commonmark.py used by Sphinx.

Please note that `rustdoc` generates HTML that is intended for Rust
code, i.e. generating an intermediate format to then generate HTML
from Sphinx would make the Rust docs worse, unless the mapping is
perfect (but, at that point, why not just keep the standard Rust
docs?).

> Perhaps the bare minimum is running rustdoc first, and generating the
> results into Sphinx static pages [1], to make them part of the
> whole. Even if the HTML style might be different. Perhaps it would be

I don't think it is the "bare minimum", I think this is the optimal
solution! :-)

It is also not just about the style. The Rust docs are organized for
Rust code, the search functionality is meant for it, etc.

> possible to come up with a Sphinx extensions to make it convenient to
> reference content in the rustdoc generated HTML from reStructuredText.

For C -> Rust links, the plan I suggested to Jonathan was to have
Sphinx generate a text file with (reference, URL) pairs that then
`rustdoc` can use as links (e.g. to link to, say, the docs for
`printk`).

I also discussed it with the `rustdoc` maintainers, and they thought
it would be an interesting proposal, so I agreed to make an RFC for it
(note that it can be useful not just for Rust docs that need to refer
to C code, but also for any other kind of external content, e.g.
imagine a math library referencing a set of papers, books, etc.
without having to re-write the URL everywhere).

Cheers,
Miguel
