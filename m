Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1757545CD74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhKXTre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKXTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:47:31 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C418C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:44:21 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 14so4684224ioe.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVY0xbbNHGxOoTnm29wKJKABb+CBuNHDgBMwoMorQ2g=;
        b=IDGj76q2VEC2WdGF9jr62e6uYamT9DHKLSk8HUTszRtO/fvegN5T6t6alvqlzZGJLv
         k3eGKKCfDj9MuJiowcN0nzQlexrBpkv3mnYfkn8V2jnXpFduH1yAk2yw1DpF2XPOVRyC
         YVqa3ZgzhcdsnD80Lec3EX2uFl/RlaS/d8IAYT0+EXaCmCaBkmsGVTbkmqLP5RbpGhgI
         7jZjizXNHUh5Pz0nr/U2mz5oc9JJwhi5PJKCs/Gmzh7fgqfKUTahpZAiw6Zhf0pbyBy5
         g1lD3l5cTvfAwQH2a0xMhPZBQNIbftQCc6hxWho0K5WYUNdfwnxi5UqhLra0Incfibt5
         rhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVY0xbbNHGxOoTnm29wKJKABb+CBuNHDgBMwoMorQ2g=;
        b=mTjIpujgDR7V5BhaT2OlK1JBlhqgihhD7VO9HehsDHavNIpP9E6cnFzyMMAXU0udN4
         vYbECHyoQf3fdkfX9a/brpyXJEEbeTuYL4Rl5w3Tz34S5DMCUIdWnI+z7/ctALRLS/jI
         Y0iRUSllK1Z+XTNJCfKxYxCNGu5fluyp2KNdM6irOp0d5snKYvTJ5pcrvafa/6ZZuTXH
         8XDfp1++Zrnmgb0UH8hJ+hamkbfNo5VE2nbL7Kss1xrINsqQme0d/Qwv7XDYQl5aXKdW
         i+5aqiCm7WpK7wAnNhYEUxJq90IlEvNVi8udQkKbpbvic0aEJlZbmmB51y9tUG12Regg
         DeDw==
X-Gm-Message-State: AOAM531b61S4rodlozOnOUGNEBS8gSD18Ksuwd/hiLKKBeTSiRgq7Vby
        5HEC3unWISzw1pgsnweNi2LQQR2msc5gUDcS
X-Google-Smtp-Source: ABdhPJzSvYeWShlZpzbONR090fnXMSi5s3F8BjV1BxpHOETC4EcWCjEhxVc0xZ1ZcHQs4HImdxpapQ==
X-Received: by 2002:a05:6638:12d6:: with SMTP id v22mr20175309jas.6.1637783060762;
        Wed, 24 Nov 2021 11:44:20 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id r14sm490145iov.14.2021.11.24.11.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:44:20 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     pkurapat@codeaurora.org, avuyyuru@codeaurora.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, evgreen@chromium.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: GSI channel flow control
Date:   Wed, 24 Nov 2021 13:44:14 -0600
Message-Id: <20211124194416.707007-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with IPA v4.2, endpoint DELAY mode (which prevents data
transfer on TX endpoints) does not work properly.  To address this,
changes were made to allow underlying GSI channels to be put into
a "flow controlled" state, which achieves a similar objective.
The first patch in this series implements the flow controlled
channel state and the commands used to control it.  It arranges
to use the new mechanism--instead of DELAY mode--for IPA v4.2+.

In IPA v4.11, the notion of GSI channel flow control was enhanced,
and implemented in a slightly different way.  For the most part this
doesn't affect the way the IPA driver uses flow control, but the
second patch adds support for the newer mechanism.

					-Alex

Alex Elder (2):
  net: ipa: introduce channel flow control
  net: ipa: support enhanced channel flow control

 drivers/net/ipa/gsi.c          | 70 ++++++++++++++++++++++++++--------
 drivers/net/ipa/gsi.h          | 10 +++++
 drivers/net/ipa/gsi_reg.h      |  4 ++
 drivers/net/ipa/ipa_endpoint.c | 50 ++++++++++++++----------
 4 files changed, 99 insertions(+), 35 deletions(-)

-- 
2.32.0

