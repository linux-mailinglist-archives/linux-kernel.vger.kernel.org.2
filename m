Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC84473AE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 17:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhKGQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 11:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhKGQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 11:19:44 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFFDC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 08:17:01 -0800 (PST)
Received: from dslb-178-004-202-058.178.004.pools.vodafone-ip.de ([178.4.202.58] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mjkqi-0002GA-EB; Sun, 07 Nov 2021 17:16:52 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/2] staging: r8188eu: remove code for writing efuses
Date:   Sun,  7 Nov 2021 17:16:22 +0100
Message-Id: <20211107161624.9452-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's two patches that remove code for writing efuses, the driver needs
only read access.

Martin Kaiser (2):
  staging: r8188eu: remove write support from rtl8188e_EfusePowerSwitch
  staging: r8188eu: remove efuse write functions

 drivers/staging/r8188eu/core/rtw_efuse.c      |   4 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 480 +-----------------
 drivers/staging/r8188eu/include/hal_intf.h    |   3 +-
 3 files changed, 4 insertions(+), 483 deletions(-)

-- 
2.20.1

