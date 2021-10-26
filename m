Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93743AFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhJZKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234341AbhJZKOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:14:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B331560F9D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635243148;
        bh=twrEZLaMQ0NQoCzo2RcNtw2B3HV4CRBdcZESaF0y5vM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cR2F+cnIKrktpQUAzLsfHB6BXbILar4x2e9b75eQ2zHBr6L2Gr6ogd/6FigHJdJ/2
         vmxFG4iTJ1hXtysqUIxZ21CMo82kybjGApX/tQR93aPo8/Og3Bl8dcozPAR2BPEoil
         ywxrNnCUhIS6XWsFICLnggrHq0S7TBBMlI51Nss5E9AokD4lQpu6I5J+FCqDZHac0z
         xubwGeH7Ue1YvxPXp86beNbzfVpn2TyiFKmSK9qISK8y/v0dueyI7ad2SGsSVuhCji
         Qv/vvqjCUSEApdyLdl7ZHoyFIyZBJxTELdlm4au3w3zxs75pyLDMnXndRYnY1mxNEp
         +SFLmZ/hiQrpA==
Received: by mail-ot1-f50.google.com with SMTP id y15-20020a9d460f000000b0055337e17a55so19048576ote.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:12:28 -0700 (PDT)
X-Gm-Message-State: AOAM533+sVpD9X8aAuPE6dEYC/UYGJ9UQhzHrfxTCW/eeZx3M2as78UL
        XQ0F8aM8E5toett3R37Q9pv2mxZewUujCULQUEY=
X-Google-Smtp-Source: ABdhPJxWhWUpE09/MAv3e+SdRVbqsguP9WIglwlV482PiU5HlsSMZnddzE6zwneIubMeQ6uAmUvRmtncZKhdaxtd0kY=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr18303620otg.147.1635243147991;
 Tue, 26 Oct 2021 03:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
 <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
 <YXfDdmrCynZk/QW8@shell.armlinux.org.uk> <cddc3cd6-a36d-e02f-4cd8-26ff15e72d13@windriver.com>
In-Reply-To: <cddc3cd6-a36d-e02f-4cd8-26ff15e72d13@windriver.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 26 Oct 2021 12:12:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEyc0S6A_OQRQOTtTFxev=Kj55Zhn2dRDaZ6FP+Ek=17w@mail.gmail.com>
Message-ID: <CAMj1kXEyc0S6A_OQRQOTtTFxev=Kj55Zhn2dRDaZ6FP+Ek=17w@mail.gmail.com>
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
To:     Quanyang Wang <quanyang.wang@windriver.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 at 11:53, Quanyang Wang <quanyang.wang@windriver.com> wrote:
>
> Hi,
> Sorry for the inconvenience.
>
> On 10/26/21 4:59 PM, Russell King (Oracle) wrote:
> > On Sun, Oct 24, 2021 at 11:44:31PM +0200, Linus Walleij wrote:
> >> On Wed, Oct 20, 2021 at 7:50 AM <quanyang.wang@windriver.com> wrote:
> >>
> >>> From: Quanyang Wang <quanyang.wang@windriver.com>
> >>>
> >>> Not only the early fixmap range, but also the fixmap range should be
> >>> checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
> >>> some systems which contain up to 16 CPUs will crash.
> >>>
> >>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> >>
> >> Looks reasonable to me.
> >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> Please submit this patch into Russell's patch tracker.
> >
> > ... and has totally broken what looks like _all_ ARM kernel builds.
> This patch is intended to trigger build error when it check the value of
> __end_of_fixmap_region is equal or larger than 256.

Why? The fixmap region is larger than one PMD, so why do we need to cap it?

> In fact, it breaks the ARM kernel builds which NR_CPUS is equal or more
> than 16. If CONFIG_DEBUG_HIGHMEM is enabled, all ARM builds which
> NR_CPUS is more than 8 will fail.

You really need to be more specific about the failure mode here.
