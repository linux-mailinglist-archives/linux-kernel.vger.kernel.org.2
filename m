Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9573B3C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhFYFUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:20:21 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37533 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhFYFUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:20:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id A260C58052E;
        Fri, 25 Jun 2021 01:17:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 25 Jun 2021 01:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=vSROeU7z9482TNpdKnv6pm1ZKXE
        /MwX2CYvN+3SFd98=; b=vpkUt7bN5Q/eTWj+SzMWMwZIX8MWuD5kBJhQAgzVxsI
        z6I32K977FIO8A7TvlWYfNifXhPbMBnSdWJwa0rDrdAXVt82x3+pSi2WHQwddgwe
        clHCUEbZ1G/xR9IO4PtSX3PHQ3Jjc8ZphbHZEnmwBgGMX6vAUxBsBAYyfMoV8SZX
        Wh+x7B4y7UgpoDBGwSrkpZiZMiB+tT6xk+U8DLtwfXOmcurNZ8qFH3xJJ2Ejjehx
        IozR1WdzWFw1ZOKh5KXnlMbLwV2dua8f2T7T3Ue/weG59uVzv+xYeS7g6LJSAvJS
        qDxLXv86e/2rieH0TxUF9/T5kzeiR5bCf8j1ir0qHxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vSROeU
        7z9482TNpdKnv6pm1ZKXE/MwX2CYvN+3SFd98=; b=EzoFdxPS9+B5ALxtQsJOnV
        nOmNCiQqLig0sHjKhDAW/MnL6S5EyQ5kw+s39sstHzUHNvlqMWqN8aL7UBek/kFI
        WZJ/MnVD0xTCi1zahSyfo9CpjAjJkJQ1t+tkIYHiQdT3qgG27ku/9+H6xS++TDSv
        lcLsU2TrCT7VrhoChnWGpUEAVReFZwlWA8Ao+ey6Rkp3tboufDxRlLYsJuYu4DsS
        AvxpDJp20bedqJhyu0V2uyoK7HRovjmARgSjV9CoHRdZHHETvXU2xeKe7S6kF3Ga
        OuyBYbf19wt7vHjK+i3gvUE3UUg/CExWnjc3NGaPjGlUFOXkbKost0QRvarwHUKQ
        ==
X-ME-Sender: <xms:BmfVYKtxqoTzOVmrD7woLKlcuHKjZemJbLbKMfem_qVnmkhj1a53Cw>
    <xme:BmfVYPcjTPr4ZovqNQ4jv4a3Px1Yda2EK8OezUfI50WlPS31LBVOh9H1etJBad6nd
    9cOCbdS_-0xwg>
X-ME-Received: <xmr:BmfVYFySz0uW7u0BemkpkhsrBCHwi8UXW6Uwj9ZQwzGvyDHrffsrF9SBg1fB441y7cMCn6cQjA-r0RCHf8WtTJKTkbEQlaIS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegiedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:BmfVYFNlk77vNesBy75l0tRtl-1pxascBcIujhykXotdSJDqCcTcEQ>
    <xmx:BmfVYK96kjCubEDf2s9krQRbO5ofkEhcexdAnRFoK4L7WhMJrOVXCA>
    <xmx:BmfVYNUS0qQROX4480NVqHEGCsZ0NyMGnYLRqJP0wxiC34xYDbQO4g>
    <xmx:B2fVYKMMMMExmlHhR8-5VhA166rU5c5asOy7UR_4pFH1K9j6c6iXGQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jun 2021 01:17:58 -0400 (EDT)
Date:   Fri, 25 Jun 2021 07:17:54 +0200
From:   Greg KH <greg@kroah.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNVnAlCVc9BhBRZj@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <33bccec9-c4c4-d52b-9ee4-9a09e7353812@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33bccec9-c4c4-d52b-9ee4-9a09e7353812@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 01:07:14PM -0400, Liang, Kan wrote:
> 
> 
> On 6/24/2021 11:31 AM, Greg KH wrote:
> > On Thu, Jun 24, 2021 at 08:24:29AM -0700, Andi Kleen wrote:
> > > 
> > > On 6/24/2021 7:29 AM, Greg KH wrote:
> > > > On Thu, Jun 24, 2021 at 07:24:31AM -0700, Andi Kleen wrote:
> > > > > > But first off, why is this symlink suddenly needed?  What is so special
> > > > > > about this new hardware that it breaks the existing model?
> > > > > The driver can be in two modes:
> > > > > 
> > > > > - Driver fully knows the hardware and puts in the correct Linux names
> > > > > 
> > > > > - Driver doesn't know the hardware but is in a fallback mode where it only
> > > > > looks at a discovery table. There we don't have the correct names, just an
> > > > > numeric identifier for the different hardware sub components.
> > > > Why does this matter?  Why would the driver not "know" the hardware?  If
> > > > it doesn't know it, why would it bind to it?
> > > 
> > > It's a similar concept as a PCI class. How to have a driver that can handle
> > > future hardware, but with some restrictions
> > 
> > But this is NOT how busses work in the driver model.
> > 
> > PCI classes are great, but we do NOT suddenly add a symlink in sysfs if
> > a driver goes from being handled by "generic_pci_type_foo" to
> > "vendor_foo".  Userspace can handle the change and life goes on.
> > 
> > > The perf CPU PMU has had a similar concept for a long time. The driver can
> > > be either in architectural mode (with a subset of features), or be fully
> > > enabled. This allows users who are on an older kernel to still use at least
> > > a subset of the functionality.
> > 
> > So a device name will move from "generic" to "specific", right?
> 
> We'd like to keep both names.

That is not how the driver model works, sorry.

Stick with the first name you got (i.e. the one in the kernel now).  Do
not try to use symlinks for things that should not be symlinked.

If a device changes names, wonderful, deal with that in userspace, we do
so all the time in tools for busses because device names are never
guaranteed to be the same each boot.  But bus names do not change for
the obvious reason that bus names are not dynamic, you pick them at
build time.

If you have userspace code that relies on device names to be static and
never change, then you need to stick with that as that was your choice
when you created that api.

thanks,

greg k-h
