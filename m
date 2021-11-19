Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF1457500
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhKSRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhKSRHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:07:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFCFD6141B;
        Fri, 19 Nov 2021 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637341452;
        bh=pnilSeY7EmNW2jb+l8r5iagKCZq/4fpi9tJ1JVBD7HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruzeI72c5ayPpoN/aWCa93ngo5M5UysLV0+pulNk13JVSXduq02csZwyezf0qCQqV
         8pMi84eZ1w/8CZ2ACxjuM+HITL68+CO34OAnaG8CIkJP954/wzEpf+fGgSNP7qjko+
         +BX3P/uRWB0zz8ouJNRFEniXn3kt2NYwQIeCkgtw=
Date:   Fri, 19 Nov 2021 18:04:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rafael.j.wysocki@intel.com
Subject: Re: Intel bluetooth regression in 5.15.3
Message-ID: <YZfZCdy1lnIKx1z8@kroah.com>
References: <371c6dde-ee04-cf2e-1463-113ba8a2ac22@googlemail.com>
 <YZe2iVBCPIdsWmZd@kroah.com>
 <3212e538-f846-40ba-7a2a-a687c24c8b1a@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3212e538-f846-40ba-7a2a-a687c24c8b1a@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 03:32:28PM +0000, Chris Clayton wrote:
> 
> 
> On 19/11/2021 14:36, Greg Kroah-Hartman wrote:
> > On Fri, Nov 19, 2021 at 01:43:32PM +0000, Chris Clayton wrote:
> >> Hi,
> >>
> >> I built and installed 5.15.3 this morning and found that my bluetooth devices no longer work. 5.15.2 and 5.10.80 are
> >> both OK.
> >>
> >> I've bisected it and landed on:
> >>
> >> cfc1a472a8d89c0d0bbb3600501eeeebc5ec8039 is the first bad commit
> >> commit cfc1a472a8d89c0d0bbb3600501eeeebc5ec8039
> >> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Date:   Sat Oct 9 16:22:09 2021 +0200
> >>
> >>     ACPI: scan: Release PM resources blocked by unused objects
> >>
> >>     [ Upstream commit c10383e8ddf4810b9a5c1595404c2724d925a0a6 ]
> >>
> >>     On some systems the ACPI namespace contains device objects that are
> >>     not used in certain configurations of the system.  If they start off
> >>     in the D0 power state configuration, they will stay in it until the
> >>     system reboots, because of the lack of any mechanism possibly causing
> >>     their configuration to change.  If that happens, they may prevent
> >>     some power resources from being turned off or generally they may
> >>     prevent the platform from getting into the deepest low-power states
> >>     thus causing some energy to be wasted.
> >>
> >>     Address this issue by changing the configuration of unused ACPI
> >>     device objects to the D3cold power state one after carrying out
> >>     the ACPI-based enumeration of devices.
> >>
> >>     BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
> >>     Link: https://lore.kernel.org/linux-acpi/20211007205126.11769-1-mario.limonciello@amd.com/
> >>     Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> >>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>     Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> >>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >>
> >>  drivers/acpi/glue.c     | 25 +++++++++++++++++++++++++
> >>  drivers/acpi/internal.h |  1 +
> >>  drivers/acpi/scan.c     |  6 ++++++
> >>  3 files changed, 32 insertions(+)
> >>
> >> 5.15.3 with that commit reverted works fine.
> >>
> >> Let me know if you need any additional diagnostics or patches tested but please cc me as I'm not subscribed.
> > 
> > Is 5.16-rc1 also a problem for you and your devices?
> > 
> > thanks,
> > 
> 
> No, 5.16-rc1+, built after a git pull just a few minutes ago, woks fine. Looking at Linus's tree, the commit I
> identified in the bisection was reverted a couple of days ago (commit 3b2b49e6dfdcf423506a771bf44cee842596351a).

Ah, good, I'll go queue that up right now, thanks.

greg k-h
