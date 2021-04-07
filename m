Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC9357513
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355672AbhDGTnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:43:25 -0400
Received: from ned.t-8ch.de ([212.47.237.191]:41836 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236501AbhDGTnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:43:23 -0400
Date:   Wed, 7 Apr 2021 21:43:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1617824587;
        bh=mvR/pDFkKBWS5pLNv6hPGxPatI7yD4wMnsO8csAvWyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fimj+cxFa7qnF5otTS6+FnmDyKQT+5ifdc9oME9ICjf0q2TUuVB1QZVwzZOCeE5Ni
         2vbEQ2P/1Nz1GrRRAUXyBAwPIK3ciUp6BPxE5UdSmmYW/Ny9cBoC4XQvHoAbuH1MRl
         Rep0v4J6Wwl/auU0Tnh+xqG8GM0+RmcWiUyyQdJw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
Message-ID: <123d021b-b86b-4356-b234-fb46fa260193@t-8ch.de>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
 <44fbb57c-88ee-62f0-c72c-507cad17eb7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44fbb57c-88ee-62f0-c72c-507cad17eb7d@redhat.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-PGP-Key: https://t-8ch.de/pubkey.asc
X-PGP-Key-Fingerprint: 187EF7CE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mi, 2021-04-07T17:54+0200, Hans de Goede wrote:
> Thank you for your new driver and thank you for the quick respin
> addressing Barnabás' request to make it a WMI driver.
> 
> The code looks good, so merging this should be a no-brainer,
> yet I'm not sure if I should merge this driver as-is, let me
> explain.

thanks for the encouraging words.

> The problem is that I assume that this is based on reverse-engineering?

Yes, it is completely reverse-engineered.
Essentially I stumbled upon Matthews comment at
https://bugzilla.kernel.org/show_bug.cgi?id=204807#c37 and went from there.

> We have some mixes experiences with reverse-engineered WMI drivers,
> sometimes a feature is not supported yet the wmi_evaluate_method()
> call happily succeeds. One example of this causing trouble is:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1797d588af15174d4a4e7159dac8c800538e4f8c

There actually are reports of recent, similar mainboards with recent firmware and
similar sensor chips that do not support the temperature query.
(https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/3 and
https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/2)

Unfortunately for unknown WMI queries the firmware does not return any value.
This ends up as an ACPI integer with value 0 on the driver side.
(Which I could not yet find documentation for if that is expected)
In the current version of the driver EIO is returned for 0 values which
get translated to N/A by lm-sensors.

> At a minimum I think your driver should check in its
> probe function that
> 
> gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, ...)
> 
> actually succeeds on the machine the driver is running on chances
> are that Gigabyte has been using the DEADBEEF-2001-0000-00A0-C90629100000
> GUID for ages, where as the 0x125 value for GIGABYTE_WMI_TEMPERATURE_QUERY
> suggests that this is a pretty new API.

Would it be enough to probe all six sensors and check if all return 0?

> It would be good if you can see if you can find some DSDT-s for older
> gigabyte motherboards attached to various distro's bug-tracking systems
> or forum posts and see how those respond to an unknown gigabyte_wmi_commandtype.

Will do.

> Another open question to make sure this driver is suitable
> as a generic driver (and does not misbehave) is how to figure out
> how many temperature sensors there actually are.

So far I could not find out how to query this from the firmware.
The IT8688 chip can report the state of each sensor but that is not exposed by
the firmware.
But even the state information from the IT8688 is not accurate as is.
One of the sensors that is reported as being active (directly via it87) on my
machine always reports -55°C (yes, negative).

> Perhaps the WMI interface returns an error when you query an out-of-range
> temperature channel?

Also "0" as mentioned above.

> One option here might be to add a DMI matching table and only load on
> systems on that table for now. That table could then perhaps also provide
> labels for each of the temperature channels, which is something which
> would be nice to have regardless of my worries about how well this driver
> will work on motherboards on which it has not been tested.

I am collecting reports for working motherboards at
https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/1 .

> You could combine this DMI matching table with a "force" module option to
> continue with probing on boards which are not on the table to allow users
> to test and report their results to you.
>
> And hopefully after a while, when we're confident that the code works
> well on most gigabyte boards we can drop the DMI table, or at least
> only use it for the channel labels.

That sounds good.

> Please don't take this the wrong way; I think it is great that you are
> working on this. And the quick turnaround of the v2 of this drivers makes
> me pretty certain that we can figure something out and get this merged.

Thank you for the feedback!

> Have you tried contacting Gigabyte about this? I don't think the WMI
> interface is something which they need to keep secret for competitive
> reasons, so maybe they can help? Note if they want you to sign a NDA
> of sorts to view docs, then make sure that it contains some language
> about them allowing you to release an opensource driver for their
> hardware based on the "protected" information.

I have not contacted them yet, will do.

As mentioned in the initial patch submission there would be different ways to
access this information firmware:

* Directly call the underlying ACPI methods (these are present in all so far
  observed firmwares, even if not exposed via WMI).
* Directly access the ACPI IndexField representing the it87 chip.
* Directly access the it87 registers while holding the relevant locks via ACPI.

I assume all of those mechanisms have no place in a proper kernel driver but
would like to get your opinion on it.

Thomas
