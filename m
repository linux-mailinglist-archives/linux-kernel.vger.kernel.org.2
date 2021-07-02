Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97E73B9DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGBIxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhGBIxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:53:53 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43574C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 01:51:21 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id b2so10535561oiy.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbPxvu3NmB2z0+Y/UKqhW4DpRcr/7LUWF7NaploBKiY=;
        b=g25azOrQxK05y8GRoMOZ+brcEx47mkcPMDJpvFXSyPuG3DFIItFa0fY3sE+mixpaVM
         ws+joTgnwsvcrFjC6noqzghYqyjApLTZf3/GR8fpmhPRBepsgZlXCGzzTzpiQL8gPjXe
         fnMwrTok4oukOf/UFv6IpM2uO5IJ3hn1t5IK+TQTyMLXEJzjnxjh6Sl9jPj5Bjj7glXm
         YGGskCsDUjCqolu/ZsbHGqSQPW43Wv+9O2Ui00PyBlyUwGkGEW1hSlIliznPfxEcWbT2
         WxNonKgDlH2gwU7OekOq+F8AXT2NvkSnK0AggHowz4Y/P1Z/E1HvUOauPgrjYC6kBDno
         DW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbPxvu3NmB2z0+Y/UKqhW4DpRcr/7LUWF7NaploBKiY=;
        b=nNNkPEGskL8Fu79aGzGOAzw/q9aSaxSfg+qX9jfor6qCr7XHYk2S+ln5DweerLvaUT
         QUwOomR4715Cpw3AQqfnq9I3fYBoakF7rgNPcNauIDf4L9vV7NfdJBe1b2EJgTL6Cn3x
         mbi1IPHxAGOPC0rX1g1DPXQekFNA3uP6GhiuevCieAxOIRaKCFHQDKKtvq/5/HlNZ9zs
         gzcm1GejUOCsPvmelHyGLQxJ3RDirHjoByrpSOWUkOyCfXGrfPXnCjgDiRV0uEjeZwFs
         S2bb+dUXxV1NfAvN3Gs413lIfV7GhYK5fLPAG8pw+/oNmjnd5l2rng7vuI6QqehAqHAh
         A4Cg==
X-Gm-Message-State: AOAM530GoZtLvzEBmX5kouXA8bmP7RQ6BkPXd1TjD/nFLkG+dpd0NqXU
        WhsBzqkIG+woqVLB/3U477p4AJqYDBjpAiMChc5BMQ==
X-Google-Smtp-Source: ABdhPJympXWi8Ppuk567NBcohD0mgz01KaWIVKIBQyPdKE6YubE7I55ijr5HkmI+QxdfkyM3G3QCDTahgXwb8SBr2eM=
X-Received: by 2002:a05:6808:7c8:: with SMTP id f8mr3011976oij.121.1625215880431;
 Fri, 02 Jul 2021 01:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190734.624918-1-elver@google.com> <20210429190734.624918-3-elver@google.com>
 <20210526174217.GB19898@willie-the-truck> <CANpmjNOOW6-8su=VNipvb7ztQ0TdF9THn+yeWepz7D7BAL418Q@mail.gmail.com>
 <20210526182937.GA20055@willie-the-truck>
In-Reply-To: <20210526182937.GA20055@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Fri, 2 Jul 2021 10:51:08 +0200
Message-ID: <CANpmjNN6D7MQJN5oDuLzmG3wxuFvc-ORBoHPLPhWo+f6cOH2cA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: Add compile-time asserts for siginfo_t offsets
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 at 20:29, Will Deacon <will@kernel.org> wrote:
> On Wed, May 26, 2021 at 07:50:41PM +0200, Marco Elver wrote:
> > On Wed, 26 May 2021 at 19:42, Will Deacon <will@kernel.org> wrote:
> > > Hi Marco,
> > >
> > > On Thu, Apr 29, 2021 at 09:07:34PM +0200, Marco Elver wrote:
> > > > To help catch ABI breaks at compile-time, add compile-time assertions to
> > > > verify the siginfo_t layout.
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > >  arch/arm64/kernel/signal.c   | 36 ++++++++++++++++++++++++++++++++++++
> > > >  arch/arm64/kernel/signal32.c | 36 ++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 72 insertions(+)
> > >
> > > Do you want me to queue this patch in the arm64 tree, or is the series all
> > > going together via another route?
> >
> > I think Eric will queue them together with a bunch of other cleanups,
> > because as-is these patches are out-of-date as of:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e31f3a38e77612ed8967aaad28db6d3ee674b5
>
> Ok, thanks. I will ignore this then :)

Eric, are these static_assert patches being sent this merge-window
along with the other cleanups?

Thanks,
-- Marco
