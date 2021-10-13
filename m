Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E142CE61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhJMWhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229883AbhJMWhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634164520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=op86Y+wgkjRXsbZ7sHu0Vs7Sb243xpv1+qfNrn0VovQ=;
        b=XSSbvCmXNXngH65hmtL9/OXpjlnusUTT9Vj4lJ63knCovP+eJLWAoiPmWLVToHHz3XwlPH
        YJoXowzMa19r4nR9dVxv2nfMM8W5WYgYr8p3PKACRiVLxVr4YXYyKYHEdT+Bxchs25ZsFh
        D5wv39Rl0rDNmXI3IALHj7e34lqas7E=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-0kNe73rQMKKoibePML4cCw-1; Wed, 13 Oct 2021 18:35:18 -0400
X-MC-Unique: 0kNe73rQMKKoibePML4cCw-1
Received: by mail-il1-f198.google.com with SMTP id c10-20020a92d3ca000000b002595f56ca9aso850813ilh.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=op86Y+wgkjRXsbZ7sHu0Vs7Sb243xpv1+qfNrn0VovQ=;
        b=zVssKB/61Y0pWEmkiWGrh+K/YGW+a4qyoZIzErG/nL/Jt0bi/J0p09jXrLuazweURp
         AsAfNeTShHwq7QJumBcuCzXYUsYERJRTXQcoeXUdUwPxDNylW4idKIltccgdOfKdFnVH
         O+bzpli9HGREP9QmJ0b8pTcAxOiB3jyueCsOIL0LCSrAm0nIeBaTOzUZHdr/PLQi9qRq
         gLmOqCKzokBNOfkmpYMcF0YOJoFWsXeJMhDoS0adBRFVo2qv4QZtaQ5dcG9TNn9PmSWZ
         D6oAJ+ZezSh5dIGs00BSVd4b+/RSqS9jjcPOFMcKsa07rdbxXtu0azjpnVim6LccPNRE
         Owpw==
X-Gm-Message-State: AOAM533NCS9fjfavusLefLUdJvsDW3dG/KcaEL9kgbKFMVdjWaInc3la
        fJ5bJGxVqJVEan546XE9VyOddFypswERUNWTYZMIql2lrrwEwU9T7zIXJGqFydMUP5wsoTiMpX1
        pj6b7KDw+/lJLMWt2tyUTFzHS
X-Received: by 2002:a05:6602:21ca:: with SMTP id c10mr1534298ioc.69.1634164517844;
        Wed, 13 Oct 2021 15:35:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn8ddjt3ldT1jWwnwE6r0UuDc0rHCx5G8gnf5LHgE0E9r8E2OpT0hL442TNdFLWzoSUkKLUg==
X-Received: by 2002:a05:6602:21ca:: with SMTP id c10mr1534287ioc.69.1634164517632;
        Wed, 13 Oct 2021 15:35:17 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id a12sm378866ion.0.2021.10.13.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:35:17 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, bp@suse.de, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] init: Make unknown command line param message clearer
Date:   Wed, 13 Oct 2021 17:35:02 -0500
Message-Id: <20211013223502.96756-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prior message is confusing users, which is the exact opposite of the
goal. If the message is being seen, one of the following situations is
happening:

 1. the param is misspelled
 2. the param is not valid due to the kernel configuration
 3. the param is intended for init but isn't after the '--'
    delineator on the command line

To make that more clear to the user, explicitly mention "kernel command
line" and also note that the params are still passed to user space to
avoid causing any alarm over params intended for init.

Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Here's v2 of this. I had to change the code a bit from what Steven
recommended to compile/look proper, but the intended format he had
suggested is still the same.

v1 -> v2:
 * Print a much more concise message

v1: https://lore.kernel.org/all/20211012213523.39801-1-ahalaney@redhat.com/

Thanks,
Andrew

 init/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index ee4d3e1b3eb9..a286995449e2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -925,7 +925,9 @@ static void __init print_unknown_bootoptions(void)
 	for (p = &envp_init[2]; *p; p++)
 		end += sprintf(end, " %s", *p);
 
-	pr_notice("Unknown command line parameters:%s\n", unknown_options);
+	/* Start at unknown_options[1] to skip the initial space */
+	pr_notice("Unknown kernel command line parameters \"%s\", will be passed to user space.\n",
+		&unknown_options[1]);
 	memblock_free(unknown_options, len);
 }
 
-- 
2.31.1

