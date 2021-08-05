Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06A3E107B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbhHEIkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232749AbhHEIkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:40:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DF64610FB;
        Thu,  5 Aug 2021 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628152826;
        bh=RBha8mc8dqM4Ua20cyhF2bwe936Pq++roM5DsIEMLcg=;
        h=Date:From:To:Cc:Subject:From;
        b=UEKr9ttISJjeNRr+Gi+5pqpPtwbXxez4rAK/zJthQxqI60GiaVxYhm4l4EWtt3uV5
         tz2NjQCNd9y7TQZOYjc/xlk6c7I1aHycemjNql5rTApQ8z95QdPrJs4pk/sqCNixZ1
         F90KQNrBUh2X8EMp9i2M/rbm+5M9/UZ6yD0z8zpPrz6TCPQ9XiVIHVAzRCgzZmYu/C
         ja3QrU1j1wP+VFGpOQNhGacR4wBNwJ4d7tOv9lQ0gearDpyY+tsYd73uKYn+YHlrBU
         EOTihlsjm6ugae54fQ5/frmhSpj0nyX6MpFc0HFPg4j4ZrfubCHt0ZUd2ZE2cQcM2u
         xnAGrJa6wVAHg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mBYum-0008Fe-UV; Thu, 05 Aug 2021 10:39:45 +0200
Date:   Thu, 5 Aug 2021 10:39:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.14-rc5
Message-ID: <YQuj0Nqq3YRXVLKh@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.14-rc5

for you to fetch changes up to 8da0e55c7988ef9f08a708c38e5c75ecd8862cf8:

  USB: serial: ftdi_sio: add device ID for Auto-M3 OP-COM v2 (2021-08-05 09:47:25 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.14-rc5

Here are two type-detection regression fixes for pl2303 and a patch to
increase the receive buffer size for for ch341 to avoid lost characters
at high line speeds.

Included are also some new device ids.

All but the last three commits have been in linux-next and with no
reported issues.

----------------------------------------------------------------
Daniele Palmas (1):
      USB: serial: option: add Telit FD980 composition 0x1056

David Bauer (1):
      USB: serial: ftdi_sio: add device ID for Auto-M3 OP-COM v2

Johan Hovold (2):
      USB: serial: pl2303: fix HX type detection
      USB: serial: pl2303: fix GT type detection

Willy Tarreau (1):
      USB: serial: ch341: fix character loss at high transfer rates

 drivers/usb/serial/ch341.c        |  1 +
 drivers/usb/serial/ftdi_sio.c     |  1 +
 drivers/usb/serial/ftdi_sio_ids.h |  3 +++
 drivers/usb/serial/option.c       |  2 ++
 drivers/usb/serial/pl2303.c       | 42 ++++++++++++++++++++++++---------------
 5 files changed, 33 insertions(+), 16 deletions(-)
