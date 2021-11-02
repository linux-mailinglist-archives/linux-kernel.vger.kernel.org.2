Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B650443047
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhKBO0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhKBO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:26:10 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F0C061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:23:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g26-20020a63521a000000b0029524f04f5aso12003680pgb.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u6e4WOpk0Gy7k+VMHluWLZb26ejBKbKlf2/TYAs8po4=;
        b=XTjOStoKg0N6wfHaH3SzwOZID8vIMWONfnqf8lYJCeqJ2EiS/S6Hjq9ofmqln9P1EW
         MK6wB0SISa52PPpwF3WyGEILcviw4Z0TwMyEQrlVTMOaVOjyuefpxn/Vxl2xiQeeqdMM
         pH2QT1EO5clygoA7+wugYZ3pXkf/+US8wCMqYVEUr0K6OYhxXCUJFROEifzwNUn5dER3
         5tJFFhG6Zm6vw97ArYpj+vh0MiEv4qpk/T4sZcpYpITGMDjIaHL9lFveEqUM5b4vk1d2
         qmX1RaK3+SrFEsb0SqRiIMtBcoqLQsqhm5Mn69bzHtfNtn7gOSHj8C55GJ0+W6ZeMu1+
         zfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u6e4WOpk0Gy7k+VMHluWLZb26ejBKbKlf2/TYAs8po4=;
        b=uwDfbACiM5eqX6/eq05N8C/TpRMLgclzPGbTWo0xB9LlMWWT4fkvWx3XK/7drF6Xz6
         AIIp7f6Z3cVC5Ru7o2lV6G9c+68FZnb0I2sk1mNvidVFiv1VsWnxA/VMz2mrvNLecoCM
         lPvQ5r5DmNS9zzW5ubkhuySvqfhJkicl/2PMv9jFrJDDrZIp4t501I2QZBQbb4VK9mvC
         T2Pxs8UWgxgRTCXchsXVmlSQuga998QrAF3AvA2hL/PY0OMqeHs04INfVKZtX2OwygWj
         oyyMxyRfwAu/0BLurQgC+NbI1RrCFZW0vsUs4MAUgmXEfpjaDNYNu3TN+c2NodQDO5y5
         iqQQ==
X-Gm-Message-State: AOAM531ABi+uWjmHBze8GTpfMbZ72/LU4xr1NjLrtmxgBQwVBbIQQWGe
        iF4WFu2h0H54p/x2wje2vSQ7p2a8yTQ=
X-Google-Smtp-Source: ABdhPJy/fKRYQWUyxSBEeGg1RfqjWhYkU35eXTT+y4WzPcVm2Gqegz6Udg89ZNRpZWG5jJBtW1NkltZ3KFQ=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:3109:8497:f59d:9150])
 (user=pgonda job=sendgmr) by 2002:a17:902:9694:b0:141:ea16:aecb with SMTP id
 n20-20020a170902969400b00141ea16aecbmr12630734plp.62.1635863014799; Tue, 02
 Nov 2021 07:23:34 -0700 (PDT)
Date:   Tue,  2 Nov 2021 07:23:28 -0700
In-Reply-To: <20211102142331.3753798-1-pgonda@google.com>
Message-Id: <20211102142331.3753798-2-pgonda@google.com>
Mime-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH V3 1/4] crypto: ccp - Fix SEV_INIT error logging on init
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
called and therefore does not set an error code. This change zeros the
firmware error code in case the call does not get that far and prints
the return code for non firmware errors.

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
 drivers/crypto/ccp/sev-dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 2ecb0e1f65d8..ec89a82ba267 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1065,7 +1065,7 @@ void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct page *tmr_page;
-	int error, rc;
+	int error = 0, rc;
 
 	if (!sev)
 		return;
@@ -1104,7 +1104,8 @@ void sev_pci_init(void)
 	}
 
 	if (rc) {
-		dev_err(sev->dev, "SEV: failed to INIT error %#x\n", error);
+		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
+			error, rc);
 		return;
 	}
 
-- 
2.33.1.1089.g2158813163f-goog

