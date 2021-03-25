Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5A348A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCYHwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:52:04 -0400
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:58166 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230023AbhCYHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616658687; bh=6zSrCQh9NnoaLzoOqXhzt5f/21bkuF9X7e+cdFN1SdU=;
        h=From:To:Subject:Date:Message-Id;
        b=zJijgYjDo9wsW6HLNLHRApH2+dqxrKIDD7nxkiYo94TM6BcChVY0K190gVyb6ptXy
         DL+VLGcUHRVDnduvK37cVwtztAj2B++Mk5+7Jl4bg03DFDXuug3+1bvGfrwIEU6HDi
         jrLR+eLRNZF8MMNjjmFMvjcII9w/zAsjm9gXISGFa0UesXOGVjeMMU1KYWcfgihqfh
         edwy8eF7NSAmlLobEFAUh6xAU9GEZ1cWkfygcA4u/4EnuLmnGB10EMTrMPLgfJuWIF
         z7E7sOkznN7NBY4lLa4yoCCTwKn8HFiyIZNK4OfC1gnQKLIJCgHoF8LG2cLe3gByAz
         UOI7GjxM/glXg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id CAB328C0650;
        Thu, 25 Mar 2021 07:51:25 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 05/16] dt-bindings: clock: st: clkgen-pll: add new introduced compatible
Date:   Thu, 25 Mar 2021 08:50:07 +0100
Message-Id: <20210325075018.6598-6-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325075018.6598-1-avolmat@me.com>
References: <20210325075018.6598-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-24=5F14:2021-03-24=5F01,2021-03-24=5F14,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250059
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

