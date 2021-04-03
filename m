Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C3353382
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbhDCK4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 06:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236661AbhDCKwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 06:52:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 855FE6121D;
        Sat,  3 Apr 2021 10:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617447117;
        bh=agUx7vFj2/l5cn/nf3JSg237+LnTDEN3bnISaf8zwuo=;
        h=Date:From:To:Cc:Subject:From;
        b=umc4Q9Rs3Tpz0m26TxcV9RHdzp0rDgUpCEowd8oOUKCXavqEXlO8pdjwrVF3r+zmG
         aTJCBsgfAJXdk0hPn0ZmTwBwxLsK5Vmj9ncj/5HKEgCeP+k76n9uZw8pfz7kKLcaKR
         +tKNtDJoPdo+XrM0QxzmyzVb1TsoBlfHxZ7Teqgw=
Date:   Sat, 3 Apr 2021 12:51:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fix for 5.12-rc6
Message-ID: <YGhIytAgDzvMQU/O@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.12-rc6

for you to fetch changes up to f0acf637d60ffcef3ccb6e279f743e587b3c7359:

  driver core: clear deferred probe reason on probe retry (2021-03-23 15:13:43 +0100)

----------------------------------------------------------------
Driver core fix for 5.12-rc6

Here is a single driver core fix for a reported problem with differed
probing.  It has been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahmad Fatoum (1):
      driver core: clear deferred probe reason on probe retry

 drivers/base/dd.c | 3 +++
 1 file changed, 3 insertions(+)
