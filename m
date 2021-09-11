Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8854B4078B2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhIKORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbhIKORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:17:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CC4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:16:01 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP3nQ-0006bt-F6; Sat, 11 Sep 2021 16:15:56 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/12] staging: r8188eu: power management cleanup
Date:   Sat, 11 Sep 2021 16:15:09 +0200
Message-Id: <20210911141521.24901-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused parts of the power management code.

Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.

Martin Kaiser (12):
  staging: r8188eu: btcoex_rfon is always false
  staging: r8188eu: setting HW_VAR_SET_RPWM does nothing
  staging: r8188eu: remove write-only variable cpwm
  staging: r8188eu: remove write-only variable tog
  staging: r8188eu: remove rtw_set_rpwm
  staging: r8188eu: remove unused power state defines
  staging: r8188eu: _free_pwrlock is empty
  staging: r8188eu: remove unused pwrctrl definitions
  staging: r8188eu: remove unused enum and array
  staging: r8188eu: rtw_set_ips_deny is not used
  staging: r8188eu: remove unused variable cpwm_tog
  staging: r8188eu: remove unused variable b_hw_radio_off

 .../realtek/rtl8192cu/include/rtw_pwrctrl.h   |   1 -
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  69 ------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   2 -
 drivers/staging/r8188eu/include/hal_intf.h    |   1 -
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 102 ------------------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 -
 6 files changed, 177 deletions(-)

-- 
2.20.1

