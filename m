Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6A359228
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhDICrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:47:40 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:9312 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:47:27 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 6D4E7400208;
        Fri,  9 Apr 2021 10:46:48 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] fs: cifs: Remove repeated struct declaration
Date:   Fri,  9 Apr 2021 10:46:39 +0800
Message-Id: <20210409024639.1092204-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk5KSFZNGEpIT0tCQhgZHklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6Njo*LT8TOCEoNCsIOBA0
        DhcaCwlVSlVKTUpMQkhNT0tCS0tKVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTktKNwY+
X-HM-Tid: 0a78b4866026d991kuws6d4e7400208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct cifs_writedata is declared twice.
One is declared at 209th line.
And struct cifs_writedata is defined blew.
The declaration hear is not needed. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 fs/cifs/cifsglob.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index ec824ab8c5ca..5ec60745034e 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1316,8 +1316,6 @@ struct cifs_readdata {
 	struct page			**pages;
 };
 
-struct cifs_writedata;
-
 /* asynchronous write support */
 struct cifs_writedata {
 	struct kref			refcount;
-- 
2.25.1

