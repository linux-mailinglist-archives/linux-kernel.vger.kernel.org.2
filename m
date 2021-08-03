Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968213DF7F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhHCWg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhHCWgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B7E861029;
        Tue,  3 Aug 2021 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030203;
        bh=hQ50CpAn7wAmW4WIyQJTFytEVNqrsX5q/ubUIcXjkgg=;
        h=From:To:Cc:Subject:Date:From;
        b=sAXwd2yVSeHKnfYXpLo0f4bKSUOd85VghAfY/zwkrp07hCFSHOaQHKhqRHCeV30fI
         yHJn5nXmYlqPGUw9CSNu5ySebChQtDRd7UwyArTCmbt5OdsdXPqUGjMuAI3wHwo8oz
         JJ+qzu7nrUQOb9iBBFgCAmPXUitt8DVKgMgJO8zoMAnUNiE4laeollNuUWw4fmzC7h
         K3iCAEy79Ee9tQlgVl1HnzTEqq4GI97yUw47jc2CwXU9OKTunaenCa6DfncRwjV+Ve
         L7v+p0bgVqJ5iS2pHHXEYwbWTtCGA+F3xYP2IE3re2MhscDH1wa/bl3ib8aRv/4Acv
         v+z0rR6PAImHg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/4] staging: r8188eu: Fix clang warnings
Date:   Tue,  3 Aug 2021 15:36:05 -0700
Message-Id: <20210803223609.1627280-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up all of the clang warnings that I noticed with
x86_64 allmodconfig on the current staging-next. This has been build
tested with both clang and gcc with x86_64 allmodconfig.

Nathan Chancellor (4):
  staging: r8188eu: Remove _rtw_spinlock_free()
  staging: r8188eu: Remove unnecessary parentheses
  staging: r8188eu: Remove self assignment in get_rx_power_val_by_reg()
  staging: r8188eu: Remove pointless NULL check in
    rtw_check_join_candidate()

 drivers/staging/r8188eu/core/rtw_cmd.c        |  2 -
 drivers/staging/r8188eu/core/rtw_mlme.c       | 18 +----
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  2 +-
 drivers/staging/r8188eu/core/rtw_recv.c       | 11 ---
 drivers/staging/r8188eu/core/rtw_security.c   |  4 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    | 77 -------------------
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       | 19 -----
 drivers/staging/r8188eu/hal/odm.c             |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  2 -
 drivers/staging/r8188eu/hal/usb_halinit.c     |  2 +-
 .../staging/r8188eu/include/osdep_service.h   |  1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 -
 .../staging/r8188eu/os_dep/osdep_service.c    |  4 -
 14 files changed, 9 insertions(+), 139 deletions(-)


base-commit: 11e14fc3e49481b6322bbd976bb7dd2f0d7ef3d2
-- 
2.33.0.rc0

