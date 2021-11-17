Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399B2454919
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhKQOtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhKQOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:49:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DED8C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:46:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z200so2477682wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hRF+BgcDUiadc0hJeVF27opRetxHYdrgA6l/XdmMrO0=;
        b=rEKr9QmcXAJ0wf6vrpHhwlh1BW6jvBDqpQSHD5dTknVkBRfl5rH8/tPAQ49uXujIQi
         YguyDJiZ45k7i9n6ZJnaw4Ba5g7M75jvcKNOtIleWPvqzzDnSdidTU2bq8vcIFRwXkrF
         7KLicR7lSjxvw0y35+LiLo+Lmw0hM/n9NP/SwiNZEKPQBsJDC1dm9HWTxaPM3Ml8Uqkz
         tWofXtyWF187fnb8NujfXWVY+h92zgYbl38FikjHRu60QoOh6Xg/r84h41KP94qCgfIV
         41jqU/5NIfPPQzBb6j41cXIdL31zu3jphITIGI1rbTxfzewCEmjvWPSd5as2+iPKvpoh
         BgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRF+BgcDUiadc0hJeVF27opRetxHYdrgA6l/XdmMrO0=;
        b=fplBJxeE6INJ+Vx/eLXyVsLZMNMvHuJ7BOQXOjiXdxfidAPPfu4EQ1wK4QlurCY+UL
         gUt8K5qlQr0+ntuBiZ6Y0MYFLepa6NGf5xcr/oU9y5V+juFx2LgEaWwHWCGMiEdRQiFE
         +sC6YAIPhSGpVM/LQJU4NatqjX8lLrgk4li06+8S4QsnR1OVxAgejfrfwwBoKgZscnJM
         w/r9+QcV6j8u8BAW8AhqyC3+VKq6Ia33fnDdmWxccREANlCmLJO4wOTr9sifbpStGCPB
         MLp4Jo9Up+4tWqa7WZ6FNuWmlymD1N/Wlg0mWuymW0MvYIg8+cOFQf2ceQSxTh8Ayx2b
         p7Uw==
X-Gm-Message-State: AOAM531eWErv9bEOIjHVjMhW34wft7h1HthsMVnugAYdwZp8kRxWBR+T
        GD5ph9jD9FYI3bxGwD90NKUkeg==
X-Google-Smtp-Source: ABdhPJy0QKi/nqZxBMgNpeuX0B9rlzCEk7hgxcr/b6ppRvlTL4/JOKpqldFaS051NoOLIz2csFpogA==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr263769wmj.84.1637160399103;
        Wed, 17 Nov 2021 06:46:39 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id k27sm6687777wms.41.2021.11.17.06.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:46:38 -0800 (PST)
Date:   Wed, 17 Nov 2021 14:46:36 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
Message-ID: <20211117144636.tu4lbkfs5mlwktnt@maple.lan>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com>
 <20211111172340.fpn4pou2xwm654g5@maple.lan>
 <a61c7240-f053-e0a4-c4ce-f93241f7181a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61c7240-f053-e0a4-c4ce-f93241f7181a@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 03:03:04PM +0200, Laurentiu Tudor wrote:
> Hi Daniel,
> 
> Sorry for the late reply, please see some comments inline.
> 
> On 11/11/2021 7:23 PM, Daniel Thompson wrote:
> > Hi Laurentiu
> > 
> > On Thu, Jul 15, 2021 at 05:07:12PM +0300, laurentiu.tudor@nxp.com wrote:
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> ACPI DMA configure API may return a defer status code, so handle it.
> >> On top of this, move the MC firmware resume after the DMA setup
> >> is completed to avoid crashing due to DMA setup not being done yet or
> >> being deferred.
> >>
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
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
> 
> That's pretty strange. Was the DPAA2 based networking working with this
> patch reverted?

I think so. I haven't studied the LX2K architecture too heavily but I
assume the 1G networking socket at the back of Honeycomb LX2 is DPAA2
baseD? If so, that 1G socket works with the patch reverted.

Note that I was already using "arm-smmu.disable_bypass=0" on this platform
since I was guided into doing that based on the error messages from
older kernels. It was only the new requirement to set iommu.passthrough
that caught me out.


> > Is there some specific firmware version required for this patch to work
> > correctly?
> 
> It's a bit of a long story. As Jon already mentioned, we're waiting for
> maintainers to agree on the IORT RMR support on which we depend to
> declare in UEFI reserved memory regions for the MC firmware.
> For now, the recommended workaround is to use the
> "arm-smmu.disable_bypass=0" kernel boot arg.

I see. Looks like, after the traffic on the ML in October, that this
patch set is pending a v8 revision in order to stimulate the next round
of discussion?


Daniel.
