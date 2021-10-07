Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A621142528F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbhJGMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbhJGMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:09:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A8C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 05:07:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a11so3840953plm.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ScG3lgg2A+wioahvAFL/bv14fhjzDHIWorhUIASLWkE=;
        b=lHKHL5SBbEI7TFL6lDVTJkVY/BM7rYiDvcwWoburx4U0uaa0wFOUCekZoeCfyA/aIy
         IkebgAaCUmxkjgJFJ/Wyk0qyKgXYZkQAu5v1w8WQLkeMAgCubjobCR+qle3CrgvFHnlD
         /T689vWK8u6Xz60dR9svQdTnIiiYeRCLXCvxktCHyT8RHhLG/dXeE6xeu6C/f/2Q758h
         3JM/dhrVAkQTG2zu2x22BpA7M6qtJv1iAJcreysBYZ6qSa8rYPDIRAIx1b6hrsdLEdzC
         kioZUroF70ymumfTuGdqjxGNoJYUJoKRxaDlY+kgnUoDZLpq6p9jf6vD/i33savkeviX
         CaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ScG3lgg2A+wioahvAFL/bv14fhjzDHIWorhUIASLWkE=;
        b=rSwug8Iuur8I2NQwnCgUP1oh/0kSIUkEBTJcoNLE0vbynqjKOQQSJ5xdsL5+sjkwJE
         Eg7Df9aBpZ+n+eFyELJXeUqpXKvjU/lKmKNLddxVTmGBS2PWrML/QFO1/HmrtWuztkjb
         BuS2rmPTiP3BT2jO+NokN5o9Puzp4oaWEuiYZKIsWPOSpYBcCcNNFUd5GCm2CUr4KGDa
         gbsh4hMDJz/sBlfCta1PCoI8oogy95jEAWLFRG7xlurIfG83F0knaS1W/qoMKfELoH/b
         8vYUQq9uapbIJGVsWh8g5bkaX31atCIIr6BTnStqqEpIVJ/VDxlnXvhpDRr9+oiP76lL
         tAtQ==
X-Gm-Message-State: AOAM533p2y7fBxPAcNCMhukc93yY/A3iR/yj8v/M1DID54FCV3CshSTm
        8snIGOtohIyJTBtTNRswYMs=
X-Google-Smtp-Source: ABdhPJybak48DO+Jye/NWBqzObwcj9gL2FyCBQQMhBlIfz5dlbXn0/8VxSVAxZIzlUMOYV81TClPhQ==
X-Received: by 2002:a17:90a:5d8c:: with SMTP id t12mr2065610pji.98.1633608478725;
        Thu, 07 Oct 2021 05:07:58 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id c8sm23915582pfj.204.2021.10.07.05.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:07:58 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, keescook@chromium.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCH v2 1/4] cn_proc.h: use TASK_COMM_LEN instread of 16 in struct proc_event
Date:   Thu,  7 Oct 2021 12:07:49 +0000
Message-Id: <20211007120752.5195-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211007120752.5195-1-laoar.shao@gmail.com>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct comm_proc_event was introduced in commit
f786ecba4158 ("connector: add comm change event report to proc connector").
It seems that there is no strong reason we must define the comm as a
hardcode 16 bytes. So we can use TASK_COMM_LEN instead.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/uapi/linux/cn_proc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index db210625cee8..351d02786350 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -110,7 +110,7 @@ struct proc_event {
 		struct comm_proc_event {
 			__kernel_pid_t process_pid;
 			__kernel_pid_t process_tgid;
-			char           comm[16];
+			char           comm[TASK_COMM_LEN];
 		} comm;
 
 		struct coredump_proc_event {
-- 
2.18.2

