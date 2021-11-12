Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D1C44EF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhKLWZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKLWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:25:06 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E66C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:22:15 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id l8so10393806ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oofobncB6zcDchp95iNx9ee8iwZFnsC9uA/95m01SxI=;
        b=hXu0m+jbprrwHVbmDRDLPxR4jP2UlcGtxLQpE/Ln1FChq6mlHV617YbAP8Bm0FopvB
         A3JiDXcRWUJKdaKWMIFCwYLk7LXR4pIb3UCTzIxy2OV1N/tCViQQVPfun7qOjPFv2/Wf
         yJfCavAVsNTaujm90sEXo1izfGso3aGZpU/Jx2lmjGOf61Sy8YZDjp7rVjluj45nTpAB
         8UGB9BPO9TV7pW0gRyUylsEEeEt8edy9stDhXpdFy+S0ZnrcJjD9VGIRR13yGKttBqr5
         99SvmwKkysMxqbYROOoBEbmou/qG9XP7uzhMFwM7OVVKfG2bXSpdTHJYBrVWQ4H7VuqQ
         tW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oofobncB6zcDchp95iNx9ee8iwZFnsC9uA/95m01SxI=;
        b=3ero5ysI5xvdvAVDYpPCq3tmjgIUCysoX7rbAOKTuG8Ia34+X7FFRYDBfLaMia3nXd
         U5aSZHPQ0/JHjAp2V+ubAt7Ka7KpXsEklJO9j/mbsI0LujXlDBq0qG/POErMJ9lNVe1F
         wmV6sXRsTZnluO0UBxBbEbmcblZbCF6bNu4AygvbLA2cr0qnmxP0Co+JE+jiqxu/btZL
         15oLX1vWg6v2YQhzpTgP9ac7ywydCZrEvQUnXyLWb6RXMhabxTbucL2pWLsJLevTxfn4
         Yuq+7UidLjAuhuBq2btfygV5NW1lEwQzBAP3XkQNfvjOeMheqoBnj/RtqsOo2g6grln2
         S6Xw==
X-Gm-Message-State: AOAM531boIot8w04X3nASTihCdj9IfGnvWDDiuKQG3Qt7X6szva/h6i1
        X6GzOQ1HWVZhD7PGbCbu2NfA0Q==
X-Google-Smtp-Source: ABdhPJyGS73m8Hz5pzCLotdbGUnMtKBTv03BwkoPYtvgyRSPAXk89ni7TaDvw59bF0N/dsjtFVCZfQ==
X-Received: by 2002:a05:6e02:198b:: with SMTP id g11mr3582144ilf.288.1636755734995;
        Fri, 12 Nov 2021 14:22:14 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id y6sm5241117ilu.38.2021.11.12.14.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:22:14 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     pkurapat@codeaurora.org, avuyyuru@codeaurora.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, evgreen@chromium.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: ipa: HOLB register write fixes
Date:   Fri, 12 Nov 2021 16:22:08 -0600
Message-Id: <20211112222210.224057-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series fixes two recently identified bugs related to the
way two registers must be written.  The registers define whether and
when to drop packets if a head-of-line blocking condition is
encountered.  The "enable" (dropping packets) register must be
written twice for newer versions of hardware.  And the timer
register must not be written while dropping is enabled.

					-Alex

Alex Elder (2):
  net: ipa: HOLB register sometimes must be written twice
  net: ipa: disable HOLB drop when updating timer

 drivers/net/ipa/ipa_endpoint.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.32.0

