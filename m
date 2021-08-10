Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84803E7DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhHJQla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236059AbhHJQl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628613666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1IvooYq8Yem5dV4nvC50nzcM/pns/C6jIbPJ9hHA2Q8=;
        b=c+b/t7zBNoZJ7bT7QZ1e4LoIoweS11RAqEEr9WI3X9uQ0pHTaKQPImyZ43mD6hF20+aPQP
        9vf2ZLIvoyTy0293iKfbJPGoK2mj23CKRuTdasl7O1Tv5Qiu+nk4vqbZGbAmxL1pbbA8J2
        +nkuZywBTzsmEL70E4GV571OS94hhZY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-v_PpvmJ-Ori64KN2mNUPaw-1; Tue, 10 Aug 2021 12:41:05 -0400
X-MC-Unique: v_PpvmJ-Ori64KN2mNUPaw-1
Received: by mail-oi1-f197.google.com with SMTP id u77-20020acac4500000b029025c7e6f8b64so7331313oif.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IvooYq8Yem5dV4nvC50nzcM/pns/C6jIbPJ9hHA2Q8=;
        b=Pdlb+OoxrZCOkd8YD/y47pXfmxwMLz2Np737v0XoI3bRBoj8L8yV0XERjMczNrIDAe
         oyHXViInG6UNZIbJbpIKeBLNSuZewy3735x8X9ZhaRSvAtkcvmGCfCZfBceLw/91VA0y
         giKsiBRDeOfPILvp6pJ3uSKtBIlgQPSe7rnZcyc/V/Pk2azgQ08d6C5BfXHL6AhBZ9z4
         FqRj3FiY4KL/jjHtgtz0itnhS2LHBQM7xMF4CrnLGWiwLr/GfihABE3OHIn+WFtp/7fb
         FfkjLx8OHGZccVM7aTYGim62vuEy2mWOnhai6Na16ggnAPTqkliCyKjwFQpiuFEqUx/9
         aZIA==
X-Gm-Message-State: AOAM530avWK2UlPS3iDaZpIYORreCxebVNG5tJuVm/ilPzpNwxJ6Aj0s
        1e2gLUdQf3IrXKCCL/bxp8Uh92oKoXIttXMS1UfZ4bpZ/nl0trWRtUlldAY2t0QCd2SBPLWzB3R
        /omFg2RkLvPrYePRz5gi732fq
X-Received: by 2002:a9d:7f86:: with SMTP id t6mr20468920otp.269.1628613664396;
        Tue, 10 Aug 2021 09:41:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNsOjdc2qoaUNmR4+l/xdEfnMAyNpy3pbbZwHpE13rTuphdCuMy5G6p2BuPvKZPgmVuIcvOw==
X-Received: by 2002:a9d:7f86:: with SMTP id t6mr20468906otp.269.1628613664226;
        Tue, 10 Aug 2021 09:41:04 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u136sm250903oie.44.2021.08.10.09.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 09:41:03 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, p.pisati@gmail.com, atull@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] fpga: machxo2-spi: return an error on failure
Date:   Tue, 10 Aug 2021 09:40:36 -0700
Message-Id: <20210810164036.922830-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Reported problem

	drivers/fpga/machxo2-spi.c:229 machxo2_write_init()
	warn: missing error code 'ret'

	drivers/fpga/machxo2-spi.c:316 machxo2_write_complete()
	warn: missing error code 'ret'

Earlier successes leave 'ret' in a non error state, so these errors are
not reported.  So set ret to -EINVAL before going to the error handler.

Fixes: 88fb3a002330 ("fpga: lattice machxo2: Add Lattice MachXO2 support")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/machxo2-spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 1afb41aa20d71..b4a530a31302f 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -225,8 +225,10 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 		goto fail;
 
 	get_status(spi, &status);
-	if (test_bit(FAIL, &status))
+	if (test_bit(FAIL, &status)) {
+		ret = -EINVAL;
 		goto fail;
+	}
 	dump_status_reg(&status);
 
 	spi_message_init(&msg);
@@ -313,6 +315,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 	dump_status_reg(&status);
 	if (!test_bit(DONE, &status)) {
 		machxo2_cleanup(mgr);
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.26.3

