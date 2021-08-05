Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9573E1BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbhHES6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241540AbhHES6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:58:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF15B60F01;
        Thu,  5 Aug 2021 18:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628189916;
        bh=3ObuCvajMVwFZHaW6VfTf+mUS6N2qt4nTWItZGJEjxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFeKCcM9a5RqaPPvJh+1aszzPBb59pCIupK8wH6+bTr9OkibsMFSy//6oJU1awXjp
         Jf/udtqP5uE1n3w+Yw30gbnnhDtG8WahxONLKVDWrXYg7TFv/EjwcrOlz0rv19KVMu
         zo0idywt4nTrwyrx7gdMlYfh/yh3un6JXAmitgVIgho7IZ8G20gipGbuIJY3r1NfrT
         KIr3FQQiC/i03dkbZvVURX6pvRbga2zoZWhJH+WKWWZkeZTWvHuWElOON+PDw2Zcar
         O8DBZkdwyflA+FgU1Wh2s07VgjbuSlYqQhexT908LcrXvqzuvx7VSrKTYUvDkZckXt
         tBF7aTYf+Zgwg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 0/3] staging: r8188eu: Fix clang warnings
Date:   Thu,  5 Aug 2021 11:58:04 -0700
Message-Id: <20210805185807.3296077-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
In-Reply-To: <20210803223609.1627280-1-nathan@kernel.org>
References: <20210803223609.1627280-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up all of the clang warnings that I noticed with
x86_64 allmodconfig on the current staging-testing. This has been build
tested with both clang and gcc with x86_64 allmodconfig.

v1 -> v2:

* Rebase on staging-testing and fix conflict in patch 2.

* Drop patch 1 as it has already been fixed with commit 1c10f2b95cc1
  ("staging: r8188eu: Remove all calls to _rtw_spinlock_free()") and
  follow-ups.

* Pick up Nick's reviewed-by tag for patches 1 and 2.

Nathan Chancellor (3):
  staging: r8188eu: Remove unnecessary parentheses
  staging: r8188eu: Remove self assignment in get_rx_power_val_by_reg()
  staging: r8188eu: Remove pointless NULL check in
    rtw_check_join_candidate()

 drivers/staging/r8188eu/core/rtw_mlme.c       | 2 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 2 +-
 drivers/staging/r8188eu/core/rtw_security.c   | 4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 2 +-
 drivers/staging/r8188eu/hal/odm.c             | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 2 --
 drivers/staging/r8188eu/hal/usb_halinit.c     | 2 +-
 7 files changed, 7 insertions(+), 9 deletions(-)


base-commit: d48401b8609ff19db0f461759ac6b5210cd81288
-- 
2.33.0.rc0

