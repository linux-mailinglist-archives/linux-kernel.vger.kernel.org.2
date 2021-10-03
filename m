Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3A7420129
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhJCKSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 06:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhJCKSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 06:18:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BDDF61A05;
        Sun,  3 Oct 2021 10:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633256222;
        bh=qwrZP4dKw6cHJcKptberzuDISPmPUXbMCT6n/3ZK8pg=;
        h=Date:From:To:Cc:Subject:From;
        b=WkHzPvkh8mS+N6G/pbw6Z+s8VAgypQrPoxRtSs0KXXvrgB7VZTadwEhugdtuvrf1X
         1xSQK2pMLW7QWg1sIBRfBSX04I1BMBz7ECtI9g1pUXbnX2a8DCWQMluS483rVeLgTI
         AgzgSYwjt3XNG3YEumeq1tyFC98AB4ufcAf7e410=
Date:   Sun, 3 Oct 2021 12:17:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.15-rc4
Message-ID: <YVmDHIFZyWWVcZHx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc4

for you to fetch changes up to bb8a4fcb2136508224c596a7e665bdba1d7c3c27:

  ipack: ipoctal: fix module reference leak (2021-09-27 17:38:49 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.15-rc4

Here are some small misc driver fixes for 5.15-rc4.  They are in two
"groups":
	- ipack driver fixes for issues found by Johan Hovold
	- interconnect driver fixes for reported problems

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'icc-5.15-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Johan Hovold (5):
      ipack: ipoctal: fix stack information leak
      ipack: ipoctal: fix tty registration race
      ipack: ipoctal: fix tty-registration error handling
      ipack: ipoctal: fix missing allocation-failure check
      ipack: ipoctal: fix module reference leak

Shawn Guo (4):
      interconnect: qcom: sdm660: Fix id of slv_cnoc_mnoc_cfg
      interconnect: qcom: sdm660: Correct NOC_QOS_PRIORITY shift and mask
      dt-bindings: interconnect: sdm660: Add missing a2noc qos clocks
      interconnect: qcom: sdm660: Add missing a2noc qos clocks

 .../bindings/interconnect/qcom,sdm660.yaml         | 46 ++++++++++++++--
 drivers/interconnect/qcom/sdm660.c                 | 25 ++++++---
 drivers/ipack/devices/ipoctal.c                    | 63 ++++++++++++++++------
 3 files changed, 108 insertions(+), 26 deletions(-)
