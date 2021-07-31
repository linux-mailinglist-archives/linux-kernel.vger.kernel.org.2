Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBF3DC2F7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 05:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhGaDhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 23:37:14 -0400
Received: from mail.bonc.com.cn ([39.155.134.159]:43163 "EHLO bonc.com.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231518AbhGaDhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 23:37:12 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 23:37:12 EDT
Received: from localhost.localdomain.localdomain (unknown [223.70.140.94])
        by coremail (Coremail) with SMTP id AQAAfwCnRmRnwwRhD7MmAA--.10921S2;
        Sat, 31 Jul 2021 11:28:48 +0800 (CST)
From:   Baisheng Gao <gaobaisheng@bonc.com.cn>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: fix incorrect macro referencing in mscc-phy-vsc8531.txt
Date:   Sat, 31 Jul 2021 11:34:47 +0800
Message-Id: <1627702487-234812-1-git-send-email-gaobaisheng@bonc.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAfwCnRmRnwwRhD7MmAA--.10921S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFykWF4kAFyDKw4kGFyxAFb_yoWkuFcEkF
        naqF18Jr9rGr1Fga1jvrsrZF4Yvr4jy3s7u3sFqFyIv3yrA398CFyDJwnxZr1xCFWUuF4x
        Zry8uF17u3ZrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCj
        nVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUJVWUXwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jz89NUUUUU=
X-CM-SenderInfo: xjdrutplvkv0nj6e003fof0zgofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify LINK_1000_ACTIVITY and LINK_100_ACTIVITY to VSC8531_LINK_1000_ACTIVITY
and VSC8531_LINK_100_ACTIVITY respectively in the example of ethernet-phy node
according to include/dt-bindings/net/mscc-phy-vsc8531.h.

Signed-off-by: Baisheng Gao <gaobaisheng@bonc.com.cn>
---
 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 87a27d7..0a3647f 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -67,7 +67,7 @@ Example:
                 compatible = "ethernet-phy-id0007.0570";
                 vsc8531,vddmac		= <3300>;
                 vsc8531,edge-slowdown	= <7>;
-                vsc8531,led-0-mode	= <LINK_1000_ACTIVITY>;
-                vsc8531,led-1-mode	= <LINK_100_ACTIVITY>;
+                vsc8531,led-0-mode	= <VSC8531_LINK_1000_ACTIVITY>;
+                vsc8531,led-1-mode	= <VSC8531_LINK_100_ACTIVITY>;
 		load-save-gpios		= <&gpio 10 GPIO_ACTIVE_HIGH>;
         };
-- 
1.8.3.1


