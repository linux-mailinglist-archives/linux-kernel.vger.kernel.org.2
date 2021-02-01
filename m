Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E8C30AA6D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBAPFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBAPDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:03:12 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC09AC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:03:10 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id v126so16434008qkd.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cwaD/KS9cDpaZAIVrcMBsnLRQJ75Ycyv9luEJSiPg88=;
        b=V9qM/Na4/H6vxU6R++Um3+t7PpzqkK1c2UlQV6OfYLsutcq/zUhowRcjN8JvNC2V58
         x1oAnHYwtpwXadZo6O6RnpFa/oUX4TAvB6jPlVJ+187m5pWJQ3EDQ8tOLzPMdInmO1XH
         uaPBePZPhAdO9hRBCbqtfI7QPKPX+gztW+I5QmLNMZ573ZpzbGYxLbjqX8eOOW4zTjIJ
         l0LtTC8IxTMpPbnXb/+FgaxyFtX0MCsZbwrKwi0gftXE/Aeg1VH6+G3UltQwbqZw1dZa
         Cbo2JPVDjz/6AIWbX7AUtxE2mc7SZrnXux1Ulq8mTbOooiSDI2xvRYU9dFZbaIdKaorg
         O7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwaD/KS9cDpaZAIVrcMBsnLRQJ75Ycyv9luEJSiPg88=;
        b=UcW3CLGderaF5uOLAOxmcFnWqm/GM2UO43BchYX9Rhnz8e9DAANU1UNCTw+K678Rzp
         Wz6i7XGrrU5wn33pLTBiz3OtCQziQrYmGo8TO0RTCvJiZetdGCIsUN4ex/xAzQOvjzhM
         PtytR8UugViVtCeBFCd2/Nc0P5eT6BK26kTIpUPgdUyfPWraw82bRSc+93sUCeqr4NvB
         JvV4/kVP6+Z3h0YyQ/+SZ/39V5wgJb1OR2h7LNZaCUbhgKHUEetSOgSSFSkSNwcLaK5r
         TN+0hu/jBGHUhHpViOYot6N4i6UB8XY5M8IHryT2tnMyeK1/brPpqTHOs0uNttOnj70v
         PQDQ==
X-Gm-Message-State: AOAM533gkfvzAiJjkKiRcHAN0v3FGeQgX2kTXe0KGQmaLnBMszm1zfkH
        RdQL90oNSotb08uvN8jmBWLKJw==
X-Google-Smtp-Source: ABdhPJz1xBjuAgzovFUei3M5R6nY9qHtlb6p7+ZK8swHO7gAiVhstZokQF9z3mi2exDsZuZNhkDcMA==
X-Received: by 2002:a37:4691:: with SMTP id t139mr15832136qka.274.1612191790207;
        Mon, 01 Feb 2021 07:03:10 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id b16sm6970160qkh.21.2021.02.01.07.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:03:09 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, mark.rutland@arm.com, steve.capper@arm.com,
        rfontana@redhat.com, selindag@gmail.com,
        tyhicks@linux.microsoft.com
Subject: [PATCH 1/1] arm64: hibernate: add __force attribute to gfp_t casting
Date:   Mon,  1 Feb 2021 10:03:06 -0500
Message-Id: <20210201150306.54099-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201150306.54099-1-pasha.tatashin@soleen.com>
References: <20210201150306.54099-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new warnings are reported by sparse:

"sparse warnings: (new ones prefixed by >>)"
>> arch/arm64/kernel/hibernate.c:181:39: sparse: sparse: cast to
   restricted gfp_t
>> arch/arm64/kernel/hibernate.c:202:44: sparse: sparse: cast from
   restricted gfp_t

gfp_t has __bitwise type attribute and requires __force added to casting
in order to avoid these warnings.

Fixes: 50f53fb72181 ("arm64: trans_pgd: make trans_pgd_map_page generic")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 9df32ba0d574..b1cef371df2b 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -178,7 +178,7 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
 
 static void *hibernate_page_alloc(void *arg)
 {
-	return (void *)get_safe_page((gfp_t)(unsigned long)arg);
+	return (void *)get_safe_page((__force gfp_t)(unsigned long)arg);
 }
 
 /*
@@ -198,7 +198,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 {
 	struct trans_pgd_info trans_info = {
 		.trans_alloc_page	= hibernate_page_alloc,
-		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+		.trans_alloc_arg	= (__force void *)GFP_ATOMIC,
 	};
 
 	void *page = (void *)get_safe_page(GFP_ATOMIC);
-- 
2.25.1

