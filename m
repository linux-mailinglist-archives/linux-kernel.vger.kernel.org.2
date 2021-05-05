Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2513749E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhEEVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhEEVJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:09:21 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1CEC061574;
        Wed,  5 May 2021 14:08:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 35286740;
        Wed,  5 May 2021 21:08:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 35286740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620248903; bh=u6FyGnz/XwbN39MDwPpjlvpqqoCaqu9hcG9HGtkp0us=;
        h=From:To:Cc:Subject:Date:From;
        b=JDbPWn529Wa15IvARnLlpmjhWh/hszWrKabbyAG1I+z9cmoIRFVTFAR0r6Y1bj2r+
         POfs5WdVQZgsS1ojMmoAZsP3Tt/TWyeJjXb4tjA9gcUmZFAbcJ/wdWjQXR+1H0WDW1
         aY9UdINOT0SmrT2nSA9aQdiTAqUYA5sRtBiDkZUTepG4T+BIJw1ItKh+T9TZ0ORU7Q
         m5M0OsTmBdK8uBvwIYP8wBUoTdWxM5S70ugo4zImZpchMCE9KV369xj8MQMd7RtW3G
         4qLfLW4U5DGgu3aIfpTp26mldAa8QuaMEGKX7BecIBzHi2nBH2QiJKZRpn8MOrRXq+
         15S6lkM1u85WQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 5.13
Date:   Wed, 05 May 2021 15:08:22 -0600
Message-ID: <87pmy4khx5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 441ca977a84dadac6173db7c07c25db110b76c1e:

  docs/zh_CN: add openrisc translation to zh_CN index (2021-04-20 16:08:15 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.13-2

for you to fetch changes up to 7fc4607899e87259bb751ccdbe53628aa467ec22:

  Enlisted oprofile version line removed (2021-05-03 17:23:06 -0600)

----------------------------------------------------------------
A few late-arriving documentation fixes, including some oprofile cleanup, a
kernel-doc fix, some regression-reporting updates, and the usual minor
fixes.

----------------------------------------------------------------
Anatoly Pugachev (1):
      docs: correct URL to bios and kernel developer's guide

Bhaskar Chowdhury (3):
      Removed the oprofiled version option
      oprofiled version output line removed from the list
      Enlisted oprofile version line removed

Matthew Wilcox (1):
      kernel-doc: Add support for __deprecated

Randy Dunlap (1):
      Documentation: input: joydev file corrections

Thorsten Leemhuis (1):
      docs: reporting-issues.rst: CC subsystem and maintainers on regressions

Wu XiangCheng (1):
      docs/zh_CN: Adjust order and content of zh_CN/index.rst

Yanteng Si (1):
      docs/core-api: Consistent code style

bilbao@vt.edu (1):
      docs: Fix typo in Documentation/x86/x86_64/5level-paging.rst

 Documentation/ABI/testing/sysfs-devices-system-cpu |   2 +-
 Documentation/admin-guide/reporting-issues.rst     |  49 +++---
 Documentation/core-api/symbol-namespaces.rst       |  26 ++--
 Documentation/input/joydev/joystick-api.rst        |  14 +-
 Documentation/input/joydev/joystick.rst            |  26 ++--
 Documentation/process/changes.rst                  |   1 -
 .../translations/it_IT/process/changes.rst         |   1 -
 Documentation/translations/zh_CN/index.rst         | 168 +++++++++++++++++++--
 Documentation/x86/x86_64/5level-paging.rst         |   4 +-
 scripts/kernel-doc                                 |   1 +
 scripts/ver_linux                                  |   1 -
 11 files changed, 225 insertions(+), 68 deletions(-)
