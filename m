Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EDC447350
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhKGOeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhKGOeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:34:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16932C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 06:31:38 -0800 (PST)
Received: from dslb-178-004-202-058.178.004.pools.vodafone-ip.de ([178.4.202.58] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mjjCm-0001Pk-SJ; Sun, 07 Nov 2021 15:31:32 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin.kaiser@paytec.ch>
Subject: [PATCH 0/4] staging: r8188eu: clean up the calibration code
Date:   Sun,  7 Nov 2021 15:30:56 +0100
Message-Id: <20211107143100.9047-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kaiser <martin.kaiser@paytec.ch>

Remove a bit of unused code related to calibration.

Martin Kaiser (4):
  staging: r8188eu: remove unused phy_PathA_IQK_8188E parameter
  staging: r8188eu: remove unused phy_PathA_RxIQK parameter
  staging: r8188eu: remove constant phy_IQCalibrate_8188E parameter
  staging: r8188eu: clean up _PHY_PathADDAOn

 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 114 ++----------------
 .../staging/r8188eu/include/HalPhyRf_8188e.h  |   5 -
 2 files changed, 12 insertions(+), 107 deletions(-)

-- 
2.20.1

