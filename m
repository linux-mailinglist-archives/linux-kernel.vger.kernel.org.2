Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E773F7746
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbhHYO0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:26:36 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37568
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240850AbhHYO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:26:35 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 074B940794
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629901547;
        bh=VhUvKPsyXjxe2LvjgGEBo9sT2cdcsgoMO30bCzrjHo0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ATPep6aNb7VkWfVFNIniT2y8f+1s5FJbDyKExRlcYaGJVm+7fMLw8KVpzqcRx88cc
         PtrV4dqAGVc7dGZvRuHQWtwLRgnEIW5jQ7l03IgwNVwTOUn339mg8OTSfDnPDWB1x0
         c3SF5RvBstSjzUgc+iDARbLAk/wcuxiYdvRl6vWClHOw9hAIViQuxLjIDuWgiGbtJW
         9jMd8CVnrMs4lcm0bkTfh9aDZpfeQ6BVEF0Ek0C3xMJeIjywD1WuykLVV6OCJeWrBo
         hoayMUAmUq3ufSILVvCheYio/jzsDqUoMWHep3W+kJLFelSfv7dnVgadGI6WWP+RrP
         GbjY5xlJPXtdw==
Received: by mail-wr1-f69.google.com with SMTP id a9-20020a0560000509b029015485b95d0cso6721675wrf.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhUvKPsyXjxe2LvjgGEBo9sT2cdcsgoMO30bCzrjHo0=;
        b=l0mgSlxtJ6nN+PxkHn/3+SyNGsW3qk9XJQluPjcLieRenPzVUbrpRQp5bBs6rh9B59
         Ng2kt+gI2QbcjVoGP5agve+l/7t6IbiX9KKCChtBLzisG1xoKkUVIpG+yIOmQI++vF4E
         TJQM8hxrrjkVpptuefpEt2Y0K93W9tCUxJ5r3E396jWMpGuD7PsM5lVHLDqvfD6Bp7GT
         aumlTFOz3taBud8WjhyGwPNZh5YIE2n7TktMS+7mEi7sUeR+9jyZT2tagh7yP9Xjx3rp
         IECzFzQsORTuerX5Y7Vbr4ckBHBNyrkiWkZ+vMNIPCGOFJax476lDSQW6Vbt40MwRraM
         ym7w==
X-Gm-Message-State: AOAM5328I9kuWHy2zcQdbe3K4gW4Fi09/ojvtUPlEEH9ZjpkkimQAYvw
        fV4VRzl+/t/m6xYHn8JNJgfYZnqADr9vUt61UzOersYiPgepDI9Xhj/4JmvrY6WAI/ao4jf8LYJ
        BSeDCZQZtTkvzv1SoAj7cZtBqDZmq3tawlR6mKhc0pQ==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr9748919wmh.180.1629901546491;
        Wed, 25 Aug 2021 07:25:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz2n7ykJoDbqtXZEZVoNFYeGdaA+OyKxpJHn4YsVvaC/ZZAHgNZphY3SDbEL7/FwzxUzHtkA==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr9748908wmh.180.1629901546312;
        Wed, 25 Aug 2021 07:25:46 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id i68sm60375wri.26.2021.08.25.07.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 07:25:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] nfc: st21nfca: remove unused header includes
Date:   Wed, 25 Aug 2021 16:24:58 +0200
Message-Id: <20210825142459.226168-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825142459.226168-1-krzysztof.kozlowski@canonical.com>
References: <20210825142459.226168-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not include unnecessary headers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st21nfca/core.c | 1 -
 drivers/nfc/st21nfca/i2c.c  | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index 5e6c99fcfd27..161caf2675cf 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/nfc.h>
 #include <net/nfc/hci.h>
-#include <net/nfc/llc.h>
 
 #include "st21nfca.h"
 
diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 1b44a37a71aa..279d88128b2e 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -18,8 +18,6 @@
 #include <linux/nfc.h>
 #include <linux/firmware.h>
 
-#include <asm/unaligned.h>
-
 #include <net/nfc/hci.h>
 #include <net/nfc/llc.h>
 #include <net/nfc/nfc.h>
-- 
2.30.2

