Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B8241E3A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbhI3WHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhI3WHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 18:07:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B051FC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:05:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d21so12346219wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqyS6h3FznDu8EubeURpzw4zm7MTy7+ReY+kVhlyTcA=;
        b=pnI+PVEGQz2zK1u7J+TOVlSECjcfROF2iiIFvTOUQjLOwLVcos+1w6mT2e2zTB+50X
         lQYyRp/xsSanwklXdm/G+BZYDMHdSehTZ3ofy96+6z9wnhj7xgEP9iGuFU96BCRakLxE
         tpnumu17f43BnK2vwjohiKZ1QaDzi++/3y5NwVq1FcmNUPvYo9nXthhV0f191NDYFKry
         //VhHdpcKoy66gRuD84lCf22fXw2af/G8KkrIcDOWCPaT4lNixXiZLtpRk8Jy+j7n3eI
         ng71ciRQ3EjVMnCUbNve/3TXi5DcsK6toPFW/re+NEcrZo/J9585HvNpRAoRggTxhm54
         KMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqyS6h3FznDu8EubeURpzw4zm7MTy7+ReY+kVhlyTcA=;
        b=kXZOmVUHgX5Y8wkZqym465tBIfTUokKpUCxCuXJhxseVTHUFtjEYZj7M08O0qT2SLc
         Jc7agxl4dTnkdPw5urgWjorWm6lwRLmCOxyhemY6qSvVZzdJ8l9rVZWRtzLqvKXdqTAR
         P0s92hrNPQJRRuKEa5YlJ6k+zMhonirdNzMm6R7+YcsINedceLxXbbjT+qzuFslgFjsL
         S3Hxe5hxRQtkXRxcKS/a5Xc2t8DS1P8B4IXYY1eCEPlrLYTZr1XS59vjEqrPMpjs0juu
         Sg8AizGaE1UQFBBEGMGnlBuPYkZ60AzjjjUxBUfBwpxe5BFPXYE6CaR42eeZmJqHBcg8
         FfFw==
X-Gm-Message-State: AOAM532Q/9IQt7LxQYyRS5rWeZVX3pPc4+fk68jhTwyl2MwtLzOmPwT8
        sbLg0mIo0xhepBtixpkfS3fBY2wQanWJaQ==
X-Google-Smtp-Source: ABdhPJx0OsfTQ+kN2qu1o5Iis6HqP17LZrgbVXo0dS+HRHEVJ6XQYka7ARZKmMuhaNDAyPZ1hyH4og==
X-Received: by 2002:adf:e509:: with SMTP id j9mr8915985wrm.416.1633039525220;
        Thu, 30 Sep 2021 15:05:25 -0700 (PDT)
Received: from localhost.localdomain ([197.49.49.194])
        by smtp.googlemail.com with ESMTPSA id z17sm4133149wrr.49.2021.09.30.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 15:05:24 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/9p: fix indentation and Add missing a blank line after declaration
Date:   Fri,  1 Oct 2021 00:04:20 +0200
Message-Id: <20210930220420.44150-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 fs/9p/fid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 9d9de62592be..0fd2d0d059c5 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -103,6 +103,7 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 	/* we'll recheck under lock if there's anything to look in */
 	if (!ret && dentry->d_fsdata) {
 		struct hlist_head *h = (struct hlist_head *)&dentry->d_fsdata;
+
 		spin_lock(&dentry->d_lock);
 		hlist_for_each_entry(fid, h, dlist) {
 			if (any || uid_eq(fid->uid, uid)) {
@@ -185,7 +186,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 			return ERR_PTR(-EPERM);
 
 		if (v9fs_proto_dotu(v9ses) || v9fs_proto_dotl(v9ses))
-				uname = NULL;
+			uname = NULL;
 		else
 			uname = v9ses->uname;
 
-- 
2.25.1

