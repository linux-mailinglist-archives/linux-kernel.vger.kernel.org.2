Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E99B444ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhKDG3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhKDG3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:29:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A71C06127A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:26:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z65-20020a256544000000b005c21b35717dso7398355ybb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4+lptrSez3O7I9lFhrCLmPI8ZR+QIBXMWJtPqo31Kho=;
        b=SN7IJCouH2K1RaDvT7DpS9fRd1EKpz2D+KwHt5kKFYQn8GJJleawLFP+9rQ7724awt
         MsANgzCrp8apBGjUpdSLvFUtzmPevdsMwOZK4d48DfaRvnuf9LPUrv1xF8+uyCrhiTLr
         U7fwK828KxzzlQeUbvAupQ0LqzGhmUQSAltbZrlEl0+uZ/Xz9/uYF4uQ3sB99UPXUTH0
         0FqBsFcgII2ZEdZfDbY5VDongWQnRMYf6uhyflx1BT0h/UWoH9aRHTZ1RkbDm9i7vA/U
         Fko9dxVExFxxc9rNalm8FlJnzXBnfe3jbzxaXX43FRxDtxcU2IItkAvLNAjoLPALroDt
         scWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4+lptrSez3O7I9lFhrCLmPI8ZR+QIBXMWJtPqo31Kho=;
        b=vd3pDggOrLuID25spiQojDouJLkUjmKp58FUj2yCx/scEgTzOyVm5zQz0GXrTaU5R2
         AxFJA/CrnfJrGc3lyYBFGcapmml1vA+3KB6zGrHlmEhhGrT/TRUvme2wEhDTj0pSljSM
         6Jeqe+PKDZYQOfeD12kKT1TlOJ5RJaNOYePRy56B21dKd3baIas6aIR1FCggPVvyrcz8
         cBjWuE5gdVAbTDInHxDX2YdpOvuW4C6O0PiTnmWjfJHgsp6fYijlmxLiiQXyDEYaAvuX
         rzCTEETDDSI6pRHa978ew7ZaeqFoRAfJGYECh5+vPgXWmrdm5V4nPwHsDji2ECE6UQG6
         st2A==
X-Gm-Message-State: AOAM530pvQEsaJ/8wvzaAWwjFOlEgOE+2dNUUYC93v8ZAleR6kUD9uB2
        nz6Mt7NGSLFLKRYvxHds7G7I/r/Y6SY0ky+HlYU=
X-Google-Smtp-Source: ABdhPJwTHX0W7XivKhw5GZhwmnwULoRpTPIU8SfZWXMRJHpAurMGO9os+98teOKiUMv8vlHtXMXy6dNUx75dqiOcjPM=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:b82c:caf0:c403:32cf])
 (user=albertccwang job=sendgmr) by 2002:a25:6c06:: with SMTP id
 h6mr52939921ybc.222.1636007183647; Wed, 03 Nov 2021 23:26:23 -0700 (PDT)
Date:   Thu,  4 Nov 2021 14:26:16 +0800
Message-Id: <20211104062616.948353-1-albertccwang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH] usb: dwc3: gadget: Fix null pointer exception
From:   Albert Wang <albertccwang@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Albert Wang <albertccwang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the endpoint interrupt functions
dwc3_gadget_endpoint_transfer_in_progress() and
dwc3_gadget_endpoint_trbs_complete() will dereference the endpoint
descriptor. But it could be cleared in __dwc3_gadget_ep_disable()
when accessory disconnected. So we need to check whether it is null
or not before dereferencing it.

Signed-off-by: Albert Wang <albertccwang@google.com>
---
 drivers/usb/dwc3/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 23de2a5a40d6..83c7344888fd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3252,6 +3252,9 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	struct dwc3		*dwc = dep->dwc;
 	bool			no_started_trb = true;
 
+	if (!dep->endpoint.desc)
+		return no_started_trb;
+
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
@@ -3299,6 +3302,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 {
 	int status = 0;
 
+	if (!dep->endpoint.desc)
+		return;
+
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 		dwc3_gadget_endpoint_frame_from_event(dep, event);
 
-- 
2.33.1.1089.g2158813163f-goog

