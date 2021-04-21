Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98C936732F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbhDUTIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbhDUTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:08:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B944BC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:07:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h10so50569444edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfuyWzaRCHi4p0AIL1yf6uYPLz6so+Mgoph5gf0xKEE=;
        b=GQLyPeSgUnxmCprFj4i5Sx5FH2Bbf+ND/0vOqqOUHFhkZ4gCvWQxE2WMT1Vffbh5Tx
         zsYsxEk1j/mXKNlvc8U1peFxcWlA017nrakG7fkpTYcX1IUwBYG0cQzyPITNqRSxKHAu
         JMTlowccj/u4w6yvu/m6mDLZTi+AwUKKih/5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfuyWzaRCHi4p0AIL1yf6uYPLz6so+Mgoph5gf0xKEE=;
        b=lvtecHMmCoLTEyhBu5EwSvPxcnfG/WEBhWGiIJz4K9/Zbn6HYdmlXbRKvsJNn20Oer
         7y0aAOsmps8mwbMHDYBzh8iqisawtO4Qidu1no6NrLuw1yNxsINM6ZeDfcDdCTye3/gW
         JeXRpnmIybH3RkiFevRlm/0d56ce+tPnEH+tcb2UAaPkh6rdEDVdz+dHxIWYKBIy0Uk0
         YaLpj+l0kGVxD4SdSBLQ0/h26kT1NtmKXe+kls+QWdMoezVUmVn21nzdBjwuHTukcjuo
         E3OczeVOw5tivPsslxQz6DbxpsAyIE7ew8SL0FDkAabT6ecAJD4PUPFG0+w+UGw02Xac
         fDOg==
X-Gm-Message-State: AOAM530awlSPESkaz5/FAAIT6FClSOFpZRz1qeE/4uPzLqWGdMfL9Idr
        oLpSQWLneWcNvIxg+4YFY0LX3HCUpSxuGV2p2EI=
X-Google-Smtp-Source: ABdhPJwZuKHB1GLs7hfQZCw+Zja/AgwnA3tCfOM3vVmdk62srIHyqWCuFcXvt8ILWyO9So28UlV3jQ==
X-Received: by 2002:aa7:d693:: with SMTP id d19mr24515304edr.8.1619032059428;
        Wed, 21 Apr 2021 12:07:39 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id e5sm251908ejq.85.2021.04.21.12.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:07:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] bpf: remove pointless code from bpf_do_trace_printk()
Date:   Wed, 21 Apr 2021 21:07:36 +0200
Message-Id: <20210421190736.1538217-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment is wrong. snprintf(buf, 16, "") and snprintf(buf, 16,
"%s", "") etc. will certainly put '\0' in buf[0]. The only case where
snprintf() does not guarantee a nul-terminated string is when it is
given a buffer size of 0 (which of course prevents it from writing
anything at all to the buffer).

Remove it before it gets cargo-culted elsewhere.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/trace/bpf_trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b0c45d923f0f..4ee55df84cd3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -412,9 +412,6 @@ static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
 	va_start(ap, fmt);
 	ret = vsnprintf(buf, sizeof(buf), fmt, ap);
 	va_end(ap);
-	/* vsnprintf() will not append null for zero-length strings */
-	if (ret == 0)
-		buf[0] = '\0';
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-- 
2.29.2

