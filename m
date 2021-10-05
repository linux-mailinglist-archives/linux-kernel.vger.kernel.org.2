Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A8A421FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhJEH5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhJEH5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568BC061749;
        Tue,  5 Oct 2021 00:55:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso2173840wme.1;
        Tue, 05 Oct 2021 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/XH2ZH+4nGjHrCB0TxUfbfwc09zHXLxmUMfP3BcMhg=;
        b=RlQIW6n0ZSfajXkuKYvMMPc9PgdCeEKwMnLx+UBVMUzUSszWSA1mmNgXfrEdf7c+fz
         G5eYxNnNAGvU4b0oB3XiytazaoE4h4Z0MILzStojXZQqi+CCKl543DAeDe8IOlzel9lr
         UqvRLFUUjIKlqXs41rBU9MDwdMC/TgismnfnJtJDv8ptbHD6+8lISPd/kWIE7LtYDHbv
         +mfcj12X6Pv6Cjl9L2hiUUJJzm3m/N49eAcqVNm937Saslx5AHj6h1o2krc+kurPOjV7
         HdLn5RGyMKXnEeVdvk4RouWBXUfXqC5Yk0Qpe6fMgs8HvLq3M6OzhvcFbgiCTDKOkWfj
         TAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/XH2ZH+4nGjHrCB0TxUfbfwc09zHXLxmUMfP3BcMhg=;
        b=ODg1ECIxiqOzvFaUcP2hYeWoWC9LbAuvL6x7FnfWQxHQBHfSov7PuaKdXzyKRTreQq
         QNo2MOr5EC72wPSSoQzJAEE78AaKdxvmDSgNwEx9a7AqpdEMchFzvOvjI9H4VYwn6D26
         BV5sMktCB61IIJGhrxZal0Lfshh7jGl7W2CPmmPzt2d3EeAJjlv+uGYDgA+dQ6aARkJO
         sIFag8FbFuRN+M2jjgJBtvQInqfY4XqemxZ26HK5KTrK62dzsC1wlBYlGBytzTDMu8KK
         HiOfSSNvvLcGA2ZIjXb1dty+61fqqe8x4+7sujKnJNln9ZwPmFJiWj0Cn3JBjvb/JtV8
         xu/Q==
X-Gm-Message-State: AOAM5320UuupSHsIvhu4ufieEw5XgtskGOPT99YoIp5UMzNREWG69ddp
        Z4NGBCTjAbGR0dZ9PwkO7Mg=
X-Google-Smtp-Source: ABdhPJzpf9vStU7MVcwYcRs0SEZQCwQHzCB1mceYahnPVzWOwQvvHi+dvXRAiqYhLuNvuQUAE1i9qw==
X-Received: by 2002:a05:600c:4e87:: with SMTP id f7mr1835960wmq.86.1633420524973;
        Tue, 05 Oct 2021 00:55:24 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:24 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v4 08/11] MAINTAINERS: rectify entry for FREESCALE IMX / MXC FEC DRIVER
Date:   Tue,  5 Oct 2021 09:54:48 +0200
Message-Id: <20211005075451.29691-9-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 96e4781b3d93 ("dt-bindings: net: fec: convert fsl,*fec bindings to
yaml") converts fsl-fec.txt to fsl,fec.yaml,  but missed to adjust its
reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
a broken reference.

Repair this file reference in FREESCALE IMX / MXC FEC DRIVER.

Reviewed-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1337ba843f26..6660b32c01f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7495,7 +7495,7 @@ FREESCALE IMX / MXC FEC DRIVER
 M:	Joakim Zhang <qiangqing.zhang@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/fsl-fec.txt
+F:	Documentation/devicetree/bindings/net/fsl,fec.yaml
 F:	drivers/net/ethernet/freescale/fec.h
 F:	drivers/net/ethernet/freescale/fec_main.c
 F:	drivers/net/ethernet/freescale/fec_ptp.c
-- 
2.26.2

