Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038A631AB8E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 14:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBMNQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 08:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhBMNQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 08:16:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA8C061786;
        Sat, 13 Feb 2021 05:15:25 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a16so1268089plh.8;
        Sat, 13 Feb 2021 05:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5UYTaCWBB2+LL3/tlIpAWg8VNUjtbCiU5GIunU3FQA=;
        b=FtSmFBNTznJDV3XVu/wjw/sH0sKR2tspk+989U4ZlsOIeNesWTaEoNFF6mHlEAcelZ
         QiXeJGQH2r3jmIU7yQ6aMGMgJ1EeDB5Ym7W8nNydVcVBFr84v6JjRnQVSNCtY7KFGXes
         zW2E2Vbeh7EU4o2sanPYBDOO2tn1utM4H7JK0Y43mbR70XkSUxlJVjOYu2YYGNIspHYN
         EuRxZrVu+PbQcHiJRv1XQtGpI1Dawlp/jOUyfcRi0AbI9cWrVXTyI/vNlQyzga7k8/AN
         sfycPprZkdv6MRQbjJSP6H32pnyksM+Rw28mauCzEynZw+r86A5+JlCQWcillFJHMISR
         Y2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5UYTaCWBB2+LL3/tlIpAWg8VNUjtbCiU5GIunU3FQA=;
        b=SaF4nDsAJ68Ms0c9zU8cY0jmkwV8VZWx4HkidK/0DvMzSYfN/uhguHkRtJ5U5OIJjF
         W8MngGQ2/BhLXv80WGLFq/TrZth/I/CWKXIl/EZBgKKGqU1VhYmQCZ9GP6ImhzFOqU2j
         dYxb7lzcbup/woTp9v/LT0VApAGtgtkhecd4ShwvWA+6SV5hwFAmkpFv3ljYd1b2EXds
         fh2DKFwkPhU/YluK+laDIHFJ4CzlPlNrItznx2W6hrmFOM0f6FcYhfDg3RGR9zGvWrb3
         6xXOvy1OZFQxl9DtEN0DSLq5Eyrkeen5taGXZbb+ItjnMvLci79x7eeBG0yMZ7GgEv3a
         EPZQ==
X-Gm-Message-State: AOAM533nN0yfJmc6QtVaT0qGH/wDgwumhAsNA5O5YipfZSOZsXU/lJox
        dBBuAs4xOqxheZ6Xa2DmviDx6f6aikUCcefR
X-Google-Smtp-Source: ABdhPJyush0sYA4KhVnvad+h1wrLqewQA8oXOXhF4Ob0C8WI0A8SF0z1ZRlOstVN7J9dBJYRyErdJQ==
X-Received: by 2002:a17:90b:17c8:: with SMTP id me8mr7450398pjb.197.1613222125217;
        Sat, 13 Feb 2021 05:15:25 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6ab4:5c97:80e6:be35:2e49])
        by smtp.gmail.com with ESMTPSA id p11sm833533pjb.3.2021.02.13.05.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 05:15:24 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-doc@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH RFC v3 3/3] docs: add documentation for checkpatch
Date:   Sat, 13 Feb 2021 18:45:13 +0530
Message-Id: <20210213131513.51386-4-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210213131513.51386-1-dwaipayanray1@gmail.com>
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link the checkpatch documentation to the dev-tools index
for sphinx.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 Documentation/dev-tools/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 1b1cf4f5c9d9..43d28998118b 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -14,6 +14,7 @@ whole; patches welcome!
 .. toctree::
    :maxdepth: 2
 
+   checkpatch
    coccinelle
    sparse
    kcov
-- 
2.30.0

