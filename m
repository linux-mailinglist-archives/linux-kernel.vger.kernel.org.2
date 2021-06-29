Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B403B74C7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhF2PDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhF2PDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:03:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E217C061766
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:00:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b3so26190615wrm.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IC/0iIQzRxRPo9b+WDc+/ztYr9KoC21F+3neWDOH/5k=;
        b=rPD6Dl6BfLhn1PHK3MeILaJWiKWEiyI99p+rFwCypedMPTWVpTN7VETYBvZjxWdK3T
         eZu6YzzPIe2swfmXXb/8gOdmYTYE6A0IYLQ/C6ZyEaqNoRH6x5Ie4rz23NwnneYCdQA3
         KjfiTRYQctF/axYBt9PhoCyzwVSmc7uU2M92+38hZLIaoWpn02QnYa4p9f5iCW0Sc/6T
         tgK3dEcF/2yJAKoBtYzwIMpUEWmA/5sjp0l2gvqTOqrMBb1uP0MVQ57RVISB3WwI3nCd
         GLteK5nS1anLpzIYbjEtlKSILy47ue2+sNknZgLtUqi4C/Q21Bx76JqHC8jB0u2Byo6X
         Yfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IC/0iIQzRxRPo9b+WDc+/ztYr9KoC21F+3neWDOH/5k=;
        b=Fug93msjzNMvHjSmMsLhGx4cAZDHOFJSHQ8jpOrUkQxr0ulEJcpGLkAEsbRyAvGZuC
         XOhz03fuJZiuO/FVvxe9qiaYVOXK1GKtMFfupZWhaDwWyjpHM8ywkQQDAYPAu3bl5XwK
         TyCxvjlPCOUTiD1B6VBT4pheHS25MYst0Z2dax7+4H8u7GNZQmCWz9ke8cBbgIAPSV6Z
         g277QBFCg+MpZcASVPxe565yKXSfwGnm06lc3cJxdqrMNzf4kyhHMRwS4R9RTkVUYmyk
         222pG0qC31Oe+ETQNx+R1Imyr5Tk4Vr57bsDMMWk9gPhjoi4Z/wT5CqcHmmcPY9j1Phd
         5VRA==
X-Gm-Message-State: AOAM532EZFFwyh4NezwqZXMaSrGcWNsMWRLyJqfIXtKkfkihD/SPdLpX
        d8LrgZ7skN761AxehY891qUR9T2YvGJ+JM3dfAUGdg==
X-Google-Smtp-Source: ABdhPJxorZzN1lyVyUktLFlE6XPvBceZJlBBNECGTNP4fjShpGZiTR4BBoZE0igpNCrm0E73GuTDpRkcIbfSbAX2bPY=
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr33472810wrj.48.1624978844017;
 Tue, 29 Jun 2021 08:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210624223423.189550-1-rickyman7@gmail.com> <CAP-5=fXWFvcvNOA+wJMSCp2Qz7EVruufvFBLWEXfdezeEJGUTA@mail.gmail.com>
 <f3bf33bfe2365241fc872ca781109f1b69374840.camel@gmail.com>
In-Reply-To: <f3bf33bfe2365241fc872ca781109f1b69374840.camel@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 29 Jun 2021 08:00:31 -0700
Message-ID: <CAP-5=fVxdwOKWN2oOv7+hr2Vr0wD4jzizzK4x4W8jM8bwZ7u-w@mail.gmail.com>
Subject: Re: [PATCH v2] perf annotate: allow 's' on source code lines
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin Liska <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 8:53 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Hi Ian,
>
> On Thu, 2021-06-24 at 22:37 -0700, Ian Rogers wrote:
> > On Thu, Jun 24, 2021 at 3:37 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > >
> > > In perf annotate, when 's' is pressed on a line containing
> > > source code, it shows the message "Only available for assembly
> > > lines".
> > > This patch gets rid of the error, moving the cursr to the next
> > > available asm line (or the closest previous one if no asm line
> > > is found moving forwards), before hiding source code lines.
> > >
> > > Changes in v2:
> > >  - handle case of no asm line found in
> > >    annotate_browser__find_next_asm_line by returning NULL and
> > >    handling error in caller.
> > >
> > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> >
> > > ---
> > >  tools/perf/ui/browsers/annotate.c | 32 ++++++++++++++++++++++++++++---
> > >  1 file changed, 29 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/ui/browsers/annotate.c
> > > b/tools/perf/ui/browsers/annotate.c
> > > index ad0a70f0edaf..f5509a958e38 100644
> > > --- a/tools/perf/ui/browsers/annotate.c
> > > +++ b/tools/perf/ui/browsers/annotate.c
> > > @@ -343,6 +343,29 @@ static void annotate_browser__calc_percent(struct
> > > annotate_browser *browser,
> > >         browser->curr_hot = rb_last(&browser->entries);
> > >  }
> > >
> > > +static struct annotation_line *annotate_browser__find_next_asm_line(
> > > +                                       struct annotate_browser *browser,
> > > +                                       struct annotation_line *al)
> > > +{
> > > +       struct annotation_line *it = al;
> > > +
> > > +       /* find next asm line */
> > > +       list_for_each_entry_continue(it, browser->b.top, node) {
> > > +               if (it->idx_asm >= 0)
> > > +                       return it;
> > > +       }
> > > +
> > > +       /* no asm line found forwards, try backwards */
> > > +       it = al;
> > > +       list_for_each_entry_continue_reverse(it, browser->b.top, node) {
> > > +               if (it->idx_asm >= 0)
> > > +                       return it;
> > > +       }
> > > +
> > > +       /* There are no asm lines */
> > > +       return NULL;
> > > +}
> > > +
> > >  static bool annotate_browser__toggle_source(struct annotate_browser
> > > *browser)
> > >  {
> > >         struct annotation *notes = browser__annotation(&browser->b);
> > > @@ -363,9 +386,12 @@ static bool annotate_browser__toggle_source(struct
> > > annotate_browser *browser)
> > >                 browser->b.index = al->idx;
> > >         } else {
> > >                 if (al->idx_asm < 0) {
> > > -                       ui_helpline__puts("Only available for assembly
> > > lines.");
> > > -                       browser->b.seek(&browser->b, -offset, SEEK_CUR);
> > > -                       return false;
> > > +                       /* move cursor to next asm line */
> >
> > comment nit, perhaps prefer "closest" rather than "next" due to
> > searching backward.
>
> The backward search is just a fallback in case the forward one finds no asm
> line, which I believe is unlikely. Maybe it's also impossible, but I don't
> really know how those lines are generated, so I put a fallback in place.
> Furthermore, "closest" would imply that a previous asm line could be chosen over
> a subsequent one if closer, even if the latter is present.
>
> Thanks,
> Riccardo

Agreed, thanks for thinking about this.

Acked-by: Ian Rogers <irogers@google.com>

> >
> > Thanks,
> > Ian
> >
> > > +                       al = annotate_browser__find_next_asm_line(browser,
> > > al);
> > > +                       if (!al) {
> > > +                               browser->b.seek(&browser->b, -offset,
> > > SEEK_CUR);
> > > +                               return false;
> > > +                       }
> > >                 }
> > >
> > >                 if (al->idx_asm < offset)
> > > --
> > > 2.31.1
> > >
>
>
