Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5E3EABE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhHLUlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhHLUlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 390CA610A8;
        Thu, 12 Aug 2021 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628800841;
        bh=pOWEY6Ktdp1G7W+1ThMMk8U6CvERPSJjoDwDwD8AddM=;
        h=From:To:Cc:Subject:Date:From;
        b=alr8zDCrwIhpMD5GkS3UlyRFebHIL2K6RWJhHlD82FT046cufN7ZgBt3ommH/6Ay+
         aWRFAt92K4shVGFNLY7/r/UqGCX+tn1CkhUeFq3VBvtNoq/bPgz8gI9y0jXn8cPC2s
         GS/HHvVqHHeDNrsfUBeEWnrOodJiNJkLUsmsq4SpphGdXkk3O0oLPgP9G6bjlYdxLC
         ukPsfe7NXVu72ZEtzxVN5TNeDjTNlqndYKUEfFc6Iownc/UyPNoWlNCm7cHrWBalH1
         qj66G6niAXBjufoZKjtvluaI42egcir8reTklUU2dKmaKifVbTetEFviwuIoSleMK7
         1jh34mL53G6uA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] staging: r8188eu: Fix -Wuninitialized instances from clang
Date:   Thu, 12 Aug 2021 13:40:24 -0700
Message-Id: <20210812204027.338872-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Commit 987219ad34a6 ("staging: r8188eu: remove lines from Makefile that
silence build warnings") exposed some instances of -Wuninitialized in
this driver. This series cleans them up. This passes my build tests with
GCC and clang against x86_64 allmodconfig.

Cheers,
Nathan

Nathan Chancellor (3):
  staging: r8188eu: Remove unused static inline functions in rtw_recv.h
  staging: r8188eu: Remove uninitialized use of ether_type in portctrl()
  staging: r8188eu: Reorganize error handling in rtw_drv_init()

 drivers/staging/r8188eu/core/rtw_recv.c    |  4 --
 drivers/staging/r8188eu/include/rtw_recv.h | 46 ----------------------
 drivers/staging/r8188eu/os_dep/usb_intf.c  | 20 +++++-----
 3 files changed, 10 insertions(+), 60 deletions(-)


base-commit: 626520f4ba27d92c8caaf2d1f70c4bca4ea3f9de
-- 
2.33.0.rc2

