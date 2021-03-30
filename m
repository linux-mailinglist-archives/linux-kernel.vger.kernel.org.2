Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB5134F281
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhC3Uwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:52:38 -0400
Received: from st43p00im-ztdg10071801.me.com ([17.58.63.171]:49852 "EHLO
        st43p00im-ztdg10071801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232607AbhC3UwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617137523; bh=8GP6O/8IJL+3JdRIOBVkqIlHRGNe9z2cZjDEuIT2MxE=;
        h=From:To:Subject:Date:Message-Id;
        b=L/YTeiNCoEMqW6u4ZYjCrPLCYzszUa+BX67y1OOFujuWyFRnHM4F54yUPbyFGa3ul
         t4CEDF5Ggj4g6SOFCSGuyZPthRlwVsvKPIlhR+4W4IQGjRAF7NWwM1vhZ5My9h4Mn7
         ydVsrtsQoVmpetggboSySa36R0nvalFIy0qL1MQjCk8rq616MYceRTWrXqw+40ev+J
         HIRLZxDepUTXbzw8M0H68qRpFuWtV4zBI5qP9d6G7uY5vR3UZEUvdI+P42J0qZbEKd
         0Gyf2pBNbomFD5SrhxfKCAP9/atOSgjEvZcSj2F/Jmv2fHFLismHJOkUmsA6X2cGPZ
         kwix75cKvqmUg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10071801.me.com (Postfix) with ESMTPSA id 5FF645402B0;
        Tue, 30 Mar 2021 20:52:02 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v3 1/7] clk: st: clkgen-pll: remove unused variable of struct clkgen_pll
Date:   Tue, 30 Mar 2021 22:51:19 +0200
Message-Id: <20210330205125.25708-2-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330205125.25708-1-avolmat@me.com>
References: <20210330205125.25708-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_12:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=945 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103300153
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODF field within the struct clkgen_pll is never used by the driver
and can thus be removed.

Signed-off-by: Alain Volmat <avolmat@me.com>
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

