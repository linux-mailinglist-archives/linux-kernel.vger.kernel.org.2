Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938B8423111
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhJETxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 15:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhJETxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:53:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF204C061760
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 12:51:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d1-20020a056902060100b005b9c7c04351so127041ybt.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ruleJux/5LJ89GBnHLLZrulEoEZQntK4/1Ov9wfpo+4=;
        b=P1FicB+D7N40MyGLhIwZ/HaGNpUlZfZIcgpM3fJyqJUBIZtpNE7GUZOHqGtLeFRuUK
         k/TY4xjrZADxoa0nsPAs682fJrrZCeK5qktH5Br+VghVRSTld5y29oifxAkdm8N4wmn8
         PXzHNn1Zp5+TidAthHOYvcYjX/SND+u3TePP7DYwDiTJK5G949OkIzKSlJjoTqJJAIzO
         SnPaArK+kTTISGDcqg+vvWhvXTTml2h4/hGBEHm8EYw/05h5N+d5Filz2NhSTt+Eu9+I
         tTjpedR3ZvJOU2/6cYsVmkGyHVlUmFJd4ohDPIh0K41/aODexlarcRxRGFqzNEOg4F3V
         hANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ruleJux/5LJ89GBnHLLZrulEoEZQntK4/1Ov9wfpo+4=;
        b=VBDw+uATi5yUpGxnTrQxnttFWN9CbXMlevYcv/ZKL37B/y7TlD+A6hT8uWCibZQPb6
         8r1uWJveBMuIxnKPuni+hX8Bg2O3V9gzMErHwqnwu5UY2Im7Dvhydn6XyFYEwh/pD3m0
         KQnOrcVoI3UnpkyC+ZPfLfBCRVvYeCkwx88Th9R4apxZZIjWKIDe+hSKmiWEuRkc7EhJ
         3h574csAfECvn46maPQqvaqsCewNPdFmB5EuhZUR9MBZmFZgf5TncPI60KrDKl51L+Cj
         be078+bagMvjvZlK0uL4QYBVfI27ebT7qbgFfcRuZSk615AK9Gqcs5XoGXb4boZFK825
         gDDw==
X-Gm-Message-State: AOAM532XoGNJztJVJnlYyQktL9lTyoei804HyRhjDsXjTuhgYoFFrKp8
        BhFltF8NIjCmmeJwI0lpNuv5M1xNVzE=
X-Google-Smtp-Source: ABdhPJzPEmHJWlRyTuNPyeYZh6L/nXbs5BX6Lcne2eMYq4+WjxiKZNPQ+V+rswlP5O89vaL5+iT5Rltg7bo=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:b603:db5:e90f:74aa])
 (user=pgonda job=sendgmr) by 2002:a25:b9cf:: with SMTP id y15mr22754044ybj.110.1633463501163;
 Tue, 05 Oct 2021 12:51:41 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:51:31 -0700
Message-Id: <20211005195131.2904331-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] crypto: ccp - Fix whitespace in sev_cmd_buffer_len()
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Rientjes <rientjes@google.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extra tab in sev_cmd_buffer_len().

Signed-off-by: Peter Gonda <pgonda@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 2ecb0e1f65d8..e09925d86bf3 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -134,7 +134,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_DOWNLOAD_FIRMWARE:		return sizeof(struct sev_data_download_firmware);
 	case SEV_CMD_GET_ID:			return sizeof(struct sev_data_get_id);
 	case SEV_CMD_ATTESTATION_REPORT:	return sizeof(struct sev_data_attestation_report);
-	case SEV_CMD_SEND_CANCEL:			return sizeof(struct sev_data_send_cancel);
+	case SEV_CMD_SEND_CANCEL:		return sizeof(struct sev_data_send_cancel);
 	default:				return 0;
 	}
 
-- 
2.33.0.800.g4c38ced690-goog

