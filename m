Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5C3C5353
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352291AbhGLHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344780AbhGLHUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:20:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B72CC03D2AA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:16:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f30so41417088lfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpdtDeV/Foprmlj1iz2xO9n3C3FzsT5HDEkASA0zUqE=;
        b=XDlxXJHk3umluPMmNduTHmpcwN9WwaEHBlqavus9qtNQvZY/T0FXOA3aPMceBdJF6X
         iPt9fUSkkobEZJCfpSzzBOsv2rM9BzrpsV8jRNHw6EOdRoWrQfoa9nBtwTKPAn5p2fu6
         27s9tyvPOcqqdTfllLEN3Z23aFgErcZbMRIuMqVY9UCTsxGWvYoRYsaqQ9hAwtqW/9J8
         m1Zyy0TaJTI9ibsnjr5Ex3KWCd8Plh02o1aPc99mSXDnQAGH3Q2aCM45LLL3qZ7g+tH9
         ta9R1ynETPAqkCj30Skh9dyWekBw5vp5cKYNnYIFTxvbpkmxrBMYgBq1zK1VIQQ+hNr2
         0w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpdtDeV/Foprmlj1iz2xO9n3C3FzsT5HDEkASA0zUqE=;
        b=oWH0bYU2NG9qdT3oaieokuQpnp9MoirQpcz73SPJtOsSJ6ozoEnPwp/2ya0AI5XKx0
         gEXLMG9Ctf+4sOjdwRxRhwaJDVY2dWvzRAMbEyP5KqopaSxeDkJ6VMA/pLpwpN8DSDxl
         4VyYBc85ikLhWw4rKjTMQxTGwEZJ2jYe1NcYWsg14zkdCJi6v89V8JlIlySqr4+qgahr
         JVLPp9dhB+Zt7bePTc88wUPl8Pojh2KbuFUOcQgWA38o4eNSTOu4rxnzRTdOva4tSmhX
         ZbTBFFi/BRBiCEiRF5zA1wVOIKrxMWJN91cWZZWjHzLh1LM7jTkob5gSl3aUdHf2I86r
         B4Gw==
X-Gm-Message-State: AOAM531pT8GK8xH9UNOT7SATgzQ8iSnAibAlXaXofvt0GP6kEKdaHgON
        qdro/0oTlik6iPMYqsskgvdlhreSNwhiEwit2MgMqQ==
X-Google-Smtp-Source: ABdhPJx2HNTOk0deYJbO7622lb9zhuNkEq686WV6CC2WId2tick8R27l/PuW75BrbhDy4W/NbZ2NppJmvBt4KR/HKKo=
X-Received: by 2002:a05:6512:3ca8:: with SMTP id h40mr39941670lfv.302.1626074187002;
 Mon, 12 Jul 2021 00:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210709104320.101568-1-sumit.garg@linaro.org>
 <20210709104320.101568-4-sumit.garg@linaro.org> <CAD=FV=XHPCXSAmgf62K7+5LLbrz--BenQk5AyDozscr62qjbJg@mail.gmail.com>
In-Reply-To: <CAD=FV=XHPCXSAmgf62K7+5LLbrz--BenQk5AyDozscr62qjbJg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 12 Jul 2021 12:46:15 +0530
Message-ID: <CAFA6WYORwft8kMt+7rJ=AKrVY0THDsLCzCtm7HS0vZjh9L-HPQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] kdb: Simplify kdb_defcmd macro logic
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2021 at 03:07, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jul 9, 2021 at 3:43 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Switch to use a linked list instead of dynamic array which makes
> > allocation of kdb macro and traversing the kdb macro commands list
> > simpler.
> >
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_main.c | 107 +++++++++++++++++++-----------------
> >  1 file changed, 58 insertions(+), 49 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 6d9ff4048e7d..371983c03223 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -654,13 +654,16 @@ static void kdb_cmderror(int diag)
> >   *     zero for success, a kdb diagnostic if error
> >   */
> >  struct kdb_macro_t {
> > -       int count;
> > -       bool usable;
> > -       kdbtab_t cmd;
> > -       char **command;
> > +       kdbtab_t cmd;                   /* Macro command */
> > +       struct list_head statements;    /* Associated statement list */
> >  };
> > +
> > +struct kdb_macro_statement_t {
> > +       char *statement;                /* Statement name */
>
> This is still not really the name. This is the actual statement,
> right? Like it might contain "ftdump -1", right? It seems really weird
> to call that the "name". You could drop the word "name", or change
> this to "Statement text", or just totally drop the comment.
>

Let me use "Statement text" instead.

> Other than that this looks good to me.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
-Sumit
