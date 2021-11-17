Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F4A454B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhKQRDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbhKQRDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:03:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7214C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:00:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so2627299wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bcfPmXku1aX7bhhG17iAR3B3fmplfge6zx9JhvFbFfQ=;
        b=BPJa1GZSabHn7Wn4ZeGVGSyZiTvkQgw9x3FtgXbdZma3/zLmbEAYSuFgcRB3mrO6Li
         BHJ/AvFv7NUQimFLa5nQrpTEULSXFpZGNlv3lymXIDnMc28+VxK50JKIUTrH4zZkz832
         hqZAZELKQF0V2XVFY0OxMa2nLA82ECbnqomRFLBaRdVK/m1KJZP6dRGgQYfHxEQwfu//
         hw92Mq2sJB0/JF78AOapLraC81pQm5roejBzd0n2XagCYUCzOrVy4GuGvXssQ/pYvhiP
         /9kD41RUe2zm0jv3lNNwRfLh5po5/AeIXkroUOVQDu4EwSZ1zx+4dtdQDy2JBCF/sDrW
         rN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bcfPmXku1aX7bhhG17iAR3B3fmplfge6zx9JhvFbFfQ=;
        b=N4DBgEzFY5loHisr+ezxQCTf1lwpB5Zo702x3xIYw48rRCPAHWHcrNp4DV/L1PCM1b
         U9eRP9CMzaviULykg76CmHGDvCNZN80B8ZYegzX6IMv21cznZSqj4M5Go8R+TIRuS1jo
         l5xuFN4dGmlu6i+70+j7mC+CPNqOD99KxOkKBdyfKgyevfjcH2SgAe1viRiaFeIYEd+b
         M1eiRNkHBJwiKziZRb8CrTU3a0IDilzvGZD5GfwSCtQPN5RKClZbnTUR/VuR2Mhes2MB
         dC3uvVGygM1Zx5B+DeNQmLw3rWf87GubvcT3uuYMfKXdJ/qik3Nz5DmExYo3wreXHKOQ
         3YRg==
X-Gm-Message-State: AOAM530oiziOmTuRT09sNeAITEmZmE/ga802OypnmWmw9yazCyHEu8Ov
        Pk4Dnt7eEUatVgxcp9uBeFSuEQ==
X-Google-Smtp-Source: ABdhPJw6P0TNCFmtr9NuyoXP+YuA+xfUO3jGgGwyZ6LK2ZktDpYbNLeAWeky0jEnN7GNAro3X8W1Og==
X-Received: by 2002:a05:600c:198f:: with SMTP id t15mr1418891wmq.94.1637168416046;
        Wed, 17 Nov 2021 09:00:16 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m14sm717255wrp.28.2021.11.17.09.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 09:00:15 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:00:13 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Jon Nettleton <jon@solid-run.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>, leoyang.li@nxp.com
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
Message-ID: <20211117170013.otj3gwfqnmvtlxlu@maple.lan>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com>
 <20211111172340.fpn4pou2xwm654g5@maple.lan>
 <CABdtJHtDbTXLPKHQiFCAVPmJ16e1TuOtyCWU9PtUMSKhWvfa-w@mail.gmail.com>
 <20211112173153.7kdx3dptlif2tqbk@maple.lan>
 <9d4ef51d-ffc7-6025-c70f-f48bddc9af23@nxp.com>
 <20211117135909.uf3pnhjorllnhcxp@maple.lan>
 <ef23386b-5b83-a791-e2f0-a72ec610836a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef23386b-5b83-a791-e2f0-a72ec610836a@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 05:30:32PM +0200, Laurentiu Tudor wrote:
> On 11/17/2021 3:59 PM, Daniel Thompson wrote:
> > On Wed, Nov 17, 2021 at 03:07:51PM +0200, Laurentiu Tudor wrote:
> >> On 11/12/2021 7:31 PM, Daniel Thompson wrote:
> >>> On Thu, Nov 11, 2021 at 06:36:58PM +0100, Jon Nettleton wrote:
> >>>> On Thu, Nov 11, 2021 at 6:23 PM Daniel Thompson
> >>>> <daniel.thompson@linaro.org> wrote:
> >>>> The correct solution for the problem you are seeing is the ACPI
> >>>> maintainers figuring out how to land the IORT RMR patchset.  Until
> >>>> that is done the only workaround is setting "arm-smmu.disable_bypass=0
> >>>> iommu.passthrough=1" on the kernel commandline.  The latter option is
> >>>> required since 5.15 and I haven't had time or energy to figure out
> >>>> why.  The proper solution is to just land the IORT RMR patchset and
> >>>> let HoneyComb run with the SMMU enabled.
> >>>
> >>> Thanks for the update. I'll probably adopt iommu.passthrough=1 for now.
> >>> That allows me to adopt a distro kernel when it updates to v5.15.
> >>
> >> The "iommu.passthrough=1" kernel arg shouldn't be needed. By chance, do
> >> you remember what errors were you seeing? What was failing?
> > 
> > For all testing of v5.15 I had "arm-smmu.disable_bypass=0" set because I
> > was guided to enable that by the error messages in older kernels ;-) .
> > 
> > Anyhow without "iommu.passthrough=1" (and without the patch from this thread
> > reverted) then the logs are being massively spammed with error messages:
> > 
> > ~~~
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> > arm_smmu_context_fault: 1697259 callbacks suppressed
> > ~~~
> > 
> > This results a relatively simple workstation (LX2 + nVidia GT-710 + USB
> > for networking) becoming unresponsive. How long to fail is a little
> > unpredictable. I assumed that the weight of such dense log messages
> > eventually gets into a timing pattern that prevented any useful
> > interrupts from being serviced... but that is only a guess.
> > 
> 
> Few comments here:
>  - I'm suspecting that the PCI video card is triggering the smmu faults.
> Would it be possible to give it a try with the card out and without
> "iommu.passthrough=1"?

The PCIe video card does not cause the smmu faults. These still manifest
when the card is removed (and with same IOVA).


>  - the IOVAs look weird to me, they should look something like
> 0xffffxxxxxx or so. Maybe there are issues in the nvidia driver?

I guess there could be, but why would a problem that bisects down to
a change in the fsl-mc-bus initialization configuration alter the
behaviour of the PCIe graphics driver?


>  - Would it be possible to share a full boot log? I'm thinking that it
> would be interesting to see how the devices are allocated in iommu groups.

See
https://gist.github.com/daniel-thompson/07489561f14965fd1af7d5bd4340f54b

It contains three files, all gathered with the GPU removed:

 * Logs from unmodified v5.15 with iommu.passthrough=1 set
   (networking is good).
 * Logs from v5.15 patched with the revert I shared earlier in
   the thread (networking is good).
 * Logs from v5.15 without iommu.passthough=1 set (many SMMU messages,
   networking is broken).


Daniel.
