Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87AD36B86A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbhDZR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbhDZR4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:56:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A7DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:56:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so1360706wmn.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5ky3C278fTyj7xzurTFg57gY5CqNWeI5tQJtroGglE=;
        b=hxhNDOS+yXCfKTmokgJ5ZlsmPx0RcbLFa/82e9gLxFOGzyHSTEw9/FIFrKI7qZ9OBN
         FyrlM646/u5pYH6pjPhPXj+d/PS6Cs9ITo9KTY3FzCnZ92Cm9qo5bXht8fB8MvbbDNON
         CtEE3HvZYtw8MYPE8Hzq9KbjcXWfSpKW0Tc2Z8lPY+q+Bq4v4fpJZ2IW/PQyG/U+Bwm1
         P5kh09lPxpBBD1rf4PQq1Lsycc/LkoQdA3fYeWmc38KCmmM6UtClI4uAVYDU+6L3NFdI
         jpJWeCJJtuwNJyHj1DDMarggDO112TZugQ1seVmvH0U/DXU7Xg3hL07dHpNdSy0aTEvS
         pmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5ky3C278fTyj7xzurTFg57gY5CqNWeI5tQJtroGglE=;
        b=tKiD14bPFhG6JSm2L6BfhIwkFy2C7MzuCaRSbRVnQ7tE/zv9Vzpox0EcQ9jOra5qs+
         oxGttJ8JnlxcwEd4N7UX+L/wkIOHsNIY+0FBkTr6IE4ehQRlS5Ox/02yvzOL0GeGOI8j
         +y6Ks7Coz3XfyZZNx1DP+yu0XQNR7/PPG7kj1QO7D0PWWzPyGfcoE/xe6Wa7i0DFW2om
         lZC2iqLxofCYGgmKk4Wez3GT1D3KESYUAVUCQWoH2NM7Ln6x2/jVYuBPiB5ZMmaCMUSR
         zzB9gwBC23dceo3CwmNao+grg89WJh2U8yOQ0fZMH5tk0xdlFh8+OtQlOcX1yy2fEDAl
         rvDg==
X-Gm-Message-State: AOAM531DHEGSvabXzzWXozczZoc05Fa/mOAvRw4JzLqIHMDSEwzxSR7P
        Zjr3pBsSVziND1aINYbDkZAyJQ==
X-Google-Smtp-Source: ABdhPJxOEf5WrroQm4+6ywa4UClWp0/lOaQSNgKwiy7DDgNpk9QkOesL9yO1Ur5kkX5LmPKDQE6LgA==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr231005wml.79.1619459763236;
        Mon, 26 Apr 2021 10:56:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:b76e:7362:77c0:ddc3])
        by smtp.gmail.com with ESMTPSA id l5sm18001806wmh.0.2021.04.26.10.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 10:56:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] mmc: meson-gx: make replace WARN_ONCE with dev_warn_once about scatterlist offset alignment
Date:   Mon, 26 Apr 2021 19:55:58 +0200
Message-Id: <20210426175559.3110575-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=D4BnzQN4yovLOupJGSNrbWTUPYCcxuBJZXJ1F8kaNeI=; m=ygoCLhKf/v/HVpjA/Pa8YJvQeeXyjQkv6fyzRtAwrHw=; p=XuOMdYKhwBPfihg5inLCFiEtpgUiSKXZkxwW0eW2eX0=; g=dafaad0776a887f410e5d3ec6e08cf89118507a5
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmCG/pEACgkQd9zb2sjISdENlBAAgUb Vjq5e1kby6MqtJS5HtnydgaMwvUs/tVSnyZGjwrspH/tuRQo6VtgxCDgW7bG5W2Gp3pnXauXLIzer jXQoBjFRLNt5rtwRg0bZPnBVIkt+8eXUtO57on+PrNCY3K04QL5A9iWYavQGEzWo+fTXzHwU7Kuwa QNNojZU8fL7umEGvgeI/AhIu4/gmYtpQ2EMnumkvoXM/UNBua/bMQb3gDXlHbfsiIhsDA0et/Z/QB OyPpiJnncBU1CvXxQ0g/3bqtZo40MvNb4Gmc1IxSM0cxUS97BLk38nnBFlSF59T7k1iUTAkSjDLLo f44Gmrf79q0nJR4aTbNVuCqeQuU8pWF9xnOn1cuM5aij7tphWCWR6IMxru9VJsptExir7P8cHD6sN noZL8hhK/wUF2lq5jYwTZGQLejK/nP7G40ZyfJTy+lkotMlwd3+PDT69az3no+qweFQu3PQvDJbSW IMXO+V+9OvVXCYKYmgY5Aqyr1rt7sevV6ziOpGb6oQceqBuPDRA41NQdmARoXec1x/k0qTqCykmN6 G+dsLxrbs97zTDf1snjcKBaZPjFUqtaJ4EgqmJ7V3EHvzmyGfpeJJppigVbbDbWq9Y3vRwDepFzf9 C8Sxu3hz0Hmy7CDTDHR/zsRR7L2VgOmvbKg6v7I8cNkT1Jpl4dEdci/x2/2xuDLE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers like ath10k can sometimg give an sg buffer with an offset whose alignment
is not compatible with the Amlogic DMA descriptor engine requirements.

Simply replace with dev_warn_once() to inform user this should be fixed to avoid
degraded performance.

This should be ultimately fixed in ath10k, but since it's only a performance issue
the warning should be removed.

Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b8b771b643cc..1c61f0f24c09 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -258,7 +258,9 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 	for_each_sg(data->sg, sg, data->sg_len, i) {
 		/* check for 8 byte alignment */
 		if (sg->offset % 8) {
-			WARN_ONCE(1, "unaligned scatterlist buffer\n");
+			dev_warn_once(mmc_dev(mmc),
+				      "unaligned sg offset %u, disabling descriptor DMA for transfer\n",
+				      sg->offset);
 			return;
 		}
 	}
-- 
2.25.1

