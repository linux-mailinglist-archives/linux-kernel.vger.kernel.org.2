Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6003E1AFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbhHESKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240965AbhHESKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:10:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD18E60E96;
        Thu,  5 Aug 2021 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628186990;
        bh=tfNDBhC2f98gL22JsGlfiCpH2HZTYOYVGcpSPtVp7CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4oGWflnoyAO9+3vZfdI9SHNf/RxbxAMMSaUKbjs/x7pSCy061MMySQ1VMSNpsyf3
         1/ugX83Hvy8fpNfddq3N0dDwn1zbqM4vXLzkLmRiXcuMOPDDEgIeLWMRwhEFmk6/Wd
         hwJ9sfT61yQe7gG/M1RWXTtDYPsczb9TnylWZrl0=
Date:   Thu, 5 Aug 2021 20:09:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQwpa+LAYt7YZ5dh@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com>
 <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
 <YQwlHrJBw79xhTSI@kroah.com>
 <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:58:46AM -0700, Andi Kleen wrote:
> 
> On 8/5/2021 10:51 AM, Greg Kroah-Hartman wrote:
> > 
> > It's controlled by whatever you want to use in userspace.  usbguard has
> > been handling this logic in userspace for over a decade now just fine.
> 
> 
> So how does that work with builtin USB drivers? Do you delay the USB binding
> until usbguard starts up?

Yes.

> > > This doesn't help us handle builtin drivers that initialize before user
> > > space is up.
> > Then have the default setting for your bus be "unauthorized" like we
> > allow for some busses today.
> 
> We need some early boot drivers, just not all of them. For example in your
> scheme we would need to reject all early platform drivers, which would break
> booting. Or allow all early platform drivers, but then we exactly get into
> the problem that there are far too many of them to properly harden.

Define "harden" please.  Why not just allow all platform drivers, they
should all be trusted.  If not, well, you have bigger problems...

Anyway, feel free to build on top of the existing scheme please, but do
not ignore it and try to create yet-another-way-to-do-this that I have
to maintain for the next 20+ years.

thanks,

greg k-h
