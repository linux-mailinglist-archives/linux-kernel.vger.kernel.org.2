Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602E9443B37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 03:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhKCCMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 22:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhKCCMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 22:12:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A204560F70;
        Wed,  3 Nov 2021 02:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635905379;
        bh=kkpMffUYO3jQ46K3FWIgj1gHt7CtLJqj8Pt/olUmEsA=;
        h=From:To:Cc:Subject:Date:From;
        b=mffNnSuElGKED+ULOpezhvEuo7RONSo3HiwZ4Ia4qhjjIpZYsaVV6/Lys2xJ5TlD0
         cJcaKLWqewxwRVGTL8m61Qb0kQGKryZU20bmYTF5Tm1KH/lQnaCEK8Jsk91J5fnFfN
         8SL8R5Vvh4h7u32A8S6I7AUDsiKhM5DRzSe8QdBt3/hfzOaJEZBmKu3nv8yzglAXpu
         v555vAyUhoaLW0N4EZXlPIWzjcbwAdO7gUYrFyLASucswOCdAQqI8XGnD0g0B8FMng
         gEIIR6sqM3BNsP6Ni2lFQLWG/wtqxYFxq523fwE83tr5lui0Lfv66L3yigA5H4Z28G
         LveRPJOSiqyoQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: vendor-prefixes: add T-Head Semiconductor
Date:   Wed,  3 Nov 2021 10:09:21 +0800
Message-Id: <20211103020921.3870764-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add vendor prefix for T-Head Semiconductor [1] [2]

[1] https://github.com/T-head-Semi
[2] https://www.t-head.cn/

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0aa9e7676fcf..eec3e9af6e94 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1173,6 +1173,8 @@ patternProperties:
     description: Terasic Inc.
   "^tfc,.*":
     description: Three Five Corp
+  "^thead,.*":
+    description: T-Head Semiconductor Co., Ltd.
   "^thine,.*":
     description: THine Electronics, Inc.
   "^thingyjp,.*":
-- 
2.25.1

