Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057523B728D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhF2Mz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhF2MzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:55:11 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D8C061787
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 05:52:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1624971161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eIkEast40xy5RwPxoGV+rwDbDTG/tZGo7a7nH58KTpQ=;
        b=gahOXFbMlnpzl93rXfbwxxjiX9Ok6fUXi4tlzoVB74a/EUQti6b0iV9rn9HV6bQJBCk7AR
        0ag0wgW3D6Sonu/PQLjJNXQcx5bmp6SRxx7HatuUwsWgtnNkh35cGuWWakuUMJqKomTnj9
        VFGKNOgl9gZHVH3Vi4zw6VPvXdyiUNc=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] x86/fpu/xstate: Remove the unlinkly in cpu_has_xfeatures()
Date:   Tue, 29 Jun 2021 20:52:29 +0800
Message-Id: <20210629125229.14666-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '&feature_name' isn't NULL in print_xstate_feature(), and also the
same as in cast5_init(). so remove the unlinkly in cpu_has_xfeatures().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8def1b7f8fb..2a6f9685f605 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -87,7 +87,7 @@ int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 {
 	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_all;
 
-	if (unlikely(feature_name)) {
+	if (feature_name) {
 		long xfeature_idx, max_idx;
 		u64 xfeatures_print;
 		/*
-- 
2.32.0

