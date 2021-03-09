Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E765D3322C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhCIKQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhCIKQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:16:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BC8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:16:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo5603749wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h7PtkbsEWdkuJd/mmYpJAYKJMOfm44GbXmX9GIVF+Uo=;
        b=wx8qqAH5D94zcPZhTci5hev6TaMVBRkTx/B9T8R2RCHadUoOcTgCEgY2J/0ylwWSqh
         qFsWCkng5osHQRgET9sguzMMOYiBxrpzSK6F3JiwxBy7Ij+i9n8XSo5sBk8CKhZftY6Z
         a9rwcCh27dXbLnjJflxEBNFjQ816PbAc32fcGC3FNnLaObGcbos7cwL6UtqZ2QB6q1C0
         jUcqcTDRpuZEjg427XPr1YVSq7qDdEB/DE4HXvQkWeiAeuc2YXQc1a27QoaRrTYhB+Wh
         eGbXyW1RkvDfDr4BJODy3d5yiJW1HLuTTcIFYnOIQdHsnQ7p99AbAiUiwUipxZ3sMmM3
         QIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h7PtkbsEWdkuJd/mmYpJAYKJMOfm44GbXmX9GIVF+Uo=;
        b=inyPPLFYlUVFPaDbMNcYrNqfno3SZW3ZnjRi4/zJPGTRm8YEpVrTBOM4SX+8SfBu1C
         9w7GUsyAXAk1uI4ERzlYyERk+54bZnM5rW9wQunYNZax1p1gWkA4rjkbMGjvQRvqC6PK
         7MNFGKZX6/4Q2RfBU8ZzjMSmfbsplfszVPMNcjtLTu8TlBjaR4XAVLs1/sNcbT6GgM4i
         99scZTe48Ali/SSV/ttLALC8PgqBvDCxGwDkpvE39+vnoGpiPheRyUV//dT7Y6h9UDeZ
         shPNTvukhljjDZITw/aDYZeuiAskslrv9MrmT5oWWfJgLQKv/L3NZada1jsKOAVWwqMC
         T0vQ==
X-Gm-Message-State: AOAM530aCWDxP+j2mOyjPl3c1omNjB0QitmpU2mC/D2dNlFOu7qJpRkY
        CuyOGyb4VpAI3towxzHmcPHLpA==
X-Google-Smtp-Source: ABdhPJwyT3j3Xfd3tolLUlZDCHTHVfr30U9H40Y0ozNmW0iEDfz/gVEPVyODJb3UTTeAt6ehMHGJeQ==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr3240872wmj.122.1615284975651;
        Tue, 09 Mar 2021 02:16:15 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r2sm22552248wrt.8.2021.03.09.02.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 02:16:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, amit.pundir@linaro.org,
        bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] ASoC: sdm845: array out of bound issues
Date:   Tue,  9 Mar 2021 10:16:10 +0000
Message-Id: <20210309101613.25995-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During testing John Stultz and Amit reported few array our bound issues
after enabling bound sanitizer

This patch series attempts to fix those!

Srinivas Kandagatla (3):
  ASoC: qcom: sdm845: Fix array out of bounds access
  ASoC: qcom: sdm845: Fix array out of range on rx slim channels
  ASoC: codecs: wcd934x: add a sanity check in set channel map

 sound/soc/codecs/wcd934x.c | 6 ++++++
 sound/soc/qcom/sdm845.c    | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.21.0

