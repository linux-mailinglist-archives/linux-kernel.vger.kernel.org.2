Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C269460060
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351687AbhK0RIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 12:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbhK0RGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 12:06:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F81C061574;
        Sat, 27 Nov 2021 09:03:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i5so26004703wrb.2;
        Sat, 27 Nov 2021 09:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lS1zair4sK18hzWn/R6s0K/jIJB9uRS8Tf1yrPl4qUE=;
        b=i6PYEDTEWBxh2uWbOmobmyDf4PFNUCGPjrhW4IBtFqgUj/wjnC942onOaGlorcKY3Q
         FF2QQnidWU7dTumffSTNPt7Cu3p0SpLPkTQgCic6IKpxWCti61SG1eJ4jOUrUGrXzhmt
         Pa424m0ujbzK7XmeCkkGp3PUoGsofw9xNatIUWVILZ/5XhlWJmNfZwaLBMgf6A6K30bo
         c7BhLrEFZKKRvW56w9sgGpmkx3Cipa8EQ/yJaXVmX7OFOr7gSJILZb2H1DSgirxwri/P
         fEUIGVLWQVHCuJD6lMu+Bh/IdWlifYk90Y8YFO5bHSEXpGTem0G6nGDiLNvai5ka6E6P
         5XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lS1zair4sK18hzWn/R6s0K/jIJB9uRS8Tf1yrPl4qUE=;
        b=B/pGMk3YOeV5NrFP1hiv9DdbGQ15NyWsuQe4rCn+75avA/Dk/f2Lzw6BEbRbpNbIeS
         Ihxpu5XyNmF3qjwiEp1H0yhwoYZqHgbmOxlSdfZVSBMKqzTeXMVUMznL1wsVGIX9Hl+X
         77Atx/i9NMP29PweRY9TFeX14PlrrZM6CR27Sb+r3xSjqeWtZTh5Vx0Lr9HPR8tC9ZVF
         bHqDShH/QFtfd+WpXOCw1spyUrPtfMm2BI1SdpPOa3Qoz2mEdwYcpJplmzaJH5pfSs89
         +0jUPZoejpSlqIObUVSLXuJFYrjJEf0L23PJc7JCRT4Y/O4RripCkN9sF3qQjheRTXlg
         fyiA==
X-Gm-Message-State: AOAM532iYutm5/cU255UhwRX0R4YwkAZTAv1nSscSUOLQqBGqagZw459
        Y7qiP6fGueXhRg==
X-Google-Smtp-Source: ABdhPJy+pishnTF0Jp3O1BLFoly/fFQfUlwkVKDWYJt8ktJqLJeucMMflxmOFNywu5S0QOwkVJHhZA==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr22456857wrr.522.1638032602333;
        Sat, 27 Nov 2021 09:03:22 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k187sm15177446wme.0.2021.11.27.09.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 09:03:22 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: make const pointer dots a static const array
Date:   Sat, 27 Nov 2021 17:03:20 +0000
Message-Id: <20211127170320.77963-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the const array dots on the stack but make it static
const and make the pointer an array to remove a dereference. Shrinks
object code a few bytes too.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/platform/uv/uv_nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 1e9ff28bc2e0..2c69a0c30632 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -725,7 +725,7 @@ static void uv_nmi_dump_cpu_ip(int cpu, struct pt_regs *regs)
  */
 static void uv_nmi_dump_state_cpu(int cpu, struct pt_regs *regs)
 {
-	const char *dots = " ................................. ";
+	static const char dots[] = " ................................. ";
 
 	if (cpu == 0)
 		uv_nmi_dump_cpu_ip_hdr();
-- 
2.33.1

