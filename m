Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD63D5B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhGZNto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhGZNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:49:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5AC061757;
        Mon, 26 Jul 2021 07:30:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso3438222wmq.0;
        Mon, 26 Jul 2021 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=noVXGPZ9APxh9n8MObrM/pA6rJteI4YtZqA3oqU+ABc=;
        b=sviGK27y3WYy5MHQHHZseM1l0upHiJlekckrhbnNCp7SP1Rg+yHyLUiaZct7gyCzM3
         Nwq47153jM68oMr1SsCwP+IkkNYLnohJP5u6c/nvaajhb+KJsAaGzlVs2ZKO6sfg1ybV
         D9oPqQaTcL8kGT6DQPHkIiqxZKfoTG7yreAtdnb9fnQf3bCZEObWcFhsWljLZWQlXHf0
         04LArRKYU4/4x5oEIfyRjLfGsWRMYJINtP/K5nTTW5vp8ggnbB33Xvxb64QAJoO8nKC1
         9JH6jv+YmlYHcJWWxtlzHD2tfhD8KyRp/JI8X8f7YUV+7z5PTxZgh/shXQ34UhGzs3bB
         ynlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=noVXGPZ9APxh9n8MObrM/pA6rJteI4YtZqA3oqU+ABc=;
        b=cMsKP0VxzxgM2goFlYN9HfAJf7M0nqXs19yENcy0ulxCDucJi8+HjoH2V2p9ruqJnV
         6NtCWtXZzGCyOmTltEd/La6Dpo0nmmYjBfVgoSru3sU3TSC/WxaWcuNdTPq64jAc8uGE
         D8/3da6SiXv/GZ0JW5//8GMGuRugY4zUgsKd0w1SH/2b2rzvd/LcdBpKIh9H5DmPOtNq
         avLq4RBqhHv3zIiMy3k9piJ45Gwbx3gHWfYZgw28XaecWdbOAXX/53DPHQ+Y3z4/5u9g
         pnvWOri8dOGYKD3N3XIpe9P1GXru5vyN5XPXyax5N7GL+aTKHxs2bPWFzHbMWSa5QpFY
         o/oQ==
X-Gm-Message-State: AOAM532ICkSnntniTyml/OzUkky8UbL96hve91vrC4V77BLs59sctqhl
        HOPrgutdF3SHHDPxl0dftL0=
X-Google-Smtp-Source: ABdhPJwr/+OkFAiulCs5w2oNqG/uCQRHJ5IcOfpZ+mXD5AGfqact3KZfVNoMcQhT75AtqY3wn6WMHw==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr17742148wmq.65.1627309810016;
        Mon, 26 Jul 2021 07:30:10 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id o17sm9176609wmp.31.2021.07.26.07.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:30:09 -0700 (PDT)
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
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3 2/8] MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
Date:   Mon, 26 Jul 2021 16:29:37 +0200
Message-Id: <20210726142943.27008-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB
gpio hub on Hikey960") refers to the non-existing file
./Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml, but this
commit's patch series does not add any related devicetree binding in misc.

So, just drop this file reference in HIKEY960 ONBOARD USB GPIO HUB DRIVER.

Fixes: 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB gpio hub on Hikey960")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 615c3e41cf92..7a568d83096a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8381,7 +8381,6 @@ M:	John Stultz <john.stultz@linaro.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
-F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
 
 HISILICON PMU DRIVER
 M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
-- 
2.17.1

