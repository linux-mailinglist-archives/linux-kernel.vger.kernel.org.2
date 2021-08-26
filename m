Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088723F839B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbhHZIPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239817AbhHZIPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:15:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52A336102A;
        Thu, 26 Aug 2021 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629965705;
        bh=xxuJPpqWR33GkXkTcT4Nz+r/pSZoMmVFYscBwDiQ3L8=;
        h=Date:From:To:Cc:Subject:From;
        b=KVEuhHStdZzgpT4M3TAHho/U69D9/fLddhNDn5g68ASaxKgw+NOr5N+CPJy1AtVAE
         DSBdRYSsBJHU+wwh0zhkeaPjAlgDUcCx2MDItDtt0JO+37wrVIBEVyZMv5S5BL5/PR
         cnsELZadPotEjTGaNl2np6nSwhRAp0tln8Oe/o4PAJtnIQ645SHMHj56ViDRscunMo
         RtNfWlwT5ieX10hhREQH50MvSzl2JddaoR4eOp3h2XiKholeik8wU+66NPbctEe6LB
         lemXVyNtm0QB7A8+xT3r6kgu1l3DfofN5MW0OLPSjaloxrCS74L62q0VPcRV3CgleZ
         wQfZGNZGCEdjg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mJAXN-0007Hs-8C; Thu, 26 Aug 2021 10:15:01 +0200
Date:   Thu, 26 Aug 2021 10:15:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.14-rc8
Message-ID: <YSdNhWruPcclFUu9@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.14-rc8

for you to fetch changes up to df7b16d1c00ecb3da3a30c999cdb39f273c99a2f:

  Revert "USB: serial: ch341: fix character loss at high transfer rates" (2021-08-25 09:13:33 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.14-rc8

Here's a fix for a regression in 5.14 (also backported to stable) which
caused reads to stall for ch341 devices.

Included is also a new modem device id.

All but the revert have been in linux-next, and with no reported issues.

----------------------------------------------------------------
Johan Hovold (1):
      Revert "USB: serial: ch341: fix character loss at high transfer rates"

Zhengjun Zhang (1):
      USB: serial: option: add new VID/PID to support Fibocom FG150

 drivers/usb/serial/ch341.c  | 1 -
 drivers/usb/serial/option.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)
