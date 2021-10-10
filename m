Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6583428248
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhJJPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhJJPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 11:30:20 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977BEC061570;
        Sun, 10 Oct 2021 08:28:21 -0700 (PDT)
Date:   Sun, 10 Oct 2021 17:28:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1633879699; bh=V9lgw1eB+RBEy+wK6KD0mCLUNFug1EVicB6VkbP5tm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpxiByitDVPJaAen+/bls/6B2KIg9ErsuDyMvJo9TfmcFSHff97wBwoZngXethTNZ
         /UD/mk45M+R6/R+eSriqr0y2by4Y7o5F+2w/zVyDvdiNNAtkSGu1hNsn2wiw5pVo5D
         deqvs8yxm7tHE/xJN5+Jc6i8tkSGhX0r4qlLQ0SE=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>, eugene.shalygin@gmail.com,
        andy.shevchenko@gmail.com, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
Message-ID: <64dda962-4ef1-496a-aa8e-7332e9fcce31@t-8ch.de>
References: <20211010095216.25115-1-pauk.denis@gmail.com>
 <20211010095216.25115-3-pauk.denis@gmail.com>
 <0a037ce5-87bb-4aad-a30a-d954ff0910a7@t-8ch.de>
 <7658358e-5ba6-b764-463c-317f5b318707@roeck-us.net>
 <13b23940-88d9-4c72-a55b-a66e8c8edffb@t-8ch.de>
 <e25063b9-634b-3f56-bcaf-77d8526b9a67@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e25063b9-634b-3f56-bcaf-77d8526b9a67@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-10T07:56-0700, Guenter Roeck wrote:
> On 10/10/21 7:10 AM, Thomas Weißschuh wrote:
> > On 2021-10-10T06:38-0700, Guenter Roeck wrote:
> > > On 10/10/21 3:20 AM, Thomas Weißschuh wrote:
> > > > Hi,
> > > > 
> > > > for WMI drivers the list platform-driver-x86@vger.kernel.org should probably be
> > > > on CC too.
> > > > Also all other WMI drivers, even for hwmon stuff are located in
> > > > drivers/platform/x86 so it may be better to put it there, too.
> > > > 
> > > 
> > > Not really. If any of those other drivers are pure hwmon drivers, they
> > > should reside in drivers/hwmon instead. And, yes, that really includes
> > > the gigabyte-wmi driver. We don't have arbitrary drivers in drivers/pci
> > > either just because they are drivers for pci devices.
> > 
> > Fair enough.
> > I suppose it would be too much churn to move gigabyte-wmi to
> > hwmon now though, correct?
> > 
> 
> Is it ? I don't recall the reason why it was added to drivers/platform/x86
> in the first place. I see other single-use wmi drivers in that directory
> as well (eg xiaomi-wmi, which should be in input). Is there some unwritten
> rule stating that all wmi drivers shall reside in drivers/platform/x86,
> no matter what subsystem they touch ?

There was no specific reason. I saw all the other WMI drivers in
drivers/platform/x86 and added mine there and sent it to the recipients as
reported by get_maintainer.pl.

You mentioned that it could move to hwmon but Hans said there are other
single-use wmi drivers in drivers/platform/x86 so I left it as is.

If you want me to move it, I'd be happy to do so.

In any case I think it would make sense to have some sort of written and
well-known policy about this, though.

> > Having the platform-driver-x86 on Cc would still be useful as they can provide
> > guidance about using the ACPI/WMI/platform APIs.
> > 
> 
> Sure, but that is unrelated to the driver location, and the opposite argument
> can be made as well (that drivers implementing subsystem code should be reviewed
> by subsystem maintainers). That is a much stronger argument in my opinion.
> 
> Guenter

Absolutely. I wanted to make two different points in my mail:

1) Maybe the driver should be moved into drivers/platform/x86 as the other
(single-use) WMI drivers are living there.
I don't know about any rule demanding that but was mentioning this so it stays
consistent.

2) The patch should *also* be reviewed by pdx86 as it is using their
infrastructure.
This was not meant to replace any of the hwmon involvement.

For example when I submitted gigabyte-wmi to pdx86 the maintainers they told
me to also solicit feedback from you as the hwmon maintainer.
And in the end both the hwmon parts (thank you!) and the wmi parts
(platform-device vs WMI bus, same as here) were much better than in the
first version.

> > For example by using the WMI bus as mentioned in my other mail would allow
> > to completely remove the manually maintained DMI list and instead directly bind
> > to the WMI GUID for any device that supports this GUID.
> > (This is possible as this WMI API seems to be self-describing, so all
> > specific parameters can be discovered by the driver)

Thomas
