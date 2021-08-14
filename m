Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48E3EC44E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbhHNR7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:59:17 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:23394 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbhHNR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:59:14 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 04E8CC400F1;
        Sun, 15 Aug 2021 01:58:43 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/2] f2fs: fix description about main_blkaddr node
Date:   Sun, 15 Aug 2021 01:58:40 +0800
Message-Id: <20210814175840.115938-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210814175840.115938-1-frank.li@vivo.com>
References: <20210814175840.115938-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkaGU9WSx8aHk0eQkMZSU
        8YVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6Ezo*Pz9DAx8#KzQzDxBK
        CzoKCwpVSlVKTUlDQk1IQklPTk1KVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUpDT0s3Bg++
X-HM-Tid: 0a7b45d0e8c3d996kuws04e8cc400f1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't leave a blank line, to keep the style consistent
with other node descriptions.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 32df6d16d74f..ff5a8fdadbfc 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -41,8 +41,7 @@ Description:	This parameter controls the number of prefree segments to be
 What:		/sys/fs/f2fs/<disk>/main_blkaddr
 Date:		November 2019
 Contact:	"Ramon Pantin" <pantin@google.com>
-Description:
-		 Shows first block address of MAIN area.
+Description:	Shows first block address of MAIN area.
 
 What:		/sys/fs/f2fs/<disk>/ipu_policy
 Date:		November 2013
-- 
2.32.0

