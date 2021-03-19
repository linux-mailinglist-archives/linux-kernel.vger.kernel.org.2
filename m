Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05760342764
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSVEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCSVEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:04:25 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5185C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:04:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 30so5717230qva.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/nktInARZ9hXpgu975gOKxpjGnLE59YkaWuoK4EiJg=;
        b=IWB65NV/0TVHXWZlbFoIcFqEyWSU9uty0Pga1bF9DbCnhG47C98RH1PgNs8LukWHaP
         pSitF5bVqt/9MXnTFHZZD/kXJ2E7o7U8s5cm4d3nF7Gz3OW+jM/45sXGXIWpT8nKRpiI
         2dXwoLfBwq6IV9uPSGTwLvKlexZehvivmNDKuLk1JMkkOre1EPZ1pGchw+ox9ePrDkUI
         WiIo74rnSwW0Ei0bEYbqs/mN+sKjYX3aYpV+BH3pBoiprqXgVIKwyZfCcjc9h9zQXQeR
         dO7QgkMmjoH2rxQniI28l3xqM6Bj751+F+hT2+AmVla2uk04tgLRi+9w20sbDi14Znt8
         BtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/nktInARZ9hXpgu975gOKxpjGnLE59YkaWuoK4EiJg=;
        b=sjf5i5ZZGWd4j6oS+GJNX5blNFSOvzMWDzBefOyULrBarbQbABpND3KYpKilwQOTm4
         OeFM7gU20C/6ev/EwzYl6z/3VfDZG2naO66Oi85HlZNHxt0WaNR0KIZ9cCOnUmeMVbr1
         lkTcyAVFqf1hLGcQVdBPi7DfbX+DrVxY6rPXMfGUOuEWU6KdJjQk73DxmT2r4Vn+gOQo
         Oyl8YAQ/BobyzWms5bgnaa+VbJTmMKR1FEn9XQcAA2gK1qqhbaGCg/353HSCoh1FlxXO
         GJ8FCtYHZwGHDbcHGZmcPoI9xyAvoKj8v1YFBK9melZXvSozQlcKT/F5NtbVcGuwWc9I
         EOTg==
X-Gm-Message-State: AOAM532wuMYZtaf+p21srxqylHWKEyTv6uMtRzaEoofdb6D2pWhWXYJk
        kHQ9P29TE7ib1mmwu44ccWM=
X-Google-Smtp-Source: ABdhPJxTFrrldOnI2XcSJh1QtcrvLUsfFeBy7k+X2gNuf700iTYmfI1H+DP53YY4rKawgGE681kwVQ==
X-Received: by 2002:a05:6214:262a:: with SMTP id gv10mr11350351qvb.50.1616187853526;
        Fri, 19 Mar 2021 14:04:13 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id v5sm4540713qtq.26.2021.03.19.14.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:04:12 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] lib: Fix a typo
Date:   Sat, 20 Mar 2021 02:31:55 +0530
Message-Id: <20210319210155.6793-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/funtion/function/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 lib/list_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 52f0c258c895..282fe269f16a 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -107,7 +107,7 @@ static void merge_final(void *priv, cmp_func cmp, struct list_head *head,
  * @head: the list to sort
  * @cmp: the elements comparison function
  *
- * The comparison funtion @cmp must return > 0 if @a should sort after
+ * The comparison function @cmp must return > 0 if @a should sort after
  * @b ("@a > @b" if you want an ascending sort), and <= 0 if @a should
  * sort before @b *or* their original order should be preserved.  It is
  * always called with the element that came first in the input in @a,
--
2.26.2

