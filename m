Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5216037EDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbhELUwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:52:50 -0400
Received: from ms.lwn.net ([45.79.88.28]:46786 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1389186AbhELUvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:51:10 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5EC7137B;
        Wed, 12 May 2021 20:49:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5EC7137B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620852599; bh=A72A0ng7ue0f4QDFOktx3v8jm1ywul+VfilJg4lRtcs=;
        h=From:To:Cc:Subject:Date:From;
        b=dH6uMndNMgSVZpxK1Ve1MvsAwfCoin4p0xCOaLtS7skowNxicsMF38jAsLqsbjve8
         Gj5HzuQdpZm4LLxHjKi/koaSkgAIFWYiRO7w9rwNDBjBotyshZosXIwcNoPRo/Jyaa
         OZMNkdsdak8GWl1sgOq9/eRiisJrEFeFGR9bSQaK4FJFWQ1KVHmxpVefh4t/tIQBgC
         tSCeDTmhe5C77JzvcZrjQx7aonjgLZotLZRk0/vFTrAgzQXnSS8O1Lb5jHRLXkSxvu
         Ljw5jzltOQD+rO8xHf7V/KS0kvhT18E7fiAkRwtRRvB2wGHZIeuqO3Bu2Occ6kBzmY
         QT8vg15pQzbKg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes
Date:   Wed, 12 May 2021 14:49:58 -0600
Message-ID: <87mtszad8p.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.13-3

for you to fetch changes up to 7240cd200541543008a7ce4fcaf2ba5a5556128f:

  Remove link to nonexistent rocket driver docs (2021-05-11 11:02:39 -0600)

----------------------------------------------------------------
A set of straightforward documentation fixes.

----------------------------------------------------------------
Desmond Cheong Zhi Xi (1):
      Remove link to nonexistent rocket driver docs

Mauro Carvalho Chehab (5):
      docs: cdrom-standard.rst: get rid of uneeded UTF-8 chars
      docs: ABI: remove a meaningless UTF-8 character
      docs: ABI: remove some spurious characters
      docs: hwmon: tmp103.rst: fix bad usage of UTF-8 chars
      docs: networking: device_drivers: fix bad usage of UTF-8 chars

Randy Dunlap (1):
      Documentation: drop optional BOMs

Wan Jiabing (1):
      docs/zh_CN: Remove obsolete translation file

 .../ABI/obsolete/sysfs-kernel-fadump_registered    |  2 +-
 .../ABI/obsolete/sysfs-kernel-fadump_release_mem   |  2 +-
 Documentation/ABI/testing/sysfs-module             |  4 +-
 Documentation/block/data-integrity.rst             |  2 +-
 Documentation/cdrom/cdrom-standard.rst             | 30 ++++++-------
 Documentation/driver-api/serial/index.rst          |  1 -
 Documentation/hwmon/tmp103.rst                     |  4 +-
 .../device_drivers/ethernet/intel/i40e.rst         |  4 +-
 .../device_drivers/ethernet/intel/iavf.rst         |  2 +-
 .../process/kernel-enforcement-statement.rst       |  2 +-
 Documentation/security/tpm/xen-tpmfront.rst        |  2 +-
 Documentation/timers/no_hz.rst                     |  2 +-
 Documentation/translations/zh_CN/SecurityBugs      | 50 ----------------------
 Documentation/usb/mtouchusb.rst                    |  2 +-
 Documentation/usb/usb-serial.rst                   |  2 +-
 15 files changed, 30 insertions(+), 81 deletions(-)
 delete mode 100644 Documentation/translations/zh_CN/SecurityBugs
