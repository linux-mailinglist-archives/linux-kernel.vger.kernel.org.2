Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E4B33FB33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhCQWaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhCQW3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:29:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F48DC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:29:51 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v26so238518iox.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlPLbsteYQ546XPJd0ZKu7bGdTiD6IsGwA9GxCJDXFA=;
        b=stSj5RRz9zbueNxXn5jZdxPmF6jF1qr93Dxuc2iFJmafR9bP5MgWXpeZI18ySGWjji
         XYwF5hZdjQUXcskcXtPm0FW50UWGBK0/WsBfe+2y9mjoEIsGgYyTSzpi5/vGcdK41CHM
         p0aJulR04XcHEDccZQsX+TNkKUILiChfZE3m8TYvgcvPsO/sOTyqyKdmD84zmQozbiSo
         2+mtv1GZP3Q0Q1mpHAP/RIHTkZD67bxwmhei5tkGNBgBV+WT7UwC5UE28sY8w8+YYQvd
         zrlV8Sx9+jjghjitXZ3DkVmHO3eb/BG4i+nleXX6ZGXq758gqCtGVLq+5G0yxVY94t94
         SD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlPLbsteYQ546XPJd0ZKu7bGdTiD6IsGwA9GxCJDXFA=;
        b=TKSd5bi7mseyiDUU0VKLCxYG0dlYNePpYraijKEcEChhCuhYKKeqY6V6KolUbK09AC
         GQxb0uojVr55efYMT46sYKTMYxZz/LqsYcvE18X3Nhb7reZqN5jT5TULLUfNqf1TXpNy
         CQHFgBVg5ckPgzrH59QuD5eU2PfyjdcKSwTIqpvSYLNMLkUFFzppSp3ePpkqYLGdqglK
         YYsPAkGP/74R657CMI1p8A2QKZ8COFOnR2v4bCa3ZwfZGjQu2YLDVU3xZyPBH5QPql2X
         M+CZHmNpfjAct8bMKgbHUDW4uLcfLQmS8FxZxR96JZIDckQlSHUMy0Dn4uspTHF0zuI4
         KBJw==
X-Gm-Message-State: AOAM532Y3bmmIdaPkpdf6oZEopXHx8h+RGHAi7jnD/GCBSqzgHK7TRwk
        ISlO5IIP4R9qhEEpbAwK+EUl2O/WCe4y2gW+
X-Google-Smtp-Source: ABdhPJxOMHcHOacHU+9TOgcsW0ME2IKvddaFruMUGe5IvNFFZiOcacqW39YgJK/Md9rueGXQzAi/jA==
X-Received: by 2002:a05:6602:228f:: with SMTP id d15mr7804723iod.141.1616020190565;
        Wed, 17 Mar 2021 15:29:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f3sm176405ilk.74.2021.03.17.15.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 15:29:50 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: ipa: support 32-bit targets
Date:   Wed, 17 Mar 2021 17:29:42 -0500
Message-Id: <20210317222946.118125-1-elder@linaro.org>
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

					-Alex

Alex Elder (4):
  net: ipa: fix assumptions about DMA address size
  net: ipa: introduce dma_addr_high32()
  net: ipa: fix table alignment requirement
  net: ipa: relax 64-bit build requirement

 drivers/net/ipa/Kconfig     |  2 +-
 drivers/net/ipa/gsi.c       | 14 ++++++++++++--
 drivers/net/ipa/ipa_main.c  | 10 ++++++++--
 drivers/net/ipa/ipa_table.c | 34 ++++++++++++++++++++--------------
 4 files changed, 41 insertions(+), 19 deletions(-)

-- 
2.27.0

