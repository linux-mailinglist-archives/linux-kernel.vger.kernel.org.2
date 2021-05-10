Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7AC37951D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhEJRMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhEJRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:12:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C8DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:11:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x188so14059970pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hf4r1j8yMexkkTUcsa8JtJwmrwsFaPIJaZ3zXQGXtdw=;
        b=YvVz9OPDTWoisUSAk5P4ZlRRxMr1Ix8x+NOYoAAcufHvh5xPgERKzaVjeZ1VPW5GQZ
         6zMIKUBpl5H9m+yh+sku8OwUxDRRmjTY/MLi6EeyPCTVjAXYvM6TN/aHIaWF1Vzl26DS
         0za+Q5TWh0Y/s27wZHEbgJ42Ym07kka+hd4yrksb3KKbgWz3rl6OrMhv/Y9HM2zPy05d
         g83xssqre8PR+zPLL6yEmBcc80/muP8rp8LYzbMWQGp/6qo4KbwyLYX3UX3LXFb4W8zQ
         mJ+F7xhhuaSpWd+ily+UfKYiC229+vEH2nv8buS5d5L/ITIR7W6QaqxErWbGT355oC2C
         6tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hf4r1j8yMexkkTUcsa8JtJwmrwsFaPIJaZ3zXQGXtdw=;
        b=sbETsvrKCi8MIzDgg3AimBPYHJCRVap3eLrjk6kYwfNBXQCuM9ZDFvv719PiJOdaPY
         OodbCyD0L9TjgSQRI759t6y4VnEam/DpLRaXPUzYdjwLK3hMO1Anc2q0WY+ZM94SwPX2
         eIKad/2QvElcd6e+FHvyxYfXhpkSTUigvQrNd4wFCC5wIXvHm4ZCPeij9f6jp739EgTJ
         +P2E5SD/crK+rCafCVEKE0N085oGkyHwofAFAE7p5uaNEGvfSTJm3oXUg4kWbYqpcD75
         NyLakQWn7JzTRUIHrv9aU7Ipb+Xba68YmmhaOnC4qApw0G0+KgxYntX6/qTZcGmfC+pS
         4F0w==
X-Gm-Message-State: AOAM532FPxS2clqrkyUw/DA6LQWGjTNtEl8Bdivb5ZjvWxK8ZYqj2Swb
        z/RSDHq1x9jNlawbZQqDgNo=
X-Google-Smtp-Source: ABdhPJwbh6jW9+R2pT+xz1HkEGH6L2/saA7N+Sa6OXaiwgdv7cO2Kks2PNbW6T0iy7R9iek973cSjg==
X-Received: by 2002:a63:b102:: with SMTP id r2mr4918311pgf.254.1620666697166;
        Mon, 10 May 2021 10:11:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6a0a:cbd2:2beb:6a1f:472c])
        by smtp.gmail.com with ESMTPSA id a7sm68072pjm.0.2021.05.10.10.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:11:36 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] checkpatch: auto detect codespell dictionary path
Date:   Mon, 10 May 2021 22:41:27 +0530
Message-Id: <20210510171127.15056-1-dwaipayanray1@gmail.com>
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
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..cc69d2c758a3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -889,6 +889,13 @@ if (open(my $spelling, '<', $spelling_file)) {
 }
 
 if ($codespell) {
+	if (! -e "$codespellfile" && which("python3") ne "") {
+		my $output = `python3 -c "import codespell_lib; print(codespell_lib.__file__, end='');" 2>/dev/null`;
+		my $dictionary_path = dirname($output) . "/data/dictionary.txt";
+		if (-e "$dictionary_path") {
+			$codespellfile = $dictionary_path;
+		}
+	}
 	if (open(my $spelling, '<', $codespellfile)) {
 		while (<$spelling>) {
 			my $line = $_;
-- 
2.28.0

