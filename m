Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB44239D441
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 07:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFGFNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 01:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGFNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 01:13:30 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91583C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 22:11:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i4so23178773ybe.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 22:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8zWBu7PGNThrMwSPRIxZY/nfLOXlD38qeZwCIAD4+U=;
        b=Q2/775qbl2IBlSvLbip6amggplkjpk4dZgq1uMBfVH8vaqxNHWmgN4C26wNJHjuHY9
         u1qiiTdPvoAHTBzHBzcsSPrq9aN/b+W2PZjDSAAaevAYB9sP1vxJVAdCn1yfaCMSGZdJ
         Xd9lvL4xnYCBbSu6vBIAxNj/GLfDCeK91+CTayUC7D0ACvkC2GPYidjOZAxhn8fNDqIu
         kZBQk5c1yMmZ/1/5iwkOLhrxq+9GNE663UGmqDety4EzPEixJLn9Jl4ZNj1ASXuBGCe0
         y+ku/XLQM6tUE/2nLgWer9Jp9W4zHuDuiXQbWI5yGKHJhXxLqqUtsXuHVQuHeNSS40rT
         qVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8zWBu7PGNThrMwSPRIxZY/nfLOXlD38qeZwCIAD4+U=;
        b=TnGIMyyX1N9bSS9hLan+ntQx6XcDjSCh8FIfdgiXw585AxFzOvs2kLh1EUytx/NF2q
         tQRLfDjGagkdlFQYoYFaoRzY5JTpn4EKP0hfQZ9GobjxsfR+67ixhXcF1bRVdMebmXEc
         F1mTR5XbF3zOnTxzrxisHqMf+tnOiwr6SlmCPnCvZDFI/QrJYm1pRoWAQAa5aQYuIcJR
         RHBKe6FjkX1pOI4Rw+jzfjydzgfrNEtlRCm0KpueqoQEAHyGq+2ZsSCkSGrpcdPn+qR+
         srnu8mjkN4/R2RUn14l0uk0KtE6CnXvj9WER7F81NeBn4Cc0WRl5lln00PQFgGgPBKpy
         bZyA==
X-Gm-Message-State: AOAM532vmdon/E6nOvGWhwpJGi0hHgk/RGpaI3ZoEJvddskEYk/mYIRt
        nyxVYc5sPE5oP8ouk9vIpXdRy6AS1lsN4q1r2MjuiRw7Vj2Bjg==
X-Google-Smtp-Source: ABdhPJzB9rWgNjMK5jJsSxplxIQXrOG91u3vk1SLbSrM0USEcI+LAQPVd+WAjT1xizdBKsNTwHFVU3dSG1Qh91w/KMU=
X-Received: by 2002:a25:8385:: with SMTP id t5mr22221990ybk.151.1623042683605;
 Sun, 06 Jun 2021 22:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210605191754.28165-1-dwaipayanray1@gmail.com> <0c0bdfa2c0c1f2c7ebdcbe7d4a1366c1697ce57a.camel@perches.com>
In-Reply-To: <0c0bdfa2c0c1f2c7ebdcbe7d4a1366c1697ce57a.camel@perches.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 7 Jun 2021 07:11:12 +0200
Message-ID: <CAKXUXMyoiEaYaqK9PX3PnUDV94RnVc_A4d6W7JkPOdr_1RCF2g@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: do not allow using -f/--file option without a filename
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 9:32 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2021-06-06 at 00:47 +0530, Dwaipayan Ray wrote:
> > When checkpatch is run without a filename, it reads from stdin.
> > But if --file option is used along with that, it may generate

But if the --file option is used...

> > false positives.
> >
> > Consider the following test file:
> > $cat test.c
> > int x = a - b;
> >
> > $cat test.c | ./scripts/checkpatch.pl -f
> > WARNING: It's generally not useful to have the filename in the file
> > +int x = a - b;
> >
> > This is a false positive and occurs because $realfile is set to "-".
> > Also since checkpatch relies on the file's extension to run specific
> > checks for c files, assembly files, etc, most of the checks are
> > not run as well.
> >
> > So it is better to disable -f/--file option when checkpatch is
> > run without a filename.
>
> That's a reasonable commit message, thanks.
>

That can be shortened to:

Disable -f/--file option when checkpatch is run without a filename.

How about adding a description in the checkpatch Documentation on this
topic as well, as part of this patch?

Lukas

> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -331,6 +331,7 @@ help(0) if ($help);
> >
> >
> >  die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
> >  die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
> > +die "$P: -f/--file requires at least one filename\n" if ($file && $#ARGV < 0);
> >
> >  if ($color =~ /^[01]$/) {
> >       $color = !$color;
>
>
