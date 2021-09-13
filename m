Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB0409C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbhIMSyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhIMSyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:54:24 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C62C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:53:08 -0700 (PDT)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mPr4g-0005CM-PL; Mon, 13 Sep 2021 20:53:02 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/8] staging: r8188eu: power management cleanup
Date:   Mon, 13 Sep 2021 20:51:02 +0200
Message-Id: <20210913185110.3065-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911141521.24901-1-martin@kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused parts of the power management code.

Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.

v2:
- rebased against today's staging-testing branch
- fixed one patch that changed files outside of the r8188eu driver

Martin Kaiser (8):
  staging: r8188eu: remove rtw_set_rpwm
  staging: r8188eu: remove unused power state defines
  staging: r8188eu: _free_pwrlock is empty
  staging: r8188eu: remove unused pwrctrl definitions
  staging: r8188eu: remove unused enum and array
  staging: r8188eu: rtw_set_ips_deny is not used
  staging: r8188eu: remove unused variable cpwm_tog
  staging: r8188eu: remove unused variable b_hw_radio_off

 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 48 ---------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 98 -------------------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 -
 3 files changed, 148 deletions(-)

-- 
2.20.1

