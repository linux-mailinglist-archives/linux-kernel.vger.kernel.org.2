Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC09F363E74
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbhDSJ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhDSJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:27:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B8AC061761;
        Mon, 19 Apr 2021 02:26:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r20so2030923ejo.11;
        Mon, 19 Apr 2021 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xezRxZg+LzYQIKGOESHgm7jvDgtF8jLNLhDDugbFxvY=;
        b=q7VvB8MGJubuYioQv+Lcu58E2XFdxbgH93ULMStrRhH7gZLaToFPsMUPGjQ77XD2D6
         jGnV5RBUUeY7W1PS9R5OC+qKGuz/1vB9W0wKPRZKsCQ0yczGuXwc95xLTEp4r1FUQm6V
         t0ztkvxUVEGHTK1neEUXy5jzqVUyqTecSpgqshvPiIy4ggm3dzNmL8rGSO5x/9n8HSjp
         +ZLBhwpFrl+p6GavCtQAveopt6ZtUXDCiJegZSM7Q867bbXMnSddROuwGpmDG3qL+1T7
         KVx1mBjksGPTbC6EWYvCiI6q2SYn8T6LppTzkgPVEuvPVNPniIBmeFkjlFH3wFgH4Xuy
         yUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xezRxZg+LzYQIKGOESHgm7jvDgtF8jLNLhDDugbFxvY=;
        b=es6eeLMDbLO97nnNKf4vlpM4/vuIcSrYtLV11CiyFEOx9kBZa6TxG9Uxxap/X6RVHb
         Z3ijR8DVQnqxhkZrUNQkp+CkUva9J/rnFFNOGowR0s5jVieWKFP01CLLJXFi0+eIdusA
         VY+YdtIWgQbhpCqTjyxYCVsDHUB7ci9pg/mOmfaYJvFkyCwh+fXzUqOkC7hI6xMYgMsX
         4GaLOR0MxKekQmD0jo9n66RlwN90C7dOifPeXpcGo56EQnVIRtOI/Z9+m8/Yu9ghfUGE
         WQj2k/eduy2KnIRx1uaTJmAtp/Ff4P3DowPLghogTwrlYmJ+14AorUyoOtHZZzJcMeNj
         52eA==
X-Gm-Message-State: AOAM530m/8qkF0B6gpOTy2uTEP8hwcFR2x5R2BxC8Q3hnAoyyvmarYRy
        oE2uF03hJezPRFc4vsvWwt0=
X-Google-Smtp-Source: ABdhPJxzFS4qh0dWxyAMucW04nftljvn+rAcpOidjz5YMidBwjIjnGVWQieAGWtfOIYniY/p4fMr3g==
X-Received: by 2002:a17:906:b251:: with SMTP id ce17mr21340171ejb.333.1618824383491;
        Mon, 19 Apr 2021 02:26:23 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dc6:900:a414:a08d:9e82:6738])
        by smtp.gmail.com with ESMTPSA id bh14sm9943706ejb.104.2021.04.19.02.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 02:26:23 -0700 (PDT)
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
Subject: [PATCH 2/3] MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
Date:   Mon, 19 Apr 2021 11:26:08 +0200
Message-Id: <20210419092609.3692-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419092609.3692-1-lukas.bulwahn@gmail.com>
References: <20210419092609.3692-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB
gpio hub on Hikey960") refers to the non-existing file
./Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml, but this
commit's patch series does not add any related devicetree binding in misc.

So, just drop this file reference in HIKEY960 ONBOARD USB GPIO HUB DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d31c8058b17f..4f152717365c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8239,7 +8239,6 @@ M:	John Stultz <john.stultz@linaro.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
-F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
 
 HISILICON PMU DRIVER
 M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
-- 
2.17.1

