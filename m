Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3118407978
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhIKQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhIKQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 12:11:45 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 09:10:32 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP5aF-0007nr-Fy; Sat, 11 Sep 2021 18:10:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] staging: r8188eu: more power management cleanup
Date:   Sat, 11 Sep 2021 18:10:15 +0200
Message-Id: <20210911161019.26881-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bHWPwrPindetect is always 0 for the r8188eu driver. This makes a lot of
code unreachable.

Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.

Martin Kaiser (4):
  staging: r8188eu: bHWPwrPindetect is always false
  staging: r8188eu: brfoffbyhw is always false
  staging: r8188eu: remove rtw_hw_suspend
  staging: r8188eu: remove rtw_hw_resume

 drivers/staging/r8188eu/core/rtw_cmd.c        | 10 --
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 20 ----
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  4 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 14 ---
 drivers/staging/r8188eu/include/osdep_intf.h  |  2 -
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  7 --
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 99 -------------------
 8 files changed, 2 insertions(+), 156 deletions(-)

-- 
2.20.1

