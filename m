Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047853B2AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhFXJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhFXJDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9283C613BE;
        Thu, 24 Jun 2021 09:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624525292;
        bh=YnyWkWEizzBW+4L6vyTdV/hlaYvEAtpeYkBydMQ2mow=;
        h=Date:From:To:Cc:Subject:From;
        b=aQwL/UrAMMlnmYoIM+R5MOrDefVKmYZm/yxt9D8zGy5sUDzyDVtb3TdNzXSjgvRMj
         djKQmw5pwgYL9fZi0I266mgA/Jhm3s8qsb5+/cvflZx3N4hZP9j7y84v0vXE/HYorV
         heTSRcxGg9xCZdI2HO7qWQlxVNnCvuFOCMoJcYgwQrsotfywVvH9fF1ZdAVjFb8dPq
         PMKdp1NerfmZ91nbQC38JPNV0MJKUgU30x90awHGZkS5DtLgm9DF5RmCFqcoszyRr+
         zaAsUbaaDLM+m5jmaMxhfOvjWvDMs6G9tRseAJXOj23d7HB8Js0mf/W4uSUU+HBzQa
         D38fo3WJG/urQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lwLEq-0006iJ-OO; Thu, 24 Jun 2021 11:01:32 +0200
Date:   Thu, 24 Jun 2021 11:01:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 5.14-rc1
Message-ID: <YNRJ7D7kVwaLWXe5@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are the USB serial updates for 5.14-rc1.

Note that you'll get a merge conflict in cp210x between 

	6f7ec77cc8b6 ("USB: serial: cp210x: fix alternate function for CP2102N QFN20")

which is already in your tree and

	8051334e901f ("USB: serial: cp210x: add support for GPIOs on CP2108")

This was also reported by Stephen here

	https://lore.kernel.org/r/20210617150224.19213166@canb.auug.org.au

and the resolution should be straight forward.

Let me know if you prefer I pull in Linus's rc:s like you do to resolve any
issues like this in the future.

Johan



The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.14-rc1

for you to fetch changes up to 8051334e901f2f7ab9fa30a15b74cdc8e58dfde2:

  USB: serial: cp210x: add support for GPIOs on CP2108 (2021-06-16 17:40:01 +0200)

----------------------------------------------------------------
USB-serial updates for 5.14-rc1

Here are the USB-serial updates for 5.14-rc1, including:

 - gpio support for CP2108
 - chars_in_buffer and write_room return-value updates
 - chars_in_buffer and write_room clean ups

Included are also various clean ups.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Jiri Slaby (2):
      USB: serial: make usb_serial_driver::write_room return uint
      USB: serial: make usb_serial_driver::chars_in_buffer return uint

Johan Hovold (6):
      USB: serial: digi_acceleport: reduce chars_in_buffer over-reporting
      USB: serial: digi_acceleport: add chars_in_buffer locking
      USB: serial: io_edgeport: drop buffer-callback sanity checks
      USB: serial: mos7720: drop buffer-callback sanity checks
      USB: serial: mos7840: drop buffer-callback return-value comments
      USB: serial: drop irq-flags initialisations

Pho Tran (1):
      USB: serial: cp210x: add support for GPIOs on CP2108

 drivers/usb/serial/cp210x.c           | 189 ++++++++++++++++++++++++++++++----
 drivers/usb/serial/cyberjack.c        |   4 +-
 drivers/usb/serial/cypress_m8.c       |  16 +--
 drivers/usb/serial/digi_acceleport.c  |  46 ++++-----
 drivers/usb/serial/garmin_gps.c       |   2 +-
 drivers/usb/serial/generic.c          |  12 +--
 drivers/usb/serial/io_edgeport.c      |  39 ++-----
 drivers/usb/serial/io_ti.c            |  12 +--
 drivers/usb/serial/ir-usb.c           |   6 +-
 drivers/usb/serial/keyspan.c          |   4 +-
 drivers/usb/serial/kobil_sct.c        |   4 +-
 drivers/usb/serial/metro-usb.c        |  12 +--
 drivers/usb/serial/mos7720.c          |  29 ++----
 drivers/usb/serial/mos7840.c          |  17 ++-
 drivers/usb/serial/opticon.c          |   6 +-
 drivers/usb/serial/oti6858.c          |  12 +--
 drivers/usb/serial/quatech2.c         |   6 +-
 drivers/usb/serial/sierra.c           |   8 +-
 drivers/usb/serial/ti_usb_3410_5052.c |  16 +--
 drivers/usb/serial/usb-wwan.h         |   4 +-
 drivers/usb/serial/usb_wwan.c         |  12 +--
 include/linux/usb/serial.h            |   8 +-
 22 files changed, 286 insertions(+), 178 deletions(-)
