Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D229339DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 12:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCMLLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 06:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhCMLLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 06:11:17 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE95C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 03:11:17 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id l2so17533343pgb.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 03:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NcvGiHbYQxROrH9TdsfaW7MsRBE3rsynjXGocCNb5Kc=;
        b=ZKHCCL3jjt8Oh9RVyaO592Hozw7tAuJwpw0L3jRz2xmNMJQ6dC5MyPJJNzTts6t/Ay
         PSLFmUf0+BIFk/wNs5cANujWFbSnp5GD2V1FjcUsOw32i/nGRgtH/ietEJZxZ0lJPRHg
         cqTcakZLEl2DSCqS0JeKlhhRmvKcwycOfXBIU0BNMbdLhHbLhssgJ8QFhbL3BNsjY5AO
         DDXb8xTJfS4iU5m/ct4XbCOvJ5eiOfBN8Cx7NyqSz86EPZVz3JezavncRpPdQHe8X3G1
         yQlHi3Mfzz4D2QwsGfaPjiumkl8fE/WmM6Vjr1ScRMjNkxPsHh3IQXRnLCi94kl/ilUI
         5kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NcvGiHbYQxROrH9TdsfaW7MsRBE3rsynjXGocCNb5Kc=;
        b=AubOdNKnDrZE9uJ13ChQe+HHW+ZwpNVDLsP9GUKXk1cRQ2+ADvFK1BZAzS1frmoUMH
         ESKsPEVvNHWyXLu740e/rrxpVWQDHVLTDJdGaUmFT3MvNlCb0MnYq4l1haas4N15RyZy
         r4uUmqbdMy4AHfJb9eTsHM+iJgcaKgugoJNj1i/7ltkB4Hf62M+T3S8/rtNemCQXOG7E
         1vXz6hW31BToFZ4usB6cbcpzauitO/t41PA59uXWcsBT84jikfVbDnlEBpjmaQSjVVOK
         WisesLA/TVwe9o/uhjHO9IdiuZvbg/b0B6Y/c325uKXv/ZbTPaLmCjZlpWfuE7LLmwPy
         E+sg==
X-Gm-Message-State: AOAM530T351Jfht3YlcNoPviiGMrsgb9pK/zYUkULSw2VXpkl3EJ3Oo5
        458OCpM+ru9q8VPeQkSEjJ8=
X-Google-Smtp-Source: ABdhPJyOfUr3n0ClOOVIRfkgpLsTLKR1WrqMJVF5sb/o57FmCwEgnpohDoiMrE+o3ymtwgjbtzM/pw==
X-Received: by 2002:a65:458f:: with SMTP id o15mr15299914pgq.111.1615633876967;
        Sat, 13 Mar 2021 03:11:16 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id y8sm7893193pfp.140.2021.03.13.03.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 03:11:16 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     ebiederm@xmission.com
Cc:     gustavoars@kernel.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, zhang.yunkai@zte.com.cn, pcc@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] signal: remove duplicate include in signal.h
Date:   Sat, 13 Mar 2021 03:11:08 -0800
Message-Id: <20210313111108.366380-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/string.h' included in 'signal.h' is duplicated.
It is also included in the 7th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 include/linux/signal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 205526c4003a..c371d3a3ff61 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -124,7 +124,6 @@ static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
 #define sigmask(sig)	(1UL << ((sig) - 1))
 
 #ifndef __HAVE_ARCH_SIG_SETOPS
-#include <linux/string.h>
 
 #define _SIG_SET_BINOP(name, op)					\
 static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
-- 
2.25.1

