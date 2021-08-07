Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792173E361E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhHGPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhHGPhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:37:52 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AEDC061798
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 08:37:17 -0700 (PDT)
Received: from dslb-084-059-249-202.084.059.pools.vodafone-ip.de ([84.59.249.202] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mCONo-0003Y3-5p; Sat, 07 Aug 2021 17:37:08 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/12] remove the remaining RT_TRACE prints
Date:   Sat,  7 Aug 2021 17:36:24 +0200
Message-Id: <20210807153636.11712-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg and all,

I'm resending the patches from earlier this week, all in one series, based
on today's staging-testing branch. I hope they do not conflict with other
pending submissions.

As per Greg's request, I removed only RT_TRACE prints and left DBG_88E
alone for now.

While at it, I resurrected the IW_HANDLER change that was already accepted
for the deprecated driver.

Thanks for reviewing this set,

   Martin

Martin Kaiser (12):
  staging: r8188eu: remove RT_TRACE prints from usb_intf.c
  staging: r8188eu: remove RT_TRACE prints from usb_ops_linux.c
  staging: r8188eu: remove RT_TRACE prints from ioctl_linux.c
  staging: r8188eu: remove empty function
  staging: r8188eu: remove RT_TRACE prints from mlme_linux.c
  staging: r8188eu: remove RT_TRACE prints from os_intfs.c
  staging: r8188eu: remove an RT_TRACE print from osdep_service.c
  staging: r8188eu: remove RT_TRACE prints from recv_linux.c
  staging: r8188eu: remove RT_TRACE prints from xmit_linux.c
  staging: r8188eu: use IW_HANDLER to declare wext handlers
  staging: r8188eu: remove unused DEBUG_OID macro
  staging: r8188eu: remove the RT_TRACE macro

 drivers/staging/r8188eu/include/rtw_debug.h   |   9 -
 drivers/staging/r8188eu/include/rtw_ioctl.h   |   6 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 181 +++++-------------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   4 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  49 +----
 .../staging/r8188eu/os_dep/osdep_service.c    |   6 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c   |  23 +--
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  51 +----
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  15 --
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   8 +-
 10 files changed, 58 insertions(+), 294 deletions(-)

-- 
2.20.1

