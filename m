Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207DB3EC980
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhHOOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 10:11:24 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37931 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhHOOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 10:11:23 -0400
Received: (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DD7291BF203;
        Sun, 15 Aug 2021 14:10:50 +0000 (UTC)
Message-ID: <7522b44a323e49daece4e69aeeb6292cd7e3dfaa.camel@hadess.net>
Subject: Re: [PATCH v3 0/1] asus-wmi: add platform_profile support
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>, Luke Jones <luke@ljones.dev>,
        linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
Date:   Sun, 15 Aug 2021 16:10:50 +0200
In-Reply-To: <a918bfe0-03c4-e7d3-8a99-efb1d11333e4@redhat.com>
References: <20210814043103.2535842-1-luke@ljones.dev>
         <THKTXQ.ELSNF0TA7RAV1@ljones.dev>
         <a918bfe0-03c4-e7d3-8a99-efb1d11333e4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-15 at 15:48 +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/14/21 9:51 AM, Luke Jones wrote:
> > 
> > 
> > On Sat, Aug 14 2021 at 16:31:02 +1200, Luke D. Jones
> > <luke@ljones.dev> wrote:
> > > Changelog:
> > > - V2
> > >   + Correctly unregister from platform_profile if
> > >     throttle_thermal_policy fails
> > >   + Do platform_profile_notify() in both
> > > throttle_thermal_policy_store()
> > >     and in throttle_thermal_policy_switch_next()
> > >   + Remove unnecessary prep for possible fan-boost modes as this
> > >     doesn't match expected platform_profile behaviour
> > > - V3
> > >   + Add missing declaration for err in
> > >     throttle_thermal_policy_switch_next
> > > 
> > > Luke D. Jones (1):
> > >   asus-wmi: Add support for platform_profile
> > > 
> > >  drivers/platform/x86/asus-wmi.c | 139
> > > +++++++++++++++++++++++++++++++-
> > >  1 file changed, 135 insertions(+), 4 deletions(-)
> > > 
> > > -- 
> > > 2.31.1
> > 
> > Hi,
> > 
> > I teested the patch again and it appears that the
> > platform_profile_notify() in both throttle_thermal_policy_store() and
> > throttle_thermal_policy_switch_next() updates the
> > /sys/firmware/acpi/platform_profile sysfs path fine, but userspace
> > isn't updated?
> > 
> > The way I'm checking is:
> > 1. echo 1 |sudo tee /sys/devices/platform/asus-nb-
> > wmi/throttle_thermal_policy
> > 2. cat -p /sys/firmware/acpi/platform_profile
> >   - performance (updated correctly by platform_profile_notify)
> > 3. Check gnome-settings, not updated.
> > 
> > Doing `echo "performance" |sudo tee
> > /sys/firmware/acpi/platform_profile` updates both
> > throttle_thermal_policy and userspace as expected. I'm wondering if
> > I've missed something?
> 
> If you add a printk where you call platform_profile_notify() and you
> see that
> happening, then you are likely seeing a userspace bug. Possibly your
> power-profile-daemon is simply a bit old and therefor does not support
> the combination of profiles which asus-wmi offers, IIRC it falls back
> to
> using intel-pstate in that case.

Support for the quiet profile is only available in git:
https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/commit/c9b646025d9f155509a6cda1c292bfd120daeb9e

You can apply the patch on top of 0.9.0 if you want to use your
distribution's packages or something.

There's debugging info in the README should that be necessary.

> You could try building the latest power-profile-daemon from git and run
> it in verbose mode. If it sees the changes and the control-panel applet
> is
> still not updating then I would not worry about that. The userspace
> code
> is still somewhat new and I'm not sure which version your distro is
> running and how well it is keeping up with gnome-updates.
> 
> Regards,
> 
> Hans
> 


