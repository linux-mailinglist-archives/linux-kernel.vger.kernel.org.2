Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BDA3E8995
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhHKFHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:07:05 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:49664
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234105AbhHKFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:07:04 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id BC67C3F36D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628658399;
        bh=TotvfBcP1kbMjZh8i1BQ1gZcG+xBW5bAWGmpNSwCNpM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=MaxgNhH5g/cUUNLHZHshJ2LxVqSOKLnzT8XA/oZ/Ngqh3z8S+wdTHTjne6m1tUBBv
         fWQHusnVTW7iWjY5Kufd3Qt1RGwmm44EREuTxyRGQwtxSwy1DlPls8mtUvWYVfJsl5
         tNI/PGIOxhmPuXNCPrwXxP5vGQ0fabuk+AD5lRaFwC+BzFFUwC0dfNl9IHWMY9xLF3
         Da2XWANv/Z/HCgRLhqd+zpK2ARSAahZrDux251hOt7kUFfnsNqnHA6uvWBxnyv177L
         TLDwJrYiovUF3XYAtejaD19yCQqJ+nvt9SPOYz/Ar7z7+MuOxy6CZ7mGZt8txXfx7D
         VnSHnS14mFg+A==
Received: by mail-ed1-f70.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso614776edh.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TotvfBcP1kbMjZh8i1BQ1gZcG+xBW5bAWGmpNSwCNpM=;
        b=IYrSCdQVYlrTwAumnaOAPdtIrJkLfNG/F6fQSdvOI6GLG7hHnxgTSqynQu8Lard4Rn
         nT5iP28hrPDjz5M0SF8ZgHknS+cSbMC5Ey5UeArg2loDxoeXDDgAp+szdC94UBzQWzAO
         WMTubFF8qIv1Ev+ZZapI7Bb6lEskCojh/NOG1wrol/EejG8VHXsJxDSAu4fMkA07MboF
         D3Fz7sX2W35wVbIocSYqZeMP4aYgQ6dyi74XCWVT4SB/lfZbrCvAOmFC/pqEioqC1xpp
         /o6nWDtKD/zDxP1DbecLe4nrejEmITlr8OaJH++ssE6/ExgMVaZeVlb1OIhz/tOFhUAH
         SQPw==
X-Gm-Message-State: AOAM530LxYRvl9Vii/jZXK8jk0Cx8oFk7/chsiO8doeyJAcvbIAjTkA4
        iwdUMLqi19rErglNfmn0mWWrAXCUIxXR3/UIdib+NXHw4izRRaxZXZQPGxJI9Bp2OguitrUQgPY
        IcrGx1tsGvUUpBcemo791U/1db7zgLBDcWY5LAJDdE7Ao0pWLTJRABnr9NQ==
X-Received: by 2002:a17:906:1fd5:: with SMTP id e21mr1818193ejt.78.1628658399261;
        Tue, 10 Aug 2021 22:06:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjbceDaG+3OstRYpbet+P/X5bEXCCmLxZKIkHr9viaPkg/A8aTiHo8F16CG0uSfno2K4R1xAFbim0uYcXs4JM=
X-Received: by 2002:a17:906:1fd5:: with SMTP id e21mr1818176ejt.78.1628658399029;
 Tue, 10 Aug 2021 22:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <20210809042414.107430-1-kai.heng.feng@canonical.com> <20210809094731.GA16595@wunner.de>
 <CAAd53p7cR3EzUjEU04cDhJDY5F=5k+eRHMVNKQ=jEfbZvUQq3Q@mail.gmail.com>
 <20210809150005.GA6916@wunner.de> <CAAd53p7qm=K99xO1n0Pwmn020Q7_iDj2S6-QGjeRjP0CpSphTg@mail.gmail.com>
 <20210810162144.GA24713@wunner.de>
In-Reply-To: <20210810162144.GA24713@wunner.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 11 Aug 2021 13:06:27 +0800
Message-ID: <CAAd53p7bMm5KyjXvUOTevspm9e0mtPP2KWoq5xZSWng8q1kGPg@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Disallow runtime suspend when waekup is
 required but PME service isn't supported
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:21 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Aug 10, 2021 at 11:37:12PM +0800, Kai-Heng Feng wrote:
> > On Mon, Aug 9, 2021 at 11:00 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > If PME is not granted to the OS, the only consequence is that the PME
> > > port service is not instantiated at the root port.  But PME is still
> > > enabled for downstream devices.  Maybe that's a mistake?  I think the
> > > ACPI spec is a little unclear what to do if PME control is *not* granted.
> > > It only specifies what to do if PME control is *granted*:
> >
> > So do you prefer to just disable runtime PM for the downstream device?
>
> I honestly don't know.  I was just wondering whether it is okay
> to enable PME on devices if control is not granted by the firmware.
> The spec is fairly vague.  But I guess the idea is that enabling PME
> on devices is correct, just handling the interrupts is done by firmware
> instead of the OS.

Does this imply that current ACPI doesn't handle this part?

>
> In your case, the endpoint device claims it can signal PME from D3cold,
> which is why we allow the root port above to runtime suspend to D3hot.
> The lspci output you've attached to the bugzilla indicates that yes,
> signaling PME in D3cold does work, but the PME interrupt is neither
> handled by the OS (because it's not allowed to) nor by firmware.
>
> So you would like to rely on PME polling instead, which only works if the
> root port remains in D0.  Otherwise config space of the endpoint device
> is inaccessible.

The Windows approach is to make the entire hierarchy stays at D0, I
think maybe it's a better way than relying on PME polling.

>
> I think the proper solution is that firmware should handle the PME
> interrupt.  You've said the vendor objects because they found PME
> doesn't work reliably.

The PME works, what vendor said is that enabling PME makes the system
"unstable".

> Well in that case the endpoint device shouldn't
> indicate that it can signal PME, at least not from D3cold.  Perhaps
> the vendor is able to change the endpoint device's config space so
> that it doesn't claim to support PME?

 This is not an viable option, and we have to consider that BIOS from
different vendors can exhibit the same behavior.

>
> If that doesn't work and thus a kernel patch is necessary, the next
> question is whether changing core code is the right approach.

I really don't see other way because non-granted PME is a system-wide thing...

>
> If you do want to change core code, I'd suggest modifying
> pci_dev_check_d3cold() so that it blocks runtime PM on upstream
> bridges if PME is not handled natively AND firmware failed to enable
> the PME interrupt at the root port.  The rationale is that upstream
> bridges need to remain in D0 so that PME polling is possible.

How do I know that firmware failed to enable PME IRQ?

And let me see how to make pci_dev_check_d3cold() work for this case.

>
> An alternative would be a quirk for this specific laptop which clears
> pdev->pme_support.

This won't scale, because many models are affected.

Kai-Heng

>
> Thanks,
>
> Lukas
