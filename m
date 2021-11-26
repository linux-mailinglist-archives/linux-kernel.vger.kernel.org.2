Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0774A45F6EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 23:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbhKZWmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 17:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244438AbhKZWkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 17:40:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5740FC061574;
        Fri, 26 Nov 2021 14:37:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i5so21548030wrb.2;
        Fri, 26 Nov 2021 14:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpcy4LQHbJZ4KnLGyBkFJNHlZX/wwL3cJLnUQsB4iT8=;
        b=nA8BR6tZL4dWGKsrb/dqLl1FcItkAlnllTZ74OZPDySGHlIshy/rTUnZVLnN11FCiP
         WvOMIWNiTWgmT2QFvN39fVR0FAjgwTohde8Q8NFvP+nI7n2kBFU1fkJQ7y8+FZUIxzVP
         0hcba5BL6Kj3JUhiuZzkvsIdR/RSCeFjorA5b/0PktodUxfuxhDX+CoXhrYrrdqauEEV
         qbST3pnPPsrrBGajf1ykZFognlwz1oRZJO7qRLzLyJP5yFjInS31IkXvW3TJbPq9kyYC
         frmdd1Eg4NxmKu6SprKy58PicnQS+fS0EP42CNb2FnvB/nB2c8agPknmjEZ1WO5EurKK
         hoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpcy4LQHbJZ4KnLGyBkFJNHlZX/wwL3cJLnUQsB4iT8=;
        b=ikZwAeUDNyw+RCZGDjb/kjbux3pFrfwMt6p9GOjOMWTFHMjmSMnPdqMWfC4Z8Kt+fc
         hKAhJzzXqEZY7/jgWVTg7ntmF57hOq8PGA+mIxM70X8MEsMCBkzK2otWLnCgS01mWJH+
         C88XpCp8WSt+75DhsquzEOTPscpkviIPduzoRpbSsHkcCt+qbigvypUpR53BqJs2L3pT
         Wi90NTk1vIV/nixz57fX4MjGvBgzGyWvrQ8jXHBGHhx21VUH6fliMpT2kWjoUCni5gPN
         DZPwe+M+My2bukpLfQVip42moldedckW8dCdzaeXnUxhuRyp/g1XFOQW2W5kK03Up+Ed
         wB0w==
X-Gm-Message-State: AOAM532HstvEVbQkTcYBbeOhhzwE4lFF3iPWsMmAF7gkp9zzagH1/cJK
        LIC1s3zSimxEIw==
X-Google-Smtp-Source: ABdhPJz/nM05YK/QiL3oEoUkStF521T3WBtz5E7K8S6rk4LywrRw45w/ITcFRqvcZRoTn9FAhX6zZA==
X-Received: by 2002:a05:6000:252:: with SMTP id m18mr17107910wrz.117.1637966219908;
        Fri, 26 Nov 2021 14:36:59 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n2sm12061923wmi.36.2021.11.26.14.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:36:59 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/sev: clean up initialization of variables info and v
Date:   Fri, 26 Nov 2021 22:36:58 +0000
Message-Id: <20211126223658.1150141-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently variable info is being assigned twice, the second assignment
is redundant. Clean up the code by making the assignments at declaration
time and remove the latter two assignments.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/kernel/sev-shared.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ce987688bbc0..6083d6f658c8 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -104,10 +104,7 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 
 	if (ret == 1) {
 		u64 info = ghcb->save.sw_exit_info_2;
-		unsigned long v;
-
-		info = ghcb->save.sw_exit_info_2;
-		v = info & SVM_EVTINJ_VEC_MASK;
+		unsigned long v = info & SVM_EVTINJ_VEC_MASK;
 
 		/* Check if exception information from hypervisor is sane. */
 		if ((info & SVM_EVTINJ_VALID) &&
-- 
2.33.1

