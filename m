Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39F45590F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 11:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbhKRKcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 05:32:39 -0500
Received: from ms.lwn.net ([45.79.88.28]:53468 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243409AbhKRKcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:32:32 -0500
Received: from localhost (unknown [151.34.20.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2001B615E;
        Thu, 18 Nov 2021 10:29:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2001B615E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1637231370; bh=e0HnsECkTvPiMDr10G2QXBJrT9qzN992w+6UgN1B/tk=;
        h=From:To:Cc:Subject:Date:From;
        b=HoOQanOeQLzQBPjVCwMMEFJ6g0CyQa5ZTNmP9zkCipRHZWr0+pj3awMc0RTSGonVQ
         xZSieJB/mr5izu4a/WNywWzCD1b9bnSAS6zpuAzYD5mIK3oe6IIJwb1ELdJDIx8GBn
         /1z8b12RheEvSBdCCvqoc5elLOpO2oqAeNMC/fzV3GWzFd4ee01zAIA6gfC31006oi
         Vzd0L68htNF0oYrHroaWgnDstmxuOVseTBPL7CdoFUewRsS5H0hX6JLSg9xujYflyT
         YBe/qMSwoKWmiBR1hFDkEov/g0eKb4Ru0a9XK0KRrAb9vUXpO+lupyJe16OYY/l0ok
         rL1zymYrXaeaQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.16
Date:   Thu, 18 Nov 2021 03:29:26 -0700
Message-ID: <871r3dg3jt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.16-2

for you to fetch changes up to b96ff02ab2be1791248237b1bf318aaf62e8b701:

  Documentation/process: fix a cross reference (2021-11-17 06:12:14 -0700)

----------------------------------------------------------------
A handful of documentation fixes for 5.16

----------------------------------------------------------------
Akira Yokosawa (1):
      docs: Update Sphinx requirements

Alex Shi (1):
      doc/zh_CN: fix a translation error in management-style

Mauro Carvalho Chehab (4):
      libbpf: update index.rst reference
      docs: accounting: update delay-accounting.rst reference
      Documentation: update vcpu-requests.rst reference
      Documentation/process: fix a cross reference

Pali Roh=C3=A1r (3):
      Documentation: arm: marvell: Add some links to homepage / product inf=
os
      Documentation: arm: marvell: Put Armada XP section between Armada 370=
 and 375
      Documentation: arm: marvell: Fix link to armada_1000_pb.pdf document

Wasin Thonkaew (1):
      docs: filesystems: Fix grammatical error "with" to "which"

Zhaoyu Liu (1):
      docs: ftrace: fix the wrong path of tracefs

 Documentation/admin-guide/sysctl/kernel.rst        |  2 +-
 Documentation/arm/marvell.rst                      | 48 +++++++++++-------=
----
 Documentation/bpf/index.rst                        |  2 +-
 Documentation/doc-guide/sphinx.rst                 | 22 ++++------
 Documentation/filesystems/autofs.rst               |  2 +-
 Documentation/process/changes.rst                  |  2 +-
 Documentation/process/submitting-patches.rst       |  4 +-
 Documentation/trace/ftrace.rst                     |  9 ++--
 .../translations/it_IT/doc-guide/sphinx.rst        | 23 ++++-------
 .../translations/it_IT/process/changes.rst         |  2 +-
 .../translations/zh_CN/doc-guide/sphinx.rst        | 21 ++++------
 .../zh_CN/process/management-style.rst             |  4 +-
 arch/riscv/kvm/vcpu.c                              |  2 +-
 13 files changed, 65 insertions(+), 78 deletions(-)
