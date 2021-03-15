Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6AF33A94D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 02:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCOB1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 21:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhCOB0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 21:26:53 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 18:26:53 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f10so7897322ilq.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 18:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IqN1+l9+mYvAuC2nDjrRFzq7WU4KEQGo+hHkda3FvIo=;
        b=ACVXhZ1bP7NqeT+LDMspwNQhd3ZdhgZW7bNST4BernYUB1i5AAzbuIHDhg6gbNFFXm
         hiGWzF0LWjrDok+2l7xaJAhZ7nvzCcYZEd5LyQStzpB/XI+B1gBblQ1bf3Z6gvSO5rQv
         XCEMQboXkSh5zkmfB4Ns8qRCLAXJOK7o8wFKftML92A3+UDI5zHmaJG5VQ64jZF4WcP4
         lE/eXbZjuyVUwWP10uCBE/eRAmGBEMQvfBgfSsOZdkl2DW6Iso/k0Jsqa5whyYXlfvxr
         COTgheXzBPISuaJx/9C3/UcOQv04spspHnzb0U6MIMP/Ixh4JuRvirELwbYOAHXieBU3
         RKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IqN1+l9+mYvAuC2nDjrRFzq7WU4KEQGo+hHkda3FvIo=;
        b=C/BLXMC+iKU0bf2YkAAtqbGjSAaP7j5aEx/nIdIvvcMNJWexeV3TpgKTQi+jkNQb7n
         HBadYMdBY3rti7GRh4dXxyd7gVRhVKUmRZh53K+9O7SZ99E5U0Ch8APTjsc5I97llz++
         RGKCy8HLi09R0cSbnqp/1bW1CoAVYcesdpST2R8yz8UMnmv2GjUQcP4d7JikR96qvfh9
         FR2/fpqFn+riEML8ZmLtaJvfblUQYoqjtL3ipv6yqTshx01vBlb2LGDqeBIRdI0r8f8u
         P1QW6sWmh5IkAaZBl3iC7p+y+bl5TCzinBxdIJxeJw5CDgXKY3BNk34YhOzF0AAzLrJb
         H50Q==
X-Gm-Message-State: AOAM530YeS0UMpJgUlwDARen2wTEOMe8nTh45S1OcEv9T2tNkMPUNz6b
        9mNiwlKWbjGYe5G4p7E4XeXauQ==
X-Google-Smtp-Source: ABdhPJwP8LuereZH7kWfB6S7WP/gTSONfsnEfKSep5tfrNuZYbQrTGgZlkacyVl+cnIbkxD1KO8LaQ==
X-Received: by 2002:a92:d7c7:: with SMTP id g7mr9698422ilq.305.1615771612870;
        Sun, 14 Mar 2021 18:26:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o13sm6315322iob.17.2021.03.14.18.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 18:26:52 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: csum: cast to the proper type
Date:   Sun, 14 Mar 2021 20:26:50 -0500
Message-Id: <20210315012650.1221328-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last line of ip_fast_csum() calls csum_fold(), forcing the
type of the argument passed to be u32.  But csum_fold() takes a
__wsum argument (which is __u32 __bitwise for arm64).  As long
as we're forcing the cast, cast it to the right type.

Signed-off-by: Alex Elder <elder@linaro.org>
---

With this patch in place, quite a few "different base types" sparse
warnings go away on a full arm64 kernel build.  More specifically:
  warning: incorrect type in argument 1 (different base types)
     expected restricted __wsum [usertype] csum
     got unsigned int [usertype]

					-Alex

 arch/arm64/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
index 93a161b3bf3fe..dc52b733675db 100644
--- a/arch/arm64/include/asm/checksum.h
+++ b/arch/arm64/include/asm/checksum.h
@@ -37,7 +37,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	} while (--n > 0);
 
 	sum += ((sum >> 32) | (sum << 32));
-	return csum_fold((__force u32)(sum >> 32));
+	return csum_fold((__force __wsum)(sum >> 32));
 }
 #define ip_fast_csum ip_fast_csum
 
-- 
2.27.0

