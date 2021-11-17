Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7D454721
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhKQN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbhKQN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:26:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:23:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so11359443edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imMPR7cXMIidqV0ZrvPxmvYtF6t4Y+7SizbVbeAu/0g=;
        b=UGueTOqOi0bGnjqT3KX/n3fKnhDJCLXWfE5YiiD9pj+zrN1t41LBPNxgYACoT9+Pj9
         xE0wdHhWidSFOOW6DnJIFGDp3IBFyyU0aUE8aQc+3WBA7oFfQy3YSUaFHFaiUygF02dI
         Q0/j6jxNZ9grl2JCEPl+LumVP1eg0S4+avce5KVmwhokCEMCshtPC1YEHFLdBAlI2TSt
         okzxW8s1mNG4Lk1BAQCcT6Swsr/XVrhbuxQzz5Piysy0ZxG/QS8y1Bt92oEhB+B2GxES
         PTpaneVvPZ7lqn54EN4jS6l4ASJVYbdc/vF+erkuNWc6m/KKKiqL5L3n89r4MNf5/Qib
         FnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imMPR7cXMIidqV0ZrvPxmvYtF6t4Y+7SizbVbeAu/0g=;
        b=ZXLl2ievP9noKbPhy4EuI6bvoW6iMLNYc9xGxp3mfkKW21fLTAwSJEnkqY23T8djBf
         pzcNnZ8O0Lu8hfsPg9xxL80vuSxBv/cRLL1Cvzwx2/Dpz99NYpvsiIJD6NQ+dFKNdhx2
         LVSpf54x0+yz4mIutmD5abCYNar1aa60wJyF0X999hCWEigO0LkbLzFRRyVp72SdhlFb
         fPtGa+6i8gjfPr6rrjFy0et4skUXMCBEAP2SJLfUdGyeu37LYaK9ii5gFo4UJ47+bDly
         raZjvAHAqTYak1qPdjna/tW2/D4Gjs0UM5lAZOPK9jixFT4826IeUxo+nf0/LjTj01YC
         aAxg==
X-Gm-Message-State: AOAM530ibEzie4ZU72f8qB8hpOBooZ7UFNlh1WA9W+Fwy1T5isth/8q7
        JSXQe4ej6xCpdnXnWbAzhMzSGvp5o118KYHK3OweEbdqNT4=
X-Google-Smtp-Source: ABdhPJymsXYwuWgeUV54h9/f77Vf8wo9Mmy0QX2ZDW2Uhh6xgstO3OTc5u+eA1DzwIz3Mi7xVGLvoR9PS/Qun2UxrIk=
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr21582905edz.307.1637155409031;
 Wed, 17 Nov 2021 05:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com> <20211111172340.fpn4pou2xwm654g5@maple.lan>
 <CABdtJHtDbTXLPKHQiFCAVPmJ16e1TuOtyCWU9PtUMSKhWvfa-w@mail.gmail.com>
 <20211112173153.7kdx3dptlif2tqbk@maple.lan> <9d4ef51d-ffc7-6025-c70f-f48bddc9af23@nxp.com>
In-Reply-To: <9d4ef51d-ffc7-6025-c70f-f48bddc9af23@nxp.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Wed, 17 Nov 2021 14:22:52 +0100
Message-ID: <CABdtJHsroGYe9Q7WdwusjG7Ac8_RNT+E0DbQCOo_VzZqkWdiLw@mail.gmail.com>
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>, leoyang.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 2:07 PM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
>
>
> On 11/12/2021 7:31 PM, Daniel Thompson wrote:
> > On Thu, Nov 11, 2021 at 06:36:58PM +0100, Jon Nettleton wrote:
> >> On Thu, Nov 11, 2021 at 6:23 PM Daniel Thompson
> >> <daniel.thompson@linaro.org> wrote:
> >>>
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

This wasn't needed prior to 5.15, both are needed now. I have not bothered
to bisect what caused it, since we have a proper solution that just needs
to be merged.  Then we won't need any kernel arguments.

-Jon

>
> ---
> Thanks & Best Regards, Laurentiu
