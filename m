Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17701419575
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhI0N4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234589AbhI0N4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:56:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD58E60F4F;
        Mon, 27 Sep 2021 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750877;
        bh=xcFxy6MyzTR6iVTbX6fBwgGA1J9bnebZi7SNVjHXrfY=;
        h=Date:From:To:cc:Subject:From;
        b=sjPxw1S8k2ySZCHM8TSr1gBK5Cqu3b+CQJ1+5HlRgiV8wwX/yOThHS8sL3h3yJ/+W
         AnGwpOoS+jIwP1LOJ56Ltz+JWJ/LArKMuJw/YYvPKGP8Eqy8WawwXHF0F80Ailtz11
         5TSwVIXEpfSeMA8oSBEGtQ1fHuNgOhXpW6Tj3UsMGIesSJ9TcOxdQ6fsRxz+5+vx16
         oUbBKsflU+ZzLKoX0U7Y6AnX+Q3G2W8mcEji2ASznyqlXwKxX20DCx7iDU5MTKiaZA
         YQLMfllJIzd3pCR1E0KaXpEcfuec7S0ulzi0fXoH1KhkG8IZrK4B0ZspvdY5h5xaMA
         ltH0D0MCokAKw==
Date:   Mon, 27 Sep 2021 15:54:34 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2109271551130.15944@cbobk.fhfr.pm>
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
- NULL pointer dereference fixes in amd_sfh driver (Basavaraj Natikar, 
  Evgeny Novikov)
- data processing fix for hid-u2fzero (Andrej Shadura)
- fix for out-of-bounds write in hid-betop (F.A.Sulaiman)
- new device IDs / device-specific quirks
=====

Thanks.

----------------------------------------------------------------
Andrej Shadura (1):
      HID: u2fzero: ignore incomplete packets without data

Basavaraj Natikar (1):
      HID: amd_sfh: Fix potential NULL pointer dereference

Evgeny Novikov (1):
      HID: amd_sfh: Fix potential NULL pointer dereference

F.A.Sulaiman (1):
      HID: betop: fix slab-out-of-bounds Write in betop_probe

Joshua-Dickens (1):
      HID: wacom: Add new Intuos BT (CTL-4100WL/CTL-6100WL) device IDs

Mizuho Mori (1):
      HID: apple: Fix logical maximum and usage maximum of Magic Keyboard JIS

 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c |  8 ++++----
 drivers/hid/hid-apple.c                |  7 +++++++
 drivers/hid/hid-betopff.c              | 13 ++++++++++---
 drivers/hid/hid-u2fzero.c              |  4 +++-
 drivers/hid/wacom_wac.c                |  8 ++++++++
 5 files changed, 32 insertions(+), 8 deletions(-)

-- 
Jiri Kosina
SUSE Labs

