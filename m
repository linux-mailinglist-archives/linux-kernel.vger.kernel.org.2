Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA04B3889EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhESIzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:55:52 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53108 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhESIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:55:51 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 324F91C0B7F; Wed, 19 May 2021 10:54:31 +0200 (CEST)
Date:   Wed, 19 May 2021 10:54:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jafar Akhondali <jafar.akhoondali@gmail.com>, jlee@suse.com,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: acer-wmi: Add support for Acer Helios 300
 RGB keyboard backlight
Message-ID: <20210519085429.GA2025@bug>
References: <CAMW3L+24ZGowtpURUbjoCoA+eZMF0wDae1izxS+HM2uz1L9Rig@mail.gmail.com>
 <9e455325-d9d6-557d-e9a5-779f59e2af4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e455325-d9d6-557d-e9a5-779f59e2af4c@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > From e65b0ddbf559aa3ca8a7998404e7e67e64b705e9 Mon Sep 17 00:00:00 2001
> > From: JafarAkhondali <jafar.akhoondali@gmail.com>
> > Date: Fri, 14 May 2021 08:26:47 +0430
> > Subject: [PATCH] platform/x86: acer-wmi: Add support for Acer Helios
> > 300 rgb keyboard backlight
> > 
> > The Acer helios 300 provides gaming functions WMI that is available in
> > Windows, however this was not implemented in Linux. The process of finding
> > the related method was done by decompiling PredatorSense(official Acer
> > gaming functions software for Predator series) and decompiling WQ
> > buffers. This patch provides a gaming interface which will then expose a
> > character device named "acer-gkbbl". This character device accepts 16
> > bytes long config, which is specific for the backlight method. The
> > meaning of each bytes ordered by bit position is as follows:
> > 
> > Bit 0 -> Backlight modes:
> > 1: Breath
> > 2: Neon
> > 3: Wave
> > 4: Shifting
> > 5: Zoom
> > Bit 1 -> Animation Speed: from 1 to 9 ( 1 is slowest, 9 is fastest)
> > Bit 2 -> Brightness from 0 to 100 ( 0 is no backlight, 100 is brightest)
> > Bit 3 -> Unknown. Wave effect uses 8, other modes must use 0
> > Bit 4 -> Animation Direction:
> > 1: Right-to-Left
> > 2: Left-to-Right
> > Bit 5 -> Red Color Selection
> > Bit 6 -> Green Color Selection
> > Bit 7 -> Blue Color Selection
> > Bit 8 -> Currently unknown, or not used in known model
> > Bit 9 -> Currently unknown, or not used in known model
> > Bit 10 -> Currently unknown, or not used in known model
> > Bit 11 -> Currently unknown, or not used in known model
> > Bit 12 -> Currently unknown, or not used in known model
> > Bit 13 -> Currently unknown, or not used in known model
> > Bit 14 -> Currently unknown, or not used in known model
> > Bit 15 -> Currently unknown, or not used in known model
> > 
> > Filling this config is out of scope for the kernel module, and this module
> > only acts as an interface.
> > 
> > Currently, I'm not sure with the method for communicating with user-space,
> > but since leds.h subsystem wouldn't fit for complex actions such as this
> > complex config, I couldn't find any better method than char dev.
> 
> Thank you for your patch, given that there is no existing kernel
> interface which is a good match for the features exported by this
> keyboard I'm fine with just having a raw interface where userspace
> writes GAMING_KBBL_CONFIG_LEN bytes as you suggest.

Keyboard backlight goes through LED interface (so please cc the mailing list) and
no, passing raw bytes to hardware is not an acceptable interface.

> But lets not use a classdev + chardev for this please, you can
> just add a binary write-only sysfs-atrribute under the wmi-dev for
> this with a name like (for example) gaming_kbd_backlight_config
> and then userspace can write to that without needing a class + char
> dev just for this single write.

NAK. We have existing interfaces for this.

Best regards,
								Pavel
