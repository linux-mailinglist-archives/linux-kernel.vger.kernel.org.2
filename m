Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8515C394C80
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhE2O3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 10:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhE2O3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 10:29:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64BAF61157;
        Sat, 29 May 2021 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622298446;
        bh=1P+cDThHFLJ5DWoDQlJSOefvLO2+1pFzzeFhdDE5qz0=;
        h=Date:From:To:Cc:Subject:From;
        b=fXvlDUcjvCRen0HT/+4yhcTwa0DkDROLlTasvnzoWlKM+nTjYRg8TMsY99g7qaWQ/
         zSuqH3HBFtcb5i/drkTBwif7UqkqDMu/4fYHd1gX4JDmEn3VmEUW9zmAajzO00c5LE
         bgaDr1C6CpcjI71jaK3DJQNTI0JO72vALPL9Urog=
Date:   Sat, 29 May 2021 16:27:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 5.13-rc4
Message-ID: <YLJPTFZ8aIx7Mu20@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc4

for you to fetch changes up to 0c8713153fbf7ba4e45172e139d501c86006dc03:

  drivers: base: Reduce device link removal code duplication (2021-05-21 22:12:14 +0200)

----------------------------------------------------------------
Driver core fixes for 5.13-rc4

Here are 3 small driver core / debugfs fixes for 5.13-rc4:
  - debugfs fix for incorrect "lockdown" mode for selinux accesses
  - 2 device link changes, one bugfix and one cleanup

All of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ondrej Mosnacek (1):
      debugfs: fix security_locked_down() call for SELinux

Rafael J. Wysocki (2):
      drivers: base: Fix device link removal
      drivers: base: Reduce device link removal code duplication

 drivers/base/core.c    | 68 ++++++++++++++++++++++++++------------------------
 fs/debugfs/inode.c     |  9 ++++---
 include/linux/device.h |  6 ++---
 3 files changed, 44 insertions(+), 39 deletions(-)
