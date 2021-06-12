Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF03A4F98
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhFLP5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhFLP5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:57:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D63B3610FC;
        Sat, 12 Jun 2021 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623513295;
        bh=EDNW8qcQ6bxhsUUgeTf9VlCr0Q/8pLhBmFNUlwYgfuk=;
        h=Date:From:To:Cc:Subject:From;
        b=u4NbBkFdja5kodz5RNxbK89yu42OrBd5/J+quHqqNI4MjSQh4byaLHXW6HhpI2XFd
         ms6rYhkJ66q+2Oj/7nzrNeRvDNfSuxHYwbTv9rfbBo30nNYmanLd32td+UN71QlD67
         nNnjuSrDRQtuxzvG63cKfbLR/LWri1zlA4m7LWxQ=
Date:   Sat, 12 Jun 2021 17:54:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fix for 5.13-rc6
Message-ID: <YMTYzUp9cv+e4U6R@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc6

for you to fetch changes up to 7c3e8d9df265bd0bdf6e328174cdfba26eb22f1c:

  serial: 8250_exar: Avoid NULL pointer dereference at ->exit() (2021-06-09 14:40:48 +0200)

----------------------------------------------------------------
Serial driver fix for 5.13-rc6

Here is a single 8250_exar serial driver fix for a reported problem with
a change that happened in 5.13-rc1.

It has been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_exar: Avoid NULL pointer dereference at ->exit()

 drivers/tty/serial/8250/8250_exar.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
