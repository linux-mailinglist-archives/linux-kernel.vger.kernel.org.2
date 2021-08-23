Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2D3F48A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhHWK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:29:12 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37149 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbhHWK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:29:05 -0400
Received: (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C5E40240006;
        Mon, 23 Aug 2021 10:28:21 +0000 (UTC)
Message-ID: <7a8a8d56c4e6addfc41b5dd5262968bd169f538f.camel@hadess.net>
Subject: Re: [PATCH v4 1/1] asus-wmi: Add support for custom fan curves
From:   Bastien Nocera <hadess@hadess.net>
To:     Luke Jones <luke@ljones.dev>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org
Date:   Mon, 23 Aug 2021 12:28:21 +0200
In-Reply-To: <1EQ5YQ.6O8MNIPTU6V4@ljones.dev>
References: <20210820095726.14131-1-luke@ljones.dev>
         <20210820095726.14131-2-luke@ljones.dev>
         <321afe1a293be3a623a9be53feea3a008e044b31.camel@hadess.net>
         <L0W4YQ.ZVWQDLFJE8NR2@ljones.dev>
         <e7fbcf85f61b5c727a93df07b3bfe1624547067f.camel@hadess.net>
         <c19dfdde11754c234ca8a45c4af2187699498ee8.camel@hadess.net>
         <U8X4YQ.79I8GZJ1LDW02@ljones.dev>
         <b20a879dce98f27dfc68b86aaf486be9e623eacf.camel@hadess.net>
         <1EQ5YQ.6O8MNIPTU6V4@ljones.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-08-21 at 09:30 +1200, Luke Jones wrote:
> 
> 
> On Fri, Aug 20 2021 at 13:39:02 +0200, Bastien Nocera 
> <hadess@hadess.net> wrote:
> > On Fri, 2021-08-20 at 23:00 +1200, Luke Jones wrote:
> > > 
> > > 
> > >  On Fri, Aug 20 2021 at 12:51:08 +0200, Bastien Nocera
> > >  <hadess@hadess.net> wrote:
> > >  > On Fri, 2021-08-20 at 12:43 +0200, Bastien Nocera wrote:
> > >  > >  On Fri, 2021-08-20 at 22:33 +1200, Luke Jones wrote:
> > >  > >  > > Am I going to get bug reports from Asus users that will
> > >  > > complain
> > >  > >  > > that
> > >  > >  > > power-profiles-daemon doesn't work correctly, where I
> > > will
> > >  > > have
> > >  > >  > > to
> > >  > >  > > wearily ask if they're using an Asus Rog laptop?
> > >  > >  >
> > >  > >  > No. Definitely not. The changes to fan curves per-profile
> > > need
> > >  > > to
> > >  > >  > be
> > >  > >  > explicitly enabled and set. So a new user will be unaware
> > > that
> > >  > > this
> > >  > >  > control exists (until they look for it) and their laptop
> > > will
> > >  > >  > behave
> > >  > >  > exactly as default.
> > >  > >
> > >  > >  "The user will need to change the fan curves manually so
> > > will
> > >  > >  definitely remember to mention it in bug reports" is a very
> > >  > > different
> > >  > >  thing to "the user can't change the fan curves to be 
> > > nonsensical
> > >  > > and
> > >  > >  mean opposite things".
> > >  > >
> > >  > >  I can assure you that I will eventually get bug reports
> > > from
> > >  > > "power
> > >  > >  users" who break their setup and wonder why things don't
> > > work
> > >  > >  properly,
> > >  > >  without ever mentioning the changes they made changes to
> > > the 
> > > fan
> > >  > >  curves, or anything else they might have changed.
> > >  >
> > >  > A way to taint the settings that power-profiles-daemon could
> > > catch
> > >  > would be fine by me. I absolutely don't want to have to
> > > support
> > >  > somebody's tweaks until they undo them.
> > > 
> > >  Definitely understood. Do you have something in mind?
> > 
> > A sysfs attribute with boolean data that shows whether custom fan
> > curves are used would be enough.
> 
> The path /sys/devices/platform/asus-nb-wmi/active_fan_curve_profiles 
> should be usable like this? I added this as the method for
> controlling 
> which fan curves for which profiles are active.
> 
> If empty, then no custom fan curves are active at all. If it contains
> any combination of strings "quiet, balanced, performance" then those 
> associated (named) platform_profiles have an active fan curve and you
> can throw up a general warning, maybe add the contents of that file
> too?

That works for me, although I would probably have preferred a way that
wasn't specific to the asus-wmi module, I'm sure I can made do with
that.

Thanks

