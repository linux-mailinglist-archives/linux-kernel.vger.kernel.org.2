Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7CA41DCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351409AbhI3Ou4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349797AbhI3Ouy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633013351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugADMhcG12DXi90Mi9xu4IZCB4uc/XgW9seUM0TOKhE=;
        b=M7kuqrbI3jN1N6yJ0tXmPPTmf3oG5u8yM74P12TyTozLGuH16Ygk+6rvzRX08gL33xnAPQ
        5Y/N2nxr8hOQ5CjUwGSzE+vVN4nWDHoCXytwsylYN0V6hr0qQVoFEV6RDEvzbBgXecKVIa
        q1Q7epZyJXn53ye7Hpu+K6AcK8fXjxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-DFFcmIQMNI2p97PjOt7ANQ-1; Thu, 30 Sep 2021 10:49:10 -0400
X-MC-Unique: DFFcmIQMNI2p97PjOt7ANQ-1
Received: by mail-wr1-f70.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso1755144wra.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ugADMhcG12DXi90Mi9xu4IZCB4uc/XgW9seUM0TOKhE=;
        b=m9eI+RbTK4rlEVksQOR/J4wgSgbGMji1/lsVhECeg3/hzpgu2iDvLU9J8ezy/Eik1j
         xxQITKmuJW+9WIe8j8aiZIs67EsfV85zHK+A5Qy9ITDb9e9M3ZgR8bg73Vd2xwwZADjx
         5L38J0TKuTnaccbAtgJdJp3MaXBUBIauVIN+0PT/5Txpakl2YY4G381zbnv/KD01dHgK
         7MzUFsyiRDYLFG8Y3yNK1dhVh6BcbuBfRZ1EVFDFgwDNSGxrQuus3eTzWzJ/vW93N/A9
         /UKDR7CPX7w2zBH525PeJAQ0PZFdKGNaf7faZnBqxZM206zBIMdqNq1Rh+l72q745abQ
         GxhQ==
X-Gm-Message-State: AOAM533Oi+ZcsFsBpB3VP5i87+MpR8VTqQgbSLKs26Dhj5842lbNo5IE
        CEYLkcX42y/djpEhLeTNogNNt74Bf8MXVeJe/EaRn/ydvt8s7oJn7GRnbrl+yMLH6VV9VkXYnQh
        G+VTKda2jCc5UEFvmbntMKCKr
X-Received: by 2002:adf:9bd2:: with SMTP id e18mr1750463wrc.218.1633013345239;
        Thu, 30 Sep 2021 07:49:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOLlTkV6NaPrivI76QGEXMY+sb/gYn7NFiwzA/bHBOUf/+W/Njis05LJ+J8I0brEkffd7nQQ==
X-Received: by 2002:adf:9bd2:: with SMTP id e18mr1750088wrc.218.1633013340064;
        Thu, 30 Sep 2021 07:49:00 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
        by smtp.gmail.com with ESMTPSA id n68sm4975961wmn.13.2021.09.30.07.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:48:59 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:48:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930104640-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930144305.GA464826@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:43:05AM -0400, Alan Stern wrote:
> On Thu, Sep 30, 2021 at 03:52:52PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Sep 30, 2021 at 06:59:36AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > While the common case for device-authorization is to skip probe of
> > > > unauthorized devices, some buses may still want to emit a message on
> > > > probe failure (Thunderbolt), or base probe failures on the
> > > > authorization status of a related device like a parent (USB). So add
> > > > an option (has_probe_authorization) in struct bus_type for the bus
> > > > driver to own probe authorization policy.
> > > > 
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > 
> > > 
> > > So what e.g. the PCI patch
> > > https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > > actually proposes is a list of
> > > allowed drivers, not devices. Doing it at the device level
> > > has disadvantages, for example some devices might have a legacy
> > > unsafe driver, or an out of tree driver. It also does not
> > > address drivers that poke at hardware during init.
> > 
> > Doing it at a device level is the only sane way to do this.
> > 
> > A user needs to say "this device is allowed to be controlled by this
> > driver".  This is the trust model that USB has had for over a decade and
> > what thunderbolt also has.
> > 
> > > Accordingly, I think the right thing to do is to skip
> > > driver init for disallowed drivers, not skip probe
> > > for specific devices.
> > 
> > What do you mean by "driver init"?  module_init()?
> > 
> > No driver should be touching hardware in their module init call.  They
> > should only be touching it in the probe callback as that is the only
> > time they are ever allowed to talk to hardware.  Specifically the device
> > that has been handed to them.
> > 
> > If there are in-kernel PCI drivers that do not do this, they need to be
> > fixed today.
> > 
> > We don't care about out-of-tree drivers for obvious reasons that we have
> > no control over them.
> 
> I don't see any point in talking about "untrusted drivers".  If a 
> driver isn't trusted then it doesn't belong in your kernel.  Period.  
> When you load a driver into your kernel, you are implicitly trusting 
> it (aside from limitations imposed by security modules).  The code 
> it contains, the module_init code in particular, runs with full 
> superuser permissions.
> 
> What use is there in loading a driver but telling the kernel "I don't 
> trust this driver, so don't allow it to probe any devices"?  Why not 
> just blacklist it so that it never gets modprobed in the first place?
> 
> Alan Stern

When the driver is built-in, it seems useful to be able to block it
without rebuilding the kernel. This is just flipping it around
and using an allow-list for cases where you want to severly
limit the available functionality.


-- 
MST

