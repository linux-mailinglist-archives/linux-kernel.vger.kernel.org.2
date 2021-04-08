Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81A358790
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhDHOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:55:10 -0400
Received: from ned.t-8ch.de ([212.47.237.191]:42610 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231557AbhDHOzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:55:09 -0400
Date:   Thu, 8 Apr 2021 16:54:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1617893692;
        bh=i5EMyQfq3kZPFLPYso2zTOESvsqAwut440RBPTf3LPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSWhRZWGABtqOmFYLTTAacbrnlVez40LRoNl2mtvlPmcW4uz9pYrNyLnoI5fjsBX8
         KYtFp6BGiJKl16IRGh25EThVfx98mDpL/Uu4D1tds4sc5sUYvlNExLzxrFiuWsdS4B
         57/bO1zk4P+siy1XQlgoYChAgCdIgwGGr5VNFCbg=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
Message-ID: <37a67493-c489-477c-8133-16d5dbd494f2@t-8ch.de>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
 <44fbb57c-88ee-62f0-c72c-507cad17eb7d@redhat.com>
 <123d021b-b86b-4356-b234-fb46fa260193@t-8ch.de>
 <6993d257-fdc1-2be6-555d-86c6b8c9d18d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6993d257-fdc1-2be6-555d-86c6b8c9d18d@redhat.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-PGP-Key: https://t-8ch.de/pubkey.asc
X-PGP-Key-Fingerprint: 187EF7CE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Do, 2021-04-08T11:36+0200, Hans de Goede wrote:
> On 4/7/21 9:43 PM, Thomas Weißschuh wrote:
> > Hi Hans,
> > 
> > On Mi, 2021-04-07T17:54+0200, Hans de Goede wrote:
> >> Thank you for your new driver and thank you for the quick respin
> >> addressing Barnabás' request to make it a WMI driver.
> >>
> >> The code looks good, so merging this should be a no-brainer,
> >> yet I'm not sure if I should merge this driver as-is, let me
> >> explain.
> > 
> > thanks for the encouraging words.
> > 
> >> The problem is that I assume that this is based on reverse-engineering?
> > 
> > Yes, it is completely reverse-engineered.
> > Essentially I stumbled upon Matthews comment at
> > https://bugzilla.kernel.org/show_bug.cgi?id=204807#c37 and went from there.
> > 
> >> We have some mixes experiences with reverse-engineered WMI drivers,
> >> sometimes a feature is not supported yet the wmi_evaluate_method()
> >> call happily succeeds. One example of this causing trouble is:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1797d588af15174d4a4e7159dac8c800538e4f8c
> > 
> > There actually are reports of recent, similar mainboards with recent firmware and
> > similar sensor chips that do not support the temperature query.
> > (https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/3 and
> > https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/2)
> > 
> > Unfortunately for unknown WMI queries the firmware does not return any value.
> > This ends up as an ACPI integer with value 0 on the driver side.
> > (Which I could not yet find documentation for if that is expected)
> > In the current version of the driver EIO is returned for 0 values which
> > get translated to N/A by lm-sensors.
> > 
> >> At a minimum I think your driver should check in its
> >> probe function that
> >>
> >> gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, ...)
> >>
> >> actually succeeds on the machine the driver is running on chances
> >> are that Gigabyte has been using the DEADBEEF-2001-0000-00A0-C90629100000
> >> GUID for ages, where as the 0x125 value for GIGABYTE_WMI_TEMPERATURE_QUERY
> >> suggests that this is a pretty new API.
> > 
> > Would it be enough to probe all six sensors and check if all return 0?
> 
> I think that failing the probe with -ENODEV, with a dev_info() explaining why when
> all six sensors return 0 would be good yes, that should also fix those 2
> issues on https://github.com/t-8ch/linux-gigabyte-wmi-driver/.

I added such a validation step.

> >> It would be good if you can see if you can find some DSDT-s for older
> >> gigabyte motherboards attached to various distro's bug-tracking systems
> >> or forum posts and see how those respond to an unknown gigabyte_wmi_commandtype.
> > 
> > Will do.
> 
> Since you alreayd have bugreports of boards where this does not work,
> please don't spend too much time on this. I guess those older DSDT-s will
> also just return an integer with value 0.

Ok.

> >> Another open question to make sure this driver is suitable
> >> as a generic driver (and does not misbehave) is how to figure out
> >> how many temperature sensors there actually are.
> > 
> > So far I could not find out how to query this from the firmware.
> > The IT8688 chip can report the state of each sensor but that is not exposed by
> > the firmware.
> > But even the state information from the IT8688 is not accurate as is.
> > One of the sensors that is reported as being active (directly via it87) on my
> > machine always reports -55°C (yes, negative).
> 
> Ok.
> 
> >> Perhaps the WMI interface returns an error when you query an out-of-range
> >> temperature channel?
> > 
> > Also "0" as mentioned above.
> 
> Hmm, so maybe this can be used to limit the amount of reported temperature
> sensors, IOW if sensors 5 and 6 report 0, only register 4 sensors ?

So far the 0-returning sensors have not been at the end of the list but in the
middle. Is it worth building logic to properly probe a bitmask of useful
sensors?

> >> One option here might be to add a DMI matching table and only load on
> >> systems on that table for now. That table could then perhaps also provide
> >> labels for each of the temperature channels, which is something which
> >> would be nice to have regardless of my worries about how well this driver
> >> will work on motherboards on which it has not been tested.
> > 
> > I am collecting reports for working motherboards at
> > https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/1 .
> 
> Good, you should probably ask reporters there to provide the output of:
> 
> grep . /sys/class/dmi/id/* 2> /dev/null

I added a DMI-based whitelist and asked users to submit their DMI information.

> Ran as a normal user (so that the serial-numbers will be skipped) so that
> you will have DMI strings to match on if you decide to go that route.

The serials seem not to be too critical on these boards:

/sys/class/dmi/id/board_serial:Default string
/sys/class/dmi/id/chassis_serial:Default string
/sys/class/dmi/id/product_serial:Default string

> > As mentioned in the initial patch submission there would be different ways to
> > access this information firmware:
> > 
> > * Directly call the underlying ACPI methods (these are present in all so far
> >   observed firmwares, even if not exposed via WMI).
> > * Directly access the ACPI IndexField representing the it87 chip.
> > * Directly access the it87 registers while holding the relevant locks via ACPI.
> > 
> > I assume all of those mechanisms have no place in a proper kernel driver but
> > would like to get your opinion on it.
> 
> Actually the "Directly access the it87 registers" option is potentially interesting
> since it will allow using the it87 driver which gives a lot more features.
> 
> I actually wrote a rough outline of how something like this could work here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=204807#c47

I must have overread this one, but yes that's also what I had in mind.

> Note I'm not sure if that is the right approach, but it definitely is an
> option. It seems that this one might also solve the X470-AORUS-ULTRA-GAMING
> case (https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/2)
> 
> Hopefully the direct-register ACPI/WMI access methods will also allow
> reading the super-io vendor and product ids so that we can be reasonably
> sure that we are not loading the wrong driver on a board.
> 
> OTOH the WMI-temp method approach may also work on boards where the sensors
> (or some of the sensors) are not supported.
> 
> I'm afraid there is no obviously correct answer here. If you feel like it
> experimenting with the "Directly access the it87 registers" option would certainly
> be interesting IMHO.
> 
> It might be good to get hwmon subsystems maintainer's opinion on this
> before sinking a lot of time into this though (added to the Cc).

Sounds good.
