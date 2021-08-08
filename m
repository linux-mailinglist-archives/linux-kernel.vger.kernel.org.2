Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B593E39FF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 13:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhHHLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 07:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhHHLcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 07:32:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 278786101D;
        Sun,  8 Aug 2021 11:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628422307;
        bh=pFXS4VCk4tnXATSSr6pMxl6LeXMy+l/Ukg0gWGLdotE=;
        h=Date:From:To:Cc:Subject:From;
        b=h5XDsKRRuc2PyMyJmsx3fqY4kQGTDCM/8NY8RZ120/yuFhFT01+6W58cwzhxugXMl
         B4VHFfEf2zceTgrwNK/PP6N8gE0yi3JZQ/My57wsMngAi6AsGA+y89Xk4MhAgWW6qU
         78+28YNpPKiI3TeMYAtjRq/ZGRctjhG6olmPff2s=
Date:   Sun, 8 Aug 2021 13:31:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 5.14-rc5
Message-ID: <YQ/AoZ14maH5H6nf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.14-rc5

for you to fetch changes up to 75d95e2e39b27f733f21e6668af1c9893a97de5e:

  firmware_loader: fix use-after-free in firmware_fallback_sysfs (2021-07-29 17:22:15 +0200)

----------------------------------------------------------------
Driver core fixes for 5.14-rc5

Here are 3 tiny driver core and firmware loader fixes for 5.14-rc5.
They are:
	- driver core fix for when probing fails
	- firmware loader fixes for reported problems.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Anirudh Rayabharam (2):
      firmware_loader: use -ETIMEDOUT instead of -EAGAIN in fw_load_sysfs_fallback
      firmware_loader: fix use-after-free in firmware_fallback_sysfs

Filip Schauer (1):
      drivers core: Fix oops when driver probe fails

 drivers/base/dd.c                       |  4 ++--
 drivers/base/firmware_loader/fallback.c | 14 ++++++++------
 drivers/base/firmware_loader/firmware.h | 10 +++++++++-
 drivers/base/firmware_loader/main.c     |  2 ++
 4 files changed, 21 insertions(+), 9 deletions(-)
