Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60454182D3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbhIYOsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 10:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234173AbhIYOs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 10:48:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C84BE60232;
        Sat, 25 Sep 2021 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632581214;
        bh=bmpvbZiY+/2vqOjx4rQ67EsEJblSzIHFhNjMtsc4s8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIv6OsbHnOSnCtMjei0XwA/Zmlk3Yyu9hsALym8ihTExKqIqAr6HVxEUBmv/33DfY
         aWxSuayNbtt6uJjtpldsH8bIZ6mupz+04PRS/nlXEoLi2JsAeTedp2zDMPyOwOAumn
         oUT44vj31+vXkbcW5hZA0bZtejdNldOiMRS9/00g=
Date:   Sat, 25 Sep 2021 16:46:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YU82W8AEvY2Z3viS@kroah.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
 <20210924213157.3584061-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924213157.3584061-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 02:31:57PM -0700, David E. Box wrote:
> The SDSi device itself is enumerated as a PCIe VSEC capability on the Intel
> Out Of Band Management Services Module (OOBMSM) device. The SDSi device is
> a cell of the intel_pmt MFD driver and as such has a build dependency on
> CONFIG_MFD_INTEL_PMT.

I don't understand this.  It looks like if this driver is loaded it
instantly grabs the first iomem resource it can find and assumes that
this is the device in the system.  Where does it check to verify that
the hardware really is present?

And this isn't really a platform device, so why is it written like one?
Just because it is using the mfd subsystem?

PCIe devices are not platform devices, please use the real pci device
structures for this type of thing.

thanks,

greg k-h
