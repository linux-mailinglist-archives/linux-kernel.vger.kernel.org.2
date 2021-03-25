Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4042A3486E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 03:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhCYCTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 22:19:55 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:38814 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhCYCTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 22:19:47 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id F416C9802FC;
        Thu, 25 Mar 2021 10:19:44 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: linux: host1x: Remove duplicate declaration
Date:   Thu, 25 Mar 2021 10:19:36 +0800
Message-Id: <20210325021936.839782-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUsZTU0eS0hPH0NKVkpNSk1NSENMQ05JTE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MEk6OTo5GD8QEj8sNE5IPA4p
        VkJPCzZVSlVKTUpNTUhDTENNSUpIVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTkhJNwY+
X-HM-Tid: 0a78672e3693d992kuwsf416c9802fc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct host1x is declared at 20th line. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/host1x.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index ce59a6a6a008..462f0bc7a703 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -140,7 +140,6 @@ static inline void host1x_bo_munmap(struct host1x_bo *bo, void *addr)
 
 struct host1x_syncpt_base;
 struct host1x_syncpt;
-struct host1x;
 
 struct host1x_syncpt *host1x_syncpt_get(struct host1x *host, u32 id);
 u32 host1x_syncpt_id(struct host1x_syncpt *sp);
-- 
2.25.1

