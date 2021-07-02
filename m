Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC223BA535
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhGBVmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBVmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:42:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FA7C061765
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 14:40:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f30so20549170lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZqwALtsQH508tfhUhLkddcNRdEqyv+/EhplpEdJ7pE=;
        b=W9R8pciJeHPopheaM4dxRYQGRdFdnYvt5IhQAOtvo0wWZduPQ99gAJNxhkarmUN9Hj
         WBqvxUAZ4TG638+jnCmrTHQQ7u9tdOYur+Rqk4LCJW+cox858p4xQOB9IY1rCKsWBLYh
         ky2fTm14sB1+RbkbNhx6IdQIjkFO+r2Z6YPkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZqwALtsQH508tfhUhLkddcNRdEqyv+/EhplpEdJ7pE=;
        b=FE3kOZCw/JJJc1le35EQKZg8dWms5z8O/NBDw79KfyBiu/Dkx2a30gULvpxEhRSdnz
         lqSsZIn+rhSBqIZeEVuj0DFb8wJzd/BDUFcpwDxdo9aGThy6g5KsUWJm4c9cMPwV4aJ0
         0RDOIP2DuMDKNRIeCY10eKDdi16uZgotVk9GvaH1mjlPBNr7AyASlkZbQ78dKtOgqrGw
         tbhv8jiywZyFocWVAepnjO72S7HkDFABQWgg4lNhIAq5w2ndzR326Q+Tx/XIcn+4jWwR
         3izVr1Ft2b2l7xZ0KlcMOaWG5lJTxmYkrjUK2jQnfDTBsoCyHCLixCQ4Mzb2JTvgmuzV
         5+ew==
X-Gm-Message-State: AOAM531LrdYuhlXdRoxDqEEbpjO6IyG0Fy1fA0VMREpGjkUtFSEQ1vaB
        CDqLrmMJ6tdgsxhurn74MylE5naWf7ZqjalOcEM=
X-Google-Smtp-Source: ABdhPJy6a/qWrP/lJ8vDerUTQ9vQ7Ugc7sDR1663rYWBiie0SJmGOT41a3IMwH+fiaCv8S20UMVTig==
X-Received: by 2002:a19:7d82:: with SMTP id y124mr1213045lfc.76.1625262005642;
        Fri, 02 Jul 2021 14:40:05 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n5sm375982lft.139.2021.07.02.14.40.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 14:40:05 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id r16so15158818ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 14:40:04 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr1096050ljj.411.1625262004353;
 Fri, 02 Jul 2021 14:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210702201643.GA13765@locust>
In-Reply-To: <20210702201643.GA13765@locust>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 14:39:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaCmLbgtSXjVA19HZO6RS8rNePjUf6HuMa3PoDS9VuSQ@mail.gmail.com>
Message-ID: <CAHk-=wjaCmLbgtSXjVA19HZO6RS8rNePjUf6HuMa3PoDS9VuSQ@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.14
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 1:16 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Please let me know if anything else strange happens during the merge
> process.  The merge commits I made seem stable enough, but as it's the
> first time I've ever accepted a pull request, we'd all be open to
> feedback for improvements for next time.

It looks fine to me.

I *would* suggest editing the merge commit messages a bit when doing
pull requests from other people.

It's by no means a big deal, but it looks a bit odd to see things like

    Hi all,

   ...

    Questions, comment and feedback appreciated!

    Thanks all!
    Allison

in the merge message. All that text made a ton of sense in Allison's
pull request, but as you actually then merge it, it doesn't make a lot
of sense in the commit log, if you see what I mean..

But it's not a problem for this pull request, and I've merged it in my
tree (pending my usual build tests etc, and I don't expect any
issues).

            Linus
