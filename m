Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3457E305DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhA0N6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:58:03 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:51342 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhA0N53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FH4tK
        7EUeGDiSLF52XD09EFE1ieG5Fnz4OvD4PlDeDY=; b=BlQV4s4VXLTJpbkg7LM6g
        AnUCmRQwMXJE9L1IhSnnBlyp/zO48i3XkDSctS2rWRuZnMHgaeCnsb7bT0SPwlVO
        xDllQ38VLcFuWugHoaUGljbfvT7WyZf6oxBrx1IXoC08/i8eO0GoCQXwteTboR97
        RUAx8hThNJwcLBnJrJk5Fk=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp2 (Coremail) with SMTP id GtxpCgBnPsqJARFgN+wqKg--.12363S2;
        Wed, 27 Jan 2021 14:00:46 +0800 (CST)
From:   zuoqilin1@163.com
To:     akpm@linux-foundation.org, colin.king@canonical.com,
        ebiggers@google.com, sjpark@amazon.de, xndchn@gmail.com
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] scripts/spelling.txt: increase error-prone spell checking
Date:   Wed, 27 Jan 2021 14:00:49 +0800
Message-Id: <20210127060049.915-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgBnPsqJARFgN+wqKg--.12363S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDF1vDUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbipRYmiVUMcELpTQABsS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Increase exeeds spelling error check.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 953f4a2..740aba3 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -566,6 +566,7 @@ estbalishment||establishment
 etsablishment||establishment
 etsbalishment||establishment
 evalution||evaluation
+exeeds||exceeds
 excecutable||executable
 exceded||exceeded
 exceds||exceeds
-- 
1.9.1

