Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49B35AD74
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhDJNMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234091AbhDJNMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 906B0610F7;
        Sat, 10 Apr 2021 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618060353;
        bh=LhEYAqfXIQ/avprsHf0aOqseXBcHQxdYzMNXzGKYxR4=;
        h=Date:From:To:Cc:Subject:From;
        b=zge/gBnlKU5oHhbzcTRjJwzbTebXjmigOtfE5m9ZbaFqWKEdou41hTIwUUyOBzCbW
         AJxCeKHnfMDRdCgnSoQi4uEQJM0Rm0ULEPbVvnO1Dt5q/IPTsrh198bVp2yHWiyHNf
         djJ/LYFcdZtelP+VzmeaEPJzL1rqlYw7js0FGHhM=
Date:   Sat, 10 Apr 2021 15:12:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fix for 5.12-rc7
Message-ID: <YHGkPlxkMvG1JKdn@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.12-rc7

for you to fetch changes up to eed6e41813deb9ee622cd9242341f21430d7789f:

  driver core: Fix locking bug in deferred_probe_timeout_work_func() (2021-04-05 09:14:18 +0200)

----------------------------------------------------------------
Driver core fix for 5.12-rc7

Here is a single driver core fix for 5.12-rc7 to resolve a reported
problem that caused some devices to lockup when booting.  It has been in
linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Saravana Kannan (1):
      driver core: Fix locking bug in deferred_probe_timeout_work_func()

 drivers/base/dd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
