Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899144547E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhKQOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKQOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:02:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FA2C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:59:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p18so2299732wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4RgxcUPfeMTUGCX5zi8mbfvzvc0s4xnTuI7eYhjn3qs=;
        b=Rqju6ON0WYjNlNKdfQr9kwbgxDUQmHQX2fksyXtnCVL/TI8CjI0mI1Ofi1EbcuWUzR
         XBhRwJ3afBsbkesHkHziubNruRD8fmJ9NVZfEUkDJblM2PSx+l9iAQLDH0hTPzcn/J1T
         S1OxmePY0tYtg4M4yu93FY2wHItrl/x/L/ipPmQX7YRWIDg3wpPcqxrrEhF0Fv1M8UTM
         Bt75jiltCE36xigAfPbQD4W9SbXmcF4AgCeUxgxQ9lBcG2Z8fhefwD9vP0fypAkRRebu
         V4xKZ1vyj1GWUhO+CrBWYPeDbw9bjEQgN6+FzELQ60IZ4CrjtAekl3jZhKjZ26bIdgq4
         xl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4RgxcUPfeMTUGCX5zi8mbfvzvc0s4xnTuI7eYhjn3qs=;
        b=tp+WQta/3VdGo3IShOVQWqOFiG/XWTIPtYuzeIhD0tXBmHduPxbuj/YfTb08bDA5W5
         eDFEbvk0fi5xG/IKh4/AsN+i5DNaSE/6Dn8x3c7lMHuASzoVrhZeVTYK7qiFodTW1fbe
         QPL2ugMG5QpRKuhnDFvjeU4bBjtOie6VSFJv7/X2DfHjzqoVpyAFYRdk34DUvIjHSQBj
         6Bt8QePwvnisG0juWq/EBHcSfLWMEAup8rHL0LnxvOrrPJ5pNr3BjYgbLZgHUY7o6Yke
         en6hA/w2D+mkxyn6idsGjB2KZnd0s9xh1euijzXj3OKqKU7d4uO2pUBFZAY0xs7YYg+1
         sarg==
X-Gm-Message-State: AOAM530JboV+b6Mv51i75LgrRvOzsntAh0r/5dGCkmgpc8r0iisDcnCo
        2qZcKU2g2Ii8BS3YU5sjysEZMBR51v6uvKdU
X-Google-Smtp-Source: ABdhPJyFgxzXUdjWbkEpWdszMwuyfjz+KXvA2UuEMf7AvJug5rQZk+sy8bhhW2hp+GuAEdUG3ZNokQ==
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr18038565wms.144.1637157552560;
        Wed, 17 Nov 2021 05:59:12 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id d9sm20338973wre.52.2021.11.17.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 05:59:11 -0800 (PST)
Date:   Wed, 17 Nov 2021 13:59:09 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Jon Nettleton <jon@solid-run.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>, leoyang.li@nxp.com
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
Message-ID: <20211117135909.uf3pnhjorllnhcxp@maple.lan>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com>
 <20211111172340.fpn4pou2xwm654g5@maple.lan>
 <CABdtJHtDbTXLPKHQiFCAVPmJ16e1TuOtyCWU9PtUMSKhWvfa-w@mail.gmail.com>
 <20211112173153.7kdx3dptlif2tqbk@maple.lan>
 <9d4ef51d-ffc7-6025-c70f-f48bddc9af23@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4ef51d-ffc7-6025-c70f-f48bddc9af23@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 03:07:51PM +0200, Laurentiu Tudor wrote:
> On 11/12/2021 7:31 PM, Daniel Thompson wrote:
> > On Thu, Nov 11, 2021 at 06:36:58PM +0100, Jon Nettleton wrote:
> >> On Thu, Nov 11, 2021 at 6:23 PM Daniel Thompson
> >> <daniel.thompson@linaro.org> wrote:
> >>> Hi Laurentiu
> >>>
> >>> On Thu, Jul 15, 2021 at 05:07:12PM +0300, laurentiu.tudor@nxp.com wrote:
> >>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>>
> >>>> ACPI DMA configure API may return a defer status code, so handle it.
> >>>> On top of this, move the MC firmware resume after the DMA setup
> >>>> is completed to avoid crashing due to DMA setup not being done yet or
> >>>> being deferred.
> >>>>
> >>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>
> >>> I saw regressions on my Honeycomb LX2 (NXP LX2060A) when I switched to
> >>> v5.15. It seems like it results in so many sMMU errors that the system
> >>> cannot function correctly (it's only about a 75% chance the system will
> >>> boot to GUI and even if it does boot successfully the system will hang
> >>> up soon after).
> >>>
> >>> Bisect took me up a couple of blind alleys (mostly due to unrelated boot
> >>> problems in v5.14-rc2) by eventually led me to this patch as the cause.
> >>> Applying/unapplying this patch to a v5.14-rc3 tree will provoke/fix the
> >>> problem and reverting it against v5.15 also resolves the problem.
> >>>
> >>> Is there some specific firmware version required for this patch to work
> >>> correctly?
> >>
> >> This patch was merged as a requirement for operational on board networking.
> >> This was merged as a prerequisite to landing the patches to support MDIO and
> >> phy initialization in general.
> > 
> > Interesting.
> > 
> > I assumed the change of behaviour comes from properly handling
> > -EPROBE_DEFER (which can hardly be regarded as a fault with the patch).
> > 
> > Having said that the patch does not seem to be mandatory to get the 1G
> > networking working on Honeycomb LX2 (running ACPI). By taking v5.15 and
> > reverting as I shared previously, I am still able to access the network
> > using the 1G port on the back of the unit (although I didn't do any
> > performance tests).
> > 
> > 
> >> The correct solution for the problem you are seeing is the ACPI
> >> maintainers figuring out how to land the IORT RMR patchset.  Until
> >> that is done the only workaround is setting "arm-smmu.disable_bypass=0
> >> iommu.passthrough=1" on the kernel commandline.  The latter option is
> >> required since 5.15 and I haven't had time or energy to figure out
> >> why.  The proper solution is to just land the IORT RMR patchset and
> >> let HoneyComb run with the SMMU enabled.
> > 
> > Thanks for the update. I'll probably adopt iommu.passthrough=1 for now.
> > That allows me to adopt a distro kernel when it updates to v5.15.
> 
> The "iommu.passthrough=1" kernel arg shouldn't be needed. By chance, do
> you remember what errors were you seeing? What was failing?

For all testing of v5.15 I had "arm-smmu.disable_bypass=0" set because I
was guided to enable that by the error messages in older kernels ;-) .

Anyhow without "iommu.passthrough=1" (and without the patch from this thread
reverted) then the logs are being massively spammed with error messages:

~~~
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm_smmu_context_fault: 1697259 callbacks suppressed
~~~

This results a relatively simple workstation (LX2 + nVidia GT-710 + USB
for networking) becoming unresponsive. How long to fail is a little
unpredictable. I assumed that the weight of such dense log messages
eventually gets into a timing pattern that prevented any useful
interrupts from being serviced... but that is only a guess.


Daniel.
