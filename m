Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D13AF9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhFUXzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhFUXzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:55:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A8DC061760
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:53:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b3so1792655plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hap5rrkK42QaF5phRIGliKevrZCv+fxjBjTLJ/pE7w=;
        b=SaTkql2WXjMyJO6whWG9JyCnglGg6faOh30E8Lhu9SgvFGWDGvulc9SplCY+Wx4hJB
         DCYHUv1GwmTka12BMkZes72rKui1uDoY0LzvsieTa2ZmIrnL4mVCj5E9Nvn0LnsgSd9a
         klTw+FraV7UJBMyr3e/hUg0h10KaCLpg93/bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hap5rrkK42QaF5phRIGliKevrZCv+fxjBjTLJ/pE7w=;
        b=FDYNczijhfiUYK/e9CiNEFW/WStlABAycIClIFRRCxWubWWr4BMfW9BtFAtaA025Wj
         JUdin1y3YTJFCCDS32xlrbWlvi6GHC5egkd4iFN60bXP7I7S5xur21VZGIQ0pS2Wbjla
         xxF+UA0w7ememrQpw6rrVyLG4jAiZlmX09TstVEhS6LkixuuB95mIuvOgia9rYX6wxqx
         gEO5qAgBm2opKCfMVkMT9xHUp8m9nzGF3xRT6C7KZgephOdKfQXBYpS3pF3DIXjL8Te2
         83cPd9MpaPQETbh6wq48eRfPiD/nGl9A0m1+DbAILFxZSlbvZUPxbXUZw7qAJYVd9vMl
         AiPA==
X-Gm-Message-State: AOAM533qD660mkqHiodrAsrxQqptLWftM7ujogp2jG6vb0Ubtne54E+b
        Bc/2TXuyDtcFRSc47PlsuhcZUw==
X-Google-Smtp-Source: ABdhPJwXH5vi0Xs9ZIXNanUJNzJ2JIBdTlSTrxUumm5ORFc6vCcYGBtgB9XO+d3fthNCPEvr8XR/lA==
X-Received: by 2002:a17:90a:6be6:: with SMTP id w93mr598015pjj.171.1624319595138;
        Mon, 21 Jun 2021 16:53:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
        by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:53:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        saiprakash.ranjan@codeaurora.org, linux-mmc@vger.kernel.org,
        vbadigan@codeaurora.org, rajatja@google.com, saravanak@google.com,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] PCI: Indicate that we want to force strict DMA for untrusted devices
Date:   Mon, 21 Jun 2021 16:52:45 -0700
Message-Id: <20210621165230.3.I7accc008905590bb2b46f40f91a4aeda5b378007@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the generic IOMMU framework reaches into the PCIe device
to check the "untrusted" state and uses this information to figure out
if it should be running the IOMMU in strict or non-strict mode. Let's
instead set the new boolean in "struct device" to indicate when we
want forced strictness.

NOTE: we still continue to set the "untrusted" bit in PCIe since that
apparently is used for more than just IOMMU strictness. It probably
makes sense for a later patchset to clarify all of the other needs we
have for "untrusted" PCIe devices (perhaps add more booleans into the
"struct device") so we can fully eliminate the need for the IOMMU
framework to reach into a PCIe device.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/pci/probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 275204646c68..8d81f0fb3e50 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1572,8 +1572,10 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
+	if (parent && (parent->untrusted || parent->external_facing)) {
 		dev->untrusted = true;
+		dev->dev.force_strict_iommu = true;
+	}
 }
 
 /**
-- 
2.32.0.288.g62a8d224e6-goog

