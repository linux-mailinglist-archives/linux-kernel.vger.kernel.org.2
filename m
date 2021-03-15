Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6F33BFA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhCOPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhCOPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:21:18 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE1EC061763
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:21:16 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id g9so9714402ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrzQhsRc599ph2zuSB7VP6Fml8kkJcZ8OjvvN5VFwSM=;
        b=mOx3t/LV8m8lw+fAqMgEDSFeYFjtJ80xNdotUsL8CQKcHlLxMSHfn1+yiEAQaPC3/d
         y2AKFpPjZqZ/sW0l9sMIX/U7lM2vIobiKYQc3XXFSGWLMpxGJI+Z3Jo56DcY0Ge7q2Hb
         59eMuvail70J81AhVO2qs7ydvFHa4N7tLWSBoX4gsv+aypnJtkDt1vLNkpEyBJl714lp
         g36os3gs9PQ7ElPtSi5hvdC0Ne4IpmKQyzjOcpiOFZ65dIs9DI4FOR1qdxHa43HyDPEp
         /ipPoj4l6Bhrp626PBZ7E0DV/zuyap1AREfNe5+SgX4VljXrIoqe8rJ5ii3ntEK4XVp2
         pULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrzQhsRc599ph2zuSB7VP6Fml8kkJcZ8OjvvN5VFwSM=;
        b=mkRKI2gZW/QqlH6aQ8RjTyHeHLfumOTOorisPlr+0u1cZ2XWXcrUIZJ7LTXKjjZVu4
         HnpzSB37TDYQdToqaL1TnOXAecY86NzMxgUAtkQ8p+ftYFv5/C1B7hycrLN4DaBJkB9E
         xybHEE20aJPYR4A+MQrB9n8ZuBrb599ddcJID3MqijmfV457BKqZtQ3kG01o55o5t6TO
         Lb6R7ohScqVhWJLnqJ1SObFxxiVKp7TfRCFQO2rnN2H8umqVJlvHAhBr+RHbuj4Zj+0c
         r/Zz6sldoncY0Bp/rauEH+cevavuDN48ccyzUQBz/YKHy798SIpxzuWSAS8V+YYBUIB6
         Wang==
X-Gm-Message-State: AOAM5336oCDcEIfGvioKgmfdR8MZRy7qGZWXjaEcbX3dht/eZ1oJa6x8
        wCxWn1B8/xGzvD+Bjr0c1ug4HIP1mCpv7g==
X-Google-Smtp-Source: ABdhPJydighsi2ivW7mHFtTlbTuLGKX5gow+eWRSmC4OMwyyrVsUuI9cm883lqIqStMz9mfUI6wHow==
X-Received: by 2002:a05:6e02:2192:: with SMTP id j18mr99575ila.196.1615821676373;
        Mon, 15 Mar 2021 08:21:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id l17sm8194275ilt.27.2021.03.15.08.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 08:21:16 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: ipa: fix a duplicated tlv_type value
Date:   Mon, 15 Mar 2021 10:21:10 -0500
Message-Id: <20210315152112.1907968-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315152112.1907968-1-elder@linaro.org>
References: <20210315152112.1907968-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the ipa_indication_register_req_ei[] encoding array, the tlv_type
associated with the ipa_mhi_ready_ind field is wrong.  It duplicates
the value used for the data_usage_quota_reached field (0x11) and
should use value 0x12 instead.  Fix this bug.

Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_qmi_msg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_qmi_msg.c b/drivers/net/ipa/ipa_qmi_msg.c
index 73413371e3d3e..e00f829a783f6 100644
--- a/drivers/net/ipa/ipa_qmi_msg.c
+++ b/drivers/net/ipa/ipa_qmi_msg.c
@@ -56,7 +56,7 @@ struct qmi_elem_info ipa_indication_register_req_ei[] = {
 		.elem_size	=
 			sizeof_field(struct ipa_indication_register_req,
 				     ipa_mhi_ready_ind_valid),
-		.tlv_type	= 0x11,
+		.tlv_type	= 0x12,
 		.offset		= offsetof(struct ipa_indication_register_req,
 					   ipa_mhi_ready_ind_valid),
 	},
@@ -66,7 +66,7 @@ struct qmi_elem_info ipa_indication_register_req_ei[] = {
 		.elem_size	=
 			sizeof_field(struct ipa_indication_register_req,
 				     ipa_mhi_ready_ind),
-		.tlv_type	= 0x11,
+		.tlv_type	= 0x12,
 		.offset		= offsetof(struct ipa_indication_register_req,
 					   ipa_mhi_ready_ind),
 	},
-- 
2.27.0

