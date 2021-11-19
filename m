Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B6B4570C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhKSOkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:40:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231243AbhKSOkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:40:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFC4E61549;
        Fri, 19 Nov 2021 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637332620;
        bh=B2DfgeKIwbJGrrYnFoPC26vXVKusWZCa7MPNwKHKe7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujLdBeEVnZEDfXadL5hyYzpJZexwoH7+mMjtZ3Ksy5it1t2moo1Xsz7VrhnrQB7YU
         ojx4ZUiCP68ZQ6jIUCObwjTkZo9+3i1pg9DOzBHwH1PuY8dkQPNSnK3NqyEVnnU904
         7cA4PM59AvkhybxLNe4nCVc6jlhnkdP1Jt8bTaY4=
Date:   Fri, 19 Nov 2021 15:36:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rafael.j.wysocki@intel.com
Subject: Re: Intel bluetooth regression in 5.15.3
Message-ID: <YZe2iVBCPIdsWmZd@kroah.com>
References: <371c6dde-ee04-cf2e-1463-113ba8a2ac22@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371c6dde-ee04-cf2e-1463-113ba8a2ac22@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 01:43:32PM +0000, Chris Clayton wrote:
> Hi,
> 
> I built and installed 5.15.3 this morning and found that my bluetooth devices no longer work. 5.15.2 and 5.10.80 are
> both OK.
> 
> I've bisected it and landed on:
> 
> cfc1a472a8d89c0d0bbb3600501eeeebc5ec8039 is the first bad commit
> commit cfc1a472a8d89c0d0bbb3600501eeeebc5ec8039
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Sat Oct 9 16:22:09 2021 +0200
> 
>     ACPI: scan: Release PM resources blocked by unused objects
> 
>     [ Upstream commit c10383e8ddf4810b9a5c1595404c2724d925a0a6 ]
> 
>     On some systems the ACPI namespace contains device objects that are
>     not used in certain configurations of the system.  If they start off
>     in the D0 power state configuration, they will stay in it until the
>     system reboots, because of the lack of any mechanism possibly causing
>     their configuration to change.  If that happens, they may prevent
>     some power resources from being turned off or generally they may
>     prevent the platform from getting into the deepest low-power states
>     thus causing some energy to be wasted.
> 
>     Address this issue by changing the configuration of unused ACPI
>     device objects to the D3cold power state one after carrying out
>     the ACPI-based enumeration of devices.
> 
>     BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
>     Link: https://lore.kernel.org/linux-acpi/20211007205126.11769-1-mario.limonciello@amd.com/
>     Reported-by: Mario Limonciello <mario.limonciello@amd.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
>  drivers/acpi/glue.c     | 25 +++++++++++++++++++++++++
>  drivers/acpi/internal.h |  1 +
>  drivers/acpi/scan.c     |  6 ++++++
>  3 files changed, 32 insertions(+)
> 
> 5.15.3 with that commit reverted works fine.
> 
> Let me know if you need any additional diagnostics or patches tested but please cc me as I'm not subscribed.

Is 5.16-rc1 also a problem for you and your devices?

thanks,

greg k-h
