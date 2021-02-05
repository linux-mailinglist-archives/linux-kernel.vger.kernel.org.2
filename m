Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD0D311A00
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhBFD0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhBFCm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:42:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB11C08EC63
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:36:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q72so4411612pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c5JPFuMfSk0p/DYjLQXzqCeRqsMAJt+xoGt9eJd6O9o=;
        b=XNrkFV7hR1zDtMPWmy2ge+vMrcaUXRlcxRTLhZ+fys99T+CZGC+DgKB0xexkUCzy2t
         xAOdxCeZSn4vXFXOL7565btR9oh2H2cqwHwnpLBFY3MWO6BvsyEbLjEqObljb/mgERFJ
         H1PZxtHyZTlhfXiVz4LTVlwVco8BPprGjX6I5zbnPR77qBNANVC/nEGT9osvqHK8OvDU
         wdCsuEwk+V24NJjtdG8ZlB8Ttwxi9duZ8d909YPZVr+LdLWH2Jj6K6NAv0j1vxu1A4Zr
         placymNWQHAf9RG/N/iQ2L2IhRxifCZa7DNbl5mYIIN78Z9BXTQRVolJc/TO2HxIjcaG
         JBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c5JPFuMfSk0p/DYjLQXzqCeRqsMAJt+xoGt9eJd6O9o=;
        b=IAGg2/Eja7gEsCBIexGG3YtpvIQY6fI3wW7PFR29N7k740JB7g1dFmFzYM8JXXp6/J
         UMfs2e0X7o/VBYlljU6W8wlwkkB8qCVwJ+prQGtbTAYmoQ5MnUXunM+IAuVMurH9EmPe
         YDDS9/i/mTKoUBfU+aNnmph/dOslcLQrJBKuP6gsnl7RAoeVK6hniYVNKasqlygtJFWb
         FtLU5/OKcxP3108M5cOieNfRi4i8+1oYXue+o8X25nF0coWxK7sQ+XuPKnbSK+8HhfkA
         mMJzAnqycY+QbkCunXiUmG5mB5ez4wh/QoeBMHGgtMjpwLtyJlBTlo+A/TQ8YwqM6izU
         nIfw==
X-Gm-Message-State: AOAM531v+HeOpOvw32ywCCoXY9ai9hOYznF242rcRtCQdh9XsAU+l1T6
        89EreCKEj9Fq5zOkHkrbYe+CX4yU6Ro=
X-Google-Smtp-Source: ABdhPJwVh8zI4/mrx1vTSrH8IilN4/EyID+ieED1x4L3e0nnrZnXiFEQFMMmrsliviQhv9qInJbJNA==
X-Received: by 2002:a17:90b:33ca:: with SMTP id lk10mr6084442pjb.186.1612564613947;
        Fri, 05 Feb 2021 14:36:53 -0800 (PST)
Received: from localhost (g186.222-224-165.ppp.wakwak.ne.jp. [222.224.165.186])
        by smtp.gmail.com with ESMTPSA id 6sm10429671pfz.34.2021.02.05.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:36:53 -0800 (PST)
Date:   Sat, 6 Feb 2021 07:36:51 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] openrisc: use device tree to determine present cpus
Message-ID: <20210205223651.GL2002709@lianli.shorne-pla.net>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
 <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
 <20210131212752.GG2002709@lianli.shorne-pla.net>
 <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
 <20210205144317.GK2002709@lianli.shorne-pla.net>
 <CAMuHMdXzr4c4=Cg1_Lmw41cmxmMrG4P=dV0yVjuXvuR5pqyh0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXzr4c4=Cg1_Lmw41cmxmMrG4P=dV0yVjuXvuR5pqyh0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:07:51PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Fri, Feb 5, 2021 at 3:43 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Mon, Feb 01, 2021 at 12:49:31PM +0100, Jan Henrik Weinstock wrote:
> > > Use the device tree to determine the present cpus instead of assuming all
> > > CONFIG_NRCPUS are actually present in the system.
> > >
> > > Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> >
> > Hi Jan,
> >
> > I cannot apply this patch, it seems you somehow sent it signed as a multipart
> > message via Thunderbird.
> >
> > This causes errors when trying to apply, even after I tried to manually fix the
> > patch mail:
> >
> >     Applying: openrisc: use device tree to determine present cpus
> >     error: sha1 information is lacking or useless (arch/openrisc/kernel/smp.c).
> >     error: could not build fake ancestor
> >     Patch failed at 0001 openrisc: use device tree to determine present cpus
> >
> > Can you send this using 'git send-email?'
> >
> > If not I can get it applied with some work, otherwise you can point me to a git
> > repo which I can pull it from.
> 
> "b4 am 6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de" works
> fine for me.
> 
> git://git.kernel.org/pub/scm/utils/b4/b4.git

Did it work?  For me I got, base not found.

    Looking up
    https://lore.kernel.org/r/6dbc27f8-5261-59c5-acba-70f6c6a74ba1%40rwth-aachen.de
    Grabbing thread from lore.kernel.org/lkml
    Analyzing 9 messages in the thread
    Will use the latest revision: v2
    You can pick other revisions using the -vN flag
    ---
    Writing
    ./v2_20210201_jan_weinstock_openrisc_use_device_tree_to_determine_present_cpus.mbx
      [PATCH v2] openrisc: use device tree to determine present cpus
    ---
    Total patches: 1
    ---
     Link:
    https://lore.kernel.org/r/6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de
     Base: not found
	   git am
    ./v2_20210201_jan_weinstock_openrisc_use_device_tree_to_determine_present_cpus.mbx

-Stafford
