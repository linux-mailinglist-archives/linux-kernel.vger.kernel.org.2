Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552BD3DB834
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbhG3MGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238736AbhG3MGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:06:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F1A860C41;
        Fri, 30 Jul 2021 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627646798;
        bh=p6LB3X1GqM8vlAqHFQjYyPK8Pdu8hNmPwBeOntH+zFE=;
        h=Date:From:To:cc:Subject:From;
        b=p+WFv+34FjpkpZ4D5jm87dwjdalexuKRlO8r9umfgdBH9XZP9JGntLauPDQ+53Tnu
         6tdgyG5sMy0xaCuGIDipI0+c9n55DTu2txiw7idGSymaAjtAdHSKrrGKdLtn/+v7Ak
         bcVRJ5/zWBbtyByI+EF22wesrFdC7DKJrMYUFVj69dcA5kVNuwRG1aaoX9FZIalAWz
         DYoIc64G7XXzcwQLrKKKR+vBoqVpNdyMF6FNl8TgSutYICqmd964WyNkjMth5Z6OXG
         qX/Gcm9EY+WdAPkPANoQGq8fYZ0RrXiL89ZiY9GFZVL4vYzVRac62xftXSTo6LygVR
         Dto5+gdaIqiqg==
Date:   Fri, 30 Jul 2021 14:06:35 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2107301403090.8253@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem fixes.

=====
- resume timing fix for intel-ish driver from Ye Xiang
- fix for using incorrect MMIO register in amd_sfh driver from Dylan 
  MacKenzie
- Cintiq 24HDT / 27QHDT regression fix and touch processing fix for Wacom 
  driver from Jason Gerecke
- device removal bugfix for ft260 driver from Michael Zaidman
- other small assorted fixes
=====

Thanks.

----------------------------------------------------------------
Christophe JAILLET (1):
      HID: fix typo in Kconfig

Colin Ian King (1):
      HID: Kconfig: Fix spelling mistake "Uninterruptable" -> "Uninterruptible"

Dylan MacKenzie (1):
      HID: amd_sfh: Use correct MMIO register for DMA address

Haochen Tong (1):
      HID: apple: Add support for Keychron K1 wireless keyboard

Jason Gerecke (2):
      HID: wacom: Re-enable touch by default for Cintiq 24HDT / 27QHDT
      HID: wacom: Skip processing of touches with negative slot values

Luke D. Jones (1):
      HID: asus: Remove check for same LED brightness on set

Michael Zaidman (2):
      HID: ft260: fix format type warning in ft260_word_show()
      HID: ft260: fix device removal due to USB disconnect

Ye Xiang (1):
      HID: intel-ish-hid: use async resume function

 drivers/hid/Kconfig                          |  2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c       |  2 +-
 drivers/hid/hid-apple.c                      |  2 ++
 drivers/hid/hid-asus.c                       |  3 ---
 drivers/hid/hid-ft260.c                      | 27 +++++++++-----------------
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 15 +++++++++++++-
 drivers/hid/intel-ish-hid/ishtp-hid.h        |  1 +
 drivers/hid/intel-ish-hid/ishtp/bus.c        | 29 +++++++++++++++++++++-------
 drivers/hid/usbhid/Kconfig                   |  2 +-
 drivers/hid/wacom_wac.c                      |  5 ++++-
 include/linux/intel-ish-client-if.h          |  2 ++
 11 files changed, 57 insertions(+), 33 deletions(-)

-- 
Jiri Kosina
SUSE Labs

