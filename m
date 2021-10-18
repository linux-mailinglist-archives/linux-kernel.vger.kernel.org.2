Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6806B432522
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhJRRh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhJRRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:37:26 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A3C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:35:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y67so17173386iof.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEucacCU68BDB2lIBlqPUDT0hO8lxTD/XcAJKwJDfIk=;
        b=gvv6ckipOFWZSbQpYDmiUNkj1GZOlN0w3KTuTNSYP2UrorvXK3vWM/IEZ7T81+biLI
         Fk4JtOA3DwU4tfocUsY8L6QNn/dU1Q7xx+8kSStQKUnC65bYKvKoPsXG71x7YZKvcsyV
         un/5bLw2GgReC4DZVDh9lZgmdgt5NFk/Zthlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEucacCU68BDB2lIBlqPUDT0hO8lxTD/XcAJKwJDfIk=;
        b=4UX57/i9SYW8+iCxYG/pV3nnegpmKSWrV/hWjv1GZFN2dCB5oJBhb/+WWocA3mXTOD
         fedU573yS20XClsCNa5fYqC3YOi0XtaoVU14THVukO7FiGAlr8s5pd16KyiD0PMUgAls
         ST/+5H5zPCDCNs4PKGzcqA6IgSBF0+erBTHYAhZ9ng2XOQYodcl9wsL676gLd4QCSQgd
         /3JO2dYZaQwcVbiapi2WGvRPPStP89Vn229TqzoIzMU3GfrjrWgkK/66pRPy2ueFwlx1
         kBSCSV0MwL2EEVxhMBTKiQvM7YIKoEa3oK7NA5aJPpNZmZO/OjbeU7lLolVT/X58NJh9
         vUFA==
X-Gm-Message-State: AOAM533xwdTe3ClMvV9Zs+OAhTA121AywpxO62yi8c350EgTRRBbqYOK
        Rjvy1CjDI6CDwOdjlsdzBCw9jvCVlkOAIQ==
X-Google-Smtp-Source: ABdhPJxJwNMspvVWyMUEIhEa+M3PacBLWDeH1Z6eDF91DzHoUCbdns/FGkXc5P+fKCm6k8vXbQxjjg==
X-Received: by 2002:a5d:9c97:: with SMTP id p23mr5520062iop.194.1634578514007;
        Mon, 18 Oct 2021 10:35:14 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x5sm6944425ioh.23.2021.10.18.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:35:13 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mcgrof@kernel.org, jeyu@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] module: fix validate_section_offset() overflow bug on 64-bit
Date:   Mon, 18 Oct 2021 11:35:11 -0600
Message-Id: <20211018173511.26542-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

validate_section_offset() uses unsigned long local variable to
add/store shdr->sh_offset and shdr->sh_size on all platforms.
unsigned long is too short when sh_offset is Elf64_Off which
would be the case on 64bit ELF headers.

This problem was found while adding an error message to print
sh_offset and sh_size. If sh_offset + sh_size exceed the size
of the local variable, the checks for overflow and offset/size
being too large will not find the problem and call the section
offset valid. This failure might cause problems later on.

Fix the overflow problem using the right size local variable when
CONFIG_64BIT is defined.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1:
- Updated commit log to describe the fix clearly. No code
  changes.

 kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index ad03a2357377..84a9141a5e15 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2942,7 +2942,11 @@ static int module_sig_check(struct load_info *info, int flags)
 
 static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 {
+#if defined(CONFIG_64BIT)
+	unsigned long long secend;
+#else
 	unsigned long secend;
+#endif
 
 	/*
 	 * Check for both overflow and offset/size being
-- 
2.30.2

