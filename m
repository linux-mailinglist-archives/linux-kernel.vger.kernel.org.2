Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF0641F461
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355667AbhJASL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbhJASLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:11:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B948C06177E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 11:10:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y5so6838371pll.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KFuOrTMhH3SQsw1rM/3FEXg4ao/BGYA5Ilqe0th6JM=;
        b=NDbfA3XjG5EhuNjh+dRar041dNJzw1gWHW6t+j97IW2pEjdJSk+YfuCAkrm4fDmjkO
         0pVPJaITMLoKmUdk6x7lCcT+oIBj+ETmUCSbdmpCdzHtL5l7zoz7tIvrGEfpKbPxiIYu
         /+P6IplqX3kirO8xwKxQmGhFDwpB3qeScSFXJVTc2it/D+aS3MMDemWs535izc/INWUw
         nUzYVdFPjGWsRtC7OdTOPI5KlsLMhNqOMT55cuSSJ3jFhvPS84t3GqwTqBxu514MA6C1
         M425dYCXlqS0TK5NPkHcYAR+SwVvSNx3oDZqFPnKdEA9d5B8B2pAY67LX+y0krOYYvOx
         +gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KFuOrTMhH3SQsw1rM/3FEXg4ao/BGYA5Ilqe0th6JM=;
        b=MQd2QBphLSaSq3vkHsVL18KphGWIwq3NYSwz7OzNGU6MHO2bUBd7znS+I9LZhwGQNN
         D0lSEryQSZpP8dafEDoVCweVFMLp8IqbXnxfWZZ+Z8Dp/wCZE6hlgRSOhMF+9EeffG/w
         nHl/m7sIZEpsYJyH3NPW8AWwrtO1c5pzRl1l1U4KUW+h6ffahutC3sXCnfywvekNoM/+
         U59rb1RfiRey/5v9EWF2Y2mXrztCUBk0NjCVF5KPvsLc0oJLCo3CaSfidadsZZX42WMN
         Jf58MKedF2U8PgWH+xjU+yokCPoKInc9B4l1fXZgqPJi6BFEr4kJi5i7smAmrlpKcDBT
         m6uQ==
X-Gm-Message-State: AOAM533ce/syPwduqJoDv66AuD/hUHXdQ4id70Qmgp/Hg8uO1/hcie2X
        KRgPW2bvg/OtWdnnapC6OHtQWmHr0C5hlS03oLJagQ==
X-Google-Smtp-Source: ABdhPJxhssf74vi65MJPjZjUi4lYRyXsEkvUbEqnuapdQ7I4PrjXBFhCptKglUzo8lM7g8GATcVf+T3EH0hIEL6uJtY=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr14704315pjb.220.1633111802704;
 Fri, 01 Oct 2021 11:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org> <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com> <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com> <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com> <20211001164533.GC505557@rowland.harvard.edu>
In-Reply-To: <20211001164533.GC505557@rowland.harvard.edu>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Oct 2021 11:09:52 -0700
Message-ID: <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
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

On Fri, Oct 1, 2021 at 9:47 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Oct 01, 2021 at 09:13:54AM -0700, Dan Williams wrote:
> > Bear with me, and perhaps it's a lack of imagination on my part, but I
> > don't see how to get to a globally generic "authorized" sysfs ABI
> > given that USB and Thunderbolt want to do bus specific actions on
> > authorization toggle events. Certainly a default generic authorized
> > attribute can be defined for all the other buses that don't have
> > legacy here, but Thunderbolt will still require support for '2' as an
> > authorized value, and USB will still want to base probe decisions on
> > the authorization state of both the usb_device and the usb_interface.
>
> The USB part isn't really accurate (I can't speak for Thunderbolt).
> When a usb_device is deauthorized, the device will be unconfigured,
> deleting all its interfaces and removing the need for any probe
> decisions about them.  In other words, the probe decision for a
> usb_device or usb_interface depends only on the device's/interface's
> own authorization state.
>
> True, the interface binding code does contain a test of the device's
> authorization setting.  That test is redundant and can be removed.
>
> The actions that USB wants to take on authorization toggle events for
> usb_devices are: for authorize, select and install a configuration;
> for deauthorize, unconfigure the device.  Each of these could be
> handled simply enough just by binding/unbinding the device.  (There
> is some special code for handling wireless USB devices, but wireless
> USB is now defunct.)

Ah, so are you saying that it would be sufficient for USB if the
generic authorized implementation did something like:

dev->authorized = 1;
device_attach(dev);

...for the authorize case, and:

dev->authorize = 0;
device_release_driver(dev);

...for the deauthorize case?
