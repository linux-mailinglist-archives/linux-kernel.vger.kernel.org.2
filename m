Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6935C348AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCYHwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:52:08 -0400
Received: from st43p00im-ztbu10073601.me.com ([17.58.63.184]:52186 "EHLO
        st43p00im-ztbu10073601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230070AbhCYHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616658695; bh=D4dih7IDfleZeM1jkz2mIoV9uzt0mlpafIv8IABeh0E=;
        h=From:To:Subject:Date:Message-Id;
        b=ELAYiYPlhTSMVgjV/8Cp9Y2atOd8NJ07OH2gfLZ1rYax11W8GNPsocpGff/Df7vuz
         g9Gon8iH4CDCfxU/6vUu08oVeoQFsYKCMzo2v4DUwnsOxI5uCjlY+VTx4dORn0OCO7
         x4xuQNHCmqwjK9AflU/5OCUYAY5I+EnVI1TDNk0kdDWx+n5vXRANF9l/7NTZRy7tJC
         DyH6YJxp1nY3gBHSKVEkY5iWHd0iTlFWqd4i6vn5/d9ZF8jyD+OXNmI3C2/but5L1C
         wZUYMFMXC2LmImt6csh0pF6XIjLLNeGKIfHTgWviYvfodmxsKlkAscRNGEkpzGmkFo
         OvBscSTZuYvaA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 82E0282048E;
        Thu, 25 Mar 2021 07:51:34 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 07/16] dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible
Date:   Thu, 25 Mar 2021 08:50:09 +0100
Message-Id: <20210325075018.6598-8-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325075018.6598-1-avolmat@me.com>
References: <20210325075018.6598-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-25=5F01:2021-03-24=5F01,2021-03-25=5F01,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103250059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New compatible are added, supporting various kind of clkgen-fsyn
used for STiH407, STiH410 and STiH418

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 Documentation/devicetree/bindings/clock/st/st,quadfs.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
index d93d49342e60..c4ba2adb0b4f 100644
--- a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
@@ -12,6 +12,9 @@ This binding uses the common clock binding[1].
 Required properties:
 - compatible : shall be:
   "st,quadfs"
+  "st,quadfs-d0"
+  "st,quadfs-d2"
+  "st,quadfs-d3"
   "st,quadfs-pll"
 
 
-- 
2.17.1

