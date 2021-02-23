Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF332258F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhBWFws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhBWFwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:52:31 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53473C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 21:51:49 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id a2so5568242qtw.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 21:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnfatnFhprykbFACP1sY2rHFU+RBjXxSen3CnnKRJiI=;
        b=iKyoVoG/NdZLFD//p9fdiACY7FaNSXwwS96epc14E+KFYjDTTvGNh+UaDaJ3qWrPTK
         2UcwSkXgM7x7nMM/UzWGXZ/v9owWVHEjBxfgYUIEOnnuhzNWd9kHWKwU6uR+rWlCSoox
         n4ZIVC9mt2Wf9JOZN56jLZBIuHz7m+NikcFJ+LMyuSpa3mh9yQumTZ5+FXrEUNmje0yr
         3dbe/+RYlNv9A/Lb4GhhvntG5KHKNNNHFezkTIcm8lV7qLFAO8W063Y5W7TIBzg5RYmc
         Y8lKgpoi8UlGciE06HFvuTmRlqnM+Ni9vOF4YaDDgV+3M4JO4ipk+5EIrX6GYJMZcVgt
         nm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnfatnFhprykbFACP1sY2rHFU+RBjXxSen3CnnKRJiI=;
        b=PpgkR8YgHC/j9HiLz4VVRH9q+7jZDVYVNTZGTiCe9ydamIvy2uHj1Up7pU7QMphJuJ
         z27fdXPbVkrnmRV2op532ms2LS6aV6ed/xOoyTpBPBYKAT9K53zc46XKqjdc0fsfRx3A
         98sjaZGwWAgDdLN0BRQNwlEmenP7VzexCAm9TyQke5VEaIgRm00Yt5WeT0gFCEuTsc6g
         PABavT7gKSk6a6jQPxkmcAwDDAdLZyhLa5OziYt+z/m3Nu1SeucatOnVp3nmZMfNAh+x
         uGaUuVEur+qaYSvkPBH9ylmm9GgtFk8NrPV50u++p8IxaJyvxchjVLtHlSayf7yjsx56
         irrQ==
X-Gm-Message-State: AOAM5323mz8EC91UPssLzhfUzfDQBqFHOU4PZWYsmS46ORdVVfviMhJJ
        35KVt0H3LS8uxUe1xLvhM2w=
X-Google-Smtp-Source: ABdhPJwctQNEjgjnNy0gm5ehL3c5WewYIr2E+Zw/1PwU70yxbH4GpK0noUnEdrblrIu5SG0nRphZdg==
X-Received: by 2002:aed:30a3:: with SMTP id 32mr20689745qtf.130.1614059508521;
        Mon, 22 Feb 2021 21:51:48 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id o12sm14534218qko.117.2021.02.22.21.51.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 21:51:47 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/1] vsprintf: dump full information of page flags in pGp fix
Date:   Tue, 23 Feb 2021 13:51:24 +0800
Message-Id: <20210223055124.75882-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the flag should be printed using default_str_spec.
There's no difference in the output after this change because the string is
printed as-is with both default_dec_spec and default_flag_spec.

This patch is a followup of the patchset
"mm, vsprintf: dump full information of page flags in pGp" [1]

[1]. https://lore.kernel.org/linux-mm/20210215155141.47432-1-laoar.shao@gmail.com/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Joe Perches <joe@perches.com>
Cc: David Hildenbrand <david@redhat.com>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 533ac5404180..5d034e799c06 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1963,7 +1963,7 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
 			buf++;
 		}
 
-		buf = string(buf, end, p->name, *p->spec);
+		buf = string(buf, end, p->name, default_str_spec);
 		if (buf < end)
 			*buf = '=';
 		buf++;
-- 
2.17.1

