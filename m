Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA46A421FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhJEH5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhJEH5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFACDC061745;
        Tue,  5 Oct 2021 00:55:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e12so15448367wra.4;
        Tue, 05 Oct 2021 00:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3T2erIsdkeI2LdejpoJ6gNyl1AGcs6GUopPQwOfHR/c=;
        b=bBoXqWlQQIf0pv6CFBMGBc0dorqG/suhpidYp/LQ+7BoUDZZNX6OLzInyST5E/+397
         V7oxMjMjaBUlaujJmor4JN/sB0xxTkk5U3l0zsL+iydLep5+kUrKD525xfgA3Op06NYC
         X6NUbaVbVJV3hh69GBZtmSHIVyMq0yuu6jw0hyvd8xZWj6CfUt0jDxjXnhqgZ97A/9fD
         wYPYeHp+QV7/vUskaM5wmzkaEMPxPynTI008ls1ThHpUGXkSYwlelehm5IuPiqIJCJHI
         yGWPiY9M64V1TMbKnTfalGLJxzF6/00s0JZoy4MTy4lBuGfMvsQSHU4kZ2QwOLTZXsJ/
         Y1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3T2erIsdkeI2LdejpoJ6gNyl1AGcs6GUopPQwOfHR/c=;
        b=Cngv6Vqne10nDz82vzl+jQiuLqNQIQI1+NPqhrc24KeYs997mn/5xJ6gmIrbuKdKkv
         6B1s9OJ4+jHCYVeNBah4fvwRp+YFquAQO7X7wdf+LPwW8SKvzt53zuikTd63aGZVmsYu
         4fXtqE9O5N5jNYHi4y6AjbsSew3sI6gP1Pm/xOMHCzAUVvp0IlwAmvZ8oy7yYq0/MUO+
         U36Js3Oydw6eJNaZoH6xAAMU7z5Y6sBGaiR7pLa5ScxGEBgzaOvl7lPv5Sizzq9RHdtk
         B1ZcaQZfR2SSVATxsRhzTUNLApeXzKdAL9iD7iD4L4yw6/vv6V6UD+/u+KT2iC7FCWe1
         DGUw==
X-Gm-Message-State: AOAM533ftf7uhb6euKATHykZHHZ4QpKxgB6OQLjcDiGE5xGi/1n0Y+OL
        7lLFwriIOml3rqAvlGJ74yI=
X-Google-Smtp-Source: ABdhPJyCwgYj+Au12kzgzJXRoWF9RIe5W4pZMcggoW9oUHVyFzWCojzn8OpfjT1A9/6xN/zwpmNKVw==
X-Received: by 2002:adf:a18f:: with SMTP id u15mr19563105wru.183.1633420527537;
        Tue, 05 Oct 2021 00:55:27 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:27 -0700 (PDT)
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
Subject: [PATCH v4 10/11] MAINTAINERS: rectify entry for SY8106A REGULATOR DRIVER
Date:   Tue,  5 Oct 2021 09:54:50 +0200
Message-Id: <20211005075451.29691-11-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b1c36aae51c9 ("regulator: Convert SY8106A binding to a schema")
converts sy8106a-regulator.txt to silergy,sy8106a.yaml, but missed to
adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
a broken reference.

Repair this file reference in SY8106A REGULATOR DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a8a043ea9c4..9e537e78f426 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18094,7 +18094,7 @@ F:	net/switchdev/
 SY8106A REGULATOR DRIVER
 M:	Icenowy Zheng <icenowy@aosc.io>
 S:	Maintained
-F:	Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
+F:	Documentation/devicetree/bindings/regulator/silergy,sy8106a.yaml
 F:	drivers/regulator/sy8106a-regulator.c
 
 SYNC FILE FRAMEWORK
-- 
2.26.2

