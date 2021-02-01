Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD96E30ACB2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhBAQdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhBAQcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:32:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7373C64E95
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612197106;
        bh=bD7UbJ6vT0UPTSwjt3ttiyd+WwYJ9x/CMpj+BEQqOrk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=duWL/5em7J4DQAo6N5fmufvAwvnGDPXYl03eqw73DHmCLNPfZ3BvmqULhlHTG3pl6
         sHWpeLwpT2roGIRrgqKXl9Jic24Uqe0vngJjUosjM3QynDprWDzwiqJqQnkT2mIccV
         CNFChxqHfz8gMxNM0LELQNDhgWM3TcBfVlfgReDE0qnD6c2Fu8FBkV8Qo4yjveT+q8
         W4dgNGv1V9XYWndHsfrhp0W0rLTaRFk2S5qPJ63e8jkEKyZp5ZIWyHGwa0R9NPYA/w
         iXwqhZixnqihupioVI+x6zZOYBL2z6GMMXcWseJBJVsccj1SBKm+8drgXODVsPsmDd
         orh3V9KD0+Zpg==
Received: by mail-ed1-f46.google.com with SMTP id y18so2257652edw.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 08:31:46 -0800 (PST)
X-Gm-Message-State: AOAM531fEsYWDGG+s8eUgx1Ymhd2XC37AoE4GjqX/BK96LlajbEcypYI
        feBbeS7gmYs8O7Fuyze/+oKa0EIavOjLLbTy0R8=
X-Google-Smtp-Source: ABdhPJwkUQ4sKV1k4FaQJHQdakd+LnJL5Mv9ZR0grIXAHNKcKHAziyB2Sukm19bCjT9V5NAf/avDGFT7c2tsO2I7zq4=
X-Received: by 2002:a50:b246:: with SMTP id o64mr18837214edd.132.1612197104981;
 Mon, 01 Feb 2021 08:31:44 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210128152646epcas5p3e0ceb57e0a2e668b4281b5733dd117d4@epcas5p3.samsung.com>
 <1611847603-15736-1-git-send-email-shradha.t@samsung.com> <a04109c80ded369fcbf8829d3d9461be7528226d.camel@perches.com>
 <19f201d6f88c$cba69450$62f3bcf0$@samsung.com>
In-Reply-To: <19f201d6f88c$cba69450$62f3bcf0$@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 1 Feb 2021 17:31:32 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdrvxuMHgxDtknWEhZuAF3fRNyXrN0h7SJ4BQVV00Lk5g@mail.gmail.com>
Message-ID: <CAJKOXPdrvxuMHgxDtknWEhZuAF3fRNyXrN0h7SJ4BQVV00Lk5g@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add warning for line space after "Fixes:" tag
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        apw@canonical.com, pankaj.dubey@samsung.com,
        Lakshay Mehra <l.mehra@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 at 12:27, Shradha Todi <shradha.t@samsung.com> wrote:
>
> > -----Original Message-----
> > From: Joe Perches <joe@perches.com>
> > Subject: Re: [PATCH] checkpatch: add warning for line space after
> "Fixes:" tag
> >
> > On Thu, 2021-01-28 at 20:56 +0530, Shradha Todi wrote:
> > > Add a check to give warning for line break between Fixes tag
> > > and signature tags as that is the commonly followed style.
> > >
> > > Also add a --fix option to delete space lines after "Fixes:" tag.
> > >
> > > Signed-off-by: Lakshay Mehra <l.mehra@samsung.com>
> > > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > > ---
> > >  scripts/checkpatch.pl | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 92e888e..6c144c5 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3027,6 +3027,15 @@ sub process {
> > >                     $commit_log_long_line = 1;
> > >             }
> > >
> > >
> > > +# Check for no line break after Fixes
> > > +           if ($line =~ /^\s*Fixes:/i && $rawlines[$linenr] =~
> /^\s*$/) {
> > > +                   if (WARN("UNNECESSARY_NEWLINE",
> > > +                            "Newline is not required after Fixes:\n" .
> > $herecurr) &&
> > > +                       $fix) {
> > > +                           fix_delete_line($fixlinenr+1, $rawline);
> > > +                   }
> > > +           }
> >
> > I think this isn't necessary and $rawlines[$linenr] may be not exist.
> >
>
> I recently submitted a patch with the fixes tag followed by a line break
> and then SOB.
> I received a comment saying "no line space between Fixes and SOB" [1].
> So my intention of adding this was to save the maintainers time from these
> silly mistakes.
> Any suggestions for improving this patch? Thanks a ton for the prompt
> review.

Hi,

Thanks for your submission. Suggestion is: do not ping too early, give
around 2 weeks for review. If nothing happens after two weeks, resend
or ping.

Best regards,
Krzysztof
