Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D857398624
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFBKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAE3C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z8so1688004wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ontm/1WjcLjJ2DXWD0FtXaoVFZvxs8qoCFJzel5PQ0U=;
        b=W38vU/EW6bYFmOA3g3xYUpPqncKZOBFgP9FE8Tajyv8VOuIXHZ4sFj45NbAfVw0Ztd
         X06O3VbAHu8/lN5gKQtvHjeMujdGrrBTh/agWJMJDKUyQkiOnzYXyWAQ63rqOwH7YCG8
         J0T7+GhlyneCD1udpwhQUdG7Cg+YCHkEK9ptIA96DFfoM61B+eRVWWbt5ii5JE+BS9wj
         6NOMO+Ee7cbGi1qaoR0lsUCGc2e8HPpT0dqFUjCerFFZmDCrFxHMEC5X3gfkv+mW8/j/
         ww5GYUMGGVOdhZV7vUlReDDba0yi/UUCcg8hMwKrNto9/D0LhSAnD8Ci+B4f6pyyzFRD
         LP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ontm/1WjcLjJ2DXWD0FtXaoVFZvxs8qoCFJzel5PQ0U=;
        b=Bgi+ovIcau+simOSUXavHONrp4GyUiDW+8A/0EZmKlslAH3pxdsA/vCBCGfxpftCBz
         yP6mybr5wa1PUFL27muaHQtBXH9EMlhxYNG9RrxAc1fxai6R4BrvBqOt4iwRJ4ICw8sD
         rAEkJmDgOK/B0DAG4+XRT8+og8rQzYktoESDjpgZ4KK36mmq7uYGLO/xnI86GcmHN1KS
         PNfAmmSojdTV95n132LDVGUzPzM1LwsxKCtHaiHU8Iq1cNtJvtIPYkrDWy7IshqGHOvh
         6ZRMJYkU1D0lvtZPc2L8TSc0JqI6DSiL2geRNsXvfWxJpTXJiI/6a/aTTjT4QPLTfyyq
         I2Ig==
X-Gm-Message-State: AOAM532VCc6ov6we58BnAEtlS7FQ1hTLwP4adj9nJT6JouWD60dm+MHa
        jYA6XZk5Bw9bXtjWaDvbzus0r7CscOXm8Q==
X-Google-Smtp-Source: ABdhPJw86cyIoSYEuZJ5FX7mQpXBSkjDtnc6mTjjIZvtpDICzcmb8kvc5REqdHugefdD2Pndm3mV0Q==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr31458994wrf.130.1622629055271;
        Wed, 02 Jun 2021 03:17:35 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, CJ <cjtsai@ali.com.tw>,
        Andre Hedrick <andre@linux-ide.org>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        "Software, Inc" <source@mvista.com>, linux-ide@vger.kernel.org
Subject: [PATCH 01/21] ide: alim15x3: Document alim15x3_init_one()'s 'id' param
Date:   Wed,  2 Jun 2021 11:17:02 +0100
Message-Id: <20210602101722.2276638-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/alim15x3.c:536: warning: Function parameter or member 'id' not described in 'alim15x3_init_one'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: "Software, Inc" <source@mvista.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/alim15x3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
index a5043e048f919..39684d12d45e5 100644
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -526,6 +526,7 @@ static const struct ide_port_info ali15x3_chipset = {
 /**
  *	alim15x3_init_one	-	set up an ALi15x3 IDE controller
  *	@dev: PCI device to set up
+ *	@id: PCI ID
  *
  *	Perform the actual set up for an ALi15x3 that has been found by the
  *	hot plug layer.
-- 
2.31.1

