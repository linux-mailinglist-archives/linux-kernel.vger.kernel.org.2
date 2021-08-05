Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CAD3E1B02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbhHESMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239986AbhHESMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:12:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF09A60F25;
        Thu,  5 Aug 2021 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628187106;
        bh=bCqDkZoewa4Itcg2pGQD3OuK7e6G6yDkQbh7McanSR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGwO6SNGjiVK5Uq/XID5d1YgoYhkFNieVoUh+bHUsdRjlPZMThcU0IIO53CnhjE69
         bA59vHAXgdHt/JtWtHKZ1lSjIvTHaIN0A6g2hF8F0TCAPShBpr1EgCfed+MCjzrTkt
         Xnw+/NMmG+g89eMEKeObNB3r3zhIWqSfVz54z4Io=
Date:   Thu, 5 Aug 2021 20:11:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQwp33gKxab6RB/e@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com>
 <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <CAPcyv4iCBknhGyw-YjO7_Tua9Vkw_UCSHVj3prL3mVfz4nj-_g@mail.gmail.com>
 <1e9efeb3-4aef-68e2-6af3-cf6bb5decb38@linux.intel.com>
 <f4dedead-5b6c-2712-deca-0d59d314016b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4dedead-5b6c-2712-deca-0d59d314016b@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:52:10AM -0700, Andi Kleen wrote:
> 
> On 8/5/2021 10:25 AM, Kuppuswamy, Sathyanarayanan wrote:
> > 
> > 
> > On 8/5/21 9:37 AM, Dan Williams wrote:
> > > I overlooked the "authorized" attribute in usb and thunderbolt. The
> > > collision problem makes sense. Are you open to a core "authorized"
> > > attribute that buses like usb and thunderbolt would override in favor
> > > of their local implementation? I.e. similar to suppress_bind_attrs:
> > 
> > Even if such overriding is allowed in default boot, it should not be
> > allowed in protected guest + driver_filter model.
> 
> 
> Allowing overriding would be acceptable, as long as nobody does it by
> default. In theory a (root) user program can already do other things that
> make the guest insecure.
> 
> Still it's not clear to me how this proposal solves the builtin and platform
> drivers problem. AFAIK that needs a builtin allowlist in any case. And once
> we have that likely we don't need anything else for current TDX at least,
> because the allowlist is so small and there is no concept of hotplug or
> similar.

What specific platform drivers do you need on these systems that you
would ever want to exclude some and not just allow them all?

> Also another consideration is that we were trying to avoid relying too much
> on user space for this. One of the goals was to move an existing guest image
> to a confidential guest with only minor changes (new kernel / enable
> attestation). Complex changes for securing it would make that much harder.

Just deny all and only allow the ones you "trust".  That is a
well-defined policy that (/me checks notes) Intel created for USB a very
long time ago.

greg k-h
