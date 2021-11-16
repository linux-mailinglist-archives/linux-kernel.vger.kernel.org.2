Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171A9453127
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhKPLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbhKPLtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:49:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A93C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:46:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d27so37024111wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOgjjFrTsTReyJ+ncLA3vp4lrNsqwZR5biwiOH5XTuU=;
        b=Op4DzHzLYAINx18qDZSvFuHVMwb3v5wRU/cOvtmFWfVEktLU/1n0NoKGj7rDyhSaFI
         l0qdkclgsFG6MsFXHZ9lOYqaZqSKGBsHt1FZ9bbObmnrEsOs1VkHdv3QZmM5zFZncRtr
         qhmlbjGMXWc7J9zW10yxM9brQtnJdl1SapU/KjKLalYX38Lrfewca2W9wLrlcrmyOQls
         goCX6OnvDLjnwWbKOwbhMuacvhtQ1A/yt3UKXZtE1E4MVUKqW8NDEAped9sG7VQDYi3G
         LH9w98trg6PhD1AVwSSHNU/ap0aS07p12yCZagZOopFxswU9zby2V7Ir88SHdAcl0I+D
         bXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOgjjFrTsTReyJ+ncLA3vp4lrNsqwZR5biwiOH5XTuU=;
        b=0Mvc796aq6gqYRj/gaiSHWea0Y+cdNHRd3Tp2AYKoSS6LmX1xzEBtoP4FmzzA3UrDE
         ahhjdHPC8PcIT4QBpX5FhvD+1GPeXOYiV6vpYfbmpFepRjvyHv9xBVJvfDMvMMtaf+59
         yowI+EXw3RNV+mo9xWhgX8S/gKeeMNw1HaBmjhYySRUpggGk3127OgsY5jDO9qq2908Q
         o2nZqJBph7Mw304JYerol0B5k8S8SSpb5M8ViNLUNi4ZDQKRGNsngJ99WFAYwNPLU2/V
         w3UcdQ80KNOr8dhnWUUm+7wIndpvmgWumpnRMQLtSA26WJpO5YbMpNmW4hvOtFWhkOkP
         ytyg==
X-Gm-Message-State: AOAM533QEgiDain8hVrmXggumnLAlyOSzYhC1ZCeGPopRU6LHNOyKbRi
        A6RDl1xj0VibtgVnkZkQOCFxMOdsLTztdw==
X-Google-Smtp-Source: ABdhPJyBJc6M5rUpEMGkFpHGASmYZWIgaH4UakDKmfqy+mNoVmKxsqa9tHCHxDfsjhIJnTijJIJ9gg==
X-Received: by 2002:a5d:6510:: with SMTP id x16mr8579610wru.2.1637063196211;
        Tue, 16 Nov 2021 03:46:36 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z11sm16934698wrt.58.2021.11.16.03.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:46:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] ASoC: codecs: Qualcomm codecs fixes
Date:   Tue, 16 Nov 2021 11:46:20 +0000
Message-Id: <20211116114623.11891-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, 

We found few issues during runtime pm testing on this codecs.
These 3 patches for wcd938x, wcd934x and lpass-rx-macro should address them.

Thanks,
srini

Srinivas Kandagatla (3):
  ASoC: codecs: wcd938x: fix volatile register range
  ASoC: codecs: wcd934x: return error code correctly from hw_params
  ASoC: codecs: lpass-rx-macro: fix HPHR setting CLSH mask

 sound/soc/codecs/lpass-rx-macro.c | 2 +-
 sound/soc/codecs/wcd934x.c        | 3 +--
 sound/soc/codecs/wcd938x.c        | 3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.21.0

