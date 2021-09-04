Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3379E400A3E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbhIDHb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 03:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhIDHbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 03:31:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8E3C061575;
        Sat,  4 Sep 2021 00:30:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m17so859395plc.6;
        Sat, 04 Sep 2021 00:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HIkttfs2aaPHWL/DCGAFe5f0f66t9FbwgpnQhrS6PDk=;
        b=jCFAMXzMXUvHVIjfVqlQcfgsrvVIVPT/bd1tUZVBfDgC4y7xYE161b38Z2SV7s305n
         wHElh/C8ofsGV0129yAtN2VXNRfsvFC7JnnnISxj2mq6EaGNPCuxo0FFgaJJTXNojhi+
         2tfUfKlWIJtOvXtsgJpha8k4wwONO3LpkIwQ8WJXlBgiL5aIQ06On7xmG3mzWlUW2G/N
         Zntf5/LkaG4q/7eX7QIEriRBs5xoAkZ5qFtW2AGvdw52wiamQp5ZGWBcmv3sDPisvgiO
         qtbFKHXp0ck7LuEkUNOocepO1lyoARatF82IdfAAS4ZGGjcLwrx/nHZ/U6csludR5JFJ
         PPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HIkttfs2aaPHWL/DCGAFe5f0f66t9FbwgpnQhrS6PDk=;
        b=tqEDeiZqOrc7UH+itnzPYKeqWEI6aiX9jGzhKWxae92MZRzOc6EnayQd1xZW5MvfAI
         SMiWYllMwpXHUwP37E9KE54O18uLxm6bDb5LeFm+iSqOgmlXfHb6laaxf/MYVjwik2am
         BYfiCIqF7U9lhRgfBWzkilUly6cdrU5NsGuakpU30doo7hPNRm4ELx/oELkMtFltV6Bs
         clvOQZL5Ti5738a0WBePpY5/O/iWkyoHeHPLXAkvE5IFn+1qNBzmOBWe2BD/Ik7nyOJw
         Eri36DeZV44NcKWvnhG7VF4vrctgvcGTQOS+JtlDkGpzRhcEbcEOVo0yu7dwmeMbttmx
         s7Vw==
X-Gm-Message-State: AOAM533N+/W6ON3Jf7yugZ55x4eaIkKuKFej48HhYGT6OyPOfXUGDtV9
        V57LRzIsc48O5fo1OlStl5o=
X-Google-Smtp-Source: ABdhPJxRgMzhgkD37f24OiagB59RKftmE/H7Mh6cw81428y0Fkp3RwwrDNQC/iO6mgreQlq2z/RDEQ==
X-Received: by 2002:a17:90a:6f24:: with SMTP id d33mr2891906pjk.239.1630740622247;
        Sat, 04 Sep 2021 00:30:22 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:82a8:3271:93dc:763c])
        by smtp.googlemail.com with ESMTPSA id x16sm1569308pgc.49.2021.09.04.00.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 00:30:21 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] Documentation: checkpatch: Add SYMBOLIC_PERMS message
Date:   Sat,  4 Sep 2021 12:59:51 +0530
Message-Id: <20210904072951.12556-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new message type SYMBOLIC_PERMS under the 'Permissions'
subsection. Octal permission bits are easier to read and understand
instead of their symbolic macro names.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index f0956e9ea2d8..01105e9c89de 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -957,6 +957,17 @@ Permissions
     Permission bits should use 4 digit octal permissions (like 0700 or 0444).
     Avoid using any other base like decimal.
 
+  **SYMBOLIC_PERMS**
+    Permission bits in the octal form are more readable and easier to
+    understand than their symbolic counterparts because many command-line
+    tools use this notation only. Experienced kernel developers have been using
+    this traditional Unix permission bits for decades and so they find it
+    easier to understand the octal notation than the symbolic macros.
+    Also, it is harder to read S_IWUSR|S_IRUGO than 0644, which obscures the
+    developer's intent rather than clarifying it.
+
+    See: https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
+
 
 Spacing and Brackets
 --------------------
-- 
2.25.1

