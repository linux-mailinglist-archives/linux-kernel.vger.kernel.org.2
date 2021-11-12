Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25EB44EC02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhKLRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhKLRer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:34:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A4C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:31:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so7317864wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wm+5jLpLPmZrf1WlwY6wH3uP/CPvgUOsV/aFaulhYng=;
        b=iy4Fr3eRlUPIev4qrkkMh2iwMbmbv+ZaysC5z5jyG8sNObrOctjYpZIHaJ0Ga9Jgbw
         TE2yI+CKXM6hH5nISknngdEmp8nEs9qj0zOiBetN0lzg5TkC23Wl3BKllqTEAdesbf19
         nN+uF/3cBzvSCjLWHnBC1S61EG9J2RXvXJgQgYvFxurOCy17Bg3a9aVr18/HNG5Cbipp
         Opt0ljQ7fOJOvZN6Z7D1RkYBhqvWVBai3Yqqah1guzNS+e4AsIBKVCBt+/btsOPfs7Tp
         jAz6/jtLf9UNb7KIorbq0WiUvkho/QnYvdywVKoppuNwMtN2Q+zFWecPw1vmNwnmPtOO
         fIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wm+5jLpLPmZrf1WlwY6wH3uP/CPvgUOsV/aFaulhYng=;
        b=r58djrgrFQGX/xekQzma2JLERmjp1we5yBUr/I/84Vtssj8jL98g6Jn51xpMVmsEyB
         BxTFjqD5Mpwmh9RV60lPWFsaO3i56VtqAseSk05AFHY0IFe+SGVAhQjiyJXCDAHowfqB
         MgRsxkEX9EHzRCl31TWxQKoQzvmWsAETjue7eCjDqVnm8RbVq+GebX+K7woq3/LV6l8x
         5xgOuZeN22FVDJpYv1djI6zYT7JXPryEmuWj1azlu1A3G3irnkch0zX9WFCiOSAh272t
         QHGsBJsxMA56wVe915wgjt7TT24x1/qoo4e0h37tWgCFUyArjLoTKVIDVE9NfoF0XyXc
         HAgw==
X-Gm-Message-State: AOAM530kXhu3EwrixU+COUlDEFrFuyTQKgozWd+AY5kXrTNIubszuEcM
        x0EiYgK86IHVaUqTPjyHjJ0duQ==
X-Google-Smtp-Source: ABdhPJwQrlUG0uL+YgowGgUwanoc7Q43jKQ5s7DD79h1qzV7ulQ9mh89/7/0nC/aurFNC+1Z6E4pcA==
X-Received: by 2002:a1c:1b48:: with SMTP id b69mr18466353wmb.103.1636738315207;
        Fri, 12 Nov 2021 09:31:55 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h22sm7879129wmq.14.2021.11.12.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 09:31:54 -0800 (PST)
Date:   Fri, 12 Nov 2021 17:31:53 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jon Nettleton <jon@solid-run.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>, leoyang.li@nxp.com
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
Message-ID: <20211112173153.7kdx3dptlif2tqbk@maple.lan>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com>
 <20211111172340.fpn4pou2xwm654g5@maple.lan>
 <CABdtJHtDbTXLPKHQiFCAVPmJ16e1TuOtyCWU9PtUMSKhWvfa-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdtJHtDbTXLPKHQiFCAVPmJ16e1TuOtyCWU9PtUMSKhWvfa-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 06:36:58PM +0100, Jon Nettleton wrote:
> On Thu, Nov 11, 2021 at 6:23 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Hi Laurentiu
> >
> > On Thu, Jul 15, 2021 at 05:07:12PM +0300, laurentiu.tudor@nxp.com wrote:
> > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > >
> > > ACPI DMA configure API may return a defer status code, so handle it.
> > > On top of this, move the MC firmware resume after the DMA setup
> > > is completed to avoid crashing due to DMA setup not being done yet or
> > > being deferred.
> > >
> > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >
> > I saw regressions on my Honeycomb LX2 (NXP LX2060A) when I switched to
> > v5.15. It seems like it results in so many sMMU errors that the system
> > cannot function correctly (it's only about a 75% chance the system will
> > boot to GUI and even if it does boot successfully the system will hang
> > up soon after).
> >
> > Bisect took me up a couple of blind alleys (mostly due to unrelated boot
> > problems in v5.14-rc2) by eventually led me to this patch as the cause.
> > Applying/unapplying this patch to a v5.14-rc3 tree will provoke/fix the
> > problem and reverting it against v5.15 also resolves the problem.
> >
> > Is there some specific firmware version required for this patch to work
> > correctly?
> 
> This patch was merged as a requirement for operational on board networking.
> This was merged as a prerequisite to landing the patches to support MDIO and
> phy initialization in general.

Interesting.

I assumed the change of behaviour comes from properly handling
-EPROBE_DEFER (which can hardly be regarded as a fault with the patch).

Having said that the patch does not seem to be mandatory to get the 1G
networking working on Honeycomb LX2 (running ACPI). By taking v5.15 and
reverting as I shared previously, I am still able to access the network
using the 1G port on the back of the unit (although I didn't do any
performance tests).


> The correct solution for the problem you are seeing is the ACPI
> maintainers figuring out how to land the IORT RMR patchset.  Until
> that is done the only workaround is setting "arm-smmu.disable_bypass=0
> iommu.passthrough=1" on the kernel commandline.  The latter option is
> required since 5.15 and I haven't had time or energy to figure out
> why.  The proper solution is to just land the IORT RMR patchset and
> let HoneyComb run with the SMMU enabled.

Thanks for the update. I'll probably adopt iommu.passthrough=1 for now.
That allows me to adopt a distro kernel when it updates to v5.15.


Daniel.
