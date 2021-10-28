Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1690343F1AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhJ1Vc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhJ1Vc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:32:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571CAC061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:29:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so5812873pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lI7dGfxNdfHtUhR3u3dXK1xJCX1P/hNo/ulx2YmiY0=;
        b=Kb6aAKc3DeW4d1csCsIYnL7/SMjsmrZ9mbkFA6rDXkZk0VH0zQQmjE+Ax7IVjCJNqM
         BtyMSJsJ4AJJZpKdlThb2Vpwvpbh4wB+9UI1nA4+6wTjSdvYWLybZ9MNEcvUmd2p0904
         hozxk+hKZ8iV/Y76SVm3CxxB066sbo2r9TgsB+pGNLQejT54MLTcGXzqCb56IVBIROh8
         Tn/+tQcBrF+Y3Czx12EbwkjmFSC+EEoTF8iCOdaZdL4YwQNe/jYbxVt28/K3MPWCul9u
         IEcgWqMpYV+YL14hVDAdR7Hj+TrchTrugDBIEHKNem/iCbzBiRuk40/a3lL5dRC28aXl
         Gmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lI7dGfxNdfHtUhR3u3dXK1xJCX1P/hNo/ulx2YmiY0=;
        b=5w9KuLZbs9HTj/QL4LHn3edAQnGwGcKKZaDwAIg7hQrkoHLZasOKIgxs4d26qQ98+D
         dt3Rdp5yuFIk7bYyg2MU7nqY20oH6vLWzNwHFjiz8gKhyPB3XIhVlwmDvqQV9PdQUGoI
         /ZrEH0V5jq2pkfk9dBDy/FtB0qdxsWE80RCp5UbMViey8eZR7OeCZBfDiHl+ErMB5UHA
         qhxHVcVEFHa8AM+uciMnY0PWDTwADksnPhlj7AOxexPxzyiyuECvLsGoeiOSk/SM7Kyi
         EURk79swXWzbmQC3XwgbXE4lPtsQYZQHmdOZ5AeG62zHgxwzUJGqypqyvrzno/Q7HWxn
         vFag==
X-Gm-Message-State: AOAM530LHzYGKDbkiK7DX/0fYulehF6NnKJFOA+ihLkTjl3GUHZgfFdU
        xJonjHblj2dVX9AhrVW5Ht29vnLzJ/bWxrBP+4qDhQ==
X-Google-Smtp-Source: ABdhPJwMUqFd02KrmdqW470+itKjh/UlDpbY2lEHbZoZcpFM52xUQLiolhnWGvB421lSa2jZttMTjqXDWrcyc7IFMjE=
X-Received: by 2002:a17:90b:1c0c:: with SMTP id oc12mr7162794pjb.124.1635456598625;
 Thu, 28 Oct 2021 14:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211028232345.5ffa43bc@canb.auug.org.au> <20211028091646.15f6e6de@gandalf.local.home>
 <20211029081009.0fd1a83a@canb.auug.org.au>
In-Reply-To: <20211029081009.0fd1a83a@canb.auug.org.au>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 28 Oct 2021 14:29:47 -0700
Message-ID: <CAC_TJvd+RT0dwAHC8wM-CU4P15=7yQObWmJ+DZMCh26Lf-im2Q@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the ftrace tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 2:10 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Steven,
>
> On Thu, 28 Oct 2021 09:16:46 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 28 Oct 2021 23:23:45 +1100
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > > After merging the ftrace tree, today's linux-next build (htmldocs)
> > > produced this warning:
> > >
> > > Documentation/trace/histogram.rst:1766: WARNING: Inline emphasis start-string without end-string.
> >
> > I have no idea what that means.
>
> I assume you need to quote (with '\') the '*' on line 1767 (?).

Hi Stephen,

I also found the problem to be '*' character. I posted a fix at:
https://lore.kernel.org/r/20211028170548.2597449-1-kaleshsingh@google.com/

Thanks,
Kalesh

>
> --
> Cheers,
> Stephen Rothwell
