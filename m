Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4AE45C78A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353815AbhKXOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351722AbhKXOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:38:08 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B85EC1E9D9F;
        Wed, 24 Nov 2021 05:34:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso2770065pjb.0;
        Wed, 24 Nov 2021 05:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tATyhlZdq0XGywzjbQqGR8CEOKXl8O6LBdffkyjbzEQ=;
        b=d3oJH2ekvT8CIXNGsQl9TfY3iq6YzwHKmDBRWmTNRNO29KWIGZK3bPXhuQqXXdvitQ
         pNbzewjuz3W2Oy9utjnFvtmA2Fm4deFmNpg/nebPgd6CMW6W/h0GSLxkSmozfYmGnvHl
         LPdLDWhcgqUwiAGVqiHRhnHMJ8F53kd307Q3ofVSkyb4rmtH1QfFYX4SqO9JZVu1zOg1
         2pG1h6rlGXzZsnc+FFoPi6DSLKwWOfh4JhZrmx/aTX0ntE3BSALo/P5seJ6JHQ9vwMlU
         NDc1DhsOVAdH9QcfzidXYS/FIqvXjAdwZu9W02w7qr4jk9I6jOmoI+JdRDYRR3JCMnFh
         kt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tATyhlZdq0XGywzjbQqGR8CEOKXl8O6LBdffkyjbzEQ=;
        b=2tMThgRAskWrDoioo2YcXPBwmkuBwG7ig+8GVzf9DouCHYv4RsQBimy3oc474241hf
         Go3LoKjycY6d1QmTYAhqMEyP9wR19BoFkNHKeGbik7Bl6h2tOLWtDHgP4JWA0r+XCJ6n
         ru9xkk/IxXj8E5JLUtwuO5sbk5JoKQ4khzqstHFQwyaIgth4CMvmdl5RFlOS5aASgvNc
         To8y6+OOyHbYpHhnjuJxHEDN4EHMDdH0qGTvahEcn81AwvppCZC+VdNygQu9To2OcRQD
         zE2GzaT/tp0YBCluf7pOXJU2FF9rpAJCpZaRD9L7t278FuKVOIA+/HgvYU0YzzpCU85q
         YP5Q==
X-Gm-Message-State: AOAM5333BHUjBpcHjMUcQv0HH61Nh5eefW+UKoTQqZ4VB+iX3ZT9KKNN
        uHtl5sQ5+wdavZIYGHxrsKE=
X-Google-Smtp-Source: ABdhPJyOjH2HfyS8AAXLxMEI/kOiX3zzssL+dztgoeWCrjEykqmlOLJnWDsW7dauY/UjM99unIZV3w==
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr8750663pjt.168.1637760842593;
        Wed, 24 Nov 2021 05:34:02 -0800 (PST)
Received: from localhost.localdomain ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id f15sm19137397pfe.171.2021.11.24.05.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 05:34:02 -0800 (PST)
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Calvin Zhang <calvinzhang.cool@gmail.com>
Subject: [PATCH] of: unmap memory regions in /memreserve node
Date:   Wed, 24 Nov 2021 21:33:47 +0800
Message-Id: <20211124133347.3861391-1-calvinzhang.cool@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserved memory regions in /memreserve node aren't and shouldn't
be referenced elsewhere. So mark them no-map to skip direct mapping
for them.

Signed-off-by: Calvin Zhang <calvinzhang.cool@gmail.com>
---
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bdca35284ceb..9e88cc8445f6 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -638,7 +638,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
 		if (!size)
 			break;
-		early_init_dt_reserve_memory_arch(base, size, false);
+		early_init_dt_reserve_memory_arch(base, size, true);
 	}
 
 	fdt_scan_reserved_mem();
-- 
2.30.2

