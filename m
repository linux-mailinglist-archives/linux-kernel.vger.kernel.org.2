Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515AE38D32C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 04:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEVC7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 22:59:18 -0400
Received: from m34-101.88.com ([104.250.34.101]:40990 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230527AbhEVC7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 22:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=vJkq7wa9Z6jij7BO6V7KBAE4fXZ75ffcsEThU
        MYmmcI=; b=IqUSSEAJCzv5AveJBwa2mHsaQ3zv8g75Rh94PfdxMSbu/bl6AXIMy
        fiFbERQ3mwTebgNyGMTRRI6hq3Enyf6QYI4zij/D1NYFvOupIDwd8wNwAyk9AzSa
        QLEQIfGp9wPCilNiuYjMTKyKwIbUr0LO2GqqebwcbDoQVsmC8oJbG0=
Received: from localhost.localdomain (unknown [113.251.14.223])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCH1ljYcqhg2f9AAA--.18786S2;
        Sat, 22 May 2021 10:56:25 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net, bobwxc@email.cn,
        maskray@google.com, bernard@vivo.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH v2 1/2] docs/zh_CN: update a translation in zh_CN/dev-tools/gcov
Date:   Sat, 22 May 2021 10:55:44 +0800
Message-Id: <20210522025545.57275-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GiKnCgCH1ljYcqhg2f9AAA--.18786S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4Dtr13Xw1ruFyfXF4fZrb_yoWftrc_Gw
        1kWF4vyFy3Jry2gr4rAF1kJr1fZF4rKw18Arn0ya98Jw15G39rGa4DX3s5ZFW3WF43urW3
        CrZ7ZrZ3trn2yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb5xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWUJVWUGwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWxJr1UJwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjfUsvtCUUUUU
X-Originating-IP: [113.251.14.223]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original file has added some words in commit c797997a244cd2c58908
("Documentation: dev-tools: Add Testing Overview"), hence update the
Chinese translation of them.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 Documentation/translations/zh_CN/dev-tools/index.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
index fd73c479917b..7ba02fc392a6 100644
--- a/Documentation/translations/zh_CN/dev-tools/index.rst
+++ b/Documentation/translations/zh_CN/dev-tools/index.rst
@@ -11,6 +11,9 @@
 目前这些文档已经整理在一起，不需要再花费额外的精力。
 欢迎任何补丁。
 
+有关测试专用工具的简要概述，参见
+Documentation/dev-tools/testing-overview.rst
+
 .. class:: toc-title
 
 	   目录
-- 
2.25.1

