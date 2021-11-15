Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057A145167B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348230AbhKOVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 16:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbhKOSSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:18:49 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154BBC03D784
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:41:08 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p3-20020a170903248300b00143c00a5411so1274761plw.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jpkiYNoU4Rt1WYtil9Ur4r8Q6chgaPPrn/vLi4efF9g=;
        b=G3pcIYNysMhR6NM66p0uo164DAAStqlIf6AwN268H6ksfaCnPKRR/89VetMeFilplI
         psmOOEU54SZ8Uh0mJF69xG3tmYG6Tj5dB3wrKrj1x1Jrvv2ShARB5HFfa9EHmyn9P48p
         Oetj277q7JizlSiYkm18u8AOWxSVzgZuzcQs5l7fdjCsQHJI2zChiirayJibbAq/Ze8j
         mSjSSEyMzBL6SiQqq7udVaCtnmNGEUMsM2fVKfgQWjFE+GTTTUPfCadyXluWOkleygUi
         zzLMpuPvGayBopjHc2JZmzc8m4cFPAcAxn7hVJZwGn0uWjAdYwGAmcKxocsMFkPrrOkY
         00Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jpkiYNoU4Rt1WYtil9Ur4r8Q6chgaPPrn/vLi4efF9g=;
        b=VLXtLieozHv1YZC1wQOSe7vOb5eqwIrSvHRpTwWWL7AHkUlR4bafbemJVEMWv3Xqfh
         QX7bAE0zmqmgt1US6e+zdR1FTVAmMtabv+v0Q8QivXeFfF0Dep4QtwTgMnZxXNrh1vzM
         NzFcQq7krvmALOyhBEFSL5Nfa+EcA/QJABiIvGmEdp40ymAu5wDJbeN+KktMLUzATTJo
         IGdQcE5T/11noluO9o2fncQ7Of3KSVsTQ558M6HDlEk0GIPfzIQw3Qz938fSCqrdAKq6
         w7RqLgC07/5XRSkP+haZVJr89w9Ef+FwQEhcP9pINTIL6NvfpZ028Omk/VzVlxBItxQe
         d3fg==
X-Gm-Message-State: AOAM530kN9y5dNmBi/G3Rv+A9sRhUUOOJxgG9rSMzq9NFbCQMIqDpZFv
        RM+yK2QpuBgoyHS2+DH+rxSdFaOhVtU=
X-Google-Smtp-Source: ABdhPJwZ25jW1mkY2E0R+YK+GsMUlaZ25F/AsxUD+F2TD80hQCqhChldrGScMqD5/Wji08WV2ZH0mWcP0/4=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:9fb:192e:3671:218c])
 (user=pgonda job=sendgmr) by 2002:a17:90a:df01:: with SMTP id
 gp1mr416288pjb.28.1636998067453; Mon, 15 Nov 2021 09:41:07 -0800 (PST)
Date:   Mon, 15 Nov 2021 09:40:58 -0800
In-Reply-To: <20211115174102.2211126-1-pgonda@google.com>
Message-Id: <20211115174102.2211126-2-pgonda@google.com>
Mime-Version: 1.0
References: <20211115174102.2211126-1-pgonda@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH V4 1/5] crypto: ccp - Add SEV_INIT rc error logging on init
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the firmware error code is printed. This is incomplete
and also incorrect as error cases exists where the firmware is never
called and therefore does not set an error code.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/ccp/sev-dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 2ecb0e1f65d8..62031e861e69 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1104,7 +1104,8 @@ void sev_pci_init(void)
 	}
 
 	if (rc) {
-		dev_err(sev->dev, "SEV: failed to INIT error %#x\n", error);
+		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
+			error, rc);
 		return;
 	}
 
-- 
2.34.0.rc1.387.gb447b232ab-goog

