Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D587C407194
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhIJTCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:02:38 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36492
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230513AbhIJTCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:02:36 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 47AAF3F499
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 19:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631300484;
        bh=MBtluqNukPdcEGpdwgvbXPFv3pY+sw4KVloaomnNcZg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Ndlus/ACQ9A4PJmfwqz0t9gNSpEjWNMjUkkJUjh/qKJ02PHBhbq6vxzbonF7YOPLI
         64T3jkk2jeyv00Nk2yWjS8DQpsIWXNB2YxaTt5qCTeZTTwmFkxpRgH5med7+2sOIji
         KbGvzDxG/t9Nn2ksrJxINJvzf6aJSZduUR1yb+qSZLxdaTNK6RcXLKpI3m5QhtixjJ
         sP4vBV9/A7A0lqzDCgiPxXv2L7Z988ia3n2f71pYIsp1Jsv0TxYKH2DjtqPtUsBL+Y
         D0rDUnJ6SrK8yBgOvYyS0HX+lT8XOR8KJMx+k70Bwz4FX6JF39G085Q1OGJmUsru4i
         OcQK+wr3n99Zw==
Received: by mail-pj1-f69.google.com with SMTP id y15-20020a17090a600f00b001993b27b471so1808847pji.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBtluqNukPdcEGpdwgvbXPFv3pY+sw4KVloaomnNcZg=;
        b=6YtkFbxF1ADeMnLe3TWs5faEFvVz6i4pQa6wL7BCedoznfIdLCTJfyu5KoIfg7J4pm
         2ZEn0BNHAGWBc+Ma9uvLbi4HDshogzg0RAetSLIvCl7Mxnm1YEh7Jx7scZG6PSbK+kUf
         ry1lqXQULKi/nUVPwIHDBZYcQ7Ws9BzHm2kifds73346eZcqaTreqcejWXMST1l2OGZS
         /dBMHnZ+DS/N4ZGC6L6KLK2+pgPF1gENA2e70TckYXAbnAjKbue1wlgm2Y4Mwk5leMr5
         5cgEVSD3v7nTjWbqMRXxk9hjM3Lfrz2xkH+7TQDidFZmwV/Dc4kpc32UsxaPGnJFBLx3
         5MUQ==
X-Gm-Message-State: AOAM532jt3HWeEVHfiSDqCWVXdCGuXuCHQTnIIEtFFe3uAODPTb+5wvF
        lwYTrwTjEUlki77vKaHw6ZdggIPGyDz8pumVql8Xe+QYPrg8Rloi8hoEdGx8LaiW3DbcAv3O/KU
        oVFOE/92CP01TSKZf+gKMqmr76Y+xF6DLGgUcYB9iCQ==
X-Received: by 2002:a63:68a:: with SMTP id 132mr8612402pgg.154.1631300482703;
        Fri, 10 Sep 2021 12:01:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgNV/BhWRskvi5hTjkSPzv93WPvsAkhP+1MjE4wfxOgQjdY3eWlCNEVCpeLprlPYvbtvEEMQ==
X-Received: by 2002:a63:68a:: with SMTP id 132mr8612363pgg.154.1631300482138;
        Fri, 10 Sep 2021 12:01:22 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id t23sm5377869pjs.16.2021.09.10.12.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:01:21 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-crypto@vger.kernel.org
Cc:     tim.gardner@canonical.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: drbg - Fix unused value warning in drbg_healthcheck_sanity()
Date:   Fri, 10 Sep 2021 13:01:17 -0600
Message-Id: <20210910190117.24882-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity warns uf an unused value:

CID 44865 (#2 of 2): Unused value (UNUSED_VALUE)
assigned_value: Assigning value -14 to ret here, but that stored value is
overwritten before it can be used.
2006        int ret = -EFAULT;
...
value_overwrite: Overwriting previous write to ret with value from drbg_seed(drbg, &addtl, false).
2052        ret = drbg_seed(drbg, &addtl, false);

Fix this by removing the variable initializer.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 crypto/drbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index ea85d4a0fe9e..f72f340a1321 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -2003,7 +2003,7 @@ static inline int __init drbg_healthcheck_sanity(void)
 #define OUTBUFLEN 16
 	unsigned char buf[OUTBUFLEN];
 	struct drbg_state *drbg = NULL;
-	int ret = -EFAULT;
+	int ret;
 	int rc = -EFAULT;
 	bool pr = false;
 	int coreref = 0;
-- 
2.33.0

