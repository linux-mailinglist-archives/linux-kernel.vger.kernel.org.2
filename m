Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ABC438B33
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhJXSHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJXSHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:07:23 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A484DC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:05:02 -0700 (PDT)
Received: from dslb-178-004-201-201.178.004.pools.vodafone-ip.de ([178.4.201.201] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mehrd-00049p-Gw; Sun, 24 Oct 2021 20:04:57 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/5] staging: r8188eu: remove struct sreset_priv
Date:   Sun, 24 Oct 2021 20:04:43 +0200
Message-Id: <20211024180448.20624-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sreset_priv structure is not used by the r8188eu driver. This patchset
removes sreset_priv step by step.

Martin Kaiser (5):
  staging: r8188eu: silent_reset_inprogress is never read
  staging: r8188eu: wifi_error_status is write-only
  staging: r8188eu: silentreset_mutex is unused
  staging: r8188eu: remove last_tx_complete_time
  staging: r8188eu: remove the sreset_priv structure

 drivers/staging/r8188eu/Makefile              |  1 -
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  2 ++
 drivers/staging/r8188eu/core/rtw_sreset.c     | 32 -------------------
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c | 15 ---------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 10 ------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  1 -
 .../staging/r8188eu/include/rtl8188e_sreset.h |  1 -
 drivers/staging/r8188eu/include/rtw_sreset.h  | 29 -----------------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  4 ---
 .../staging/r8188eu/os_dep/usb_ops_linux.c    | 18 +++--------
 10 files changed, 6 insertions(+), 107 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/core/rtw_sreset.c
 delete mode 100644 drivers/staging/r8188eu/include/rtw_sreset.h

-- 
2.20.1

