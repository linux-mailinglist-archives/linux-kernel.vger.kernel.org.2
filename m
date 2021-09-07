Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84330402871
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbhIGMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:19:47 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36906
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344148AbhIGMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:34 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 68A314079A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017107;
        bh=hZ5N4zB6ne7AqKTWsazgl2eww5+7SrfSBiF0jiwRIRU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fkzyi7n2xgRThZvtfH3XLRK+o6Zi5blyGh4ByOfRM/sSR9Cgp0Y2eDc40e84Vanzs
         kC+WzjJtzvYxuyFUmpdqyHEKLG5TRiTAXRwcBiRPqp4RZgwVSMTIn4QmEVe8lieaOU
         KcPfoFh1kcX6o/UkVuptmGXQTUnYIUFgjcTaZyyKkZMdEN8JyhuyjOrXKrodx4V8eC
         qCPbbUgwQ3y/qrmL6gT+SgFm857RhIunvC8c0LFXkt/iwGqqRKORntTYAluSCXTwfB
         RigmusWPTsxExSx7aAk56pBDbWBvHTDqB88i+U5wyL2yJUETciH47H8bmuaNMErxNz
         NJFnfzSFLe33A==
Received: by mail-wm1-f71.google.com with SMTP id h1-20020a05600c350100b002e751bf6733so1027051wmq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ5N4zB6ne7AqKTWsazgl2eww5+7SrfSBiF0jiwRIRU=;
        b=d339wKGOM0VdTT5Q7iuMdUmujUFDjzDyyTHqXq+0DnPuMVUMZw4uWUujSUo+8ylP81
         8rLY3BcgFqfA99pgnm1cEUsujIY+pctvu2gZXFUm95d7jjQvGE6oW0XLFFTRmYXxd5XT
         t8QOVzLZ1zqc9afV8kVNbOIiBcovOjLFLToOoQvZWhHMb4izP+ENO3WnX2knu5EWvCzx
         xwdPUNUwdUPSsWCVJgjHmtHahVbBJpRfTsaV62bYIMK6WJioGu34OuD/UgJ0YiA0dmLX
         Rvq/yr0EJpuA13sTkQuEiBy+79csLFyhM1II2/DVFd4v1KK48ZsuVVxGSMnJ4E4kZ0MM
         7qgA==
X-Gm-Message-State: AOAM530VfMTem3QlpSAD0sYAWEevuzAaP6t2MO/YRiYKiVCcX/dLenYK
        PpsZPTzonycnqB3zpPe1OgEfOfsHU5fZf1JwPtoBn1IlzVE9gNimiz2l2LRHu7CeUPscdMOdskS
        MszUaNl5bs0L91sezNcaeR8z9J4Dd0ssxgum/1F7nuA==
X-Received: by 2002:adf:b348:: with SMTP id k8mr3883770wrd.123.1631017106986;
        Tue, 07 Sep 2021 05:18:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgbBZYQOs4YRKdywoy8M0o3zhvETIaAW/i0wBtwjAAuvZRpPDbv0ZXj/kM++iU/bcy36GOCg==
X-Received: by 2002:adf:b348:: with SMTP id k8mr3883754wrd.123.1631017106864;
        Tue, 07 Sep 2021 05:18:26 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 04/15] nfc: fdp: drop unneeded debug prints
Date:   Tue,  7 Sep 2021 14:18:05 +0200
Message-Id: <20210907121816.37750-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index 051c43a2a52f..f78670bf41e0 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -335,7 +335,6 @@ static int fdp_nci_i2c_probe(struct i2c_client *client)
 		return r;
 	}
 
-	dev_dbg(dev, "I2C driver loaded\n");
 	return 0;
 }
 
-- 
2.30.2

