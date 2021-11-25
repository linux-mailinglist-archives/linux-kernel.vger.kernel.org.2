Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8F45DEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356416AbhKYQuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356478AbhKYQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:48:08 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6FC061758
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:25:31 -0800 (PST)
Received: from dslb-188-097-211-055.188.097.pools.vodafone-ip.de ([188.97.211.55] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqHYs-0006jj-HY; Thu, 25 Nov 2021 17:25:26 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] staging: r8188eu: clean up workers
Date:   Thu, 25 Nov 2021 17:25:09 +0100
Message-Id: <20211125162513.25039-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the wrapper functions for work items. Use a delayed worker in the
led layer.

I tested this series on top of "clean up efuse / eeprom code".

Martin Kaiser (4):
  staging: r8188eu: remove the _set_workitem wrapper
  staging: r8188eu: remove the _init_workitem wrapper
  staging: r8188eu: remove the _cancel_workitem_sync wrapper
  staging: r8188eu: use a delayed worker for led updates

 drivers/staging/r8188eu/core/rtw_cmd.c        |   4 +-
 drivers/staging/r8188eu/core/rtw_led.c        | 106 ++++++++----------
 .../staging/r8188eu/include/osdep_service.h   |  14 ---
 drivers/staging/r8188eu/include/rtw_led.h     |  16 +--
 4 files changed, 55 insertions(+), 85 deletions(-)

-- 
2.20.1

