Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91C3B329B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhFXPd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:33:58 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:57557 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhFXPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:33:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4BA2F2B0126C;
        Thu, 24 Jun 2021 11:31:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 24 Jun 2021 11:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=G+xOU7HQpxdU31iXz8RKBlmS+yk
        rWxCmEVtGrt9fCVc=; b=JyeTFcCishyAIpTYgbphIIwFyCRQTW7wn1FaIeJI1Wx
        SJ/oyh2NqQF1LhpVkT9tWgHoqf2bgV1P4BVc0j/Em9OUFcEPASy8T/3bAKHoVjTz
        YKvVNQu1bvbizok61Vs3efxvvJ3ICfAYfFQUeXT/QX8aGjhtUD1TDonDsSaO6p9r
        Q4BeuNTjkz54yPow/eMfwNqbMrSD169BJVzChvWvd7xJ8hUAcFlgdMzvG3svMjzc
        dMuCN+WxShyiOslileWdDDX6sKpVvTxySBtiC7TW3oV545Lh5VdwIXGECB5DXSLC
        Fw/OXUVrMPKhtTKs+/vsoi5RaF+KEykID4G4YvXCZFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G+xOU7
        HQpxdU31iXz8RKBlmS+ykrWxCmEVtGrt9fCVc=; b=BWIs25akaiTOED52yVMl5d
        TvbFNhDoMkOjVemuqCqU2JwzV5evP3C9oQq7BKNPm3ds+J0SilNYx6cGE6LIaqFW
        kVrOsn/oB04yUEbaIarHi4t+Tafd4mlbR8L07Wl1RMEtgI9+V3OcPL1Opj84NdLN
        NzA3RV3YKxDkMjbUTsmgOqWMoesNZuLJP9+Znil0nWYzYMAo8rMgw+v5DWlpW/k2
        xZoNkc+cMrkiQVXzYel/1cVsKl34wHrmck3vxR3jvXzFWeal2WBtQnC8Mm60ojLa
        9gwklcKP5qhbsSGlkgFCm364nPz+MIQ+GT6M32U4cJ8kX+NsRjwAdytq+g9WJemg
        ==
X-ME-Sender: <xms:V6XUYKe9eXVF272aZ0dBUO86lNsvaLXRk57os9J6bUKY5tUn7AOSWg>
    <xme:V6XUYEPmI1WistKynVhQWo63Js6YPG9tPmdfUPs54JYAJKqEvTgAhaGeQ3lKBnhAA
    kZ2y3Wx5KAo4Q>
X-ME-Received: <xmr:V6XUYLiUTdjLUrE18iAxQBF2YFbRYYV7RWcJoYjsK9xoMUowzKVUBg8krV7j_EYjOh8Hk3dRPguqt7cRArGkJcu9lxeZKl4b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeghedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:V6XUYH8OKbvCgmklEqXP4Cb8Soj3VB72dkWUiMzWbXkcE3SWQO0gLQ>
    <xmx:V6XUYGsK2U7UZvmNP98bCz3cKmAUFPv44cwZUxLxow9NMI6-sK_UhA>
    <xmx:V6XUYOEtUHdB_dBi8wlBjLEzbllgIYw3tvg7cjVbEir83_oMtO4qsA>
    <xmx:V6XUYH-tIXegNPcghH_GnIPW2u3sO15SPPp0oG-jMiGJ_cv0-A3nR0p2b6I>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jun 2021 11:31:34 -0400 (EDT)
Date:   Thu, 24 Jun 2021 17:31:32 +0200
From:   Greg KH <greg@kroah.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNSlVPcjHInk4un6@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 08:24:29AM -0700, Andi Kleen wrote:
> 
> On 6/24/2021 7:29 AM, Greg KH wrote:
> > On Thu, Jun 24, 2021 at 07:24:31AM -0700, Andi Kleen wrote:
> > > > But first off, why is this symlink suddenly needed?  What is so special
> > > > about this new hardware that it breaks the existing model?
> > > The driver can be in two modes:
> > > 
> > > - Driver fully knows the hardware and puts in the correct Linux names
> > > 
> > > - Driver doesn't know the hardware but is in a fallback mode where it only
> > > looks at a discovery table. There we don't have the correct names, just an
> > > numeric identifier for the different hardware sub components.
> > Why does this matter?  Why would the driver not "know" the hardware?  If
> > it doesn't know it, why would it bind to it?
> 
> It's a similar concept as a PCI class. How to have a driver that can handle
> future hardware, but with some restrictions

But this is NOT how busses work in the driver model.

PCI classes are great, but we do NOT suddenly add a symlink in sysfs if
a driver goes from being handled by "generic_pci_type_foo" to
"vendor_foo".  Userspace can handle the change and life goes on.

> The perf CPU PMU has had a similar concept for a long time. The driver can
> be either in architectural mode (with a subset of features), or be fully
> enabled. This allows users who are on an older kernel to still use at least
> a subset of the functionality.

So a device name will move from "generic" to "specific", right?

Why does a bus have to do with any of this?

> > > In the later mode the numeric identifier is used in sysfs, in the former
> > > case the full Linux name. But we want to keep some degree of Linux user
> > > space compatibility between the two, that is why the full mode creates a
> > > symlink from the "numeric" name. This way the (ugly) identifiers needed for
> > > the fallback mode work everywhere.
> > So what _exactly_ does the symlink do here?  What is it from->to?
> 
> It's from numeric identifier to full perf name
> 
> In fallback mode there is no symlink, only the numeric identifier.

Those two sentences do not describe a sysfs path to me.

Where are the Documentation/ABI/ entries for all of this?

> > And where is it being documented?  What userspace tool needs to be fixed
> > up so that the symlink can be removed?
> 
> The names are visible in the perf command lines. Perf supports either name
> without changes. So it's not about fixing a specific tool, but about using
> the drivers in both modes, with limited compatibility between the two.

But a driver does not caer.  And if perf does not care, who cares?

still totally confused,

greg k-h
