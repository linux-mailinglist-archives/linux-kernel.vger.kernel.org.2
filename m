Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2552D403679
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351268AbhIHI73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351325AbhIHI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:59:25 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A91C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 01:58:17 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mNtPK-0000yP-DS; Wed, 08 Sep 2021 10:58:14 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] staging: r8188eu: remove unused function prototype
Date:   Wed,  8 Sep 2021 10:57:45 +0200
Message-Id: <20210908085747.32254-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908085747.32254-1-martin@kaiser.cx>
References: <20210908085747.32254-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no rtw_write_scsi function in this driver. Remove its prototype.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 4b41c7b03972..263a37d49b6e 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -298,8 +298,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 	_rtw_write_port_and_wait((adapter), (addr), (cnt), (mem), (timeout_ms))
 #define rtw_write_port_cancel(adapter) _rtw_write_port_cancel((adapter))
 
-void rtw_write_scsi(struct adapter *adapter, u32 cnt, u8 *pmem);
-
 /* ioreq */
 void ioreq_read8(struct adapter *adapter, u32 addr, u8 *pval);
 void ioreq_read16(struct adapter *adapter, u32 addr, u16 *pval);
-- 
2.20.1

