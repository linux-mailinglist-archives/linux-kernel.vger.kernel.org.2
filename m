Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515F333C612
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhCOSuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhCOSte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:49:34 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199DC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:49:34 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id c10so10349042ilo.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkE3LmGUj01YPH3BPs1/nEBfeLQdWBdBqpXnFwRgcR4=;
        b=bom4lMmQJrp5VcTVXyEm9MMJ4NeJCRL6bqdHhGXRV8mep6rnDF0QdfZZzpn1mM50H6
         qvHHmBXE2mqaHSkdqifKS546EMOYBAnUJ5FhxHltL83Pdxc5JCc4ZUiIFrxjZNQeQ5bV
         Okf91VbuTCBZJ6I4UYIxfXiwnzNKEfNANWfqyKPqkk1ZaDlOHyfibNOZBNFIcDjjQyTE
         qtTU/ERepKCjDksL8h+aY++zNqwez/tAA1gpPrf09QeUe08+i+ryBizTgRUUSBnQVqoD
         nkP3sOy/HYJ4nzBS01d7XTLT+SqI0ubN7ayRTRPjYdv02YaufxlII17g5KoZztlN2IHG
         M3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkE3LmGUj01YPH3BPs1/nEBfeLQdWBdBqpXnFwRgcR4=;
        b=kUAoJwEUSDp8yVh8bVOFowPXktiT8K4DO12bicwEuOC32OhgpqWfNll8IN4sMbU+Ho
         ZPYg1pX5GtdMnNzxNVwBQKuTwRmiWizWl1r3+u02Ncn6OiEVSqNP7wPSMQ2cCB2+ckMm
         lVmu6KaSSL00/JaeuS+ltAve92N1V6flxCcwhG7HpsqmDxbrEcT1pLvE6b3s2Rr0ZoKw
         XKlTAMlk8iM9gNmMIziluYEcQ7yWCIhhq18gCRfiY/xZOqVyiSYnGIpSiKdBUXAVX2Il
         KwDF8Q/G/See+YbXYl9XnCgN1iLtFxO9HNa30fYbfhkyJPaiZbPWHtF7Y1ni4MWBRIYz
         QcKA==
X-Gm-Message-State: AOAM533S7DBWWSi3c6/YZVmPa19vGl34e/rOYuYsgUq4vhytxkm6iFCm
        3JgVcr1RFNa9Hys5s0lF9/N/GQ==
X-Google-Smtp-Source: ABdhPJxoEqSlw3wLBbuIXMxokGl4pSHO7F63WKkv8o6e2lAwtEG+kIowll9PL/c1tM70omcDWEfwMQ==
X-Received: by 2002:a05:6e02:ee1:: with SMTP id j1mr765610ilk.179.1615834173956;
        Mon, 15 Mar 2021 11:49:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a5sm8212162ilk.14.2021.03.15.11.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:49:33 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        David.Laight@ACULAB.COM, olteanv@gmail.com,
        alexander.duyck@gmail.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Duyck <alexanderduyck@fb.com>
Subject: [PATCH net-next v5 1/6] net: qualcomm: rmnet: mark trailer field endianness
Date:   Mon, 15 Mar 2021 13:49:23 -0500
Message-Id: <20210315184928.2913264-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315184928.2913264-1-elder@linaro.org>
References: <20210315184928.2913264-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields in the checksum trailer structure used for QMAP protocol
RX packets are all big-endian format, so define them that way.

It turns out these fields are never actually used by the RMNet code.
The start offset is always assumed to be zero, and the length is
taken from the other packet headers.  So making these fields
explicitly big endian has no effect on the behavior of the code.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 include/linux/if_rmnet.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
index 9661416a9bb47..8c7845baf3837 100644
--- a/include/linux/if_rmnet.h
+++ b/include/linux/if_rmnet.h
@@ -32,8 +32,8 @@ struct rmnet_map_dl_csum_trailer {
 #else
 #error	"Please fix <asm/byteorder.h>"
 #endif
-	u16 csum_start_offset;
-	u16 csum_length;
+	__be16 csum_start_offset;
+	__be16 csum_length;
 	__be16 csum_value;
 } __aligned(1);
 
-- 
2.27.0

