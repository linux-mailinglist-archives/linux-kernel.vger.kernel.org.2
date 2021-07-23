Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484313D3C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhGWORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhGWORo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:17:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D0B060EB6;
        Fri, 23 Jul 2021 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627052296;
        bh=rZcEOxNvSLjMgqTg7OTDkrLNaseCvf9ayrUZM9yMcJk=;
        h=Date:From:To:Cc:Subject:From;
        b=AXbXQheYmzpxNKpjGtsnIPVlrJuhAVnwG2b36TY1wIXfO9hq7ezEVwn2rjBxRMK9T
         dhH/Y7F5btbwGnWWKaqwhTtS9lowx2fHwMipxEA9wTvkZUHLocxSOy01yOisegholo
         Sq3hDeiHThl0n96o1WOC/vUibp1LmLN1n1X8j5MA=
Date:   Fri, 23 Jul 2021 16:58:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 5.14-rc3
Message-ID: <YPrZBiDr/6Y78Vda@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.14-rc3

for you to fetch changes up to e64daad660a0c9ace3acdc57099fffe5ed83f977:

  driver core: Prevent warning when removing a device link from unregistered consumer (2021-07-21 17:28:42 +0200)

----------------------------------------------------------------
Driver core fixes for 5.14-rc3

Here are 2 small driver core fixes to resolve some reported problems for
5.14-rc3.  They include:
	- aux bus memory leak fix
	- unneeded warning message removed when removing a device link.

Both have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adrian Hunter (1):
      driver core: Prevent warning when removing a device link from unregistered consumer

Peter Ujfalusi (1):
      driver core: auxiliary bus: Fix memory leak when driver_register() fail

 drivers/base/auxiliary.c | 8 +++++++-
 drivers/base/core.c      | 6 ++++--
 2 files changed, 11 insertions(+), 3 deletions(-)
