Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFB3E33F9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhHGH0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 03:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhHGH0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 03:26:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C78C610A1;
        Sat,  7 Aug 2021 07:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628321182;
        bh=IMpk0o1hS1Y/l+HPxA2D6QVy28dpg16VfLfqbilGAdM=;
        h=Date:From:To:Subject:From;
        b=LzskHGcyTIxa4dSUluOVMceoyA56cmOXbee1mhI0SjUZ6+Ggw3hqth537S3AzSEVh
         HXCNHEYh3L6Gkfsbt5f53hOZJD5a4vmKKQPViE+HuFiM52mT24livNSuFaUE8zqn9R
         J74iDpm3e7Ez7wSewI5M/utFbxA/U4K2CXH/aang=
Date:   Sat, 7 Aug 2021 09:26:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: usbutils 014 release
Message-ID: <YQ41m+9JMSzt69fM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to announce the usbutils 014 release.  There have been a number
of small changes in it over the past 8 months, so it's time to finally
bundle it together and do an "official" release so that the distros can
take advantage of the update.

One nice new thing is that the project is now REUSE compliant, to make
it easier for users to verify the license and copyright information of
all files in the release.

Full details of the changes are found below in the shortlog.

Tarballs can be found on kernel.org here:
	https://www.kernel.org/pub/linux/utils/usb/usbutils/

Or you can pull from the following git locations as well:
	https://github.com/gregkh/usbutils
	https://github.com/linux-usb/usbutils
	https://git.sr.ht/~gregkh/usbutils
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usbutils.git


thanks,

greg k-h

------------

usbutils 014
============

Adrian Kalazi (1):
      Add Tx+Rx lanes to tree mode

Aurelien Jarno (1):
      lsusb(8): mention the udev's hardware database

Benson Leung (1):
      lsusb: Fix typo in string output for iAdditionalInfoURL

Bui Quang Minh (1):
      lsusb-t: Add lower bound checks in read_sysfs_file_string

Grant Grundler (2):
      lsusb: remove unused RETRIES constant
      lsusb: don't complain on EAGAIN

Greg Kroah-Hartman (10):
      sysfs: add copyright notice taken from name.*
      LICENSES: add symlink to handle "or-later" issue for GPL-2.0
      LICENSES: put spdx headers on the license files
      rename "GPL-2.0+" to "GPL-2.0-or-later"
      LICENSE: rename GPL-3.0.txt -> GPL-3.0-only.txt
      usbhid-dump.8.in: add copyright information
      .gitignore: add copyright and SPDX info
      usbhid-dump: add copyright and SPDX info
      SPDX header cleanups from GPL-2.0 -> GPL-2.0-only
      usbutils.spdx: update with output of latest reuse tool

Jonathan Neuschäfer (2):
      lsusb: Fix spelling of bEndpointAddress in UVC
      lsusb: Decode endpoint addresses in UVC

Lukas Zaoral (3):
      lsusb.c: fix leak in dump_printer_device
      usb-devices: do not use `local` in a POSIX shell script
      desc-defs.c: fix possible out-of-bound read

Matthias Braun (1):
      Fix typos in lsusb.8.in

Ruslan Kabatsayev (5):
      Fix locating endpoint when it's a directory rather than a symlink
      Fix formatting of interface descriptors to match /sys/kernel/debug/usb/devices
      Fix formatting of endpoint direction to match /sys/kernel/debug/usb/devices
      Fix formatting of endpoint type to match /sys/kernel/debug/usb/devices
      Fix formatting of max endpoint packet size to match /sys/kernel/debug/usb/devices

Thomas Hebb (1):
      lsusb: Fix buffer size copy/paste error

Tormod Volden (1):
      Makefile.am: Remove unused DATADIR


