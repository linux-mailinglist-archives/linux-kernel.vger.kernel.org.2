Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0510033286E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCIOWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCIOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:21:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C3CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:21:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n22so2090156wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uuunhz4NVbgt9DS/9Uu7zQbhYemZOp1upoBNYz2qHKM=;
        b=zE6Oke1uYpEL93BU1SzCXg4rAN3Hbt7L8fLgcvD3MoC2yQ58TRyGXFFbiOkBxIZMYK
         E/IrFrBh1engrQznWZHdrezeHHDnunIBi6WkBvB5sLeKeY9GsKAsbnmTQoW7SRKlzLoO
         EHfyKyrTJBFsHLNAmAVVWJwtvRNQdDfQcEy7zzSfiZmMIYqzPuJuq7ez1qGK3nNoZKWY
         dnugJnLkYjyf6/RhO3Z3+8J8AKKBaMNe0TfXtw1TYX1GhDHAzzG59cChNNd5n8jHvYaH
         aARBI/SL5ofCq4y7xC7+jVZcGwPsW8gkGra8CWb5jIa61WOrklB7h/LldzKu3vlRlrU2
         Je5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uuunhz4NVbgt9DS/9Uu7zQbhYemZOp1upoBNYz2qHKM=;
        b=qNFoQLxoPUQw54SUJBvnpN56/SQ9NkSTavomVJB+6WIWMGj0WRbSShXYb1mc8MoeYJ
         f8feEgcoLcPsPRYB1nNQLAvWRTpa/3SLftMkrYQ7g+oxHQi6hH/yXfSdP7+GoGahfJCq
         jHgSn8u42BKuJLQrNXp0BYn6cWLRpuP5UIKV3RQeyHs1FFvgeOODlr961Y3DT3454Y0K
         B6pscuFn/O7BEBpgURoxjIkT+8k202Dw9Usc5GRTvRs8e47dHPzUgiwtO+JezzIrr55u
         tVu/IFRFs+vLkwpTHfohDYRQx0ftQyyMLJ8X2q4A/LzofYV+RVCJ/k8c+YFgvWWgoUks
         hFuA==
X-Gm-Message-State: AOAM533MFfkr0DCGrYIHnuk/hFTV2Sog3gXtDBU32hYYGSKQUPwmoHuz
        Oc52vprH4tQXkyMnnusTJEGJ9Q==
X-Google-Smtp-Source: ABdhPJzpStRN37EUxIxXe8L6OZuLIdr6qJSH8rCEnhhSFX+L7iYjHQbbx1WqeoUTXNoaAZdfuYaDRg==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr4405267wmb.134.1615299704651;
        Tue, 09 Mar 2021 06:21:44 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id j14sm22265123wrw.69.2021.03.09.06.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:21:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, amit.pundir@linaro.org,
        bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/3] ASoC: sdm845: array out of bound issues
Date:   Tue,  9 Mar 2021 14:21:26 +0000
Message-Id: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During testing John Stultz and Amit reported few array our bound issues
after enabling bound sanitizer

This patch series attempts to fix those!

changes since v1:
	- make sure the wcd is not de-referenced without intialization

Srinivas Kandagatla (3):
  ASoC: qcom: sdm845: Fix array out of bounds access
  ASoC: qcom: sdm845: Fix array out of range on rx slim channels
  ASoC: codecs: wcd934x: add a sanity check in set channel map

 sound/soc/codecs/wcd934x.c | 6 ++++++
 sound/soc/qcom/sdm845.c    | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.21.0

