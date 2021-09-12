Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF422407DBA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 16:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhILOE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 10:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhILOE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 10:04:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 687E261039;
        Sun, 12 Sep 2021 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631455423;
        bh=c5yCUw0T6FcB/bXkAOSTCJb58L+/egyiW0yK5I7dpQg=;
        h=Date:From:To:Cc:Subject:From;
        b=ubjGifgxhUrowPiQE1ksBU64wv5v5Mu3TgPVx+130zDKHpuNCtbxc9uhAgESyiF3p
         XaqxRrkHZ7XEQFI/46O3gwA9r+fuTAKkmfsOapNM+A+AsDUjEJWoTeX5GZyzdDjbt6
         QFW97koiBAbi2nTjUaYEjHnUCUb7hE7IqbQ2yuBI=
Date:   Sun, 12 Sep 2021 16:03:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] Misc driver fix for 5.15-rc1
Message-ID: <YT4IvKLQHm9mfpR+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bf9f243f23e6623f310ba03fbb14e10ec3a61290:

  Merge tag '5.15-rc-ksmbd-part2' of git://git.samba.org/ksmbd (2021-09-09 16:17:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc1-lkdtm

for you to fetch changes up to 3a3a11e6e5a2bc0595c7e36ae33c861c9e8c75b1:

  lkdtm: Use init_uts_ns.name instead of macros (2021-09-10 17:09:40 +0200)

----------------------------------------------------------------
Misc driver fix for 5.15-rc1

Here is a single patch for 5.15-rc1, for the lkdtm misc driver.

It resolves a build issue that many people were hitting with your
current tree, and Kees and others felt would be good to get merged
before -rc1 comes out, to prevent them from having to constantly hit it
as many development trees restart on -rc1, not older -rc releases.

It has NOT been in linux-next, but has passed 0-day testing and looks
"obviously correct" when reviewing it locally :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Kees Cook (1):
      lkdtm: Use init_uts_ns.name instead of macros

 drivers/misc/lkdtm/core.c  | 10 ++++++++++
 drivers/misc/lkdtm/lkdtm.h | 28 +++++++++++++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)
