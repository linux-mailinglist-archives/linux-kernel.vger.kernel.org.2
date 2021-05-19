Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6EB38944A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355464AbhESRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhESRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:03:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF4C061761
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:02:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q5so14779925wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GbhOm1lXC1PstzpfY9MX2mKhRg7fjTmm4mMZicIr7gI=;
        b=TdvzMycRkiHyUf6eIw0R9u4l2tciZ/wkB0+oFTWvaGpg12nfK0Z5fc8jXkRHkLb22n
         /N985mQ4z+PkSXA0E0afppp/UVemowULrfQSclSCVhxjcI+cmremSIfcwEGU9jBYtG3y
         FQv5Q3xMHOBUQCjhrVDfogbmxIoIwKBzuU79Hm6DkdeG8orRIGBr0VvxJl/Y11Z5X7u1
         NTeGGjUmKEkMmoiv3NzLwolTqyPCD/slii2TdoAlY7bRt1WPmY24TeaKsJGQd9yQIZWF
         CJN5/Fbvx/nAXVVnwtykSK//C03rx68CR9CNbf/sGPFBW2/rdmxfrOgyhwa5MR0i5yd/
         9gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GbhOm1lXC1PstzpfY9MX2mKhRg7fjTmm4mMZicIr7gI=;
        b=eIs871WA89zUhp6xHaaUXaG0YVhMD1EV024iSVrezyw98cTIIktf2ot+iGg98N31oa
         V+sDvbWrZh3l9blFMSByqtGGzsj3TVdbDhfVoX70Rmkl6CXdPO61FEBqS7M8PzgJDi9U
         2gXTbk/UE2yfBbZ/luQ10GPLRkRB0HqJpB350bRkB9SpvB3pkXFwZPOJEOHG1eeDSima
         q+9Fjkvo+Iq1DZ8hP7G5CmCUw+9zp0Nrh/kI9SG1UNtapy+B9U+WsiamHO72FLTALA/+
         PZ5I6+S3V+PxWpuqrpRbxopxTzq1tn7euWM7y/FJ20EdeuosGyCDxyyAxZssri5NuJei
         WI1g==
X-Gm-Message-State: AOAM5305RaAEYh9Ca3eovVmAYrdK3Li3IeVz14Y45xxcoJsIuAxmSnyv
        8m7umY1nLicVZ6qSo6igPBnqoFlr7pvvVJSJnjQ=
X-Google-Smtp-Source: ABdhPJxps07sVqyP2VIY5CpiZD68Qc4v7iu0Wf/ZrAS1/9xjae5+KT5YntS4cejJogbcsFnD4PP+Lw==
X-Received: by 2002:adf:f14d:: with SMTP id y13mr15781747wro.261.1621443746098;
        Wed, 19 May 2021 10:02:26 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058b850800205e07f10870202e.ipv6.abo.wanadoo.fr. [2a01:cb05:8b85:800:205e:7f1:870:202e])
        by smtp.gmail.com with ESMTPSA id q1sm6390561wmq.48.2021.05.19.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 10:02:25 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: OP-TEE as transport channel for SCMI messages
Date:   Wed, 19 May 2021 19:01:57 +0200
Message-Id: <20210519170158.27586-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210519170158.27586-1-etienne.carriere@linaro.org>
References: <20210519170158.27586-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compatible "linaro,scmi-optee" for SCMI transport channel
based on an OP-TEE service invocation.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 Documentation/devicetree/bindings/arm/arm,scmi.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 667d58e0a659..7658f16b3f35 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -14,10 +14,11 @@ Required properties:
 
 The scmi node with the following properties shall be under the /firmware/ node.
 
-- compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
-- mboxes: List of phandle and mailbox channel specifiers. It should contain
-	  exactly one or two mailboxes, one for transmitting messages("tx")
-	  and another optional for receiving the notifications("rx") if
+- compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports,
+	  or "linaro,scmi-optee" for OP-TEE transport.
+- mboxes: List of phandle and mailbox channel specifiers. When used, it should
+	  contain exactly one or two mailboxes, one for transmitting messages
+	  ("tx") and another optional for receiving the notifications("rx") if
 	  supported.
 - shmem : List of phandle pointing to the shared memory(SHM) area as per
 	  generic mailbox client binding.
-- 
2.17.1

