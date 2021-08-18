Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD823F074C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhHRPAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbhHRPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:00:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6340C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:59:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o2so2521429pgr.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBgoBWZ1Nj5av7VhKX9E+2duoDv+qmChdEi2w6LtlvU=;
        b=r3lXDwsqVpzCbwrLVj0t1BPGIqrau9mGcpVCpLgjbbnJIpyqRObCCTeHdmP4xkc65q
         zKNkkkEGCGppUmAM64SksrZt4ccxCakfQCuRSUMwHEg0b4Bk9w4vcE314SeoYKOXmsK4
         lJojPQYIVwkKvrUVfMST0N9ZfsxnYKemqhNa2CTLvgwTx3teygWBXYu71KdDf7fLq0zP
         kEIqrY41bNHC6x+iWGwbgcUSqUiWw77KI+GQXv40wqOvKzzL0++dq+VGOxiE4awGtKQV
         HfoAxyM5LKVN9Ghw3geZ4uH7FyEQYC8fCm+qByxioCZ+aU6JIT7GuETzcNwYfShplY8b
         xGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBgoBWZ1Nj5av7VhKX9E+2duoDv+qmChdEi2w6LtlvU=;
        b=DLo4iF9+OtzhfqkXiRvhAhOZH5aiL4iesuaDjCtBVX/KJtiFCjd3GJZEii3NbbPxZp
         QFvAVHC93MMN50A33AnCLfyY1WMgXWgd52bWmORvQI2Cyc+hHLAt7IuUD9/ytEnZAizE
         j2pQkPMIz1V1NLYOEDQWSYgDZokxXNqT0cdZTDn8sUpFZYvziwBHvTmMcIBdtvnLUBE5
         Xz7VLZklBOwPeN5suu9e+o5c4Qrle+yUmCMnur+y5GxEXdQDKjKeMBeph6X28k1xSjLe
         s6kE/bN0OzTb+L/jkgdZ2IuY/m+k7LCmGMA46AXsjTYCgGDBLaCn/xeRaUs67Rm7P06s
         GamQ==
X-Gm-Message-State: AOAM531yjRbbmuxo1Myis19D1nA/dkVRazo5V4Qpnqq2soE9QaQNdKtk
        Q4dkQ7UX5MQLNiIiCO2fryRYS17EIzZXwEfFM23gdJDEcDgTwg==
X-Google-Smtp-Source: ABdhPJwXDA/RU3SgFGIGZf73vkhszMMBN089VDmiusykFqaL07LtRIpSGnrZKMdg45ppW2cbOPZwLYzE/SLt70DkATM=
X-Received: by 2002:a63:3c7:: with SMTP id 190mr9167314pgd.240.1629298786167;
 Wed, 18 Aug 2021 07:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com> <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com> <20210818134814.GF4177@sirena.org.uk> <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
In-Reply-To: <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Aug 2021 07:59:35 -0700
Message-ID: <CAPcyv4hWNk-avNOPdWBNND9Bd9nebzs2A4Weveqy289gM+A1Bw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] driver core: export driver_deferred_probe_trigger()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 7:52 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> >>> The issue is that the driver core is using drivers completing probe as a
> >>> proxy for resources becoming available.  That works most of the time
> >>> because most probes are fully synchronous but it breaks down if a
> >>> resource provider registers resources outside of probe, we might still
> >>> be fine if system boot is still happening and something else probes but
> >>> only through luck.
> >
> >> The driver core is not using that as a proxy, that is up to the driver
> >> itself or not.  All probe means is "yes, this driver binds to this
> >> device, thank you!" for that specific bus/class type.  That's all, if
> >> the driver needs to go off and do real work before it can properly
> >> control the device, wonderful, have it go and do that async.
> >
> > Right, which is what is happening here - but the deferred probe
> > machinery in the core is reading more into the probe succeeding than it
> > should.
>
> I think Greg was referring to the use of the PROBE_PREFER_ASYNCHRONOUS
> probe type. We tried just that and got a nice WARN_ON because we are
> using request_module() to deal with HDaudio codecs. The details are in
> [1] but the kernel code is unambiguous...
>
>         /*
>          * We don't allow synchronous module loading from async.  Module
>          * init may invoke async_synchronize_full() which will end up
>          * waiting for this task which already is waiting for the module
>          * loading to complete, leading to a deadlock.
>          */
>         WARN_ON_ONCE(wait && current_is_async());
>
>
> The reason why we use a workqueue is because we are otherwise painted in
> a corner by conflicting requirements.
>
> a) we have to use request_module()
> b) we cannot use the async probe because of the request_module()
> c) we have to avoid blocking on boot
>
> I understand the resistance to exporting this function, no one in our
> team was really happy about it, but no one could find an alternate
> solution. If there is something better, I am all ears.

Additionally you mentioned that the consumer is unknown to the
producer, so you are not able, for example, to use the newly exported
device_driver_attach() to directly trigger the unblocked dependency.
