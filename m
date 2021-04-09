Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B21359517
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhDIGCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:02:52 -0400
Received: from ned.t-8ch.de ([212.47.237.191]:34170 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233244AbhDIGCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:02:50 -0400
Date:   Fri, 9 Apr 2021 08:02:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1617948149;
        bh=FHpOq7QS5QYAWuDQCp+yK31YAWp1DRpKH+1+t7s003I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FayLsPnKzAtX8Vx8EDISy/FpK1sMI/VA6cDo4MvXv0VIG2TxMvDiinOilY2L6UnnN
         f9twWpEZtdV1fx22PYZAY+KbFjCy0LR3LHowFB0GxB8GIP9BKCqQQckPXgjd73A2tm
         KU3GWPNrbOOdx2072zUqCKeqWoRQwEqkpQ2SvUYY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
Message-ID: <c55b1f8e-24b9-4574-8668-aed64832242b@t-8ch.de>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
 <44fbb57c-88ee-62f0-c72c-507cad17eb7d@redhat.com>
 <123d021b-b86b-4356-b234-fb46fa260193@t-8ch.de>
 <6993d257-fdc1-2be6-555d-86c6b8c9d18d@redhat.com>
 <d6cc98f4-1be2-f8bf-0426-58e324fc495b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6cc98f4-1be2-f8bf-0426-58e324fc495b@roeck-us.net>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-PGP-Key: https://t-8ch.de/pubkey.asc
X-PGP-Key-Fingerprint: 187EF7CE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2021-04-08T08:00-0700, Guenter Roeck wrote:
> On 4/8/21 2:36 AM, Hans de Goede wrote:
> > On 4/7/21 9:43 PM, Thomas Weißschuh wrote:
> >> On Mi, 2021-04-07T17:54+0200, Hans de Goede wrote:
> > Jean, Guenter,
> > 
> > Thomas has been working on a WMI driver to expose various motherboard
> > temperatures on a gigabyte board where the IO-addresses for the it87 chip
> > are reserved by ACPI. We are discussing how best to deal with this, there
> > are some ACPI methods to directly access the super-IO registers (with locking
> > to protect against other ACPI accesses). This reminded me of an idea I had
> > a while ago to solve a similar issue with an other superIO chip, abstract
> > the superIO register access-es using some reg_ops struct and allow an ACPI/WMI
> > driver to provide alternative reg_ops:
> > https://bugzilla.kernel.org/show_bug.cgi?id=204807#c47
> > 
> > Do you think this is a good idea (or a bad one)? And would something like that
> > be acceptable to you ?
> > 
> 
> The upstream it87 driver is severely out of date. I had an out-of-tree driver
> with various improvements which I didn't upstream, first because no one was willing
> to review changes and then because it had deviated too much. I pulled it from
> public view because I got pounded for not upstreaming it, because people started
> demanding support (not asking, demanding) for it, and because Gigabyte stopped
> providing datasheets for the more recent ITE chips and it became effectively
> unmaintainable.
> 
> Some ITE chips have issues which can cause system hangs if accessed directly.
> I put some work to remedy that into the non-upstream driver, but that was all
> just guesswork. Gigabyte knows about the problem (or so I was told from someone
> who has an NDA with them), but I didn't get them or ITE to even acknowledge it
> to me. I even had a support case open with Gigabyte for a while, but all I could
> get out of them is that they don't support Linux and what I would have to reproduce
> the problem with Windows for them to provide assistance (even though, again,
> they knew about it).
> 
> As for using ACPI locks or WMI to ensure that ACPI leaves the chip alone while
> the driver accesses chips directly: That is an option, but it has (at least)
> two problems.
> 
> First, ACPI access methods are not well documented or standardized. I had tried
> to find useful means to do that some time ago, but I gave up because each board
> (even from the same vendor) handles locking and accesses differently. We would
> end up with lots of board specific code. Coincidentally, that was for ASUS boards
> and the nct6775 driver.

At least for all the Gigabyte ACPI tables I have looked at all access is done
via two-byte "OperationRegion" over the Index/Data addresses, a "Field" with
two entries for these and an "IndexField" that is actually used to perform the
accesses.
As the IndexField is synchronized via "Lock" it should take a lock on the
OperationRegion itself.

So I think we should be technically fine with validating these assumption and
then also taking locks on the OperationRegion.

If it is reasonable to do so is another question.

> Second, access through ACPI is only one of the issues. Turns out there are two
> ITE chips on many of the Gigabyte boards nowadays, and the two chips talk to each
> other using I2C. My out-of-tree driver tried to remedy that by blocking those
> accesses while the driver used the chip, but, again, without Gigabyte / ITE
> support this was never a perfect solution, and there was always the risk that
> the board ended up hanging because that access was blocked for too long.
> Recent ITE chips solve that problem by providing memory mapped access to the
> chip registers, but that is only useful if one has a datasheet.

Are both of these chips available at the two well-known registers 0x2e and
0x4e?

Would this too-long blocking also occur when only accessing single registers
for read-only access?
Any write access would probably have to be blocked anyways.

> Overall, I don't think it makes much sense trying to make significant changes
> to the it87 driver without pulling in all the changes I had made, and without
> finding a better fix for the cross-chip access problems. I for sure won't have
> time for that (and getting hwmon patches reviewed is still very much an issue).
> 
> Having said that, I am of course open to adding WMI/ACPI drivers for the various
> boards. Good luck getting support from Gigabyte, though. Or from ASUS, for that
> matter.

Thomas
