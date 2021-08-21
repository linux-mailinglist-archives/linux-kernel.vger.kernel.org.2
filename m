Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08E3F3B86
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhHUQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhHUQuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:50:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C9C061760
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:50:05 -0700 (PDT)
Received: from dslb-178-004-175-162.178.004.pools.vodafone-ip.de ([178.4.175.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mHUC0-0002Ch-Ef; Sat, 21 Aug 2021 18:50:00 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/10] staging: r8188eu: remove unused members of struct _io_ops
Date:   Sat, 21 Aug 2021 18:48:58 +0200
Message-Id: <20210821164859.4351-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210821164859.4351-1-martin@kaiser.cx>
References: <20210821164859.4351-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function pointers which are not used by the r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_io.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index f1b3074fa075..4b41c7b03972 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -100,13 +100,10 @@ struct _io_ops {
 			  u8 *pmem);
 	void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
 			   u8 *pmem);
-	void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);
-	u32 (*_read_interrupt)(struct intf_hdl *pintfhdl, u32 addr);
 	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
 			  u8 *pmem);
 	u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
 			   u8 *pmem);
-	u32 (*_write_scsi)(struct intf_hdl *pintfhdl,u32 cnt, u8 *pmem);
 	void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
 	void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
 };
-- 
2.20.1

