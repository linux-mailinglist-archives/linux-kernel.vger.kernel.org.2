Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4490C3CBBE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhGPSgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:36:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:43372 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPSgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:36:50 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AB8D14A2;
        Fri, 16 Jul 2021 18:33:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AB8D14A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626460434; bh=IOhvh6s7TBzb4YTWnj3YYWT8WSg5gjl2lvgZ2N5ehl4=;
        h=From:To:Cc:Subject:Date:From;
        b=fUL2Yx/YDe/7uF32i1McO29I4co2rP06ugCGpzaXwHaoKbMbhDV/h1niL3iWwDiol
         RtxhD1yU4IZr4xj0a1rt4b6QYOv9a05uq1zNLqi0twnKbvYaUTxUhFQJPzihtPA/63
         1WWd9XdHZ+jDU5+e+IUjDom6zoCDF/E213i887f2mhzmxFpPv+8oWHSuKhZaFk1/3z
         YA0JJ+qZF4ibhKBlhORq7DKKUTqkhQTNj3vMITIkSqsCoTGyKeUxL6xmqhEsBydHTv
         OoC5mXM50IOmFwEyd0WuTIVsqcvyaklEXWBy4f+DkI4wA88KrjckMEo80bhRZUaLg6
         xUUEmIQKxP3OQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.14
Date:   Fri, 16 Jul 2021 12:33:54 -0600
Message-ID: <87fsweds6l.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.14-2

for you to fetch changes up to 530c4374e21ae750c5fa5aa67b36a97635ddb379:

  docs/zh_CN: add a missing space character (2021-07-15 06:33:44 -0600)

----------------------------------------------------------------
A handful of fixes in and around documentation.  Some funky quotes in
LICENSES/dual/CC-BY-4.0 were giving spdxcheck.py grief; that has been
fixed on both ends.  Also a couple of features updates and one docs
build fix.

----------------------------------------------------------------
Hu Haowen (1):
      docs/zh_CN: add a missing space character

Ingo Molnar (2):
      Documentation/features: Update the ARCH_HAS_TICK_BROADCAST entry
      Documentation/features: Add THREAD_INFO_IN_TASK feature matrix

Nishanth Menon (2):
      scripts/spdxcheck.py: Strictly read license files in utf-8
      LICENSES/dual/CC-BY-4.0: Git rid of "smart quotes"

 .../core/thread-info-in-task/arch-support.txt      | 32 ++++++++++++++++++++++
 .../time/arch-tick-broadcast/arch-support.txt      |  2 +-
 .../translations/zh_CN/process/2.Process.rst       |  4 +--
 LICENSES/dual/CC-BY-4.0                            |  2 +-
 scripts/spdxcheck.py                               |  2 +-
 5 files changed, 37 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/features/core/thread-info-in-task/arch-support.txt
