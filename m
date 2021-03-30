Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD12D34E981
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhC3NqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhC3Np5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:45:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE02C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:45:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso7680038pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8c5509vV/LgWSAQV021ydpvF5jynvLy8ktsJyCm1QGg=;
        b=YtGQ65HJmwMcsoK2FQ3uwftOrZ8tOMHCD7th69JjUf7giIY7ec4GxAJM07/XUJIwJF
         EKAPhSn5NktRq+fBDANX5b1uCH9GqUpfq/ZQK5du9hdSAnrcbH2675KQaJ0UZ2olRp+g
         CmiYyVAh3ivxbGyMWqqpc/LN80DBzHSLHcis8NXx6Y3IBKwl5ZIuk2olQX3dW/TpXcNg
         1sJv6/nwl5FBir5bBrna2Y/gJ5dG8Q1vwTh9lkzbgc5bmyRMpv61tXpx3fRT7C5Idmz+
         711NHnl0eEO04IWfihtIVA2G7e8rObbyNRaVE0AAeEqGa/NdNshTf89tdeOOQWqOudkT
         WKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8c5509vV/LgWSAQV021ydpvF5jynvLy8ktsJyCm1QGg=;
        b=Pte8WGMBtrBh7oriG4m34n5jnnOQ6NTQiIYHSIOgvgr49v9JwAa+bTFL/Nj3k76q/p
         i3wHtbU3hU9jeuowApllBXKyEbEjJ0AmDTw7Wka60NgB5Sti44KJZ3jqydC5P67XjYxd
         kwG7beF8hTVgF6CWvWnOHtpvH5f5Sr3o/CZG7hp1OoTDTJKp4ffAwRJ9fq6zQHK7+Od9
         LokQFXzriT3NWR0dMBC6L8/k/zDmBzp9psSEyNwINeLWAQblU/fQVmnNoV0Ai7Q2rvSl
         ApBku8qKTxtkXXFWa6uDeBWKU66R1+UVGHLNvY/H8RWwJa74uRpw5V/riBczjHbiYxIK
         gtPQ==
X-Gm-Message-State: AOAM531bLQJz6qyLbJ34p9qyH3uXgn92bumHwVhqYZtFFql38WeECOe/
        snspqkgbelhRsUs/VFyBflk=
X-Google-Smtp-Source: ABdhPJwWDH3BQkfqOeU9t1w+ZAk375K8y/vuSEtzyEjTZ07vw37wh7R1AVhW922MDYuotjeu33+uZw==
X-Received: by 2002:a17:90a:c289:: with SMTP id f9mr4432939pjt.105.1617111956260;
        Tue, 30 Mar 2021 06:45:56 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id mr5sm2918531pjb.53.2021.03.30.06.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:45:55 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     "William A . Kennington III" <wak@google.com>,
        Lei YU <mine260309@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: Hook up splice_write callback
Date:   Wed, 31 Mar 2021 00:15:37 +1030
Message-Id: <20210330134537.423447-1-joel@jms.id.au>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

overlayfs using jffs2 as the upper filesystem would fail in some cases
since moving to v5.10. The test case used was to run 'touch' on a file
that exists in the lower fs, causing the modification time to be
updated. It returns EINVAL when the bug is triggered.

A bisection showed this was introduced in v5.9-rc1, with commit
36e2c7421f02 ("fs: don't allow splice read/write without explicit ops").
Reverting that commit restores the expected behaviour.

Some digging showed that this was due to jffs2 lacking an implementation
of splice_write. (For unknown reasons the warn_unsupported that should
trigger was not displaying any output).

Adding this patch resolved the issue and the test now passes.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 fs/jffs2/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index f8fb89b10227..4fc8cd698d1a 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -57,6 +57,7 @@ const struct file_operations jffs2_file_operations =
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
 	.splice_read =	generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
 
 /* jffs2_file_inode_operations */
-- 
2.30.2

