Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F5731B9EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBONFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:05:01 -0500
Received: from m12-12.163.com ([220.181.12.12]:54555 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhBONE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=jn5wFcSnmHdT53x+ii
        MLKfUla40lhRJCtIiyrfo//Ws=; b=KDqFfmZAXyjBHk/duvm36y+5BNTvSf1mLX
        m9Nt9b9wtWaVdtd6oHf1iM0ZFmdY3ekqBeY79Qmi1/99Nbd068aKoVKJ3ELcMcKx
        L+ZNnyczg3stPmguqEML1ltvhJPW0FVMbDUUbFDJycgils9/ex0Sw7+PXL11miEI
        ud+A35qEs=
Received: from localhost.localdomain (unknown [125.70.196.55])
        by smtp8 (Coremail) with SMTP id DMCowAAXWOMOcSpgGXoLQw--.51584S2;
        Mon, 15 Feb 2021 21:03:14 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     gregkh@linuxfoundation.org
Cc:     ross.schm.dev@gmail.com, foxhlchen@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Chen Lin <chen.lin5@zte.com.cn>
Subject: [PATCH] staging: rtl8723bs: Remove unused function pointer typedef wi_act_func
Date:   Mon, 15 Feb 2021 21:02:54 +0800
Message-Id: <1613394174-3826-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: DMCowAAXWOMOcSpgGXoLQw--.51584S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1xuF4rXF4DXF1xXry5Arb_yoWxAFc_C3
        yftrs7Gry8AF1Syw47trZ5X3y0gF1xXw4vq3Z0vrZ8Zan09FW5C34qqr17CF45W397KF93
        Ca1vvrZakry8JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn5GYPUUUUU==
X-Originating-IP: [125.70.196.55]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/1tbiyhI6nlQHLJEUfgAAs4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lin <chen.lin5@zte.com.cn>

Remove the 'wi_act_func' typedef as it is not used.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 drivers/staging/rtl8723bs/include/rtw_mp.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mp.h b/drivers/staging/rtl8723bs/include/rtw_mp.h
index ab7cd51..2ea7100 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mp.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mp.h
@@ -31,8 +31,6 @@ struct mp_wiparam {
 	u32 io_value;
 };
 
-typedef void(*wi_act_func)(void *padapter);
-
 struct mp_tx {
 	u8 stop;
 	u32 count, sended;
-- 
1.7.9.5


