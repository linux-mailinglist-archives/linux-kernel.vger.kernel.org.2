Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA930B388
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhBAX1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhBAX1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:27:35 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82701C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 15:26:16 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id y17so17350025ili.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZynBD22K6qpzM6Yh76qjCwf3pTBe5alSzNft0NWoIQ=;
        b=NIHr2Aq+gAUuQ+bMAHQM1WU4q2DPkL+sVGYZEN1OnIFVyZkBbEKCpftjUDCAqITBsf
         RP8hEazoRxKh7FvP1o8SlpNPTxBy6gLs6679bosgwNgpv3i8TTC3pooIAHKE9oKojkum
         cFBXvH1eCxC0DiPkT1VIanRe7sM5MHjxq4uDCF7NyZ2TSCxj2GM8yQ0txihq6/KXkJVx
         vxo3QpeG4kZdtFQwVEov7QMseUB2hOvrKJx+VPTTkee3n4r617mJMRxXTjRuXciwGb/P
         MGjISQq3R+SLUKimd2S7k71O0pQ7YLvrNC8DfxltWasAXrpVq0Xc/T2/OzlJLmBywZyM
         YdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZynBD22K6qpzM6Yh76qjCwf3pTBe5alSzNft0NWoIQ=;
        b=oVpOL2gqQFJPV28rYFSgVtJXODY/BAC/oR79SSAYIyi0Xaufb71JAaxKcLxecZa07p
         9lRFoLOH3mklLv8dt8DwEg8e2cqEycgZe04rgutWONT7vh28IM8OnOS63VtSKpdQNSRq
         ckhYulInISaoSCkGgOPsSP0CoT+5mi3dKarNj0cv0+cUOFfhgEp/DOhdVF1IgnGHyfrH
         f8MRoAXcRJZSwNa03CxpjZ++m4UK8Uotc22kXM/LIMYbyJ1dkTbjuj7FzekCmwcC4jfH
         yJtNF9wuNMwONIF2Ux7WKEBQTC7JtAmDePi4925I3omwbJj7Ta76JuBpSCxxFK62jIYS
         8ZRQ==
X-Gm-Message-State: AOAM53210IwV+f7SBv4JyviX8T8I9Z+QLlJBFMYqX/JhMeiw/rzIBzNH
        BpZFeaKf6fGOEgKYzFQsjW2SYg==
X-Google-Smtp-Source: ABdhPJyhNtu8B0+dY6bUUX9WUh982PLYELjLAMiQjTBfhhJZ0zRPvYd86WuP/bSXAB0+F8Ar43wDjQ==
X-Received: by 2002:a05:6e02:1a89:: with SMTP id k9mr13620271ilv.68.1612221975432;
        Mon, 01 Feb 2021 15:26:15 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id v18sm10359588ila.29.2021.02.01.15.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:26:14 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/4] net: ipa: be explicit about endianness
Date:   Mon,  1 Feb 2021 17:26:07 -0600
Message-Id: <20210201232609.3524451-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210201232609.3524451-1-elder@linaro.org>
References: <20210201232609.3524451-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse warns that the assignment of the metadata mask for a QMAP
endpoint in ipa_endpoint_init_hdr_metadata_mask() is a bad
assignment.  We know we want the mask value to be big endian, even
though the value we write is in host byte order.  Use a __force
tag to indicate we really mean it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 9f4be9812a1f3..448d89da1e456 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -588,7 +588,7 @@ static void ipa_endpoint_init_hdr_metadata_mask(struct ipa_endpoint *endpoint)
 
 	/* Note that HDR_ENDIANNESS indicates big endian header fields */
 	if (endpoint->data->qmap)
-		val = cpu_to_be32(IPA_ENDPOINT_QMAP_METADATA_MASK);
+		val = (__force u32)cpu_to_be32(IPA_ENDPOINT_QMAP_METADATA_MASK);
 
 	iowrite32(val, endpoint->ipa->reg_virt + offset);
 }
-- 
2.27.0

