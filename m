Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5B35080A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhCaURP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:17:15 -0400
Received: from st43p00im-ztdg10071801.me.com ([17.58.63.171]:49828 "EHLO
        st43p00im-ztdg10071801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236490AbhCaUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617221806; bh=Ga3ZG8EPAgfy8VOncEjhIuXGpD1CkGhjvnsJWI0WAaw=;
        h=From:To:Subject:Date:Message-Id;
        b=i1gMLKhQGNhEh4H+6LEKLKreop2A3ox5q289Q+FY785LM0lWbbrA7o2ZBbMk7sNCr
         dwgm3OPRKFtD7FV+X/HYjDek4L+rsuy+L1slx3sFRTACPCZ3C/znMBl0X8y2Vlepz5
         tFVqR4rIdDD1A2+nZzOkpFhdLhElaKJjFl+/8VURhXwLPQaIIpT8CGVMRbPKv+jiNN
         aBlLF5TbNH3nguCFFW7JgjH3dSwbK3eezqi1mSATDd3mlAG3ZdwI7ACRr7EVTJyGn9
         PMc6ayvFor4OqCn9hnkwZp1vEOnGJ9z23bRyXeGxr79tgRKmmKo1b76NNlR/E7gr/X
         dEtinumlxPaew==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10071801.me.com (Postfix) with ESMTPSA id 8F3E054044D;
        Wed, 31 Mar 2021 20:16:45 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v4 1/7] clk: st: clkgen-pll: remove unused variable of struct clkgen_pll
Date:   Wed, 31 Mar 2021 22:16:26 +0200
Message-Id: <20210331201632.24530-2-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331201632.24530-1-avolmat@me.com>
References: <20210331201632.24530-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-31=5F10:2021-03-30=5F02,2021-03-31=5F10,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103310140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODF field within the struct clkgen_pll is never used by the driver
and can thus be removed.

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
v3: s/used/unused within the subject

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

