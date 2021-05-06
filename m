Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32173754B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhEFNaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhEFNaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:30:05 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 06:29:07 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id f20-20020a0caa940000b02901c5058e5813so4071509qvb.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9BMU8p5qfGti/xTJnOzpUYWHpECrazIQEd72D2+OXX0=;
        b=jAonvSUMTqq9qzXhGStvl7B5zfMJ0ofgbVwgAyB6xn1JODIJFQwPXoFqgsKHdhELGx
         6pKmwoxN1GFV4LtYftGPXxXZiyQto2Y2jr0yzQX8xBrxlX62YIZ0s4D54gZ3lg9dPpA5
         J9EamFcrfjKwEcvoInbmf3arS+xE7+o3VO5KcdyTyHf/gEq7srqGZsWfHYhOQVeGh5CG
         uTnhrBFS4O6QuTQGOyvWe5S9vdzzT2f58xOnI5xqDqvkbDUHeBVxuP70Y/KuBfT+Hqbk
         Yzl9ChNCR2nqGHFuvCDnNMaVJz+sEtJXP7D9NzZzdpcO6oRkDB01X1Go6J5oQm3wpDNW
         nccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9BMU8p5qfGti/xTJnOzpUYWHpECrazIQEd72D2+OXX0=;
        b=jIETHLxM+7dRHrEYTtbc+YBA2lTIj1aUHsWCIULgCdtpGXMcUg7SlXjATyxbvXLeF6
         2degVW/9qZqre1CTsryDYAQkhOFRwsQgvKPd4Ui2HuTpHrZzRujvhkzr5NOopXC0rLP5
         apFQdPmcyO1+CQwc+UNbyxUtQ1ccYuRItqS04dYtnG5bTD2rVbzKSXLcK6rsvWGnqWhE
         Annb4CuElxAiFPBG8fCkodYUSI+H7+XAExF2XQVcijy7JrJdB+6HnI+rbJjSmR5DrUoH
         jr99cyYFMn82pJFzPcSKCgZFjx1X2PHS2ieyfatp8KDyknwAUAwaWMdPjravnzvtzx2S
         2EBA==
X-Gm-Message-State: AOAM53254N90/rxwQEhb4l1pXNaOsRqJUwGndziMqYR3tVXJZYsHBgHl
        cCHzejrZQ9Lf2Em0QtDvESRPxdW0xg==
X-Google-Smtp-Source: ABdhPJwXT3I9jkXlc0Vt+bqju8KbT6c3voLPjMon893IdHwKHqutEcmFsApalWLXW1MnDqkNRb+OFw9TgA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:56c7:a45c:aa57:32c4])
 (user=elver job=sendgmr) by 2002:a05:6214:2125:: with SMTP id
 r5mr4329047qvc.28.1620307746353; Thu, 06 May 2021 06:29:06 -0700 (PDT)
Date:   Thu,  6 May 2021 15:28:27 +0200
Message-Id: <20210506132827.3198497-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] checkpatch: warn about direct use of send_sig_info and force_sig_info
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting up siginfo and using send_sig_info() and force_sig_info()
directly is discouraged. Instead, new code wanting to generate signals
should use the appropriate helper specific to the signal.

Eric mentioned that he'd like to make these static at some point, but
until that can happen, let's try to avoid introducing new users of them.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Marco Elver <elver@google.com>
---
Eric,

While siginfo doesn't need changing often, when it does, it's quite the
adventure. We now have the various static asserts. The other thing is
usage of {send,force}_sig_info.

I think the best option right now is to teach checkpatch.pl about it
until they become static.

Fyi, I noticed one such new user here:
https://lkml.kernel.org/r/20210421024826.13529-1-wangjunqiang@iscas.ac.cn

Thanks,
-- Marco
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ccb412a74725..3a86aafc3bcd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7153,6 +7153,12 @@ sub process {
 			     "Where possible, use lockdep_assert_held instead of assertions based on spin_is_locked\n" . $herecurr);
 		}
 
+# check for direct use of send_sig_info(), force_sig_info()
+		if ($line =~ /\b((force|send)_sig_info)\(/) {
+			WARN("USE_SIGINFO_HELPER",
+			     "Where possible, avoid using '$1' directly and use a signal-specific helper setting required siginfo fields (see include/linux/sched/signal.h).\n" . $herecurr);
+		}
+
 # check for deprecated apis
 		if ($line =~ /\b($deprecated_apis_search)\b\s*\(/) {
 			my $deprecated_api = $1;
-- 
2.31.1.607.g51e8a6a459-goog

