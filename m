Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1881B4186CE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 08:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhIZG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhIZG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 02:57:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BA8C061575
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 23:55:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so10752164pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 23:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u8dwdasDMIbDsJqPa5ttmn9bjefExMCA1hLofRY28s8=;
        b=uNBD+cs0OHhTfWt3inrISgxHjx4FUqyGUUX6ggudTlz4ZgILC2d8Y+tQ95yJfezkOF
         9TZKTKwZ4kVxvCNrcX1QvNtynJBbhkBOREnIr9LmU1dlnbM3jHJ+ufvqg+9nNRFzDOUH
         DFKo+QfABZ0DiQbBGDnBUpC0LlSVS5YUzf5Bpb9yWzhhdAylEWBIkjiGtErsftUdOYgG
         W8Wgdhcq1dj2AqAzBCUHlDqKNrSSvI+CioTnksss93kiHdLInBwZ520l4dLnOCJvNL9E
         0RxhxRkERFk+yGdnfPha8+lk67+/wdS+po8jGjd8wbhGM17EmsugCsir7C6DA/rdZYBx
         SRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u8dwdasDMIbDsJqPa5ttmn9bjefExMCA1hLofRY28s8=;
        b=sKZMgAYvHuBblLoYkBA60xSxP0i29j8aSpfOcsZXgtTlZxwuSoSe6VFRb+zoAWYItj
         9mxnEA9Omu8Q5c+rRlNkDozDmtNJEEzWvbG9+NfWwKa8qE/dncNBcMcogL8NtlgVW/DG
         KgNW8Iqnu5y6PG79vXdVGdbnc8wjD8J1Z9G0sNnAmcewl3ZBs9ZbNDP/AX2OQZW7E/Bj
         EfqYaPcMXoqSjU0/9JAzL4rG5E9ps/NA9+u2kE/OKeld8nFfR8u2afh2URlANuM45/7p
         VHCnsqE9NqPXSNLwqPcvK6gN71S6iqBAf6gtckJjPb4/J09tjRMDYV1JLaPr7jznKVMR
         jjcg==
X-Gm-Message-State: AOAM532VuP2KHrD9jKYSjdIaeJwJuVhBSNVttygCdHKcdOIl/pYl9u15
        BntHgZy4hzj2Sik691Tq+y3d8Q==
X-Google-Smtp-Source: ABdhPJyX97SDoA8dsUAa/TKwy7G+hx3vx6meOkgiUiof2Do7odaJZ+f9Vz108L7rPWB6okRQUZyJDw==
X-Received: by 2002:a17:902:a702:b029:12b:aa0f:d553 with SMTP id w2-20020a170902a702b029012baa0fd553mr16602901plq.3.1632639338516;
        Sat, 25 Sep 2021 23:55:38 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id i19sm13214021pfo.101.2021.09.25.23.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 23:55:38 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] net: ipa: Declare IPA firmware with MODULE_FIRMWARE()
Date:   Sun, 26 Sep 2021 14:55:29 +0800
Message-Id: <20210926065529.25956-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare IPA firmware with MODULE_FIRMWARE(), so that initramfs tools can
build the firmware into initramfs image or warn on missing of the
firmware.

W: Possible missing firmware /lib/firmware/ipa_fws.mdt for module ipa

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index cdfa98a76e1f..264bebc78d1e 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -545,6 +545,8 @@ static int ipa_firmware_load(struct device *dev)
 	return ret;
 }
 
+MODULE_FIRMWARE(IPA_FW_PATH_DEFAULT);
+
 static const struct of_device_id ipa_match[] = {
 	{
 		.compatible	= "qcom,msm8998-ipa",
-- 
2.17.1

