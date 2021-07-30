Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA203DC0AB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhG3WCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhG3WCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:02:32 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F66C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:02:26 -0700 (PDT)
Received: from TimeMachine.lan (bband-dyn19.178-41-181.t-com.sk [178.41.181.19])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 4EAF2202E6;
        Sat, 31 Jul 2021 00:02:22 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] RPMCC for SM6125
Date:   Fri, 30 Jul 2021 23:59:23 +0200
Message-Id: <20210730215924.733350-1-martin.botka@somainline.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the
RPMCC found in SM6125 SoC.

I did not include patches that were already merged.

Changes in v2:
Add commit description to all the patches

Changes in v3:
Drop merged patches
Squash adding compatible
Deduplicate clocks
Nicer commit message
Use defined but prev not used clocks using the
recently added dt-binding for them (In linux-next)
Sort sm6125 clocks according to their
ID in qcom,rpmcc.h

Martin Botka (3):
  clk: qcom: smd: Add support for SM6125 rpm clocks

 drivers/clk/qcom/clk-smd-rpm.c   | 56 ++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/smd-rpm.h |  1 +
 2 files changed, 57 insertions(+)

-- 
2.32.0

