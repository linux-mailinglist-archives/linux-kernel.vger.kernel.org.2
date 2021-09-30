Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA99941E365
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 23:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhI3Vf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhI3Vf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:35:57 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1128C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:34:11 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id az15so9069590vsb.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQIn9LX0/6lHimAU3PxpL2fMOSQNHbXs6F/RXNLFXYg=;
        b=oJ/7MvU56rxaxIVOdg/A1WWldVM4n9wx545WRI7M7df3LdbdPdSBUVlxzQV+mf7Ttf
         ye5lWn7DB+vIoniNgDq6lC/4yhZnM85dzIe2QjupxlaH/E8wIW6shVO97j5rNSRuXb4k
         pvnCljnY+hYR1zE+Y8W5809s5Ha3TthaMStVviIxJpRGwg5E7xLjuI4cCXcBkw6ERILe
         ord7VA/U5odnAXxslk9JfsPRXtIapOPjUrGrtlxwHG+tvzy9Y+I3a+1AJoOBL2watR2S
         2htt5THGTnSkc8AGffCdz8Y23SDRCFXnYJ2N93BzNgnwbv3mBb93hepjga98LvaG63Eo
         R8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQIn9LX0/6lHimAU3PxpL2fMOSQNHbXs6F/RXNLFXYg=;
        b=ktmQUbxfF5JtVMX4X/jJ9aZTZ3uqZ/5EdEWYNPIg7qRyARPFFUrEEKvoqqOONx6deb
         uBqLDYQjdpWVasOAC4tfqvS+f/52mUHUZ+MfLJKJrlmB0TQa2g6RIc+E8dfOWHQhGj8s
         WPP7uEeW2ITYG2vfPRxiGeXUSpz3i3665r3L8js/02Evu8NqU7RdIK0Zdk9EIe2Ql7LI
         j50ItvmKi5BrNAeJJiYT1WAsv+DMq1XmoiuG6KuHoIMauJundlr1AB/UgyRNsJKyG2aE
         0/+iQoL7ywaxzqfrN3MS1CatZdxVqf3WOgicS0XfQCFR8iDPExbpsX8c5aQFn0f9pdtf
         rfYQ==
X-Gm-Message-State: AOAM531uGpX4pgMrshl5TUwQbvde/JGgCCBSVC3QAaV7Es08sXMUNMK3
        MIZZrYObEc3LxdzDlu9TsFHy7ADPOrfbe6t6dhT4vKIe
X-Google-Smtp-Source: ABdhPJzoyY37wBHrQ6EtlYNw2hIMCyJ9w8N0E2BHxppP5Tkj5WYXbgAO0fFusDz2EMpmIf5huFoz/dUwUred9vctjOo=
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr1600895vsk.11.1633037651036;
 Thu, 30 Sep 2021 14:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210929183735.6630-1-jim.cromie@gmail.com> <YVVTxZDkGUk7dGLp@kroah.com>
In-Reply-To: <YVVTxZDkGUk7dGLp@kroah.com>
From:   jim.cromie@gmail.com
Date:   Thu, 30 Sep 2021 15:33:44 -0600
Message-ID: <CAJfuBxxhoEs6z+HQ-ts55TbzfuVvxh=YPtEjqnqB6ZOOgiiMBw@mail.gmail.com>
Subject: Re: [PATCH 0/6] dyndbg updates for 5.15-rcX
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 12:06 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 29, 2021 at 12:37:29PM -0600, Jim Cromie wrote:
> > Hi Jason, Greg,
> >
> > Heres a set of "maintenance" patches distilled out of other work.  Its
> > almost all tweaks to verbose output, except for 1st, which changes a
> > strcmp to == because its true, and useful going forward.
> >
> > Jim Cromie (6):
> >   dyndbg: recode for stronger precondition
> >   dyndbg: show module in vpr-info in dd-exec-queries
> >   dyndbg: rationalize verbosity
> >   dyndbg: use alt-quotes in vpr-infos, not those user might use
> >   dyndbg: vpr-info on remove-module complete, not starting
> >   dyndbg: no vpr-info on empty queries
> >
> >  .../admin-guide/dynamic-debug-howto.rst       |  2 +-
> >  lib/dynamic_debug.c                           | 47 ++++++++++---------
> >  2 files changed, 26 insertions(+), 23 deletions(-)
>
> Are these real bug fixes that have to get into 5.15-final?  They seem
> like 5.16-rc1 patches instead.
>

not real bug fixes.
I thought maybe theyre low-risk enough, maybe on rc1+, but I was late.
I'll try to hit the window right for 5.16



> thanks,
>
> gre gk-h
