Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB989416D77
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244641AbhIXIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244561AbhIXIKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:10:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2144610F7;
        Fri, 24 Sep 2021 08:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632470929;
        bh=h5t3gDZn60MU8ZE7VKIxFCCn1WkNkGwylZ89i2iIZqA=;
        h=Date:From:To:Cc:Subject:From;
        b=tDyF35wqn6itte2A8LjqHMwsWiAfOHrgz1MbTczWi5oV75Fua4RzaUbv+vGI/Fir0
         1Kycwo8GU8Rs+zvFZCFCPq1CscH+xfIxo1VxDRjheByva32oaWPN3vgE2/0ReU/BBR
         SIslzyxzlj8JutqwUG5/EsYd8Gt0WOcG3RhL9xI2PlsaX9F/ynthbxVRscwthszIyJ
         va27Jnd9Bjv1b/bO0CLWgSNQFcAiajWEYg4OUJJl8ic7JmDa62dp7lsvH/e2VdzGOg
         xlx8eI8QL4M6D2EjsQYeTNCIHSXRfGh3TMH9RcZbA+Fo1M0SLaecs2BqfGdp67WJio
         MIP9oPu340MHg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mTgGJ-0005rB-PZ; Fri, 24 Sep 2021 10:08:51 +0200
Date:   Fri, 24 Sep 2021 10:08:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.15-rc3
Message-ID: <YU2Hk/bryF85iq5G@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.15-rc3

for you to fetch changes up to 9e3eed534f8235a4a596a9dae5b8a6425d81ea1a:

  USB: serial: option: add device id for Foxconn T99W265 (2021-09-24 09:32:11 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.15-rc3

Here's a fix for a regression affecting some CP2102 devices and a host
of new device ids.

Included are also a couple of cleanups of duplicate device ids, which
are also tagged for stable to keep the tables in sync, and a trivial
patch to help debugging cp210x issues.

All have been in linux-next with no reported issues. Note however that
the last last two device-id commits were rebased to fix up a lore link
in a commit message (as the patch itself never made it to the list).

----------------------------------------------------------------
Carlo Lobrano (1):
      USB: serial: option: add Telit LN920 compositions

Johan Hovold (2):
      USB: serial: cp210x: fix dropped characters with CP2102
      USB: serial: cp210x: add part-number debug printk

Krzysztof Kozlowski (2):
      USB: serial: mos7840: remove duplicated 0xac24 device ID
      USB: serial: option: remove duplicate USB device ID

Slark Xiao (1):
      USB: serial: option: add device id for Foxconn T99W265

Uwe Brandt (1):
      USB: serial: cp210x: add ID for GW Instek GDM-834x Digital Multimeter

 drivers/usb/serial/cp210x.c  | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/mos7840.c |  2 --
 drivers/usb/serial/option.c  | 11 ++++++++++-
 3 files changed, 48 insertions(+), 3 deletions(-)
