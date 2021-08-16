Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA853EDC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhHPRgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhHPRgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:36:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3FAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:35:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so1423343pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8SwTsPx4UYisguWy8Lsk5AZC9AKkSCySPlgNFqLhFrs=;
        b=XhzPXa2/DuXnsWeMM+nj/dHlsE2F9IpphR/qnZL74arj5QR7aFtwzBkgnbqmnEuQab
         wXc+J7WDhs8fhUNzEwTV/lFDkd/ewsnBLPRPpX1vK0tm/Rq33ZZBu1hjdkqwv0uxN34P
         KcAaiB4mCP9gmmLCZ3zYd/rGleXHxsWztBTChXNlz4MbCYUDUZE86JPKdBCLLZGMDQ4M
         qgeOfx+wubjoFoIF6MT0dnfgjwpZVDvbkB5QUscAYNaHg1WHv4gKg6xif40SqQwNgmTf
         fuxKjSIWvJ+595wqKDuPzxe0Wkls16jGd24iK0hres5cBH3/x48TAv47rsQ2/cDzzvjp
         Dz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8SwTsPx4UYisguWy8Lsk5AZC9AKkSCySPlgNFqLhFrs=;
        b=I858FJ6OGJknbcFwEvMki2zv6Wo8aF6/6MigRhRdxoivfykJKadlcjsooQZHw/pguW
         cJjW66VFRWAtxRwK9/iB89l5WAAFx83lwJAwEfYN0II7cVPV84lYY5RSSRvXmqFzO3dy
         NAz5WYD8EusFZpxNC9LniviIHDt+yLrrsf5Y/JA7HMLKn4O21kzASWzsBnv5NL3EpfLB
         1bkHNIzvrs0HiP20MWQG1p+b4VdEvnJ68JFiRo6npU33aB9bdFzRwkDZvo7ikt+gme7i
         h24Z13fs8PCyfotJtAOOcVIw8gqx5KAIHqWqW1rwS82OnDFLna/fxtSGo7J+PdL/AG0P
         bSNg==
X-Gm-Message-State: AOAM533ecvIG2nitdB1C2QLYOkcV+6V69T4V1MipTSL2j/tG8zXIn1vC
        IyJhRfAzT6XDsVjjaVZQR05od6vYj4dm3w==
X-Google-Smtp-Source: ABdhPJx/YiLxJeq0cMJZXttVox/qN9kvq0gqEd++DqW+xgu/P2njP+jG6ErKbdxx1Mr7cDXxVhJA2Q==
X-Received: by 2002:a63:f656:: with SMTP id u22mr6324635pgj.392.1629135339309;
        Mon, 16 Aug 2021 10:35:39 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id u10sm14030pgj.48.2021.08.16.10.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:35:38 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: fix cast to restricted __le32
Date:   Mon, 16 Aug 2021 23:05:07 +0530
Message-Id: <1be80f0196bed681bf55bfe3155f564b4ebf3b76.1629135143.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629135143.git.aakashhemadri123@gmail.com>
References: <cover.1629135143.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
warning: cast to restricted __le32

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 381deeea99d0..5320b1a46dfb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -122,7 +122,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		arc4_crypt(ctx, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
-		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+		*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);
 
 	}
 }
@@ -621,7 +621,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arc4_setkey(ctx, rc4key, 16);
 			arc4_crypt(ctx, payload, payload, length);
 
-			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+			*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);
 
 			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
 			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
-- 
2.32.0

