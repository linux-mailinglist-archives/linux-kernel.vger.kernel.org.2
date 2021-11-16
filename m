Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2095453A36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 20:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhKPTff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 14:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbhKPTf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:35:27 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC9C061746;
        Tue, 16 Nov 2021 11:32:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g28so82790pgg.3;
        Tue, 16 Nov 2021 11:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEUJ6Cchj6DxoHgG1vlE1s8aOzepdDzEGtiMa3XVL2Q=;
        b=CIytzrlXphzfFrs6A3g8F+qIiR5oMedCXkVqQxjEkLVx8DqZXENvsXIIfHSHeiIax6
         WTknH5rIMVTfjebiAHH3/3JEqYF3qJaONSJkIntZO4i2Bcx21tkHmlN/NZwyCSPTteYx
         1lvnbhQEU9B3FV6QtGliIk8ElS061RX9fg88InlfUvwWvLgrPe5EXTlV7754PRGs4U3P
         ZtZZJQXMunUejVwtiTYwKZ38Q95KqkI54/rkZrTnIosldagx7UclSHkPSCZBSbaDPmQO
         yqXjRCum+cmBbniPK3EMAigXEbNTkwcqW03GRd/q1dlltG4jv4/CeNUjc+lF1BkD+qel
         LfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEUJ6Cchj6DxoHgG1vlE1s8aOzepdDzEGtiMa3XVL2Q=;
        b=RWDVs2Xpm5jPH0zk1DSaj73MZzHbtAa/RyqTp3DbdE8kFoMrpx8yvGMk4BglB3GvM1
         1AFjs+Btb2KRsxuIZBgljBQdPUm5a42PV7ofKu6YkLSCdUgOfkQHusGQhxr0C5wdbDRK
         RQhbk+eebQ9cr7FxMy89odAtJf/vi79nyzf0JiMhkAbGuvRZhDWYm1prbC/EKLmwpz1L
         lyXej2E0blsPlz4P3O+oeDcXq33uZTgT7oEKBZUp/lzHYuPr3zWeN+zOVDa2QsUkXqVT
         fpEKlugisx+Dm918Uc1zgiz079EBjI9twaYRqb4v649DXl45hNM5cTOtnM4QRE0LXBO4
         e39g==
X-Gm-Message-State: AOAM530ixAWazAsI+Q5YADuu9vTeq5VZq/tQ+6YlhZVyRl9dM9CjI/31
        V0v9S3gZDlC4MO6Wb30kH9Jvb2NbKad/TTRe6Ck=
X-Google-Smtp-Source: ABdhPJxBqEcKGkrn5U38ZOGVuIn7FvUUDyTGdOzWbs7YQUjE6ddOcIfyLgADmd4ZYn1wDiLO1wFlZg==
X-Received: by 2002:a63:e444:: with SMTP id i4mr1021586pgk.474.1637091149674;
        Tue, 16 Nov 2021 11:32:29 -0800 (PST)
Received: from nutanix-ahv.sre-labs.nutanix.com ([4.7.20.99])
        by smtp.googlemail.com with ESMTPSA id k19sm20472563pff.20.2021.11.16.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:32:29 -0800 (PST)
From:   Rushab Shah <rushabshah32@gmail.com>
Cc:     rushabshah32@gmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <trivial@kernel.org>, ntfs3@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Doc/fs/ntfs3: Fix a trivial typo
Date:   Tue, 16 Nov 2021 11:31:38 -0800
Message-Id: <20211116193138.335050-1-rushabshah32@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the typo effectice -> effective

Signed-off-by: Rushab Shah <rushabshah32@gmail.com>
---
 Documentation/filesystems/ntfs3.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
index d67ccd22c63b..05e9c49b7400 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -104,7 +104,7 @@ this table marked with no it means default is without **no**.
 Todo list
 =========
 - Full journaling support over JBD. Currently journal replaying is supported
-  which is not necessarily as effectice as JBD would be.
+  which is not necessarily as effective as JBD would be.
 
 References
 ==========
-- 
2.34.0

