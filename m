Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3778341D12E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347727AbhI3B5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347699AbhI3B5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:57:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F54DC06176A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:55:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u7so3524768pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppSjAe5S3xlWKT7s8el3Il5gQkJrN0MmdVf0E/AP7Gc=;
        b=ydGPiSJNMnM7op/wkyAmXwGCpbqUNFYUHuTIB1J9VMHKIEt0sSU7kMooEJf9ONRPIA
         1epCxOZbM0aS2EhNFY6KaCCjZUa3fkU0LWjAEDekFcojleEFYbUWcOuBjLnFNrOYEP0b
         mA+QtRVrgb+QVIzp8Q6gIPM6zutuAF5hBMmH4psZDUSy/atAm1KGSsMtdvT9RYXwFNoC
         0OxTcAvRXaSSlv2eJGo5aW5AjIbbmaejIHX929b6XcPXwpNZj92Vz8XUEuL92z5RkXVg
         41hSRYzrA1jBcQMejxi5WxXv4SfKoIIdMc6rLHA0kQZZpePX/R7ifabPflyujG0OznzI
         tNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppSjAe5S3xlWKT7s8el3Il5gQkJrN0MmdVf0E/AP7Gc=;
        b=pWxtFC2QEPA++oMdkxHi0+9+TI4Db+aPJJfULNiQ4wIfS/3AsxC/FSFJBe1Oo5KMIR
         1VYXp2iFKA45w6RnGLZhzs5ED8XhInD8TmRW98Sf1JFrdQTv2SD3tNZXA2hxoHzoD1Rs
         HbUiGbtn2CKe/K14MyYOopsZE9NcRuYRPnCq2nT/vhzpnEGvjn6LkSIAHkzpvTl9Km/t
         wwIS4kgjolDz42LPDSQNXGcFgbkHumYsRSx1Cw65g8nKOBBbEa/mnFD8EJZY9nsnXeZH
         mxJvr2TfK+IctU8FcuVI4lYIWx6q4iogtcm5wVBSWXVEEI8pydv663hR9UjcsK+PBuIQ
         MeQw==
X-Gm-Message-State: AOAM532/tqRSJiohspV0Qq1QgiUePHlC3LLlsVBA4ETOfyo8PXwoA9Nf
        epdbDvl/BkKCr7N32BxIDZUwV63lvFxsJoi/aBvIyw==
X-Google-Smtp-Source: ABdhPJxRCE7JDiUtfbj2unJgpoYL58Y7cUzTX2X/PJ4QmiFOuX+rJGY6EYObim88lDm7ERTzm39OsGnRXceY8UTFM6A=
X-Received: by 2002:a63:d709:: with SMTP id d9mr2624751pgg.377.1632966921696;
 Wed, 29 Sep 2021 18:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com> <20210930014229.GA447956@rowland.harvard.edu>
In-Reply-To: <20210930014229.GA447956@rowland.harvard.edu>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 29 Sep 2021 18:55:12 -0700
Message-ID: <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 6:43 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Sep 29, 2021 at 06:05:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > Currently bus drivers like "USB" or "Thunderbolt" implement a custom
> > version of device authorization to selectively authorize the driver
> > probes. Since there is a common requirement, move the "authorized"
> > attribute support to the driver core in order to allow it to be used
> > by other subsystems / buses.
> >
> > Similar requirements have been discussed in the PCI [1] community for
> > PCI bus drivers as well.
> >
> > No functional changes are intended. It just converts authorized
> > attribute from int to bool and moves it to the driver core. There
> > should be no user-visible change in the location or semantics of
> > attributes for USB devices.
> >
> > Regarding thunderbolt driver, although it declares sw->authorized as
> > "int" and allows 0,1,2 as valid values for sw->authorized attribute,
> > but within the driver, in all authorized attribute related checks,
> > it is treated as bool value. So when converting the authorized
> > attribute from int to bool value, there should be no functional
> > changes other than value 2 being not visible to the user.
> >
> > [1]: https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Since you're moving the authorized flag from the USB core to the
> driver core, the corresponding sysfs attribute functions should be
> moved as well.

Unlike when 'removable' moved from USB to the driver core there isn't
a common definition for how the 'authorized' sysfs-attribute behaves
across buses. The only common piece is where this flag is stored in
the data structure, i.e. the 'authorized' sysfs interface is
purposefully left bus specific.

> Also, you ignored the usb_[de]authorize_interface() functions and
> their friends.

Ugh, yes.
