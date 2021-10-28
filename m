Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6207043E799
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhJ1SAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhJ1SAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B01C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:57:56 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id kn11-20020a17090b480b00b001a4053c7510so2977257pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mw2CEev1daiNooIUJdohH5RCMmpfenCt657Mggafnbc=;
        b=MSKfK4nONzPt7Myx/SxS6nxfZjl+nZdS/hkiePnWXsEhkNwS9oTJQ2HE+A0ZMOQjkX
         iC53fI1FAiegTNnv9P+hTODEKrN18e8abE/wQibPSg0QIkhHTnNNX4xp3Y8N+Kv194m1
         SZC2Hma+yhfo84NwD0AVaDLPFpUQGiYHm4icLKN+FcfA14gR1uNJVtvHPwCbjSRPUmC2
         sDn0nUGABX1lTfRtHRbosxqhXhIFtemiRhHBo5R2TfjqjFggQ+9O7+4VhrORj8SW+HQu
         PpOpEAy7flzmyjNPdlkY6Wu6b46qyOnpbQIq7YrK5NnOr7BZclFAPdcxYjZ7CSjOrkZe
         BLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mw2CEev1daiNooIUJdohH5RCMmpfenCt657Mggafnbc=;
        b=bNQ7c5leT/89vC88FPq7Ou/K7ARVSmMr8UZPYmc7w7GIXyhUacoZONwR6EJ5twEoId
         69MrgtxuDT+b49t9ChUkcM5fjWm2lzUzZphCYSUcqMCZ6BzGUiba5v+a1zaAJwisr4p4
         2fHQ6zYM5lbA2WU8kEui32Mqxsr7eQkQlVuGsCSYGzu6IKFm9oCV2FO4uWSd3bCxTSGr
         7VsCUnfBEjIT61kKngh9Fb7drojNEHvRrEWDOaKJdU/cOpiWhJz2oPC0bxoDbrMDmoL9
         dayfzQtHgMxc7KlJ+YZpXvKfAX9VXNRQYbkJw7RSWoXUpPcL/XPhGoPjLUi8Ok5GqpqU
         g0Vw==
X-Gm-Message-State: AOAM533KrUoMXYGj3xhoXfVjyPC4B2C26TX4s98sEI4mUCBBlml853cL
        if4qxrkWp0e3rDeuhx9J2/0J8WjMdrU=
X-Google-Smtp-Source: ABdhPJykzThu+/EfBE/7opbI5H7qsPR4G5huaeOs73W0XdgLYL3hky8dnEW/THN65LDvY4ghrkh0TTyWKMI=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:41d0:ac84:3b61:5938])
 (user=pgonda job=sendgmr) by 2002:a17:903:31ce:b0:13e:a6e6:9a53 with SMTP id
 v14-20020a17090331ce00b0013ea6e69a53mr736424ple.4.1635443875763; Thu, 28 Oct
 2021 10:57:55 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:57:46 -0700
In-Reply-To: <20211028175749.1219188-1-pgonda@google.com>
Message-Id: <20211028175749.1219188-2-pgonda@google.com>
Mime-Version: 1.0
References: <20211028175749.1219188-1-pgonda@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH 1/4] crypto: ccp - Fix SEV_INIT error logging on init
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>,
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
Acked-by: David Rientjes <rientjes@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Bonzini <pbonzini@redhat.com> (
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

