Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF041269F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbhITTJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 15:09:07 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52620
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345637AbhITTHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 15:07:06 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AB69240262
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 19:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632164738;
        bh=N1jlmDSs8H0I7NLlGSj51cpDN2fjb2N3sgtJnV4vW+w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kkfAXBh2iunRiTVmV1y/6K0RJGxfuW9rFIWH1UIjjfi7VipkuLcp9k22uJPsYVi5a
         GkYThY3CxCiteKnsEUlCSgIRQr8PBTU5oA2cNm4bQxc7NaGOrDJyeuQWSDWt8SSPA2
         Tvw72tnN6pCpPzvtQjLaeiP6lFXTbqXG3qZ5FIsyPpcu4f6SMd4avI+Z3Wvpb3gAFP
         B5m4RGF8wx9Kz5tnW/bYqrbAwi/2Z/+uPkr2Hg6AayR7WvZkPak2HcUSrkIrrlaD/p
         ynmz/ACZ2YROBg5zKAQJfRDYW5wnx/+Wu9XXzZ1KKrLVUXJG24sfiyv/K4F3fNPOHh
         o761eGAnvFoRw==
Received: by mail-pg1-f200.google.com with SMTP id u5-20020a63d3450000b029023a5f6e6f9bso16008153pgi.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1jlmDSs8H0I7NLlGSj51cpDN2fjb2N3sgtJnV4vW+w=;
        b=jxvwjDoHoZ2CSO7xjEf7EllMG3o/bpXwFgoGKOCDwE83+NEqfYC6Jeao9ILyOKUqF5
         7YUfIqGRkUU36jEQCqzs5q8hiaolhy9xOPjg77W6gZPjRadJcI0gWfeegT9ty6/qzWID
         9TuDQvknllPjas/3ErmxXwvyb/7VN5rs/o9UEhIzRzf/098HuEL3+MsZSSgIuguf4fH5
         rk5exbkKrzRgb2Ch47B25nEYjkI72K+aaCLRlyhD7oNGg9EX/+F5I6ebB0ETAqBI3eQo
         RDRv2mubqan0QBAGiumWOieakh+ujmNyOdGG8L1ktLnMTyEukqreaDIz+Ec9SrPkkAMM
         H5ag==
X-Gm-Message-State: AOAM533WKUkSV47O9tPgflDTLDagcgiRm0aw/TmVtLym0gJE33sIlHRm
        m6EbvzjDAUjrRAjLOVzQh7kXGboOSemcwdei4dQ53SPSEK0lOse6XnBHHZ1ndfUVon2j+SIc2IU
        crjpFEYQRTaqDGJ2BsJvFwlGGVYAFwa1lzryqD/kGlQ==
X-Received: by 2002:a63:f346:: with SMTP id t6mr24668800pgj.345.1632164736988;
        Mon, 20 Sep 2021 12:05:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhabpRbi2FUhM5/agVT+o9dMdu+hHL1/0/QLW2Q1CXcI39gGGyhNspJi+3wGqmuJFO7H3o3w==
X-Received: by 2002:a63:f346:: with SMTP id t6mr24668784pgj.345.1632164736788;
        Mon, 20 Sep 2021 12:05:36 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id l1sm203209pju.15.2021.09.20.12.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:05:36 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     cluster-devel@redhat.com
Cc:     tim.gardner@canonical.com, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: Fix unused value warning in do_gfs2_set_flags()
Date:   Mon, 20 Sep 2021 13:05:18 -0600
Message-Id: <20210920190518.23056-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains of an unused value:

CID 119623 (#1 of 1): Unused value (UNUSED_VALUE)
assigned_value: Assigning value -1 to error here, but that stored value is
overwritten before it can be used.
237        error = -EPERM;

Fix it by removing the assignment.

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 fs/gfs2/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 354cf85154a6..7e09d2168030 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -234,7 +234,6 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	if ((new_flags ^ flags) == 0)
 		goto out;
 
-	error = -EPERM;
 	if (!IS_IMMUTABLE(inode)) {
 		error = gfs2_permission(&init_user_ns, inode, MAY_WRITE);
 		if (error)
-- 
2.33.0

