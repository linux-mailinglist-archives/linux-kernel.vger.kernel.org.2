Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241E635124B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhDAJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:31:36 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:37586 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhDAJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:31:20 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 6C4A39800D7;
        Thu,  1 Apr 2021 17:31:18 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] rcar/rsnd.h: Remove repeated struct declaration
Date:   Thu,  1 Apr 2021 17:31:13 +0800
Message-Id: <20210401093113.1004819-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHkJCQ0xKQhhDTUhOVkpNSkxJTUJPTENNSkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6TQw5HT8KFitWEDI4Gi83
        Dx8KFBVVSlVKTUpMSU1CT0xDQ0NOVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKSU1MNwY+
X-HM-Tid: 0a788cc5d47cd992kuws6c4a39800d7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct rsnd_dai_stream is declared twice. One is declared
at 254th line. The blew one is not needed. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 sound/soc/sh/rcar/rsnd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 6b519370fd64..8cb94a988e27 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -347,7 +347,6 @@ struct rsnd_mod_ops {
 	int (*id_cmd)(struct rsnd_mod *mod);
 };
 
-struct rsnd_dai_stream;
 struct rsnd_mod {
 	int id;
 	enum rsnd_mod_type type;
-- 
2.25.1

