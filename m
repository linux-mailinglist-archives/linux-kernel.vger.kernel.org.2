Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E33A4F93
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhFLP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhFLP4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:56:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11504610FC;
        Sat, 12 Jun 2021 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623513254;
        bh=37tg6Z6PtjuzOW8ZCYh6Bik3TuAV0MEMXIOuh+nuMp8=;
        h=Date:From:To:Cc:Subject:From;
        b=cIFF/bJpO4XtSfTcJig9BMPs4JTqB0+qzCNkEgsM4n/bLZWcVp+MnLbWVB32vPk49
         o7T3S/lqULDcwmjHHcv2kvqpulms0+fe8byGQ4hXNEkzatWo8kNSyA/d49yjp+TFpL
         aJJPLK05ZrYrTFBQVG3hB56KcCFdpBVEC397QZw4=
Date:   Sat, 12 Jun 2021 17:54:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fix for 5.13-rc6
Message-ID: <YMTYpO790N/LAZ/Q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc6

for you to fetch changes up to f501b6a2312e27fffe671d461770426fe5162184:

  debugfs: Fix debugfs_read_file_str() (2021-06-04 15:01:08 +0200)

----------------------------------------------------------------
Driver core fix for 5.13-rc6

Here is a single debugfs fix for 5.13-rc6.

It fixes a bug in debugfs_read_file_str() that showed up in 5.13-rc1.

It has been in linux-next for a full week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dietmar Eggemann (1):
      debugfs: Fix debugfs_read_file_str()

 fs/debugfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
