Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0483A6599
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhFNLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbhFNL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:29:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0482C061198;
        Mon, 14 Jun 2021 04:24:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m18so14146542wrv.2;
        Mon, 14 Jun 2021 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xzBiF0deuxW/VmhACuRBNENUpwSYlJ5ATqHOdjxFmsg=;
        b=S85sOn7tyRrYrw2MxeHOj8uSP5E/fcrrOe30A6f494GDX860/tEaw6a7+VxBW3yZJD
         woRDtpTGNIMDhEAVzOprAEdKk894yU3ZiJLUprpJzGjwknaaKrXMYE06FD3SnCe9RGlh
         wjsf3mq43j1HhDvY5WRQc0SJScH6pUDTshpUNARguREig9Eeqzlxw+E1Esh3j5so4eA7
         l58dGTVQxvak3xNzXoKdthxlGfOe4TKojbbnE7+zu2nzldBseQdRtQWt8Nq18nc5H1Cr
         cKz9dH7YrNmQRqEw/u4BQJW7UYiEzizhRA0rXPUauLP3EOXDMXKEMu4gAoAKjDcj+Yb3
         Ja4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xzBiF0deuxW/VmhACuRBNENUpwSYlJ5ATqHOdjxFmsg=;
        b=CqxftGIvEOnJwhGNJB0T24GzliIJAxesGr9XjhjJUHgcVWxR/PCBSDrNtDx8PakYl9
         dMnNkVtKHb7+VncsTT6yU1Ip85PhbZPfJEuSU+RDX+4XYmmya7LINlFL/FVOPBx7EGH5
         9atafc72NmPJmK0psHtiWM71fNNpdazbMhTJQehLJq8lWiX1c/0mmD9FKNCyXtU9OkKE
         ze8o6FI7MdkZmxBadu3uy5np2r9rOzzw0nAzwHK5Nk1AnVeFtrqUr6abJeZbjPG7Nwcz
         oJ4FTxTe1RJCgTOKJpKhiQcbA3aZCPsN1cACkBWgK6mMoqzleFSntK7LrzxD9FIFBczm
         0++Q==
X-Gm-Message-State: AOAM531TyzG56kmhulwtjXuN9qCia7gexfQNfyuehUnPBn7aYo8I7PvS
        y5/+1ob5U8tcN0tWp5AsN6o=
X-Google-Smtp-Source: ABdhPJxVd1GET6VG6yquZRQLMAYFTpw/1E/W7bGvy98kZXFlNfDihTcWkSaQP5jrZIuTM2tKcFQO5Q==
X-Received: by 2002:adf:f305:: with SMTP id i5mr18849410wro.29.1623669849477;
        Mon, 14 Jun 2021 04:24:09 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d62:e800:a8e7:80e:6e34:237d])
        by smtp.gmail.com with ESMTPSA id w13sm17269485wrc.31.2021.06.14.04.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 04:24:09 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 2/3] MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
Date:   Mon, 14 Jun 2021 13:23:48 +0200
Message-Id: <20210614112349.26108-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210614112349.26108-1-lukas.bulwahn@gmail.com>
References: <20210614112349.26108-1-lukas.bulwahn@gmail.com>
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
index 5df664744cd2..8e8dfe48afd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8344,7 +8344,6 @@ M:	John Stultz <john.stultz@linaro.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
-F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
 
 HISILICON PMU DRIVER
 M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
-- 
2.17.1

