Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A454312E89
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhBHKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhBHJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:57:28 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750C4C0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 01:48:32 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id c18so16145693ljd.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 01:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvINO3Dqf9GYw5Bbhf3syQ8zjJwNC62ESu6hTyzUQHk=;
        b=jWB6vPNGP1rv5/2u3F4WgblpbSq4CbDXLGDm0GDa4cQl3UzBC6FOJQ1JzwnthSspjc
         F2t5lohHh5nAaFYSX3P6JSg8D2X4hfDjvRVWoh3DMWg4sSA0/i3G468NP8xqeC1il0EY
         aNOf1UpLMO1OshNFP5CyCyoxkWdbNd8AGjstg+W6bNiO6ZjyND8jKx+T44p+hWuklbMX
         vfxIPTHgLi+OS+9Jlze+fERZlSx/eMUTaNTr7apsMWnZa9xhi6llW1cDw3wKhIXdAFhA
         JUudHBZzTlwC1cFJof12m6P9Dd3J2I/lh28hp41TUyaAxpc5pvduWgeqFKKCbEvZaXxr
         PTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvINO3Dqf9GYw5Bbhf3syQ8zjJwNC62ESu6hTyzUQHk=;
        b=Rx92kS3AGwRkXBtDKeGlTouUwagx5ziGtrpRTEgaD/hG5GS7RTrbh/gN9oRN4Yw4Ik
         7LDa1ST2nprDzB5ivq1kgQf2NmbS0YVPWdsBJ8nDvHEpusyo3Vek25DQYKy3kzf6Rn0u
         vzKG1sF3VaGR3BiTRp66U2qMdeZFmZwXw9Z07tFinxwBhnoMPgCEymmL7HAwx5LWy+As
         PwvhCy9K9nuoCI4xTKGtoYyLjlzk+QUCDMBuP8zthHIGXUYyxJupZ7EotOG5So2q0ES7
         H54z/ZOriAfsvQX/TcgVXIalRAQd9n502wLHc/o4/BUZl2FeFN46+NwTcey+tbqyvcxf
         p2cA==
X-Gm-Message-State: AOAM531QRb8NWF1uDt7cxzjm1biCCnaK/99iM2t2cUi5QOi+vJNYvB+1
        S3lbGYVSQip+XkN01p84sKGD7CrBYq/quXbiEAwVSA==
X-Google-Smtp-Source: ABdhPJx3yEHwPtUa4CJiRrMcQkDBsqs+InrhswAse6y2TIsInAwCPF+xZ/4dHIEewdl/VfA7LgKaTunmltKF2gY/1aE=
X-Received: by 2002:a2e:818e:: with SMTP id e14mr2682466ljg.226.1612777710918;
 Mon, 08 Feb 2021 01:48:30 -0800 (PST)
MIME-Version: 1.0
References: <1611915427-3196-1-git-send-email-sumit.garg@linaro.org> <20210208094303.csu2kkyi25d7a25y@maple.lan>
In-Reply-To: <20210208094303.csu2kkyi25d7a25y@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 8 Feb 2021 15:18:19 +0530
Message-ID: <CAFA6WYNDydeDg8J16tFC30=yXCDMeaMKOm0Jt-3yF5jUMCq0yQ@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Simplify kdb commands registration
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 at 15:13, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Fri, Jan 29, 2021 at 03:47:07PM +0530, Sumit Garg wrote:
> > @@ -1011,25 +1005,17 @@ int kdb_parse(const char *cmdstr)
> >               ++argv[0];
> >       }
> >
> > -     for_each_kdbcmd(tp, i) {
> > -             if (tp->cmd_name) {
> > -                     /*
> > -                      * If this command is allowed to be abbreviated,
> > -                      * check to see if this is it.
> > -                      */
> > -
> > -                     if (tp->cmd_minlen
> > -                      && (strlen(argv[0]) <= tp->cmd_minlen)) {
> > -                             if (strncmp(argv[0],
> > -                                         tp->cmd_name,
> > -                                         tp->cmd_minlen) == 0) {
> > -                                     break;
> > -                             }
> > -                     }
> > -
> > -                     if (strcmp(argv[0], tp->cmd_name) == 0)
> > +     list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> > +             /*
> > +              * If this command is allowed to be abbreviated,
> > +              * check to see if this is it.
> > +              */
> > +             if (tp->cmd_minlen && (strlen(argv[0]) <= tp->cmd_minlen) &&
> > +                 (strncmp(argv[0], tp->cmd_name, tp->cmd_minlen) == 0))
> >                               break;
>
> Looks like you forgot to unindent this line.
>
> I will fix it up but... checkpatch would have found this.
>

Ah, I missed to run checkpatch on v3. Thanks for fixing this up.

-Sumit

>
> Daniel.
