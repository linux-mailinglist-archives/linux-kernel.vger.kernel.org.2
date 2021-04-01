Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C96351245
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhDAJaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:30:00 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:29466 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhDAJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:29:41 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id CB72D9801FC;
        Thu,  1 Apr 2021 17:29:38 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] amd: display: modules: Remove repeated struct declaration
Date:   Thu,  1 Apr 2021 17:29:25 +0800
Message-Id: <20210401092925.1004512-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSh5NTk9CHxhJHkxKVkpNSkxJTUJITEJLS0hVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6Syo6FD8JFispLjdWIjQC
        CQtPFEtVSlVKTUpMSU1CSExCSU5OVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT05NNwY+
X-HM-Tid: 0a788cc44f5fd992kuwscb72d9801fc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mod_hdcp is declared twice. One is declared at 33rd line.
The blew one is not needed. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index d223ed3be5d3..03fe49c5b7d0 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -255,8 +255,6 @@ struct mod_hdcp_config {
 	uint8_t index;
 };
 
-struct mod_hdcp;
-
 /* dm allocates memory of mod_hdcp per dc_link on dm init based on memory size*/
 size_t mod_hdcp_get_memory_size(void);
 
-- 
2.25.1

