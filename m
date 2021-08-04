Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178683E08D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbhHDT33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234676AbhHDT30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:29:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A75960BD3;
        Wed,  4 Aug 2021 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628105352;
        bh=r3ZDW4vFNK88sVmyyRefvriLQS5e7IyWkdL6AfYxEIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z21sMJTd5YlE9ofg6H+0H8NRadBa5YBgBe6b8AscrZWvf9GCGC3DdMWTItYmEyyx+
         Y9LNkAfMOFGuYar6K05r26QEB5vb5rAUDYQd7wjU7Cva5r63T5LE3Kf2BI4Rlz5wMV
         8GgFgTSDLJWeeRRjamT4bIXUi3j1gYKXQAdKrC9E=
Date:   Wed, 4 Aug 2021 21:29:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQrqhYEL64CSLRTy@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 10:43:22AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Intel's Trust Domain Extensions (TDX) is a new Intel technology that
> adds support for VMs to maintain confidentiality and integrity in the
> presence of an untrusted VMM.
> 
> Given the VMM is an untrusted entity and the VMM presents emulated
> hardware to the guest, a threat vector similar to Thunderclap [1] is
> present. Also, for ease of deployment, it is useful to be able to use
> the same kernel binary on host and guest, but that presents a wide
> attack surface given the range of hardware supported in typical
> builds. However, TDX guests only require a small number of drivers, a
> number small enough to audit for Thunderclap style attacks, and the
> rest can be disabled via policy. Add a mechanism to filter drivers
> based on a "protected-guest trusted" indication.

So you are trying to work around the "problem" that distro kernels
provides drivers for everything by adding additional kernel complexity?

What prevents you from using a sane, stripped down, kernel image for
these vms which would keep things sane and simpler and easier to audit
and most importantly, prove, that the image is not doing something you
don't expect it to do?

Why not just make distros that want to support this type of platform,
also provide these tiny kernel images?  Why are you pushing this work on
the kernel community instead?

> An alternative solution is to disable untrusted drivers using a custom
> kernel config for TDX, but such solution will break our goal of using
> same kernel binary in guest/host or in standard OS distributions. So
> it is not considered.

Why is that a goal that you _have_ to have?  Who is making that
requirement?

> Driver filter framework adds support to filter drivers at boot
> time by using platform specific allow list. This is a generic
> solution that can be reused by TDX. Driver filter framework adds a
> new hook (driver_allowed()) in driver_register() interface which
> will update the "allowed" status of the driver based on platform
> specific driver allow list or deny list. During driver bind process,
> trusted status is used to determine whether to continue or deny the
> bind process. If platform does not register any allow or deny list,
> all devices will be allowed. Platforms can use wildcard like "ALL:ALL"
> in bus_name and driver_name of filter node to allow or deny all
> bus and drivers.
> 
> Per driver opt-in model is also considered as an alternative design
> choice, but central allow or deny list is chosen because it is
> easier to maintain and audit. Also, "driver self serve" might be
> abused by mistake by driver authors cutting and pasting the code.
> 
> Also add an option in kernel command line and sysfs to update the
> allowed or denied drivers list. Driver filter allowed status
> can be read using following command.
> 
> cat /sys/bus/$bus/drivers/$driver/allowed

You added a sysfs file without Documentation/ABI/ update as well?

{sigh}

And what's wrong with the current method of removing drivers from
devices that you do not want them to be bound to?  We offer that support
for all busses now that want to do it, what driver types are you needing
to "control" here that does not take advantage of the existing
infrastructure that we currently have for this type of thing?

thanks,

greg k-h
