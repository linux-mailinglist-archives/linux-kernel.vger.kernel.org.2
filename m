Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669A23A4F94
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhFLP4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhFLP4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFC34610FC;
        Sat, 12 Jun 2021 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623513273;
        bh=SvDSe+71i4/sQt3EFhqr44mKrhHMTl790UTWD9pT+08=;
        h=Date:From:To:Cc:Subject:From;
        b=CXTy3l1nRm5xq5oJGNOttyXaz9c3cA2U2coEbk5Aid5AFfbC2+tKN2sJrj93U8Ls7
         FIWo+GEeo/DJLO1kXW3E9Vs2dC1cbe8cBUZVdpkH1MqLQ+P0scs81yun4Az5gYkrQ8
         9gDWPCUtk86QD9aJGBEJPa0exfy4btZos8xTiRv0=
Date:   Sat, 12 Jun 2021 17:54:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 5.13-rc6
Message-ID: <YMTYtya0Sn/JVtz2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc6

for you to fetch changes up to e9de1ecadeab5fbffd873b9110e969c869554a56:

  staging: ralink-gdma: Remove incorrect author information (2021-06-09 12:07:52 +0200)

----------------------------------------------------------------
Staging driver fixes for 5.13-rc6

Here are two tiny staging driver fixes for 5.13-rc6
	- ralink-gdma driver authorship information fixed up
	- rtl8723bs driver fix for reported regression

Both have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Lars-Peter Clausen (1):
      staging: ralink-gdma: Remove incorrect author information

Wenli Looi (1):
      staging: rtl8723bs: Fix uninitialized variables

 drivers/staging/ralink-gdma/ralink-gdma.c         | 2 --
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)
