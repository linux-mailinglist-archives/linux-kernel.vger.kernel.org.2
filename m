Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385123185AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhBKHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKHaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:30:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42FBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 23:29:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z21so3285884pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 23:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IoDDbkA/vaVMnIhw4JfZZr78ZUSJQGF5SzLjqNA/02k=;
        b=AfYvwAFxBGw1L7iqcTOKb2C9mrdYp60863Zp9hiAKSst+SivGV97uPQnkZkXDPD/KB
         cOzdQzT4laOXT5vfDEx0OqIP7KxBD4a3pIQJdTtq9sXjCnWpX6R1U7r3NWcBM4lyqOEm
         TeKNWLn6ZUXodwlF/EL85swYXOF6h02a4Nym1oVshFWM9sZ4WPhkQ8Z5fp3vFOONaSXw
         bUaGwHWIRj+gITfaPwhgIf09ERFtclYoRDZmSL19yjfqm2BhhuTQK/KSaJY6RBTwPPqJ
         GusSVYjtiDgp/YEsmQX55SHDd65KMnwc/Ljqz0yv+VZGbxTh1aP4GauftSYVcPHdtw4Y
         H78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IoDDbkA/vaVMnIhw4JfZZr78ZUSJQGF5SzLjqNA/02k=;
        b=i6GkV79WqlckJAnGTYnZCTV268Js0yyDbG9+ufADFDVxRc/LeF+iXpn6gwTMxHNJj0
         7Q81yzfk9Youh4YgDC4TD60zUcJqEDa/awftVgWvJ53c8EdXWbK6ldVkcVD+fCvsC/9D
         grPqP7j7GR3+csn0tZzEpJLtR4wxM+e4O+WfHe2SE2RlzDy58aUfSLOcFoYKcS5i0qPK
         LmpKhFZU1aUnQlSywjpS0+5OTckbIKa/sDiB2VkQUssFqP/UFe5yMn3jC3VbFay5SwAB
         xyvPmLE9YjalVKK2z4PYIyu/cuPjIxoivQEsfqWgEuG+W6E0jgRfDT6uPGkbRGc2gDOa
         +rbA==
X-Gm-Message-State: AOAM533NA6cB58WYZGAQ7heOJB87x9Ep5/vt7RkF5Wb1gUyzieUZr/hY
        kGH24qe5qZ5+kupl+O1fq3U=
X-Google-Smtp-Source: ABdhPJweZgGWWflwwkOY5Zk3zlAcE2Qnmnuh80XdqSlaeYlRF5IALhiKLwUY/lzK9tTSrANZ/0hz3Q==
X-Received: by 2002:a65:620f:: with SMTP id d15mr6771122pgv.218.1613028561862;
        Wed, 10 Feb 2021 23:29:21 -0800 (PST)
Received: from localhost ([2601:1c0:6c02:1d30:195b:5ddb:5efc:9045])
        by smtp.gmail.com with ESMTPSA id cq2sm4059864pjb.55.2021.02.10.23.29.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 23:29:21 -0800 (PST)
From:   Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Adithya Chandrakasan <adithya.chandrakasan@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH] The Patch fixes the missing a blank line warning
Date:   Wed, 10 Feb 2021 23:29:18 -0800
Message-Id: <20210211072918.376837-1-adithya.chandrakasan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FILE: mm/util.c:930: WARNING: Missing a blank line after declarations

Signed-off-by: Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
---
 mm/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/util.c b/mm/util.c
index 8c9b7d1e7c49..60286876636d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -927,6 +927,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	unsigned int len;
 	struct mm_struct *mm = get_task_mm(task);
 	unsigned long arg_start, arg_end, env_start, env_end;
+
 	if (!mm)
 		goto out;
 	if (!mm->arg_end)
-- 
2.25.1

