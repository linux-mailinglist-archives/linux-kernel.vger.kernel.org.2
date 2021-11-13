Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6244F4AB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbhKMS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhKMS6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:36 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DBAC061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:44 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBd-0002H8-7X; Sat, 13 Nov 2021 19:55:37 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/15] staging: r8188eu: more efuse cleanup
Date:   Sat, 13 Nov 2021 19:55:03 +0100
Message-Id: <20211113185518.23941-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some more unused parts of the efuse code.

Martin Kaiser (15):
  staging: r8188eu: remove efuse type from definition functions
  staging: r8188eu: remove efuse type from read functions
  staging: r8188eu: remove test code for efuse shadow map
  staging: r8188eu: merge small adapter info helpers
  staging: r8188eu: rtl8188e_EfuseGetCurrentSize is now unused
  staging: r8188eu: rtl8188e_Efuse_PgPacketRead is now unused
  staging: r8188eu: merge Efuse_ReadAllMap into EFUSE_ShadowMapUpdate
  staging: r8188eu: use efuse map length define directly
  staging: r8188eu: rtl8188e_EFUSE_GetEfuseDefinition is unused
  staging: r8188eu: remove defines for efuse type
  staging: r8188eu: efuse_OneByteRead is unused
  staging: r8188eu: efuse_OneByteWrite is unused
  staging: r8188eu: remove bt efuse definitions
  staging: r8188eu: remove fake efuse variables
  staging: r8188eu: remove the efuse_hal structure

 drivers/staging/r8188eu/core/rtw_efuse.c      | 162 +-------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 370 +-----------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  42 +-
 drivers/staging/r8188eu/include/hal_intf.h    |   8 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |   2 -
 drivers/staging/r8188eu/include/rtw_efuse.h   |  79 +---
 6 files changed, 50 insertions(+), 613 deletions(-)

-- 
2.20.1

