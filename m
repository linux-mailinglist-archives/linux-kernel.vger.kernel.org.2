Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2537A86C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhEKOGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhEKOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:06:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8060BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:05:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so1418798pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F6C96BnUjzIKHMXU8FhTF6bd4nvV1EC4XjYBGgerihA=;
        b=npVKAVHlOmPd8BVHhVi/K7iS8P34pC0gwciP67rKlRPI4/SVxRQUwOqJk+5BOBn4M5
         JgGoOB6X+lWjgvMHLjz1klefyi0vKhVPU96ehGHb/ziJzUVuCXMCOseKuhiWUWk528Xl
         V1Va/cJRxRTLS1kMdDU4T5eWDzv2irdnuZRZo4ctcNVTRZpLfJE5KW9dqwCyvIZEgcQl
         JcSiXRSMlok5x5IlUvq8Lk7K8DF0MF5oLXUuCif1H/Gl/9PN4TvHn3jKIwKgltimyqL9
         pNmuYedoEjkCwuIMoAJwvc0VdKai/tdhLuhuOmOCHfV1+S2AmAr5SOQVUfx1seSaM3VV
         LBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F6C96BnUjzIKHMXU8FhTF6bd4nvV1EC4XjYBGgerihA=;
        b=gysHbZk3KSahUxXg1fnoyhQEt+9PG2CV2zfCFTa63c8cvTjq4KuUODBZNp0XZ0QlXG
         /XRk7J5+r+LpwzWzPPEUN7KXCP1697K0SUaB/y6VGExuzizqwlZBpXNw0ucG5/Agraiz
         9IFSQrYWnrF6O5s9RTzT/YEE/Qvr6t4kzvNd3AZncWI/zCZ1wpnfGS1DWOW9Pk+Kyz/z
         HxA/4UmR3Y24EAShoQKyVN6dbAtbSOW0RY3g6t5wy0vVFyMT+4M/m0m5KCn66Kt6bHxb
         GoxARiVMo9Dq3HiGkKRdDl8IIuOGruFVZc+KNCdeG4jTEZewojNSOjcpKjbaM3Ld2zNb
         XUOw==
X-Gm-Message-State: AOAM531fv7ahupmUYKVUxA8Woka/YuyLqXDIWr4zbcpN2gyJypaRra2u
        SOR21gUjV/t4r9LTVeCu8+LSD7dNmOhVw9rG
X-Google-Smtp-Source: ABdhPJycMKvNLE9fQM62HgNzki4LcfjOwjfwOyN4lSdnu3uEUCefHL6LDOKH7CZWXCKIKks5KvUTng==
X-Received: by 2002:a17:902:9345:b029:e7:4853:ff5f with SMTP id g5-20020a1709029345b02900e74853ff5fmr30010897plp.74.1620741934815;
        Tue, 11 May 2021 07:05:34 -0700 (PDT)
Received: from localhost.localdomain ([49.37.4.176])
        by smtp.gmail.com with ESMTPSA id g6sm13972872pfr.213.2021.05.11.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 07:05:34 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v2] checkpatch: auto detect codespell dictionary path
Date:   Tue, 11 May 2021 19:35:22 +0530
Message-Id: <20210511140522.3253-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codespell dictionary was moved from
`/usr/share/codespell/dictionary.txt` to data/dictionary.txt
under the codespell_lib installation directory.

Checkpatch still uses a default absolute path for it which will
no longer work on new codespell installations unless the path
is specified through --codespellfile.

Detect the codespell dictionary path dynamically during
runtime if the default path or the user provided dictionary
path does not exist.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---

Changes in v2:
- Check the external command return code to handle the case
  when codespell isn't installed.
- Use python to invoke the interpreter rather than python3

 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..4b1994bb443e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -889,6 +889,13 @@ if (open(my $spelling, '<', $spelling_file)) {
 }
 
 if ($codespell) {
+	if (! -e "$codespellfile" && which("python") ne "" &&
+	    `python -c "import sys; print(sys.version_info.major)"` >= "3") {
+		my $output = `python -c "import codespell_lib; print(codespell_lib.__file__);" 2>/dev/null`;
+		if ($? == 0) {
+			$codespellfile = dirname($output) . "/data/dictionary.txt";
+		}
+	}
 	if (open(my $spelling, '<', $codespellfile)) {
 		while (<$spelling>) {
 			my $line = $_;
-- 
2.28.0

