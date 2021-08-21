Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4743F3B55
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhHUQBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232241AbhHUQBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D36861185;
        Sat, 21 Aug 2021 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629561661;
        bh=zLcG6eCRDwa3AoP4nE3SApdmZOjuODzvV9o1Fg5kIfo=;
        h=Date:From:To:Cc:Subject:From;
        b=WyiYnWtWoh3i1A4Z7nM2zWZLNq9gCRar6WIntbOIhdBjvulTgmb8vxy6nIGXWVHLr
         nYRqODYXJJ6SuWC5bZegzSmrUcSSuJBBUCrnO/1ZDTX9emt7twDNJYF6SojOF/uFpw
         wE9XCnLMGqyaPrIaB+Y/nD0omUGNeNhG1nKKBP2o=
Date:   Sat, 21 Aug 2021 18:00:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fix for 5.14-rc7
Message-ID: <YSEjOWqWv/mo6eOQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc7

for you to fetch changes up to 5571ea3117ca22849072adb58074fb5a2fd12c00:

  usb: typec: tcpm: Fix VDMs sometimes not being forwarded to alt-mode drivers (2021-08-18 15:59:23 +0200)

----------------------------------------------------------------
USB fix for 5.14-rc7

Here is a single USB typec tcpm fix for a reported problem for 5.14-rc7.
It showed up in 5.13 and resolves an issue that Hans found.  It has been
in linux-next this week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Hans de Goede (1):
      usb: typec: tcpm: Fix VDMs sometimes not being forwarded to alt-mode drivers

 drivers/usb/typec/tcpm/tcpm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)
