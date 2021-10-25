Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0721439811
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhJYOH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:07:56 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:27821 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJYOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:07:54 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211025140529epoutp04d4a32e5faf801fcb7f556abd215955f5~xSx1Soog33008530085epoutp04y
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:05:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211025140529epoutp04d4a32e5faf801fcb7f556abd215955f5~xSx1Soog33008530085epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1635170729;
        bh=fey+6MHijgaTNXfUD+lxnyfQlzWGLpNI+7tezBCSDCk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fKCEq9cQg6nF9/EBUtKHHvJDzTxrZZYxkTTB3Qxs7SbabOxPvSn8IfXsqpgBTcc0P
         O8ey2XZXdYMadI8u8m9fdpjgF0G72iHxCVAcAhYwk7zOsLaCWql7qzihTUWeoHRp4C
         Zc+gFp36klYWgwkM2rVqAODtP90tKFEJnSQki7qU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211025140528epcas1p1414e38eb3f7e8f0ce83e2947801c914a~xSx0_7Q3Z1746717467epcas1p1q;
        Mon, 25 Oct 2021 14:05:28 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.248]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HdGtv51Z1z4x9Pt; Mon, 25 Oct
        2021 14:05:27 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.7D.09574.7A9B6716; Mon, 25 Oct 2021 23:05:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211025140526epcas1p3b4a59df0935297572c6417c841a4c514~xSxzFo7kx2735427354epcas1p3V;
        Mon, 25 Oct 2021 14:05:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211025140526epsmtrp16134229dd8e2885f32384c5d6ee924e5~xSxzE9O6T1138511385epsmtrp1E;
        Mon, 25 Oct 2021 14:05:26 +0000 (GMT)
X-AuditID: b6c32a35-195ff70000002566-9d-6176b9a72b6e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.C5.08738.6A9B6716; Mon, 25 Oct 2021 23:05:26 +0900 (KST)
Received: from hj514.kim-office (unknown [10.253.100.146]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211025140526epsmtip27f8f1f9dffb215a4dbbc781f7d14b3c5~xSxy1E0Df1466814668epsmtip2A;
        Mon, 25 Oct 2021 14:05:26 +0000 (GMT)
From:   Hyeong-Jun Kim <hj514.kim@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: compress: disallow disabling compress on non-empty
 compressed file
Date:   Mon, 25 Oct 2021 23:05:16 +0900
Message-Id: <20211025140517.14741-1-hj514.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmvu7ynWWJBs1b1CxOTz3LZDG94yCb
        xZP1s5gtLi1yt7i8aw6bxZZ/R1gd2Dw2repk89i94DOTR9+WVYwenzfJBbBEZdtkpCampBYp
        pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
        6dvZFOWXlqQqZOQXl9gqpRak5BSYFegVJ+YWl+al6+WlllgZGhgYmQIVJmRnfD7yj73gMntF
        Y898lgbGLWxdjJwcEgImEvfXLQGyuTiEBHYwSqw68QXK+cQo8ePRRxYI5zOjxLWOV6wwLd0H
        r0FV7WKU2PNyFyuE855RYtfkXWCD2QR0JD7MWskIYosI2Et8/n6dBcRmFpjNKHH/aC6ILSwQ
        LbHuzlKgeg4OFgFViecTuEHCvAJWElPfT2WBWCYvMfPSd3aIuKDEyZlPoMbISzRvnc0MsldC
        4BC7xJfFi6Guc5F4fPMY1HPCEq+Ob2GHsKUkXva3Qdn1EsevfGKFaG5hlHi89BUjyBESQIe+
        v2QBYjILaEqs36UPUa4osfP3XEaIvXwS7772sEJU80p0tAlBlChLbL57GGqrpMTTRX8ZIWwP
        iSuTr4HZQgKxEg+3b2CfwCg/C8k3s5B8Mwth8QJG5lWMYqkFxbnpqcWGBYbwSE3Oz93ECE5+
        WqY7GCe+/aB3iJGJg/EQowQHs5IIr82nkkQh3pTEyqrUovz4otKc1OJDjKbA4J3ILCWanA9M
        v3kl8YYmlgYmZkYmFsaWxmZK4ryf5QoThQTSE0tSs1NTC1KLYPqYODilGpgsWz5s3OWSxnk0
        5V1K5pnvZpohpyMmi07MfL3yn+xOjqPzJqVzy/CJhGyN4+k9abhqRe7EIycFtOSeuAZFqN6v
        PewwaV5E3a4eqUdOT2e0LGX6UDhZ4sa1RL7GV0vTwqwXpp3IVLY15X5dL8n+W9UvoPL2/kjh
        QK610rVMuq8yL1Z5zT7A/YjTYE+i+PE2lpJGM6+zG9vWtTy//vDk3DNGS9ufmQqtblyo3P5V
        1Md3Fn/vi1ebihZvvqk9327SoR0CmqqrlBvuXeRt7fx6kvXwiqpJGoI1C78W/7dgP5A/8Xl/
        +HqLQwVKQXFbWd0CSv/bB8vfW3p8UcoqD2V+xva1r0ICF7eu4uE78IaP74kSS3FGoqEWc1Fx
        IgCyxRtUBwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSvO6ynWWJBtOWylucnnqWyWJ6x0E2
        iyfrZzFbXFrkbnF51xw2iy3/jrA6sHlsWtXJ5rF7wWcmj74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mr4fOQfe8Fl9orGnvksDYxb2LoYOTkkBEwkug9eA7K5OIQEdjBKvOxbydrFyAGUkJSY
        t74cwhSWOHy4GKLkLaPEhq4mdpBeNgEdiQ+zVjKC2CICjhK/Xi9iBSliFpjLKHGxu4kVJCEs
        EClxbeUpNpBBLAKqEs8ncIOEeQWsJKa+n8oCcYO8xMxL39kh4oISJ2c+AYszA8Wbt85mnsDI
        NwtJahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMHBqKW1g3HPqg96hxiZ
        OBgPMUpwMCuJ8Np8KkkU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoR
        TJaJg1OqgWluX2BMtekqCz+j+4cOX26RFVTYvUy9RfUgz7/n2mWfGc/VP3fSWH1E8azyx44P
        K/7+DUtTecu6+9+keZsEa5xY63efLl76gv9VB3fbq/ds7/L3Hd9YXNOfZWdU9I3FaMLTS85X
        kvJWbFLeGG0o+CV1q8hMM/Upuvc7MzxvRr5qWBchHDnZWjE7n6vtyfIig/vP7/IxPf/mvnCN
        WuoV3klbFhbPc3jsX3Yn5k9EdWjEPLnEk6yr5JR66mdMlVr2UMmlsk+0JvV3wpnoWq12taXp
        9ZXnd53eVMjW+XXm4rD1KlH3t23ZtWzLlc9eQjsEiq7KTjnc+Srk18mtqVsKzTn9D7N61JzQ
        Os4/8Z/j2S9KLMUZiYZazEXFiQCSNI1/tQIAAA==
X-CMS-MailID: 20211025140526epcas1p3b4a59df0935297572c6417c841a4c514
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211025140526epcas1p3b4a59df0935297572c6417c841a4c514
References: <CGME20211025140526epcas1p3b4a59df0935297572c6417c841a4c514@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compresse file and normal file has differ in i_addr addressing,
specifically addrs per inode/block. So, we will face data loss, if we
disable the compression flag on non-empty files. Therefore we should
disallow not only enabling but disabling the compression flag on
non-empty files.

Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>
---
 fs/f2fs/f2fs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b8e8f8c716b0..19146c834abd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4177,8 +4177,7 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 
 	if (!f2fs_compressed_file(inode))
 		return true;
-	if (S_ISREG(inode->i_mode) &&
-		(get_dirty_pages(inode) || atomic_read(&fi->i_compr_blocks)))
+	if (S_ISREG(inode->i_mode) && inode->i_size)
 		return false;
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
-- 
2.25.1

