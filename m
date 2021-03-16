Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C594D33CC80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhCPEUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhCPETn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:19:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A85C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 21:19:43 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x10so34017448qkm.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 21:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aBuGun09RVTkJsfYELA1tZsWlV2EPtoFF9UhIELcp4=;
        b=WZWrBXZmH0At6IApmD6vUHAOAmRObRVHtt8P7BRvfDh7yRLYL0jtLFs4KXGsSPgCjc
         rSmjSpWobz1j4Wg1A7CfSx9Ibd0M5JmswiXdmiEJyyKqef08qWWR+vk/nmnchZhPSKQ4
         EcK7I0ESrnMpHztw7wHPlNleJIQjOrKkKFS6yeEzrLIlTPEeH/mP/93bb29cnZTSeXgq
         HW7BscxDTOGL7kr8XtDhTUsfIsdwQdNkSd67Fqx/SS7e57cAyPPWrSzPoZaR2LXoWOR1
         f0ndc7lz7bMI9R9IwzERqDuR/dRaSi9PrFR1q9rGlDOUrAw78H2MCnmJlvbavy01XqWD
         9BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aBuGun09RVTkJsfYELA1tZsWlV2EPtoFF9UhIELcp4=;
        b=V6isVhfASAOD6K8QQAfNCAmlzJadauxuXnVp9OOEFrdT20Iyhr1x7Nyaqmcw5aNWQQ
         58f6mP0B6EKpP8661BaJ53GT60PdluFvfHWhHicWb360Og3NtL0FJllvw2BVRn++rR1c
         FTouQs6wloiY7/zZIUMIed0rOJSJu6jBxJqsmsCj/OZnmT/ugFKzmzbOAuXB6lgBQRaV
         Tj//QgsZr0wmARvSaDiEczkvf2M45IlxI+b34OC26YMeVL1hWDpW5Kl/Iam1kF2EtmOr
         c93DaBmyD092JMdwzPSTh1oWxVhd7uhrvNH43szRkXARJf9dmM6oLzwJ5jRB5St3RlNP
         gxeA==
X-Gm-Message-State: AOAM5336Mm8M0yuhV+JUIvtep+6IUmUKWDe0gvjNZP3i6h1UsjX3W1f8
        dGzD5/Zbc2uFcVwsICC1G4E=
X-Google-Smtp-Source: ABdhPJyNaFRaaH9WGBiUIZETMkFAToJA8Vzp7gjsr1c4KUemi+0VMEbquN5UU2NDDG0KedliLN46Tg==
X-Received: by 2002:a37:6848:: with SMTP id d69mr28832506qkc.159.1615868382450;
        Mon, 15 Mar 2021 21:19:42 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.45])
        by smtp.gmail.com with ESMTPSA id d16sm13884528qka.43.2021.03.15.21.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 21:19:41 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] x86: events: intel: A letter change in a word to make it sound right,in the file bts.c
Date:   Tue, 16 Mar 2021 09:49:13 +0530
Message-Id: <20210316041913.2234069-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/kernal/kernel/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 731dd8d0dbb1..6320d2cfd9d3 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -594,7 +594,7 @@ static __init int bts_init(void)
 		 * we cannot use the user mapping since it will not be available
 		 * if we're not running the owning process.
 		 *
-		 * With PTI we can't use the kernal map either, because its not
+		 * With PTI we can't use the kernel map either, because its not
 		 * there when we run userspace.
 		 *
 		 * For now, disable this driver when using PTI.
--
2.30.2

