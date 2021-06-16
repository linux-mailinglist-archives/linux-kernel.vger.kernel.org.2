Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2A3A9DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhFPOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:44:05 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:39530 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhFPOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:44:00 -0400
DKIM-Signature: a=rsa-sha256;
        b=ZeLfAbsON47mDckqA0db4BwOC11IAO/fhpl3DqYiVptZ8ix/fPS5pNhIiRWknn/sL9uSFVaJUVWG1IsJRn9y6QgHs9jMnAFANwDT5z6dO53VAVM1pXjjxKUblnm7zb2czlK6gwPGIy7QNjnzGJ7yMPwXFdEt1535avkjh6lFmCA=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=7jayIAvLdxe4BYaM+zA/siNMUWJMUwXobFneLmZhBhs=;
        h=date:mime-version:subject:message-id:from;
Received: from wanjb-KLV-WX9.. (unknown [121.229.73.16])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id AFF13AC0173;
        Wed, 16 Jun 2021 22:41:52 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] PS3: Remove unneeded semicolons
Date:   Wed, 16 Jun 2021 22:41:31 +0800
Message-Id: <20210616144131.27441-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0IaTFYZHUJKSxhOSx5CGEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46Ngw6HT8SEU4dMR8aOSwq
        MEMwCzJVSlVKTUlIQ05PTkpISk1MVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlK
        SUpVSUlCVUxIVUpNWVdZCAFZQUlLT083Bg++
X-HM-Tid: 0a7a15457ab5b039kuuuaff13ac0173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:

./arch/powerpc/platforms/ps3/system-bus.c:607:2-3: Unneeded semicolon
./arch/powerpc/platforms/ps3/system-bus.c:766:2-3: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 1a5665875165..f57f37fe038c 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -604,7 +604,7 @@ static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
 	default:
 		/* not happned */
 		BUG();
-	};
+	}
 	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
 			     &bus_addr, iopte_flag);
 
@@ -763,7 +763,7 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 		break;
 	default:
 		BUG();
-	};
+	}
 
 	dev->core.of_node = NULL;
 	set_dev_node(&dev->core, 0);
-- 
2.30.2

