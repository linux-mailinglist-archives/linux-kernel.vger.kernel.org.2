Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF0432BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 04:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJSCxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 22:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhJSCxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 22:53:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0902EC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 19:51:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s136so14791082pgs.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 19:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ySOgTokagMhNG4M1FFqZU4QCBQ4dPrwD4fUtqFrF5T0=;
        b=gBZwTtfgwsaJA+2aRypSyO2nr8KxD/apiIG5G7yTa2mBkeI/rGsfyygd3d+UACslBO
         LRJ0k9inIBpufOGCy+ufqGMjqxLSmHl0qMxjWeqITDwj/vMi7ksZ7Vynz3OQuMfQAbj3
         XViT05/7IjMOpbVN7BGVhwYQ2K7BZJ0eUygjqW2gPCmIy1VV53gFhnKBYiFu0Vn/aJyr
         POp/eJhivaESFyxP0kVi7/VIbEuKk2DqPxltb6rs8BR88HmY74zX5KjcjASOI/hurgeE
         5O9FsvjXLDRT8ShDHiBDMBVY/SziEPDu7r7Rb178G7WA+ZVIg7zOmJRJ195nw1Qn5MRP
         knvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ySOgTokagMhNG4M1FFqZU4QCBQ4dPrwD4fUtqFrF5T0=;
        b=yEQHqVKRZwV8iaVmuLTOOBAS9nIOmwJvazgeU1vngWILN0HX7Q8a20UiX+OEUB+M5k
         Xukf1W7GDw19AvXpx5JV7qbFiZjSiQAMhofM1YDcPhvwqp84Yl7tE/lp9baWhwKF5cIx
         5563TxBYy1Qc05ZKjJOUxlqO2v9OiIsLGt0SxR8bIvot0SRvEzaTfcut3Hw1ZHS3hz/E
         ymRigajpduyULGaG4/I6dZ78eb1X/HXnOBH6EsH7O8xBsIzzaD0ONpYj/ttVh4p8iYr8
         JrkRWdMf3SGRz95V3GQAbMK1H7Coivizrpfo+qYjPQ1BFk88UXOy2SxfSZ+oB/7pyWyp
         LaRQ==
X-Gm-Message-State: AOAM533uY3+jauWahzJYQY1Q2jhtP5Ca7D20LyoCwOR1b1hfJROIWCv1
        WxKNgT78PjkbuGc0sgG037I=
X-Google-Smtp-Source: ABdhPJzKj4oMq10l1lOFiSwJWHpMWd38pgEcYhQTaOB7Y5JGezh/g8C/iAxfXRKhfKmxqqPEw1aBOQ==
X-Received: by 2002:a05:6a00:24c8:b0:44c:654b:403b with SMTP id d8-20020a056a0024c800b0044c654b403bmr31500877pfv.55.1634611868573;
        Mon, 18 Oct 2021 19:51:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id oo9sm767133pjb.53.2021.10.18.19.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 19:51:08 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     ebiederm@xmission.com
Cc:     elver@google.com, peterz@infradead.org, oleg@redhat.com,
        akpm@linux-foundation.org, tglx@linutronix.de,
        gustavoars@kernel.org, pcc@google.com, viro@zeniv.linux.org.uk,
        ye.guojin@zte.com.cn, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] signal: remove duplicate include in signal.h
Date:   Tue, 19 Oct 2021 02:49:34 +0000
Message-Id: <20211019024934.973008-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

'linux/string.h' included in 'signal.h' is duplicated.
it's also included at line 7.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 include/linux/signal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3f96a6374e4f..37f5080c070a 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -126,7 +126,6 @@ static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
 #define sigmask(sig)	(1UL << ((sig) - 1))
 
 #ifndef __HAVE_ARCH_SIG_SETOPS
-#include <linux/string.h>
 
 #define _SIG_SET_BINOP(name, op)					\
 static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
-- 
2.25.1

