Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC83455FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCWDMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:12:05 -0400
Received: from m12-12.163.com ([220.181.12.12]:52146 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhCWDLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=US+lAK9tXx3ZQu8YlR
        j1VnBBEaM3fbPCi1jDiKVVnfk=; b=JM6QntIdZsuKW6pU0JyeYAoLfLchezT0gn
        uqU+lPFj+SnB/1zUJE9+7wToQYtV6NLOLAeSFxIxeinHS1cAyArRJgy4/oQ37D0e
        R+koqtcovn4LzE+JhtZG/6xe1GKvo0gKrzCtII27UrJOOh8VxjPsltlVhbBTElXX
        wvmI7QdF8=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowAAHD48xXFlgvk9CWA--.5103S2;
        Tue, 23 Mar 2021 11:10:56 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     abel.vesa@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Jian Dong <dongjian@yulong.com>
Subject: [PATCH]  clk: imx: reference preceded by free
Date:   Tue, 23 Mar 2021 11:10:34 +0800
Message-Id: <1616469034-9691-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: DMCowAAHD48xXFlgvk9CWA--.5103S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry7Jryxur1DXr43ur18AFb_yoWDZwb_CF
        18Wrn7XrWvyr43AF15ur1xZrZ0vFnxZFsavF12qry3K39xZr15Jr1Fvw4fKw45Cry8ArWD
        Cw1DGrWq9FZ8GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn5GYJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiEABe3V8YFUAYNgAAsv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Dong <dongjian@yulong.com>

 when register failed, clk will be freed, it will generate dangling pointer
 problem in later reference. it should return directly.

Signed-off-by: Jian Dong <dongjian@yulong.com>
---
 drivers/clk/imx/clk-lpcg-scu.c | 1 +
 drivers/clk/imx/clk-scu.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index 77be763..dd5abd0 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -114,6 +114,7 @@ struct clk_hw *__imx_clk_lpcg_scu(struct device *dev, const char *name,
 	if (ret) {
 		kfree(clk);
 		hw = ERR_PTR(ret);
+		return hw;
 	}
 
 	if (dev)
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 1f5518b7..f89b4da 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -426,6 +426,7 @@ struct clk_hw *__imx_clk_scu(struct device *dev, const char *name,
 	if (ret) {
 		kfree(clk);
 		hw = ERR_PTR(ret);
+		return hw;
 	}
 
 	if (dev)
-- 
1.9.1


