Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE239358C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbhE0Sng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 14:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhE0Sne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 14:43:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E63C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 11:42:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v12so387646plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d1AeJ9/gNVsTtvN2qECAkyXI8rVDI/CqksiB5fl3ybk=;
        b=B4qXEwXmzmeTSALermnFpFJ+a4UZnn5jllh0AlqRAWIBYiq2mu9Lj70/JjD2giFqdD
         8tWAfZ84vTwi3fCobJm5tWMo0jv1S9nyVbL3l83cYQdmbAJxCGC4ObCIDZ00LHQWDK9z
         ZQPNmdlzZMcK8uq6h+8eiNhjhck3cTQJ5m73Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d1AeJ9/gNVsTtvN2qECAkyXI8rVDI/CqksiB5fl3ybk=;
        b=qASPO/11X3If/YG11X3VLdHwCDsX3xkl0sz0II0Fwn5UiztNk0Ah8epEpNJEy9UoQq
         RYOCXEUJvUmXllSFmi0tSLtU3v83l2wXo5koRvUfjqBM/TGV6qUzqZ7x9uwesTCVdPDp
         hpL1fNJH0UexIUAuQfy6u3VdsNqAKwSt5zf/5HNw6FHXLpVVVadcQglx504hK59ANksz
         rcBy4v0+yhtROo6+vJVLTqVM8qoSlUocl7hG5oz4a5QIR0/GkZoTmOl4PoxghH2XVbUP
         o696gw+bjy5L9QYjGcrplfkdHi3QthVWxzV4qJPiRHR66ybuTUz392FhGSDazKtxBpHk
         1hBA==
X-Gm-Message-State: AOAM532MHk8kwMGzSBDIaBx37qthFAbhoS8+P9oXC6rg8qHtNw7s0Bvk
        C2rTNCZqtEi0clpsox0Th4ZZXw==
X-Google-Smtp-Source: ABdhPJxQduWPg6ci6PcaE0oz61tWY1a8YLe1VwviN+Ynnc5WIrUgXukNTar0zVfG3f0haLSqXK9X3A==
X-Received: by 2002:a17:90b:ed5:: with SMTP id gz21mr5404377pjb.102.1622140920615;
        Thu, 27 May 2021 11:42:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n69sm2570517pfd.132.2021.05.27.11.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 11:41:59 -0700 (PDT)
Date:   Thu, 27 May 2021 11:41:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rodrigo Campos <rodrigo@kinvolk.io>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>, Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v2 2/4] seccomp: Refactor notification handler to prepare
 for new semantics
Message-ID: <202105271137.C491991621@keescook>
References: <20210517193908.3113-1-sargun@sargun.me>
 <20210517193908.3113-3-sargun@sargun.me>
 <CACaBj2YUiowSKzvh02OjpQNqQViA8N0eyRMimkK=90NagRF40w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACaBj2YUiowSKzvh02OjpQNqQViA8N0eyRMimkK=90NagRF40w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 01:51:13PM +0200, Rodrigo Campos wrote:
> On Mon, May 17, 2021 at 9:39 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > This refactors the user notification code to have a do / while loop around
> > the completion condition. This has a small change in semantic, in that
> > previously we ignored addfd calls upon wakeup if the notification had been
> > responded to, but instead with the new change we check for an outstanding
> > addfd calls prior to returning to userspace.
> >
> > Rodrigo Campos also identified a bug that can result in addfd causing
> > an early return, when the supervisor didn't actually handle the
> > syscall [1].
> >
> > [1]: https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/
> >
> > Fixes: 7cf97b125455 ("seccomp: Introduce addfd ioctl to seccomp user notifier")
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Acked-by: Tycho Andersen <tycho@tycho.pizza>
> 
> Kees, as I mentioned in the linked thread, this issue is present in
> 5.9+ kernels. Should we add the cc to stable for this patch? Or should
> we cc to stable the one linked, that just fixes the issue without
> semantic changes to userspace?

It sounds like the problem is with Go, using addfd, on 5.9-5.13 kernels,
yes? Would the semantic change be a problem there? (i.e. it sounds like
the semantic change was fine for the 5.14+ kernels, so I'm assuming it's
fine for earlier ones too.)

> Just to be clear, the other patch that fixes the problem without
> userspace visible changes is this:
> https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/

I'd prefer to use the now-in-next fix if we can. Is it possible to build
a test case that triggers the race so we can have some certainty that
any fix in -stable covers it appropriately?

-Kees

-- 
Kees Cook
