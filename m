Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B1C3434A7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCUUmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:03 -0400
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:46414 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230220AbhCUUl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359284; bh=gOHpXquEfX1hsU0THYneHHqC+i2psTEBMcaJtktWXlc=;
        h=From:To:Subject:Date:Message-Id;
        b=YYhz10ekr39lyQ+qsR4kiEYcTSBjWGA3UKqtnGlQHwFCZnzNgOlePMmxMyHXATwhm
         AXxqJuLZdMsHlsVUy5/thl5o62J7XqmS5UCe95cHTxJAahE+U866pteSTxrqv6XQNW
         /XR/W86mRuqUPvJ1sm77+eMhGVlp3ZWQMes8l8/PlZTm6FATyaSPZYBsbEMVqTLo8z
         CXzxIn7659Hq7mlWZwxDqVXVzpLieDtaW/D2veZc+Z3zuw7V2CMUgPtfn1cBmjtRQg
         9POPZqudVaG+l0u1SaAzDreki9G8oBImlwK9vjtnrm4UsEZiArZa2QhUgrDrFDvGDY
         5Rx6c7k8hQIGQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id D20EF540720;
        Sun, 21 Mar 2021 20:41:23 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 01/16] clk: st: clkgen-pll: remove used variable of struct clkgen_pll
Date:   Sun, 21 Mar 2021 21:40:23 +0100
Message-Id: <20210321204038.14417-2-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-21=5F05:2021-03-19=5F01,2021-03-21=5F05,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=924
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103210166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODF field within the struct clkgen_pll is never used by the driver
and can thus be removed.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/clk/st/clkgen-pll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 119c5b33080c..f6c56ca90c7d 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -146,7 +146,6 @@ struct clkgen_pll {
 
 	u32 ndiv;
 	u32 idf;
-	u32 odf;
 	u32 cp;
 };
 
-- 
2.17.1

