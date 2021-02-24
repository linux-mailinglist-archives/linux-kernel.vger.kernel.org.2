Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82546323B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhBXLhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhBXLhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:37:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166FDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:36:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id a24so1012785plm.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A65opmwoO6VYBejuJ4GKnMgGt80TykhOAa9Txv3d/fI=;
        b=sz1tIJ5EVnvB4CwUG6Qx6ZWsIW/eRmfEuSZXCtEZGzArEpI3/EcUzgkKErwoV/lAUJ
         ftPVv5GpQpN7cxDzqfU2seVgCS3h4G+yyGcgCZIumBT9KX8HGdUcbkfS3w6GKJ9x72d5
         iQccy74CrYlMHXHsIfcfwEuDVlA1gepPEjgBgu4atlLyEOfoUbVKiqwJUkHEAHoFMVI6
         fltin/tmHeG5h2mASnNggTD7Pwn3lfpgJLQMVQJRJd8rjbfc/z/YBLbuhFDSlbBH+COa
         UMR0bG1yFj2sXk2iHrJiIaDNPxoWZ+O4qmgfOZfjs+9vqppIHfB6iY/tj6p9RZHkXMSt
         PHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A65opmwoO6VYBejuJ4GKnMgGt80TykhOAa9Txv3d/fI=;
        b=DBpDV0o+3/Lp/W4/dGelFeky00BA81E5/7DFS5KDuCmmHT3JUq2TQxkZ+eb3GpZaLf
         ZBIZmpmqB+OMPmkfDKMLc6avJdg1SQBx7wpLqLAMbh8xKmck8Yeab84lrzQEH4pmTVxe
         i35nNsN2V1Vhe5dCyLq2RSRPEciyZHREFw1bBN+rHBoufO9KRwgQ7UJ88wWCVPMIpzoW
         3BtDJUwWevVhWV9ba3lri2wQnWytDegv5w4IcMJ43zxhdWQ6JktippAEPadilF8BHim+
         vt+L/Yu7TidMI6lvcjwhbTeH4DzIfj0FJaXIUMzRUSaX4Md2ZmKMtTUgp8cd0JymppCN
         euaw==
X-Gm-Message-State: AOAM533UOc8ym1NKobYVjBVuGmXFDRT+WGPvxNJjPT9ADf+ieThjcsSL
        krKwKfJA/1KajRtieDMZqnMs6+eTOZiDUqPpH4o=
X-Google-Smtp-Source: ABdhPJytv+1vkeKWGbF/0JXa5yhcGbVNotodnRSE/T3PXXHUb4nbPe3yPAUsj0fb+f2JuZRLuEpO1TpIwAPwVDrvgUQ=
X-Received: by 2002:a17:90a:4dc1:: with SMTP id r1mr4158021pjl.12.1614166597582;
 Wed, 24 Feb 2021 03:36:37 -0800 (PST)
MIME-Version: 1.0
References: <1609738534-14369-1-git-send-email-liang26812@gmail.com>
 <CAG_0j0D9Vhc5F659ZrORLD4vh56MtGK8Zf4V1Ex3nXOjkLL1gg@mail.gmail.com>
 <20210224103944.GQ1463@shell.armlinux.org.uk> <CAG_0j0BmczxbsScvJeoe9eC0JAEExvZY2wLfNCK5=bufBRTmvA@mail.gmail.com>
 <20210224112001.GR1463@shell.armlinux.org.uk>
In-Reply-To: <20210224112001.GR1463@shell.armlinux.org.uk>
From:   liang wang <liang26812@gmail.com>
Date:   Wed, 24 Feb 2021 19:36:26 +0800
Message-ID: <CAG_0j0AwUgh9mYauxvfbQi8iin_cE0iQg2Dzmv--VeaBKKxvKA@mail.gmail.com>
Subject: [PATCH] [RFC]ARM: ftrace: pause/unpause function graph tracer in cpu_suspend()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, penberg@kernel.org,
        geert@linux-m68k.org, rppt@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell

On Wed, 24 Feb 2021 at 19:20, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Feb 24, 2021 at 07:14:54PM +0800, liang wang wrote:
> > Hi Russell,
> >
> > On Wed, 24 Feb 2021 at 18:39, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Feb 24, 2021 at 06:35:47PM +0800, liang wang wrote:
> > > > Hi,all
> > > >
> > > > ftrace function_graph tracer always cause kernel panic on my ARM device with
> > > > multiple CPUs, I found a solution for the problem on ARM64, refers to
> > > > the patch above,
> > > > I was wondering why this bugfix on ARM64 hasn't been upstreamed to ARM,
> > >
> > > Patches get applied to the ARM tree after they've been submitted to
> > > the patch system. If they don't get submitted to the patch system,
> > > then they get buried and forgotten.
> > >
> > > --
> > > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > > FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
> >
> > Thanks for replying,
> > So I refers to the solution on ARM64 and sent my patch on January as below.
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2021-January/628460.html
> >
> > But I haven't got any replies on my patch. How can I get my patch reviewed
> > and submitted to the patch system?
>
> I don't use ftrace, so I'm not the right person to review it - but it
> seems that lots of patches for ARM are left to me to try and review,
> despite me not knowing sufficient to know whether it's correct or not.
> This isn't sustainable.
>
> > Should I resend a new patch to this maillist?
>
> You can try but I suspect the same thing will happen. The only thing I
> can think is if you put it in the patch system and I apply it, if
> someone has a problem with it, they'll shout about it soon enough. Not
> the best way, but I don't see much other option.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
Thanks for answering my question.
I will upload it to the patch system as needed, and see whether there
is a problem
or someone to discuss with.
