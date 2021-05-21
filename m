Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05938CA88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhEUQEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:04:14 -0400
Received: from m34-101.88.com ([104.250.34.101]:63382 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229807AbhEUQEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:04:12 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 12:04:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=vJkq7wa9Z6jij7BO6V7KBAE4fXZ75ffcsEThU
        MYmmcI=; b=DX/ygDq5lp689y+WWSOlxylrr0nAdAkrXkHhTMa1vtLbBSJqZ5neG
        6DtxfTJ42NBeIxJ2LOmzlIFFV3XOM+n3uUYIU06L4+LSzoAX9KVx+ocQvJacBqw6
        s7M/HdM26DKgqepeuCU5jtZoKzePK7v3tUX0tEC4HX/GkfAIXdrTiE=
Received: from localhost.localdomain (unknown [113.251.14.223])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgC3fkEN2Kdg5Ok2AA--.14375S2;
        Fri, 21 May 2021 23:55:58 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net, bobwxc@email.cn, bernard@vivo.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH] docs/zh_CN: update a translation in zh_CN/dev-tools/gcov
Date:   Fri, 21 May 2021 23:55:51 +0800
Message-Id: <20210521155551.29176-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgC3fkEN2Kdg5Ok2AA--.14375S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4Dtr13Xw1ruFyfXF4fZrb_yoWftrc_Gw
        1kWF4vyFy3Jry2gr4rAF1kJr1fZF4rKw18Arn0ya98Jw15G39rGa4DX3s5ZFW3WF43urW3
        CrZ7ZrZ3trn2yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbeAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWUJVWUGwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84AC
        jcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64
        vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
        0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7V
        U0mhF7UUUUU==
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

