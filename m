Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72370400A47
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhIDHh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 03:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhIDHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 03:37:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E616BC061575;
        Sat,  4 Sep 2021 00:36:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso965751pjh.5;
        Sat, 04 Sep 2021 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VOBwO0t8QC3/busodJEkbjeLNfNwavGj/xcb/50tPE=;
        b=HzpwPF9amWlZDtjG7PeY0Uo5IDxUhJhvHmXHnuvyOKr/pV3gFxigFoMVYMVcklgaAf
         PrZqMpccOavqLruEqdqP9G2j4L+pfAr3FNlM0gGAfE9gykii7yadnlLpfDQ/3c0rl6D7
         ENA6EWEnq4ZoPgk5VZ6xWPiZdKFjVGpNjNB5ACrHJgtLJH/XifW2cOOIfZTd8wMoWMLR
         VEdz2Mi0r/lDV5tZIC28MeEiy8uyvazq+Tfibz+36wDbPiXzZQqWwD9352YQNak0vh0v
         HuvvuqDjrGKRQj7Osoux+a7mMORFG0zIXmtZrC0QSjSCgzXi8Azd35cT7jVOd8OJtOVN
         OIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VOBwO0t8QC3/busodJEkbjeLNfNwavGj/xcb/50tPE=;
        b=GKlwh3f6icv8A7MoOQK0GRDKjOH1DqTbUHlNJTIVzcDfxbRf+BRID9+R+Fr9Ogs0L6
         rbVq2ivK4WH/37UrDuUbKBGWyugoIqbO3UfxOv2rcloKLl8DBOOTjAZXdRCS7sD5yBhL
         iCsIXEOPyZVngk9b03E94/wpmW+buuTwUNBaVl1Ev+HFtiAC64V7VkR2IA2FI8AvP52/
         NRTlKREmXl9xqLSj2N0bQkb+Df2YjqJGeAqnJaKffN7rWFYCl0KRhphkkMWQ68IS18jM
         eYyEO1RQbDrZD55F7c0EOONDWO8YNrsFjdHNaUUDYncq1clbxdKOGanxavGv3CkwYTps
         dhCg==
X-Gm-Message-State: AOAM532hqtaKEPfjeSRItYjpHW7GBJZlMZu1yMV5sUIJM4AR7QMsrquL
        UKMeBBZVVyL3t14kRhWAgvk=
X-Google-Smtp-Source: ABdhPJybKqrnXjJwi9WgCZmTF5ov1tESIOiScEfwfEfXuF7Aid3UvIImFjy0F41VK9E4vajsm6LXLA==
X-Received: by 2002:a17:902:c410:b0:138:b4be:289b with SMTP id k16-20020a170902c41000b00138b4be289bmr2374253plk.13.1630741013166;
        Sat, 04 Sep 2021 00:36:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:82a8:3271:93dc:763c])
        by smtp.googlemail.com with ESMTPSA id w2sm1320490pjq.5.2021.09.04.00.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 00:36:52 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] Documentation: checkpatch: Add SPLIT_STRING message
Date:   Sat,  4 Sep 2021 13:06:21 +0530
Message-Id: <20210904073621.12987-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new message type SPLIT_STRING under the 'Indentation and Line
Breaks' subsection. Checkpatch documentation for the splitting of
quoted strings that appear in userspace, across multiple lines.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index f0956e9ea2d8..b7a1288e96a9 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -710,6 +710,12 @@ Indentation and Line Breaks
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
 
+  **SPLIT_STRING**
+    Quoted strings that appear as messages in userspace and can be
+    grepped, should not be split across multiple lines.
+
+    See: https://lore.kernel.org/lkml/20120203052727.GA15035@leaf/
+
   **TRAILING_STATEMENTS**
     Trailing statements (for example after any conditional) should be
     on the next line.
-- 
2.25.1

