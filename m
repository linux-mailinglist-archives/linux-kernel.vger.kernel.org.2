Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECD73D7C66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhG0RnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhG0RnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:43:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1ABC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:43:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r26so23062558lfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmLHKY9I4CGQfN2ZPpRZEfbaLo1/Jmuu/tBLcFgmWqI=;
        b=O6olwX22wZaWUsVLlewr8wmScUxvy+vMZCDjpljm3H5qjVu7264PITXktbAyTXtOUS
         hr1cmfIFSwNa48+OhbXxWeuZHYXXPiHCdmBO1lRkKCbv+wQBUNIQfqvermJqW8i/bGaC
         Bc46IgoaLMJCEmXoRkZA4l3ChMgHrA+lhE6fFjBCRbbrQRfpZQzRHzsxd5yUHI4AxbdW
         txnqjXIht88WFCDniP3x8Bo05Et6GYugu6w+bbZPzJ++Uwpnm539a94yssyV1hAwNmU5
         VzaE9upKJ4z+Qclyok5OkoPMDoryGIvTOykJxEfFmtSamJrZz6rXNqEwf4hAQq+XGLBF
         rybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmLHKY9I4CGQfN2ZPpRZEfbaLo1/Jmuu/tBLcFgmWqI=;
        b=QNWqG5o5kGnKtEWbRBHjlGDn2i/n00QL+WbuuLA+VIELUQOR7qe3npBzHKpzPreuX0
         /KWmxlQ0+GRSvowQylfjvGhelpDkXcg4WQok8azrncIIfdAm6i7X6KmeV+j4PgDqR55t
         tKE9dQb7jv9MNOzQ+gR6IhTJ3rSQ+aps0b5pPO8N11jXD2IRWkP7fp+Z2glICGlqSAGb
         0mBuEC2Ux8remo4sORjXKN4q33s/FPNX6CFfgepBvlwxKyZfsx5wE+Q/vPNZ4464O223
         +cdXsMyOGOqBwRHB46fA9ztcXPEVJVRYScqZ3EksA0Qb8EwiToaoxxxW8gzyomPaukkm
         D/eA==
X-Gm-Message-State: AOAM532c32T3hwDkNK4MnYUYDFwsrezv+jAH+y/c/ny8yJLVXMr/dGqP
        ivgiFWw5yS8hq7JOqmh0G3sOvLq7Sjkw03GB2I4zSw==
X-Google-Smtp-Source: ABdhPJz8tOIr+r2spv1zjUK0FuqSqK7MIcG28J63mumEoj3kFNmK7+bLge2xGlcf7x7rYa8NRAsMO8vLjpvDZCffFqU=
X-Received: by 2002:a05:6512:3e0c:: with SMTP id i12mr17116556lfv.122.1627407786575;
 Tue, 27 Jul 2021 10:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com> <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
In-Reply-To: <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Jul 2021 10:42:55 -0700
Message-ID: <CAKwvOd=6fcUhDf5WXXZ8xnM-Nt91OyXafD1=kDCMXt_wwix9OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Bill Wendling <morbo@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:39 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jul 26, 2021 at 11:41 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 26, 2021 at 11:15:52PM -0700, Bill Wendling wrote:
> > > On Mon, Jul 26, 2021 at 10:27 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Mon, Jul 26, 2021 at 01:47:33PM -0700, Nathan Chancellor wrote:
> > > > > + Greg and Rafael as the maintainer and reviewer of drivers/base/module.c
> > > > > respectively, drop everyone else.
> > > >
> > > > Odd no one cc:ed us originally, I guess they didn't want the patch ever
> > > > merged?  :(

Oh, I just noticed this patch was part of a series.  Perhaps you ran
get_maintainer.pl on one patch of the series, and used that list for
all patches in the series?  Since these patches are orthogonal (ie.
they don't depend on any order relative to one another; they can go in
separately via different trees and their maintainers) consider not
using a series.  That should save you from having to write a TPS
Report^W^Wcover letter.
-- 
Thanks,
~Nick Desaulniers
