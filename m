Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2567F430269
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbhJPLcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240172AbhJPLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:32:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1132C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:30:36 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbhtY-00046d-31; Sat, 16 Oct 2021 13:30:32 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/8] staging: r8188eu: another round of removals
Date:   Sat, 16 Oct 2021 13:30:00 +0200
Message-Id: <20211016113008.27549-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some more dead code and unused definitions.

Martin Kaiser (8):
  staging: r8188eu: remove empty trigger gpio code
  staging: r8188eu: interface type is always usb
  staging: r8188eu: remove two checks that are always false
  staging: r8188eu: remove unused function prototypes
  staging: r8188eu: PHY_SetRFPathSwitch_8188E is not used
  staging: r8188eu: clean up Hal8188EPhyCfg.h
  staging: r8188eu: remove procfs functions
  staging: r8188eu: CurrentWirelessMode is not used

 drivers/staging/r8188eu/Makefile              |   1 -
 drivers/staging/r8188eu/core/rtw_debug.c      | 886 ------------------
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  14 +-
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |   3 +-
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   8 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  38 -
 drivers/staging/r8188eu/hal/odm.c             |   3 -
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   2 -
 drivers/staging/r8188eu/hal/usb_halinit.c     |   8 -
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  78 --
 drivers/staging/r8188eu/include/hal_intf.h    |   1 -
 drivers/staging/r8188eu/include/odm.h         |  11 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |   1 -
 drivers/staging/r8188eu/include/rtw_debug.h   | 148 ---
 14 files changed, 6 insertions(+), 1196 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/core/rtw_debug.c

-- 
2.20.1

