Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E6409C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhIMTCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbhIMTCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:02:10 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF533C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:00:53 -0700 (PDT)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mPrCD-0005LG-TG; Mon, 13 Sep 2021 21:00:49 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/2] staging: r8188eu: more power management cleanup
Date:   Mon, 13 Sep 2021 20:59:55 +0200
Message-Id: <20210913185957.3166-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911161019.26881-1-martin@kaiser.cx>
References: <20210911161019.26881-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bHWPwrPindetect is always 0 for the r8188eu driver. This makes a lot of
code unreachable.

Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.

v2:
- rebased against today's staging-testing branch

Martin Kaiser (2):
  staging: r8188eu: brfoffbyhw is always false
  staging: r8188eu: remove rtw_hw_resume

 drivers/staging/r8188eu/include/osdep_intf.h  |  1 -
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  7 ----
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 40 -------------------
 4 files changed, 49 deletions(-)

-- 
2.20.1

