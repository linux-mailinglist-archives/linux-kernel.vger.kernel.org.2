Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8938A3F5E08
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhHXMeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:34:36 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45623 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhHXMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:34:35 -0400
Received: (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 164B16000C;
        Tue, 24 Aug 2021 12:33:48 +0000 (UTC)
Message-ID: <3bc459afe71eb49c8c0c1f0a0b38855170ae507d.camel@hadess.net>
Subject: Re: [PATCH v4 1/1] asus-wmi: Add support for custom fan curves
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>, Luke Jones <luke@ljones.dev>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Tue, 24 Aug 2021 14:33:48 +0200
In-Reply-To: <65260602-a1f4-fc8a-a823-ca5a6e4fca60@redhat.com>
References: <20210820095726.14131-1-luke@ljones.dev>
         <20210820095726.14131-2-luke@ljones.dev>
         <321afe1a293be3a623a9be53feea3a008e044b31.camel@hadess.net>
         <L0W4YQ.ZVWQDLFJE8NR2@ljones.dev>
         <e7fbcf85f61b5c727a93df07b3bfe1624547067f.camel@hadess.net>
         <c19dfdde11754c234ca8a45c4af2187699498ee8.camel@hadess.net>
         <U8X4YQ.79I8GZJ1LDW02@ljones.dev>
         <b20a879dce98f27dfc68b86aaf486be9e623eacf.camel@hadess.net>
         <1EQ5YQ.6O8MNIPTU6V4@ljones.dev>
         <7a8a8d56c4e6addfc41b5dd5262968bd169f538f.camel@hadess.net>
         <GGIAYQ.PS5EB67PH64N@ljones.dev>
         <65260602-a1f4-fc8a-a823-ca5a6e4fca60@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-23 at 13:45 +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/23/21 1:26 PM, Luke Jones wrote:
> > 
> > 
> > On Mon, Aug 23 2021 at 12:28:21 +0200, Bastien Nocera
> > <hadess@hadess.net> wrote:
> > > On Sat, 2021-08-21 at 09:30 +1200, Luke Jones wrote:
> > > > 
> > > > 
> > > >  On Fri, Aug 20 2021 at 13:39:02 +0200, Bastien Nocera
> > > >  <hadess@hadess.net> wrote:
> > > >  > On Fri, 2021-08-20 at 23:00 +1200, Luke Jones wrote:
> > > >  > >
> > > >  > >
> > > >  > >  On Fri, Aug 20 2021 at 12:51:08 +0200, Bastien Nocera
> > > >  > >  <hadess@hadess.net> wrote:
> > > >  > >  > On Fri, 2021-08-20 at 12:43 +0200, Bastien Nocera
> > > > wrote:
> > > >  > >  > >  On Fri, 2021-08-20 at 22:33 +1200, Luke Jones wrote:
> > > >  > >  > >  > > Am I going to get bug reports from Asus users
> > > > that will
> > > >  > >  > > complain
> > > >  > >  > >  > > that
> > > >  > >  > >  > > power-profiles-daemon doesn't work correctly,
> > > > where I
> > > >  > > will
> > > >  > >  > > have
> > > >  > >  > >  > > to
> > > >  > >  > >  > > wearily ask if they're using an Asus Rog laptop?
> > > >  > >  > >  >
> > > >  > >  > >  > No. Definitely not. The changes to fan curves per-
> > > > profile
> > > >  > > need
> > > >  > >  > > to
> > > >  > >  > >  > be
> > > >  > >  > >  > explicitly enabled and set. So a new user will be
> > > > unaware
> > > >  > > that
> > > >  > >  > > this
> > > >  > >  > >  > control exists (until they look for it) and their
> > > > laptop
> > > >  > > will
> > > >  > >  > >  > behave
> > > >  > >  > >  > exactly as default.
> > > >  > >  > >
> > > >  > >  > >  "The user will need to change the fan curves
> > > > manually so
> > > >  > > will
> > > >  > >  > >  definitely remember to mention it in bug reports" is
> > > > a very
> > > >  > >  > > different
> > > >  > >  > >  thing to "the user can't change the fan curves to be
> > > >  > > nonsensical
> > > >  > >  > > and
> > > >  > >  > >  mean opposite things".
> > > >  > >  > >
> > > >  > >  > >  I can assure you that I will eventually get bug
> > > > reports
> > > >  > > from
> > > >  > >  > > "power
> > > >  > >  > >  users" who break their setup and wonder why things
> > > > don't
> > > >  > > work
> > > >  > >  > >  properly,
> > > >  > >  > >  without ever mentioning the changes they made
> > > > changes to
> > > >  > > the
> > > >  > > fan
> > > >  > >  > >  curves, or anything else they might have changed.
> > > >  > >  >
> > > >  > >  > A way to taint the settings that power-profiles-daemon
> > > > could
> > > >  > > catch
> > > >  > >  > would be fine by me. I absolutely don't want to have to
> > > >  > > support
> > > >  > >  > somebody's tweaks until they undo them.
> > > >  > >
> > > >  > >  Definitely understood. Do you have something in mind?
> > > >  >
> > > >  > A sysfs attribute with boolean data that shows whether
> > > > custom fan
> > > >  > curves are used would be enough.
> > > > 
> > > >  The path /sys/devices/platform/asus-nb-
> > > > wmi/active_fan_curve_profiles
> > > >  should be usable like this? I added this as the method for
> > > >  controlling
> > > >  which fan curves for which profiles are active.
> > > > 
> > > >  If empty, then no custom fan curves are active at all. If it
> > > > contains
> > > >  any combination of strings "quiet, balanced, performance" then
> > > > those
> > > >  associated (named) platform_profiles have an active fan curve
> > > > and you
> > > >  can throw up a general warning, maybe add the contents of that
> > > > file
> > > >  too?
> > > 
> > > That works for me, although I would probably have preferred a way
> > > that
> > > wasn't specific to the asus-wmi module, I'm sure I can made do
> > > with
> > > that.
> > 
> > Oh I see, you were looking to get a more general solution
> > implemented? Maybe something like "/sys/devices/platform/asus-nb-
> > wmi/platform_profile_tainted"? This could be an opportunity to
> > maybe make a standardised naming scheme for it.
> 
> That would standardize the name, but not the location (path to the
> name);
> so I'm not sure how helpful that would be. I think that for now
> going with /sys/devices/platform/asus-nb-
> wmi/active_fan_curve_profiles is fine
> and if we hit the same situation with a 2nd driver then maybe do
> something under the /sys/firmware/acpi/platform_profile* namespace.
> 
> Maybe something like:
> 
> /sys/firmware/acpi/platform_profile_flags or something which can
> communicate a bunch of 0 (keyword not present) / 1 values
> by containing a list of space separated keywords like:
> "custom-fan-profiles", where "custom-fan-profiles" would only
> show up when they are activated ?

That would work for me but let's wait until there's something to make
more generic before doing it, as you mentioned.

