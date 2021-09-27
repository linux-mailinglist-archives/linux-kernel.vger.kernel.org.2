Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ECC4196D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhI0O7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234944AbhI0O7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632754683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/qaQ52OCSwFpVVEZfRM30bFeuqGacykcW5CTOL4Hw+o=;
        b=BY/U/9xBMHDu+HXw0ASZOlJEXwXfh7n0BJy9vqWZy2HwL4hJRONyWUgFjsBOuBN8H6bjtB
        CzTs3BGGUuvn+8Og8nAaObeccyrUK4qPY5Q7kV3pRieBLK3AtZuj1CVQ4P+NqFQ0YqCStu
        zLuIASuEkpnNbndwBNnJcLvi7djM9TI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-6XM6Q7StMqOwwCq0Kv21yQ-1; Mon, 27 Sep 2021 10:58:02 -0400
X-MC-Unique: 6XM6Q7StMqOwwCq0Kv21yQ-1
Received: by mail-oo1-f72.google.com with SMTP id v11-20020a4a314b000000b002a9d9728566so17301645oog.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/qaQ52OCSwFpVVEZfRM30bFeuqGacykcW5CTOL4Hw+o=;
        b=24uJzWlzqrTYLnJNWrwY+MI0fD5BBfG+9k4SeIoVqoGFXRBkf7ZWVnCQfzOkE5e4AT
         r0/03mHh9fFJglj/G2np+pEK9usHZneWAAaXz+lo8LHapcNed3daKRdCraobaoOLqHhD
         zGXm5sqD5NQ+kcnJcxDshyMyRgLjRUHs2lF0tTMPl7/+4Cya0koxsg1LjPTzB/ITUuEC
         54HCbPS9UcS0v6xYcFteDkLcnLASHgGTX7h+lZfCBDB/1q4skzI2qxmaF8DxQRW+KTsF
         t/ilmNyMpgJI0JIFwBHqPz64teJFF++4kixMQL6M4pLlKGNkIBO3cyLG4zoXzfCVEeD8
         xG4Q==
X-Gm-Message-State: AOAM530R5X/y1TSsPXmJlkrGthsUNxyfCBqSwM1ktllzrSztHyGvHkwL
        n166+GdlhLA38WxFhvrqwmEWgOv2P+J/wHqUY1XRYCmZo0A8W9nqNYl9PlngY4kqBJ8rOHo3YPw
        YgnN4fV5yrPyHJbV6iraGtizP
X-Received: by 2002:a4a:bb98:: with SMTP id h24mr289356oop.23.1632754681726;
        Mon, 27 Sep 2021 07:58:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylMVNIDafwx10dmiiwMoOTn6BhavxYcofPK/B8LHY++vRWRcLzo0yq1S4cRF8RSXvx5jVdoA==
X-Received: by 2002:a4a:bb98:: with SMTP id h24mr289316oop.23.1632754681214;
        Mon, 27 Sep 2021 07:58:01 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 18sm4061748otj.10.2021.09.27.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 07:58:00 -0700 (PDT)
From:   trix@redhat.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] locking/ww_mutex: set ret variable on failure
Date:   Mon, 27 Sep 2021 07:57:56 -0700
Message-Id: <20210927145756.209435-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Building with clang 13 produces this error
test-ww_mutex.c:138:7: error: variable 'ret' is used
  uninitialized whenever 'if' condition is true
  [-Werror,-Wsometimes-uninitialized]
                if (!ww_mutex_trylock(&mutex, &ctx)) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On this failure set ret to -EINVAL as is similarly done
in the function.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/locking/test-ww_mutex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index d63ac411f36722..7dbac5dc02efb7 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -137,6 +137,7 @@ static int test_aa(bool trylock)
 	} else {
 		if (!ww_mutex_trylock(&mutex, &ctx)) {
 			pr_err("%s: initial trylock failed!\n", __func__);
+			ret = -EINVAL;
 			goto out;
 		}
 	}
-- 
2.26.3

