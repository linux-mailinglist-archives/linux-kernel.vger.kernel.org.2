Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51AE3434AB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhCUUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:15 -0400
Received: from st43p00im-ztbu10063701.me.com ([17.58.63.178]:57625 "EHLO
        st43p00im-ztbu10063701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230290AbhCUUlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359297; bh=6zSrCQh9NnoaLzoOqXhzt5f/21bkuF9X7e+cdFN1SdU=;
        h=From:To:Subject:Date:Message-Id;
        b=Sy3UhTk5mEriEC6dPvqW5BORLJ0w4cqiNfpgWaFayTXaEIj/fX+UwRFoYPTzBCbEv
         xXxvpMboRQ3hKODfPVb4OqaxEHeGl/EbY6rhnjs9QMWsSkE2cmlYyVSWva8VKeKSH3
         w2snro4Exgq1qVGcPEtGVBOMt0Go+udNxuq/a0Y5FuKdv4evpOIZSN2vlok9DqbUCm
         gY2Wi4OgoqtCFZoQmi43kcjfUnMdQ5KhH+1Q9XlPuC45u2PhBSI5DmsRDx94yXIOWv
         zKn17X0x1jD7DJ0zIUM9YOM287Z4LtkYZs5ApbISo65O9LcwufvlSr65bDtTIG/DLy
         1beKdqD19dQkg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id 707919A0553;
        Sun, 21 Mar 2021 20:41:36 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 05/16] dt-bindings: clock: st: clkgen-pll: add new introduced compatible
Date:   Sun, 21 Mar 2021 21:40:27 +0100
Message-Id: <20210321204038.14417-6-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-21_05:2021-03-19,2021-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103210166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New compatible are added, supporting various kind of clkgen-pll
used for STiH407, STiH410 and STiH418

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
index f207053e0550..d0fa1e02d06d 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
@@ -10,7 +10,10 @@ Required properties:
 
 - compatible : shall be:
 	"st,clkgen-pll0"
+	"st,clkgen-pll0-a0"
+	"st,clkgen-pll0-c0"
 	"st,clkgen-pll1"
+	"st,clkgen-pll1-c0"
 	"st,stih407-clkgen-plla9"
 	"st,stih418-clkgen-plla9"
 
-- 
2.17.1

