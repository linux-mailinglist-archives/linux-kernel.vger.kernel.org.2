Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1F444DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 04:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKDDZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 23:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhKDDZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:25:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688DBC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 20:22:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r5so5019621pls.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=v7JV6sBSjHncLlA/Je17qJW+JL2/u9zGNWzcM/tGeGQ=;
        b=iowS55dMHmgYSfkBWWCQtgegTudprjt8wmXVxeOwd6dvZWjcrLB08Sz1ygrnJkPZwW
         agjvCWv+w80j/VhP34Rauc+Bdibfzs82V6xboxx0Y259KePWFMUpfksnnjzGmY5Lx5uW
         gZiFP67XV2Xnfu+KT3CG/6A0Xu8oJ8/N0NnphbXJQ9YGFwwm3PU3T8d1jWFRNs6VvmAO
         +v+6bkMrtQ4kZqwGn7gaN5EDKrCrSM8ovFkwn7ATfxzHYfapPSg6Fd8Z9PdAnf+T/LD8
         meKMVRsDO5pbeu+bpnRXwhwKcBZNLQiX8X7OwqpPdJSN1AB9XV3fm4iDTav2ZZPeaNI1
         fcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=v7JV6sBSjHncLlA/Je17qJW+JL2/u9zGNWzcM/tGeGQ=;
        b=YB82s9whIm8/dyQW49mK2VbMrOSM3z3eOcqhGp/jaEoBHaoWH72BYxX9Eox1sJwz4V
         1ET3TapOTf8UrLLqN8FixKN66/n7Y5OEsG0MA39Axo//4fq5tcHKg44Yv144V2UhVzbM
         WdbUOKqYcSza1OwSUq8bnpJ9FCliAoAA73kULj1tJ9QLawN3bpywA7WDcy1ZEEl8RjwO
         N3e7dvyC1pmsi0YeV5OyibndSV+dqeA8z6rI3xv6qnBEYcx6nqc2Wite2zt+j/alEdkr
         OW0lXpNefseB6TntKvxqx2+NfdHYWuP6gVfbFSMLSMu/vSs5BznatURIIOIqlYeQmgSY
         pu2g==
X-Gm-Message-State: AOAM532rBPJri7U9QNw9wMOZUuvS8LlEoVZmyWbG0ecvQ5ivXIjSZzSU
        6ukhyaeoq49v2DL2n+Kl4Zl7Y8L2VyY=
X-Google-Smtp-Source: ABdhPJwOBXGeQSZgvDoMBXxO7KZwleKLJHiTvoteHDDwCxHDV5j1CPOewAnolh6Fqmj9QbQ7faCwZw==
X-Received: by 2002:a17:90a:9418:: with SMTP id r24mr18953177pjo.238.1635996171894;
        Wed, 03 Nov 2021 20:22:51 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.84.218])
        by smtp.gmail.com with ESMTPSA id z3sm3789967pfh.79.2021.11.03.20.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 20:22:51 -0700 (PDT)
Date:   Thu, 4 Nov 2021 08:52:42 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove the unused variable pAdapter
Message-ID: <YYNSAqGgDPhV1IE1@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused variable pAdapter from Efuse_Write1ByteToFakeContent
This variable is not used in the function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 03c8431b2ed3..39c77f6b06ef 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -40,10 +40,7 @@ static bool Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
 }

 static bool
-Efuse_Write1ByteToFakeContent(
-			struct adapter *pAdapter,
-			u16 Offset,
-			u8 Value)
+Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
 {
 	if (Offset >= EFUSE_MAX_HW_SIZE)
 		return false;
@@ -162,7 +159,7 @@ u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data, bool pseudo)
 	u8 result;

 	if (pseudo) {
-		result = Efuse_Write1ByteToFakeContent(pAdapter, addr, data);
+		result = Efuse_Write1ByteToFakeContent(addr, data);
 		return result;
 	}

--
2.33.0

