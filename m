Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6D3F7752
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbhHYO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:26:49 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60378
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241591AbhHYO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:26:36 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3F7C840782
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629901548;
        bh=75IyrXuKwrcLVvdo4qEJ0WJWV94tMbWLl7mt5kzUBCE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MENpSEqAJaHaS/qDCpXN34NTkNYO4QeQYYfkjKwm/nFtJ2vjfF7OlG9hWepbxEn7F
         owMuPNj/ENK2TB/YMfvci4aFKMH2fp9cTORh3EF6Ys75zXO9E8Eh8CJlEHZdg1xH0u
         kD3hcrVemaKZRHFg4Y924p1SylcCc+WsjfCWNLcYTNOroP5MzPAK5JVknfM1guWWWj
         PlizWzuykQkSj+KxUd8BS/zKX4lTCO+0V4O4puNJNeirjl6E0L73Rt+AoTdPdOmQrc
         rKPq2A80Rgx+QDxd4qPT0tuwwdvAPVWeFzVlzDm+bySOD+5xvcIhAZAM9F1v+2uQX9
         ji/yxcjezuWKQ==
Received: by mail-wm1-f70.google.com with SMTP id r126-20020a1c4484000000b002e8858850abso229997wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75IyrXuKwrcLVvdo4qEJ0WJWV94tMbWLl7mt5kzUBCE=;
        b=G9fXgzMV/gZWneixjRHNDlhUvsEJGTp9eV94qM5sKXFUjpg/n/OX7w1cMxLKeZn1Xr
         2MGNJMZi7FPf5khLb4+BT4/ud7vY2NCVPvZ+w6y7jfOGphoxkOa13wlirJ7gEXeXr2Pw
         3oGP6vJbWK4sa1EQuzViWAnbq1cOGtDsaYPqGhh2Q2QjApXrg0gkXfpHXl5GOUn+O+oQ
         ijVg0B8hFk9shgmwSm0pjDGMp6WAgXy31qEcqIlYXV36cG2Ah10t6kwxh5Eo+MeKGfRh
         9b5Jkv7bEgTiVhd9EKmF+Nn/ILjl3K4PqSW5sZc8f4Dj/TxQs93WuWrph7gs/DfZnczY
         msoA==
X-Gm-Message-State: AOAM5323/QVaKcdOtIbJkUqohl9NC/uf+cDuSDPvQn5flRbSr4nxRLuB
        Sfe+QTpV0pi0Gpbzoop33uxlbW09SdY9ymajTWtZPggoKzaJvh9D8dYF/nLyG5huMRlo4RW+pdo
        +QKx6A2nDK+lICOOlfbJ3UKAvpI+KRLigKhzLsgO+YA==
X-Received: by 2002:adf:e101:: with SMTP id t1mr25641184wrz.215.1629901548032;
        Wed, 25 Aug 2021 07:25:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0xFoz9LuF8pcrbV+A+y5xF/azh985EmDuG0RjLG0TyeZyGUZLIjZGjkNM/EhFi2oiQQqyHQ==
X-Received: by 2002:adf:e101:: with SMTP id t1mr25641170wrz.215.1629901547865;
        Wed, 25 Aug 2021 07:25:47 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id i68sm60375wri.26.2021.08.25.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 07:25:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] nfc: st95hf: remove unused header includes
Date:   Wed, 25 Aug 2021 16:24:59 +0200
Message-Id: <20210825142459.226168-6-krzysztof.kozlowski@canonical.com>
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
 drivers/nfc/st95hf/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 993818742570..d16cf3ff644e 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -16,7 +16,6 @@
 #include <linux/nfc.h>
 #include <linux/of_gpio.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/wait.h>
-- 
2.30.2

