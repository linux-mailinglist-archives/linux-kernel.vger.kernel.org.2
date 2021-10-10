Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C1C4281AD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhJJOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhJJOMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 10:12:44 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1CC061570;
        Sun, 10 Oct 2021 07:10:46 -0700 (PDT)
Date:   Sun, 10 Oct 2021 16:10:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1633875043; bh=IMqHgPD32NOtwhKZ44gkSBf60ECkunQnAY66nwYyGpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVnDgWCDNLKXYQkhSB5F8zRRyZe+/VVm3qYN1f4aZxvuMcYInGU7u4Pfab4XlaEiw
         O+nhxpzzrtpKLcfQeI0m1ZfNz+ww/HI9ycXVvsJ1kpob8ubVNaCQc50TK+7zW+w8Ug
         ChEWIC0OgdL7QUrKzMg7UcdjpSBqRdG+o83oQFLI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>, eugene.shalygin@gmail.com,
        andy.shevchenko@gmail.com, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
Message-ID: <13b23940-88d9-4c72-a55b-a66e8c8edffb@t-8ch.de>
References: <20211010095216.25115-1-pauk.denis@gmail.com>
 <20211010095216.25115-3-pauk.denis@gmail.com>
 <0a037ce5-87bb-4aad-a30a-d954ff0910a7@t-8ch.de>
 <7658358e-5ba6-b764-463c-317f5b318707@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7658358e-5ba6-b764-463c-317f5b318707@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-10T06:38-0700, Guenter Roeck wrote:
> On 10/10/21 3:20 AM, Thomas Weißschuh wrote:
> > Hi,
> > 
> > for WMI drivers the list platform-driver-x86@vger.kernel.org should probably be
> > on CC too.
> > Also all other WMI drivers, even for hwmon stuff are located in
> > drivers/platform/x86 so it may be better to put it there, too.
> > 
> 
> Not really. If any of those other drivers are pure hwmon drivers, they
> should reside in drivers/hwmon instead. And, yes, that really includes
> the gigabyte-wmi driver. We don't have arbitrary drivers in drivers/pci
> either just because they are drivers for pci devices.

Fair enough.
I suppose it would be too much churn to move gigabyte-wmi to
hwmon now though, correct?

Having the platform-driver-x86 on Cc would still be useful as they can provide
guidance about using the ACPI/WMI/platform APIs.

For example by using the WMI bus as mentioned in my other mail would allow
to completely remove the manually maintained DMI list and instead directly bind
to the WMI GUID for any device that supports this GUID.
(This is possible as this WMI API seems to be self-describing, so all
specific parameters can be discovered by the driver)

Thomas
