Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B164344F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 08:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJTGNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 02:13:39 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36422
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhJTGNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 02:13:38 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2A300406E1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634710283;
        bh=1Pwbto3xzDOuj9AdmGAawkkhjI3NOhcoDznc6EjuA4E=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=TV6/5zrABAxI7gQxS83/Nk+2lL1HQB7BRGC0eYminhVl5tQW0jxNHw6arMvHACJJ4
         WwSArGpnJRO2pZrlgCSLdBduPnLd1U6ow6wPZ/2I0WudKeLykajGMq9sFnZ3SC1j1W
         IafoLvBZO0yLXZxe1dp5rNkqFlc520kZHt9iT8VSWwx30Mo4iDTsL0Fmj9KyhkvslU
         s8qCdKDwoQIrQw9Tz98FC8k+8D46f0nJlKZlfMhtgnH4sgjNG/pcALydwsxsPuskwr
         K5fuCYUlHruHLAIAnTqx/aKUqllnmtvIH1BH97GE3n9UNdm48BflTQlmE/9gOfbVIT
         2Oh7chBAoJFzQ==
Received: by mail-ed1-f69.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so19924673edv.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 23:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Pwbto3xzDOuj9AdmGAawkkhjI3NOhcoDznc6EjuA4E=;
        b=HrTmgMJH9amkklOz173jA2uB+T9X9xTDTEwtPMOKbPc7E2kS4rKoC0sxNS38iDQrcO
         7VTxxUCry3GPwmJOZ9klFZmmgn1ZwO0uXjU50PDC5VplcDfwA2qAdHyflBWOhL419Yo1
         hQiYjXZEVmSwc/RhS3jeSJAJr1JZ74eGlD0zQtYssYtdudbcJXVOQcMY4RtoBEqbgwbY
         +9ePkG1U/k73PYCCFKhmM2LXKBK9T7QpeA+Sfp1qbWuf+chcbBjuXefcD7Ji0OnhF7G7
         lcCo3b52N8HSsdRCJOL64uzb0vITWCA5+agzkoBseOrOCbHzfRT36MiFFESjTWdvrOkl
         WrHA==
X-Gm-Message-State: AOAM532HO9byOYzL7SoQ6JBmUuTwaRc095gmhN6kfsaaBO6RCBvz3Fgr
        zKg2bKLt8oKCik5ZtWJFnPY/jM6hcMCBwmzcnxrZA6Dq0LsYdPyupvMI2ZC+tFQ9Si3Er8uAfQg
        PAxm79KlZJjvwcKGEy/upBpAqVYNLuWGFXe+B+LvI1g==
X-Received: by 2002:a50:9d49:: with SMTP id j9mr59027132edk.39.1634710282865;
        Tue, 19 Oct 2021 23:11:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy3CpnuvgbkTXuc9O1L/YV9fI7tJfyLLF6gi248jNNmlGukEUPfWeAFLRbyb7gPAFDmncXDQ==
X-Received: by 2002:a50:9d49:: with SMTP id j9mr59027121edk.39.1634710282707;
        Tue, 19 Oct 2021 23:11:22 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id e7sm573903edz.95.2021.10.19.23.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 23:11:22 -0700 (PDT)
Date:   Wed, 20 Oct 2021 08:11:21 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
Message-ID: <YW+zCbaf1Xb8lBMo@arighi-desktop>
References: <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop>
 <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
 <YWPjZv7ClDOE66iI@arighi-desktop>
 <CACT4Y+b4Xmev7uLhASpHnELcteadhaXCBkkD5hO2YNP5M2451g@mail.gmail.com>
 <YWQCknwPcGlOBfUi@arighi-desktop>
 <YWQJe1ccZ72FZkLB@arighi-desktop>
 <CANpmjNNtCf+q21_5Dj49c4D__jznwFbBFrWE0LG5UnC__B+fKA@mail.gmail.com>
 <YWRNVTk9N8K0RMst@arighi-desktop>
 <CANpmjNMXNZX5QyLhXtT87ycnAhEe1upU_cL9D3+NOGKEn-gtCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMXNZX5QyLhXtT87ycnAhEe1upU_cL9D3+NOGKEn-gtCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 08:00:00AM +0200, Marco Elver wrote:
> On Mon, 11 Oct 2021 at 16:42, Andrea Righi <andrea.righi@canonical.com> wrote:
> > On Mon, Oct 11, 2021 at 12:03:52PM +0200, Marco Elver wrote:
> > > On Mon, 11 Oct 2021 at 11:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > On Mon, Oct 11, 2021 at 11:23:32AM +0200, Andrea Righi wrote:
> > > > ...
> > > > > > You seem to use the default 20s stall timeout. FWIW syzbot uses 160
> > > > > > secs timeout for TCG emulation to avoid false positive warnings:
> > > > > > https://github.com/google/syzkaller/blob/838e7e2cd9228583ca33c49a39aea4d863d3e36d/dashboard/config/linux/upstream-arm64-kasan.config#L509
> > > > > > There are a number of other timeouts raised as well, some as high as
> > > > > > 420 seconds.
> > > > >
> > > > > I see, I'll try with these settings and see if I can still hit the soft
> > > > > lockup messages.
> > > >
> > > > Still getting soft lockup messages even with the new timeout settings:
> > > >
> > > > [  462.663766] watchdog: BUG: soft lockup - CPU#2 stuck for 430s! [systemd-udevd:168]
> > > > [  462.755758] watchdog: BUG: soft lockup - CPU#3 stuck for 430s! [systemd-udevd:171]
> > > > [  924.663765] watchdog: BUG: soft lockup - CPU#2 stuck for 861s! [systemd-udevd:168]
> > > > [  924.755767] watchdog: BUG: soft lockup - CPU#3 stuck for 861s! [systemd-udevd:171]
> > >
> > > The lockups are expected if you're hitting the TCG bug I linked. Try
> > > to pass '-enable-kvm' to the inner qemu instance (my bad if you
> > > already have), assuming that's somehow easy to do.
> >
> > If I add '-enable-kvm' I can triggering other random panics (almost
> > immediately), like this one for example:
> 
> Just FYI: https://lkml.kernel.org/r/20211019102524.2807208-2-elver@google.com
> 
> But you can already flip that switch in your config
> (CONFIG_KFENCE_STATIC_KEYS=n), which we recommend as a default now.
> 
> As a side-effect it'd also make your QEMU TCG tests pass.

Cool! Thanks for the update!

And about the other panic that I was getting it seems to be fixed by
this one:
https://lore.kernel.org/lkml/YW6N2qXpBU3oc50q@arighi-desktop/T/#u

-Andrea
