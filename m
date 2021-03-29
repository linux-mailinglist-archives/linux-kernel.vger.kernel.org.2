Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF234D927
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 22:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhC2UlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 16:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhC2Ukg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:40:36 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03FEC061574;
        Mon, 29 Mar 2021 13:40:35 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a143so15104748ybg.7;
        Mon, 29 Mar 2021 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaMnHKrcqRFdMgIooSwMY251zpzffov2Wa1tFMgJcQc=;
        b=NWXHP647lLp0tz5ggRDWXJq++xmMGdJxHith+p2+CT8rtTIE3Kc5v+GunTZ0NLkjpO
         kxBSJ0NewzcpCyz0O5WQ2HcGBjSG3dKZdUXKBfQ3LrOQ7LGKtOgkjbLvbGBbkj1KYudF
         WLfyVYA6bNmkhq+Ctwz8j08d4Qy8FqP8l+3fHiAk+dtu2jK2Xlx2EJMqf2aumEBOFb5s
         3+tgZ7kLhoMZR9Ao3ursAVSaWWCxMstpk+F3JmrrOF1k/jwTjIlOb7UWxEPgdRzIGv0t
         nIk0s6SQvbon3jahll/0VZ0UbnVoM+W+ImpLuQkBMn6tA5P2cYcfJ3j8coGeKw8xz/Ai
         704Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaMnHKrcqRFdMgIooSwMY251zpzffov2Wa1tFMgJcQc=;
        b=OKwEcN1kx/qlfqhvwAzNFeqxmnK7cdp/Sg5NpEaPIa1nEuPQnGBkhvrGRIdXgJkooO
         tsNMpzu/2roEotUiZe42IYdSemIJB+opfw9sG5tsE+Jr+7FfggyUtlDxVp3MskrOvP/c
         TOpDq2x6lOrLscWQu0dw3tjRdzTGwE8vaiMh4x8pWUxgfi3XFHYzm8SFIiqClFJTcl9r
         WQETDFMmT3MR1JivPm2dOu4BJwwclQ+3wLU5xx5C6lx5xi5mKvVou7WfY8TvidumUTez
         OdWyjhwha7pPjyPA7PxZgXLvbnkaGzfttsNx+1S3xkcZ27EBWCoxCbtP/AmkRIqxDwoY
         e2Nw==
X-Gm-Message-State: AOAM530hR+rnnvLt3tkXA53zkg2Sd89LbPEgsvMntBV3L4tTpH2rjO5A
        mUMcdgPThdWxZj4Fpl+11fwix6wWVcnDfy7p+HQ=
X-Google-Smtp-Source: ABdhPJy0sW8G5Bh8dGcRLyzl71RvsAYvdfpVfDlRwDlFU1lbSGoQ1uadfPIwsWceK5QatpxnYN+5whxAIH9cW9XQN70=
X-Received: by 2002:a25:3b55:: with SMTP id i82mr43295469yba.422.1617050434956;
 Mon, 29 Mar 2021 13:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210325184615.08526aed@coco.lan> <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net> <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net> <20210325221437.GA1719932@casper.infradead.org>
In-Reply-To: <20210325221437.GA1719932@casper.infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 29 Mar 2021 22:40:24 +0200
Message-ID: <CANiq72=kRzBQsjgUeuVNXRmRVN8zXzMvMn+yTWt=YhR+r2wNEg@mail.gmail.com>
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 11:18 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> The rust code is alredy coming though ...
>
> rust/kernel/buffer.rs:/// A pre-allocated buffer that implements [`core::fmt::Write`].
>
> so now we have three formats.  Markdown and RST are _very_ similar, but
> not identical [1].  Oh, and even better we now have three distinct tools --
> kerneldoc, rustdoc and sphinx.  Have the rust people reached out to you
> about integrating the various docs?

Yeah, I reached out to Jonathan a few weeks ago to discuss how we will
approach this, because I knew using `rustdoc` and Markdown could be
contentious ;-)

This is the solution we decided to go for the RFC but, of course,
nothing is set in stone:

  1. The "out-of-line" docs in `Documentation/rust/`: these will be in
RST as usual [*]. However, please note this does not include APIs or
anything like that, as it is done in the C side. Only a few "general
documents" that don't fit anywhere else are kept here.

  2. The "inline" docs in Rust source files: these will be parsed by
`rustdoc` and written in Markdown. These will contain the majority of
the Rust documentation. `rustdoc` is designed for Rust code, and
internally uses the Rust compiler, which comes with a number of
advantages.

The generated HTML docs will be showcased in the RFC. It is my hope
that this way we get feedback on them and see if people agree this
approach is worth keeping. We have put an effort (and I have been
annoying contributors enough to that end :-) to provide high-quality
documentation from the get-go.

Please note that we chose this way knowing well that inconsistency and
adding "yet one more tool" needs to come with big advantages to
offset. We think it is the best approach nevertheless!

[*] I discussed with Jonathan using Markdown since Sphinx supports it.
The main advantage would be easier refactoring of comments between the
out- and inline docs. But this is very minor, thus mixing two formats
inside `Documentation/` does not seem like worth it.

Cheers,
Miguel
