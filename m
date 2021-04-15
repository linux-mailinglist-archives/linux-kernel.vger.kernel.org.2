Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B78360B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhDONvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhDONva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:51:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8CAA613C1;
        Thu, 15 Apr 2021 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618494667;
        bh=D7sm2qqgaD/7c4PS2a73fPMjW4FAumJxHXGEvZrajCw=;
        h=Date:From:To:cc:Subject:From;
        b=jCrj8aDrg+wiCRNHHdNYJWS+O8HSlqJJtDSk3IebrM7R5Yr/mGD+eANnbcLSEWPHR
         /4ntjLEQUsokBL2jw2eN4+reuBK1Wv4beK580j0OhypJyBRk5ji6gYNm1SanKb5yow
         blNeSyJtGqCmx/YKK1GN1WkYBgJmoPrq2yGk15m/gTnqvE2qyFFXAsyuT+9BD+HNVa
         NXLDFzloJOvNQ8DAMsVaFK3M5Et4n+zBdOZrGpg1/p6T+BH4Yp2LmVu9xBWXGT4yto
         X05YJOe7DmwpUpLRjdW6LNECnzI84bh1Djd+9O2ogo+e6aNF0dzdrlO3bUrqmhk++p
         LwHovSXkCLXJA==
Date:   Thu, 15 Apr 2021 15:51:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2104151547250.18270@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID fixes. I wanted to send them earlier than for the last -rc, 
but then unfortunately many things interfered. The changes are all 
device/driver specific fixes.

=====
- EV_KEY and EV_ABS regression fix for Wacom from Ping Cheng
- BIOS-specific quirk to fix some of the AMD_SFH-based systems, from Hans 
  de Goede
- other small error handling fixes and device ID additions
=====

Thanks.

----------------------------------------------------------------
Douglas Gilbert (1):
      HID cp2112: fix support for multiple gpiochips

Hans de Goede (3):
      AMD_SFH: Removed unused activecontrolstatus member from the amd_mp2_dev struct
      AMD_SFH: Add sensor_mask module parameter
      AMD_SFH: Add DMI quirk table for BIOS-es which don't set the activestatus bits

Jia-Ju Bai (1):
      HID: alps: fix error return code in alps_input_configured()

Jiapeng Zhong (1):
      HID: wacom: Assign boolean values to a bool variable

Luke D Jones (1):
      HID: asus: Add support for 2021 ASUS N-Key keyboard

Ping Cheng (1):
      HID: wacom: set EV_KEY and EV_ABS only for non-HID_GENERIC type of devices

Shou-Chieh Hsu (1):
      HID: google: add don USB id

 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 40 +++++++++++++++++++++++++++++++---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h |  1 -
 drivers/hid/hid-alps.c                 |  1 +
 drivers/hid/hid-asus.c                 |  3 +++
 drivers/hid/hid-cp2112.c               | 22 +++++++++----------
 drivers/hid/hid-google-hammer.c        |  2 ++
 drivers/hid/hid-ids.h                  |  2 ++
 drivers/hid/wacom_wac.c                |  8 +++----
 8 files changed, 59 insertions(+), 20 deletions(-)

-- 
Jiri Kosina
SUSE Labs

