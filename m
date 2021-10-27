Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4051943D2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbhJ0UbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbhJ0UbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:31:14 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EE5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 13:28:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b188so5270021iof.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eWHn/jG+avRrBmFKeL+1zT6EQSwQOpXH8c+wEZwCdI=;
        b=eqYjUCU+DPOsJ4VO0oHmq55s4tf+B6tFn0ihxt9NWSqR7ecEfk11UN04t+aZw1GBoQ
         Stt7bJIawXTsNbbIejGqskDjCNlyFyC3hRiJXCfqEbcpGYzwC//tMWnt9T/1eKRsMSY1
         OSKX4iFu9dGi8lypL8EMM7CSOUCaWkKS2zZ2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eWHn/jG+avRrBmFKeL+1zT6EQSwQOpXH8c+wEZwCdI=;
        b=rc/ocaOouKHZJ2BDSf5RyZP0pslvJUR3eCUez65nmB/cu9iKgEYHYpkFB3FEPxPjC7
         EmQQ9yC8ta6tsdJFJRCGMEZAdxUCOt7RdvAJMDRgo12FTxVMz0f5ZM0FkxYZwQdIAyMm
         CiB1Cj+7gMDzwqq7HtFyt789QDnDXiKzw5cW348oJsV6IXyefWXMv/KFSFkZENPeEQ9+
         8uUt7G4aPW7WAKt/XOnsWGXjvnhCx4O17/33SKZjMJxEzjs8AQMWAbOaOj1i2Mvf9I8O
         4aZN7CrVKA9OZ//6Xx+nB8yprawZDSQjjqOI2/0zBmfzQGOxqyKu4rpMRYTaK2J+4A6k
         H2qQ==
X-Gm-Message-State: AOAM532nhHNoM1N1Tyeuy8hUlPwNwYJsgSyaClN9u9QiypiELvrg9Vqv
        vbqpAevuBR0CMwt8k7AsAoGvQg==
X-Google-Smtp-Source: ABdhPJyqqNy9vZHA1zN7jISqipB+tuyoKAYDpjxwiWrRlmWJYR3xLV9oOefmaiFi5GM5YElIqnN9hg==
X-Received: by 2002:a05:6638:1502:: with SMTP id b2mr31604jat.131.1635366527972;
        Wed, 27 Oct 2021 13:28:47 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i5sm457383ilj.49.2021.10.27.13.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:28:47 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     davem@davemloft.net, kuba@kernel.org, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: update .gitignore with newly added tests
Date:   Wed, 27 Oct 2021 14:28:46 -0600
Message-Id: <20211027202846.26877-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update .gitignore with newly added tests:
	tools/testing/selftests/net/af_unix/test_unix_oob
	tools/testing/selftests/net/gro
	tools/testing/selftests/net/ioam6_parser
	tools/testing/selftests/net/toeplitz

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/net/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 19deb9cdf72f..501550501216 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -31,3 +31,7 @@ rxtimestamp
 timestamping
 txtimestamp
 so_netns_cookie
+test_unix_oob
+gro
+ioam6_parser
+toeplitz
-- 
2.32.0

