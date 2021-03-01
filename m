Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC8329BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379359AbhCBB2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241246AbhCATPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:15:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 765376519E;
        Mon,  1 Mar 2021 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614618714;
        bh=o38ArbLCra0COZeM1Ksq0zTLLZooik7rRuUG+JnT1ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpHjFI1D/t46IJ19vhEu3bvlOL5bGp8i1IZ2fJ9GGPmnT8xrJxXXLu+V9fn7SFVHA
         /rHqwNQU1eENU4Lqq4zWqL78pyw+Y4ARagWvd1JqL2nub+tJpEXPSofNQ2XTAItu0r
         rPDzNNYx5Z15s6YO6q6/ujKRIvFgvyRMOS0/+odE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 189/663] media: vidtv: psi: fix missing crc for PMT
Date:   Mon,  1 Mar 2021 17:07:17 +0100
Message-Id: <20210301161151.125767011@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161141.760350206@linuxfoundation.org>
References: <20210301161141.760350206@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

[ Upstream commit 0a933a7f73d6c545dcbecb4f7a92d272aef4417b ]

The PMT write function was refactored and this broke the CRC computation.

Fix it.

Fixes: db9569f67e2e ("media: vidtv: cleanup PMT write table function")
Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index 4511a2a98405d..1724bb485e670 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -1164,6 +1164,8 @@ u32 vidtv_psi_pmt_write_into(struct vidtv_psi_pmt_write_args *args)
 	struct vidtv_psi_desc *table_descriptor   = args->pmt->descriptor;
 	struct vidtv_psi_table_pmt_stream *stream = args->pmt->stream;
 	struct vidtv_psi_desc *stream_descriptor;
+	u32 crc = INITIAL_CRC;
+	u32 nbytes = 0;
 	struct header_write_args h_args = {
 		.dest_buf           = args->buf,
 		.dest_offset        = args->offset,
@@ -1181,6 +1183,7 @@ u32 vidtv_psi_pmt_write_into(struct vidtv_psi_pmt_write_args *args)
 		.new_psi_section    = false,
 		.is_crc             = false,
 		.dest_buf_sz        = args->buf_sz,
+		.crc                = &crc,
 	};
 	struct desc_write_args d_args   = {
 		.dest_buf           = args->buf,
@@ -1193,8 +1196,6 @@ u32 vidtv_psi_pmt_write_into(struct vidtv_psi_pmt_write_args *args)
 		.pid                = args->pid,
 		.dest_buf_sz        = args->buf_sz,
 	};
-	u32 crc = INITIAL_CRC;
-	u32 nbytes = 0;
 
 	vidtv_psi_pmt_table_update_sec_len(args->pmt);
 
-- 
2.27.0



