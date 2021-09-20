Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD215411F76
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348222AbhITRlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 13:41:31 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49968
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352312AbhITRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 13:39:12 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0DCDB3F31B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632159463;
        bh=CQtfdbe1O3s9BEshGw98z5OXNdM0i7hCrZwLtn3F8cg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=tj3H3NE27M5xnNRzk0LyQCsuGt+xD7dfDu1fAHiOJJSFvg2V21K2IXCy9ZC6DQWxW
         K8b1Mb0huZF4qZJqRawpEpDAYI8ulB4yvnnFFqST4gfEL1T+Vm1a3v9kWtv78xUZlU
         59WHWSIXHvae9jTAIgNQ6KvU7i6+LCnU/c7ncWE4lAqxBsLnmxk6jX7TcDUqY0EVml
         cvBBuT3Wc+g5TOwv2KpSUzDbFab8u1y4z8DorlS84jxsxD8Ny2IttxAei/hNJuP//b
         dufG1MgRzePSgKqjsbowsxdnZnOvRQlPBdXgaqahR21/pcxXKhxEdpxoUakVcKqtWv
         27eTBVrFk+wCA==
Received: by mail-pj1-f72.google.com with SMTP id v10-20020a17090ac90a00b0019936bc24c7so356209pjt.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQtfdbe1O3s9BEshGw98z5OXNdM0i7hCrZwLtn3F8cg=;
        b=KhvJuze5WEP/O0zIVD83aPLmVn4wccxNGjPpV5pYzS5Vs6ZS9M2ijT7J0jsjFJCjIP
         pzIAa6qW6om423gGt2Ids8yDArzqBIvwjCIcdbZTdwVIea9rBIlZryvCRp81r876Igel
         tJukNjoWTl5GL58zCDpt/fLwy6mEuej1m/vWmS/Q629d5gdVTHrz80cPiI+TUg+0jl2j
         4/s6pDtRrrRkWnDDaapnFoOJ+GHI/aYNMGPeRLhksLGYAN6g7wuSTe1JlTQ4h1Wxfzen
         7S0UaNro6Aag/p1H2HkvjUVv/EQV0jbOLyFCI9+7YmxWoH+8zOTQqarteb/fXR1SheRw
         RxQA==
X-Gm-Message-State: AOAM532d+UGAQLSGlMmDCQzPrdZugFoXcXVUWZfjfCk6knc/dp86uu9A
        LIn/omhglDC3wazf1QaVdhbk5OxKRbHSpOM374hNgar3VOe6go14hAJrvwXCNK2Hjg0juJ5Jk7C
        ASp4EIApJ7isYm0m4iLxVMDKnM943Yylx42AfsbbrDw==
X-Received: by 2002:a65:5845:: with SMTP id s5mr24080729pgr.227.1632159461666;
        Mon, 20 Sep 2021 10:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCnJ9SLA7DSqx8gP32eeM3/WHlWuJYoH5BlFMtXi3QlDixSt/zezxCCbHLKKlROcKaXGFBKQ==
X-Received: by 2002:a65:5845:: with SMTP id s5mr24080711pgr.227.1632159461484;
        Mon, 20 Sep 2021 10:37:41 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id o12sm9763848pgn.33.2021.09.20.10.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:37:41 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-iio@vger.kernel.org
Cc:     tim.gardner@canonical.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2][next] counter: Add default statement to switch() in quad8_function_read()
Date:   Mon, 20 Sep 2021 11:37:37 -0600
Message-Id: <20210920173737.21445-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Add the correct Cc's

Coverity complains of a possible use of an uninitialized variable
in quad8_action_read().

CID 119643 (#1 of 1): Uninitialized scalar variable (UNINIT)
4. uninit_use: Using uninitialized value function.
346        switch (function) {

The call to quad8_function_read() could theoretically return without
assigning a value to '*function', thus causing the use of an
ininitialized variable 'function' in quad8_action_read().

Fix this by adding a default statement to the switch in
quad8_function_read() and returning an error.

Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/counter/104-quad-8.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index c587f295d720..3a69d35b82ea 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -215,6 +215,8 @@ static int quad8_function_read(struct counter_device *counter,
 		case 2:
 			*function = COUNTER_FUNCTION_QUADRATURE_X4;
 			break;
+		default:
+			return -1;
 		}
 	else
 		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
-- 
2.33.0

