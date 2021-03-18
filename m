Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28E340DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCRS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbhCRS7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:59:34 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6410DC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:59:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z3so3439296ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CeBUNZ1mpGDSE2L/zhj97MVN1l+b46CMqsA3MUPevg=;
        b=A3OjNBx6DWKtklwCeHq5wn6PtDUA8bC37nuDqDxBD3KLvXeUSyy4z2KA0n/bFOFwx+
         NxItLs6oARcIDI/JGRG5rvBrOdOmi4BnNA8u0erotvTg/MT0FkR7uwPqwpg+kxOs/J4o
         nrE/wluE2PJKJPG9P/8uedWOamaUqFXe6xvPCRSXp/u5YqrLxbBved4iQyNQfvDyuE2X
         e81CAxlxzZ0bz/HgyIx6tADkPj6u2hN0YQ5GrY5Sf7E3znFXNH8OA9FwtODPHFihbqCy
         XIgvV2TtTi/CIab36yhe/jmur/7mam2yLMVm5VpgEORRckJNw3Is9o1jKWsoFx++kgUB
         6kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CeBUNZ1mpGDSE2L/zhj97MVN1l+b46CMqsA3MUPevg=;
        b=cZ0VCyf7EGn+q6UlcG042u3xBbl8ih7PAv9ky5oUDzNlocFU8Un/e0LllkzQvCN1fQ
         Ija6F8/1xBoKqi8jM6behn+EYwe8c+jPiuvK2pTvOKEvzvAOOgIja60zNcrlVO/chBhU
         u11sPTXQ4Vryl2f0XXmAgIBO6u0wJIS48jhV+U/6rQlctUPAvOtdUM/RsZupFTvpS9Y0
         tgbuyIxcwv+76OkP5u8+TjJCMQ/ES2jPEbHUcV0PZXXj6xjSCQsqZonPbGd7RgcClA2a
         UOheDUCyXjeMbNgb7vZfMCzz2JGeVAup9G8dqni6gMNoVwelPFdiJUfQA/naCB1lm6ok
         5wOw==
X-Gm-Message-State: AOAM533zY3SoYs4olXmsZpBX95EJhtRtOOJejn4NklULl9g9o8Al5er1
        jZ9WyAHxgCA+rvph7xvsqHwMYA==
X-Google-Smtp-Source: ABdhPJxVHn6MiT7bbrlnoxm7Dvm3g5+aAodpk5PPaEZL8p44LKJqCphiJqQZoK04EL1XHBYMrmAITA==
X-Received: by 2002:a05:6638:343:: with SMTP id x3mr8319840jap.44.1616093973753;
        Thu, 18 Mar 2021 11:59:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k7sm770359ils.35.2021.03.18.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 11:59:33 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/4] net: ipa: support 32-bit targets
Date:   Thu, 18 Mar 2021 13:59:26 -0500
Message-Id: <20210318185930.891260-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently a configuration dependency that restricts IPA to
be supported only on 64-bit machines.  There are only a few things
that really require that, and those are fixed in this series.  The
last patch in the series removes the CONFIG_64BIT build dependency
for IPA.

Version 2 of this series uses upper_32_bits() rather than creating
a new function to extract bits out of a DMA address.  Version 3 of
uses lower_32_bits() as well.

					-Alex


Alex Elder (4):
  net: ipa: fix assumptions about DMA address size
  net: ipa: use upper_32_bits()
  net: ipa: fix table alignment requirement
  net: ipa: relax 64-bit build requirement

 drivers/net/ipa/Kconfig     |  2 +-
 drivers/net/ipa/gsi.c       | 14 ++++++--------
 drivers/net/ipa/ipa_main.c  | 10 ++++++++--
 drivers/net/ipa/ipa_table.c | 34 ++++++++++++++++++++--------------
 4 files changed, 35 insertions(+), 25 deletions(-)

-- 
2.27.0

