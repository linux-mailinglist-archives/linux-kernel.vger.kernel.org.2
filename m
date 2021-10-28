Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8643DFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 13:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhJ1LRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 07:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1LRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 07:17:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA3C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 04:14:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 83so6035127pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/BRyL9okvIG+J1Qzvl2UtiXVgsD9PcR1PiRaC7aHW94=;
        b=KTnDCGLwkevYW+J+IByeZ+jo4Tmup46/JsSDiDeiNGE0FAK8I+KmFJY5Ge0HAvantQ
         WLb1PHsN+Mp3ZM0ISowHYXKUfT3A9p89VCY0QAciE7rcLqfMIQr9IDtmdUb+BR2RWuah
         jDercNAcyb3mKnx6STzepKZHH7bjXHs6hVhU7JGdc0lGmCH1x1N9aHR+FcGO30vCGnvg
         lmHUhkW5AOHFzA2DJxN503of/IHUVbltJES7i4bsfpVHiMn1yGXEt3jClZ7TCpjU5VEm
         BL+Ecbp68iQ5r2UbvYXVmpNc3Yf18hn+Dt9ERJk79eXdwBe8q+3jisRPGNVfm6reR2TJ
         EN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/BRyL9okvIG+J1Qzvl2UtiXVgsD9PcR1PiRaC7aHW94=;
        b=1SQ93lB+mDKibNN2vq8mDe3FkAQSCXX3lUNPpIIS+oHQS1aJImyCXeL6nNqZ5OWRUa
         Qr7agD0xC7iRa2Umq03HNW+ulejCRLRKtFRFruNJAr3jeFa9benfUFTglUHrH6HvlG0Z
         LThWnIRCqw/jW1U7UGxUmVKhCcOQnbjirtlU94W57yL3AOYGGrYGQcQt98st2+ST/iBT
         E77CPLIdjLJF8SW8bbC36QiUulZrxOk39TDN/RHUL/GE4xHVWFKSqznVEUUysAxWuwT+
         rZJviEmtJa0ZjdCoMFVkaNKlUquByV3bE6O5DD9vS8VbgK+t3bElV7ZtwBcAmx17L4DL
         VBtQ==
X-Gm-Message-State: AOAM533ro+LHcUO8hzpQ73n5D/zFX7Qhu+qDAEenWxeN6ULRD2x349Tc
        bW6CAEK7zrGQW1lzlUCUOF3VqrsOiFk=
X-Google-Smtp-Source: ABdhPJzGEDug+VBXOAUz15Vn5Ai2Dt0yW0bMpLBfjgNhM3nHaw+e/JoaO2B+uFe+faOoDilp5hFgcw==
X-Received: by 2002:a63:2a88:: with SMTP id q130mr2676980pgq.169.1635419689868;
        Thu, 28 Oct 2021 04:14:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h6sm2490590pfi.174.2021.10.28.04.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:14:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     urezki@gmail.com, deng.changcheng@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] lib/test_vmalloc.c: use swap() to make code cleaner
Date:   Thu, 28 Oct 2021 11:14:43 +0000
Message-Id: <20211028111443.15744-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use swap() in order to make code cleaner. Issue found by coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 lib/test_vmalloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index e14993bc84d2..cf41fd6df42a 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -393,7 +393,7 @@ static struct test_driver {
 static void shuffle_array(int *arr, int n)
 {
 	unsigned int rnd;
-	int i, j, x;
+	int i, j;
 
 	for (i = n - 1; i > 0; i--)  {
 		get_random_bytes(&rnd, sizeof(rnd));
@@ -402,9 +402,7 @@ static void shuffle_array(int *arr, int n)
 		j = rnd % i;
 
 		/* Swap indexes. */
-		x = arr[i];
-		arr[i] = arr[j];
-		arr[j] = x;
+		swap(arr[i], arr[j]);
 	}
 }
 
-- 
2.25.1

