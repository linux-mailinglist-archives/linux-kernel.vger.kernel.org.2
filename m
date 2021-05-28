Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0374A3948B5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 00:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhE1WeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhE1WeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 18:34:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67270C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 15:32:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v5so7095043ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbrsHa/rQMz3BdevUmx8wLV3ihqPlTItaOywe0j/k9E=;
        b=idX417g+x6jiPQOwBGJDlnUAEo09JmsPhMAYuRYmitcN8A130VeL1zBDcQoZd1/Fp6
         2onD5/XnCLhZXuWZkWhLmRk8R4rgHaJP2BW/SYNDUktfK82DUXDLgEjQQttU2nmUU8Xg
         e5ppX/dygP8is9w/IHr06JjTGva8IGhxLjwMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbrsHa/rQMz3BdevUmx8wLV3ihqPlTItaOywe0j/k9E=;
        b=qxJnfoi2lT+Rzv0OEB5tSc2FzHBCBdgF5wjIdfar7yEJQdDBTLClKIVGgQkhzVELeb
         R1J+JkCPtVf+MIuXg3gRa3wVq72UHVWpbH82/3PbDTq9RJkFBeuPAvwDLB9spN2joTuo
         kxmF/kXC7VMRSPZ8QKqSNg25MGwKA+Wd1MToRdXx3b4DJuDqYfdAxg1sOIdnF/n2qx6k
         Hx9G8fnodT/NcZKZ+Doc2xR6utr6ffMFb/f/Xfjf9s4ZQjg9KaAIl2Rl/9dZtZNt09Oi
         pq3YusmiK+Kb4Wo+JCSxa4tXW49g2W83R9uPGNWu96SAN8Y3ErwoiWt1hyeNx1qYbfVE
         N3/g==
X-Gm-Message-State: AOAM531iYdFVN9bEtEnUeZokSzxw5bS0+lG5oDIhJczgRvkD0r4JxvBL
        QGxUVnQ3P+SDDQdVNVIDnr3cU3DNW5b3uKIiPnZ4HG/hgQpzLZKW3TQ=
X-Google-Smtp-Source: ABdhPJzRLaWOCJV49qefgqtgXRstiScihTWBAfCs2EkuxoSRrLUthng2+WJzOtCsDX/F8NWyp1SuZLOukrk0w6yxpp4=
X-Received: by 2002:a2e:b61b:: with SMTP id r27mr8039309ljn.327.1622241151503;
 Fri, 28 May 2021 15:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210517193908.3113-1-sargun@sargun.me> <20210517193908.3113-3-sargun@sargun.me>
 <CACaBj2YUiowSKzvh02OjpQNqQViA8N0eyRMimkK=90NagRF40w@mail.gmail.com>
 <202105271137.C491991621@keescook> <CACaBj2aaDkJwDM8ugR5LxWEOho3nZuHjYLLsth3XYjf39tpaQQ@mail.gmail.com>
 <202105281014.EECE3D3048@keescook>
In-Reply-To: <202105281014.EECE3D3048@keescook>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Sat, 29 May 2021 00:31:55 +0200
Message-ID: <CACaBj2aM0FxsTSeCDu+3tfdBY9-rbPaLA88YW3Fg-ZQDJRGoXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] seccomp: Refactor notification handler to prepare
 for new semantics
To:     Kees Cook <keescook@chromium.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 7:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 28, 2021 at 05:27:39PM +0200, Rodrigo Campos wrote:
> > On Thu, May 27, 2021 at 8:42 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, May 27, 2021 at 01:51:13PM +0200, Rodrigo Campos wrote:
> > > >
> > > > Kees, as I mentioned in the linked thread, this issue is present in
> > > > 5.9+ kernels. Should we add the cc to stable for this patch? Or should
> > > > we cc to stable the one linked, that just fixes the issue without
> > > > semantic changes to userspace?
> > >
> > > It sounds like the problem is with Go, using addfd, on 5.9-5.13 kernels,
> > > yes?
> >
> > Yes.
> >
> > > Would the semantic change be a problem there? (i.e. it sounds like
> > > the semantic change was fine for the 5.14+ kernels, so I'm assuming it's
> > > fine for earlier ones too.)
> >
> > No, I don't think it will cause any problem.
> >
> > > > Just to be clear, the other patch that fixes the problem without
> > > > userspace visible changes is this:
> > > > https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/
> > >
> > > I'd prefer to use the now-in-next fix if we can. Is it possible to build
> > > a test case that triggers the race so we can have some certainty that
> > > any fix in -stable covers it appropriately?
> >
> > I've verified that Sargun's patch also solves the problem in mainline.
> > I have now also verified that it applies cleany and fixes the issue
> > for linux-stable/5.10.y and linux-stable/5.12.y too (without the patch
> > I see the problem, with the patch I don't see it).  5.11 is already
> > EOL, so I didn't try it (probably will work as well).
>
> Oh, btw, may I add a Tested-by: from you for this fix?

Oh, right! Yes. Here it goes so it's simpler to add :)

Tested-by: Rodrigo Campos <rodrigo@kinvolk.io>


Thanks!
