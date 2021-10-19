Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94C433E10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhJSSI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:08:56 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45693 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhJSSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:08:55 -0400
Received: (Authenticated sender: peter@korsgaard.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id C9A5D1C0002;
        Tue, 19 Oct 2021 18:06:39 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.92)
        (envelope-from <peter@korsgaard.com>)
        id 1mctVX-0005yF-6z; Tue, 19 Oct 2021 20:06:39 +0200
X-From-Line: nobody Tue Oct 19 17:14:02 2021
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
        santoshyadav30@gmail.com, Mark Gross <mgross@linux.intel.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Support for EC-connected GPIOs for identify LED/button on Barco P50 board
References: <20211013140356.6235-1-santoshkumar.yadav@barco.com>
        <6183f051-969e-19e9-dd53-0d56a2fdf218@redhat.com>
Date:   Tue, 19 Oct 2021 17:14:02 +0200
In-Reply-To: <6183f051-969e-19e9-dd53-0d56a2fdf218@redhat.com> (Hans de
        Goede's message of "Tue, 19 Oct 2021 16:50:22 +0200")
Message-ID: <87a6j5cait.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Lines:  74
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Hans" == Hans de Goede <hdegoede@redhat.com> writes:

 > Hi,
 > On 10/13/21 16:03, Santosh Kumar Yadav wrote:
 >> Add a driver providing access to the GPIOs for the identify button and led
 >> present on Barco P50 board, based on the pcengines-apuv2.c driver.
 >> 
 >> There is unfortunately no suitable ACPI entry for the EC communication
 >> interface, so instead bind to boards with "P50" as their DMI product family
 >> and hard code the I/O port number (0x299).
 >> 
 >> The driver also hooks up the leds-gpio and gpio-keys-polled drivers to the
 >> GPIOs, so they are finally exposed as:
 >> 
 >> LED:
 >> /sys/class/leds/identify
 >> 
 >> Button: (/proc/bus/input/devices)
 >> I: Bus=0019 Vendor=0001 Product=0001 Version=0100
 >> N: Name="identify"
 >> P: Phys=gpio-keys-polled/input0
 >> S: Sysfs=/devices/platform/barco-p50-gpio/gpio-keys-polled/input/input10
 >> U: Uniq=
 >> H: Handlers=event10
 >> B: PROP=0
 >> B: EV=3
 >> B: KEY=1000000 0 0 0 0 0 0
 >> 
 >> Signed-off-by: Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
 >> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>

 > Thanks, overall this looks pretty good. I've a couple of comments inline,
 > please send a v2 addresing this.

..

 >> +/* Board setup */
 >> +static const struct dmi_system_id dmi_ids[] __initconst = {
 >> +       {
 >> +               .matches = {
 >> +                       DMI_EXACT_MATCH(DMI_PRODUCT_FAMILY, "P50")
 >> +               },
 >> +       },

 > But I'm a bit worried about the DMI match, it seems a bit too generic.

 > E.g. Lenovo also has a P50 laptop series.

 > For v2 please make the DMI match also on e.g. sys_vendor.

Agreed, will add a match on vendor = Barco.


 > You should put a:

 > MODULE_DEVICE_TABLE(dmi, dmi_ids);

 > here, this will add a dmi based modalias to the module, so that it will
 > be automatically loaded at boot on systems which match the dmi_ids table.

Ok.


 >> +MODULE_SOFTDEP("pre: platform:leds-gpio platform:gpio-keys-polled");

 > Is this softdep really necessary ? I would expect things to work fine too if
 > the leds-gpio and gpio-keys-polled drivers are loaded automatically after
 > the platform_devices for them have been created .

True. This was copied over from pcengines-apuv2.c, but we'll drop it for
v2.

-- 
Bye, Peter Korsgaard
