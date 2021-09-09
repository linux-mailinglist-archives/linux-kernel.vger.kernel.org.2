Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3933405AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhIIQTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230284AbhIIQTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631204307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MRfmvePdX8oOz9Q0DkpWLyNgQ3mcavCdz3BsSy6225Y=;
        b=ChAq9KdTzXi3cR0Z9jSkwNjBKnUJkBGJhHb1gSFvuCHjoYp0zWdud9Mg2Tqa+oomeA2J9M
        2JOt1+e+YNnXvfgs+9h3fYfBsUhHgkK53y02HgBDosP11a7EPyTWKUaigNEUMtx+qboFDE
        D6pZGIn5kgRzW/W/LYrB3R4sJhuwIcw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-EIgUeoy6N9u7zEK5dxp71Q-1; Thu, 09 Sep 2021 12:18:26 -0400
X-MC-Unique: EIgUeoy6N9u7zEK5dxp71Q-1
Received: by mail-il1-f200.google.com with SMTP id o12-20020a92dacc000000b00224baf7b16fso2500085ilq.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRfmvePdX8oOz9Q0DkpWLyNgQ3mcavCdz3BsSy6225Y=;
        b=MZJyprvlFJ2zKxVjRPY8w/Qxwm74+HjRBUHiqykGjfLD1eWJfrdA5PMPv2C7SmK8Cu
         7/yj8NBRnykl5MQ6hCeX/skocAEpCMp6omi2YIUGaYYMRx1pSuL3fmI+5RlGjd5sS/Xv
         HacKfCk6DpqN5KvhkcZlYYif84yld0/M2rURJHqfZpB9fTmFtpL+M1W1fRC+PwBTbVO1
         YHHMyKZY3qiNFSw2hZvzb/o49JtopAa78ym57XQT9jPCw7TXuGX23+knvcZ7b5jMJJPg
         NNDzfwlPWu/XMqEIYPhHVlatGPccFKqAosRxrnA9+POrS7lpwM0CKscnhvpJlaiJEELp
         kV5Q==
X-Gm-Message-State: AOAM532hiIgAfHI0CCdvbL4Z4btyrJ89Ibm7e1IFD0PeeZiJdG/7ZGgr
        UuL654lSz/NMMFOYqqdScpv9U0V326sEfxN8zgezf07aX7vn/IP8T40lFRKNHx8S/jh3J56sOHZ
        2svphxTHYSS3sCXweuoQpOqie
X-Received: by 2002:a02:5184:: with SMTP id s126mr566120jaa.126.1631204305160;
        Thu, 09 Sep 2021 09:18:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTV5sPNo69aDUGVwR6HP9PiY2hvJRNRDm9IS1E+OzHIGLoDdng3A7p1Q5mQS2F7YBk3zRaRQ==
X-Received: by 2002:a02:5184:: with SMTP id s126mr566106jaa.126.1631204304916;
        Thu, 09 Sep 2021 09:18:24 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id k7sm1069698iok.22.2021.09.09.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 09:18:24 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     jbaron@akamai.com
Cc:     linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] dyndbg: make dyndbg a known cli param
Date:   Thu,  9 Sep 2021 11:17:55 -0500
Message-Id: <20210909161755.61743-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now dyndbg shows up as an unknown parameter if used on boot:

    Unknown command line parameters: dyndbg=module params +p ; module sys +p

That's because it is unknown, it doesn't sit in the __param
section, so the processing done to warn users supplying an unknown
parameter doesn't think it is legitimate.

Install a dummy handler to register it. This was chosen instead of the
approach the (deprecated) ddebug_query param takes, which is to
have a real handler that copies the string taking up a KiB memory.

Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

This is the last valid param I know of that was getting flagged on boot
if used correctly. Please let me know if the alternative approach of
actually copying the string is preferred and I'll spin that up instead.

Sort of an aside, but what's the policy for removing deprecated cli
params? ddebug_query has been deprecated for a very long time now, but I
am not sure if removing params like that is considered almost as bad as
breaking userspace considering some systems might update their kernels
but not the bootloader supplying the param.

 lib/dynamic_debug.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cb5abb42c16a..84c16309cc63 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -761,6 +761,18 @@ static __init int ddebug_setup_query(char *str)
 
 __setup("ddebug_query=", ddebug_setup_query);
 
+/*
+ * Install a noop handler to make dyndbg look like a normal kernel cli param.
+ * This avoids warnings about dyndbg being an unknown cli param when supplied
+ * by a user.
+ */
+static __init int dyndbg_setup(char *str)
+{
+	return 1;
+}
+
+__setup("dyndbg=", dyndbg_setup);
+
 /*
  * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers the
  * command text from userspace, parses and executes it.
-- 
2.31.1

