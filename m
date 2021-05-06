Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9443757B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhEFPlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbhEFPlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:41:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82D8C06124F
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 08:37:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l14so6113108wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSJyU8aFK9mEONqG/nUNis6Uka+vOYd9hMvtVOFuDIc=;
        b=z57l6UWUoyml5qPK/3dbAyigL3/mFw4SWpA4jlORRMa04ADgJXr2kse+DOKvcgBMj6
         q6Rod2Pu8U/Z7HFXhUbZwV+N9F7S2ghT8tkGE15T28OFlM6bLNs+xhSzPExWm5bmmqqn
         i5GwKj+sqRYa9MOwMihoVFYbFl+18PK0T7HMhQrgzvSMT9U3v2rqocrefBcP37C110ty
         HVYJ/zH7DB1ez+PWo+LQflFW1BTren1pfZeIvSaSQgbVhH6BxvtLCpmk1g98ZAHbwv7A
         wpN5pK8V0WAbbcRUC/Hc4lddTVKyG54TJl5j7+cXQRJo5lUBA6JA5T2wq8832ohc0kQJ
         cVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSJyU8aFK9mEONqG/nUNis6Uka+vOYd9hMvtVOFuDIc=;
        b=d9wZRa50wqHvMZ0qI/GHz1hYiPU8c4jJqw/BpbTplTgeq3WrV7HO9PQBuSvEZWWDEK
         YD9HvwzMDVY4jc0YzBFPbugHGr0T2ZHRm7RtUCEl0ZFDsWt7pHAM2M15d2Yd8Us0FfyL
         qnVYXWIsRaMXqqa7Yg2sobewR9aKfUzg9ELEYgWhUGhu8YljjqMjtCSjwga4CGVUEfc+
         Hd/q+CXpXix+Jff9o/b5WBPIDufHfsW+s9vsUPjr+VhP6wcy/VhRrxC/+ScQypT9ma9b
         2WNN6JnfBK8ksoxMarPoIKaFvcf1Rmu1yGRtrK5kwiY1E7LEEeOoniv/CMO6BYylDtko
         lnWQ==
X-Gm-Message-State: AOAM533w1JCR6jy7LCMKnxrdLbfVxu19E+2pN6IJxJwqHmor6oHGlpfM
        /AUMjzJS1k2gIvoVTeiTS4BsdQ==
X-Google-Smtp-Source: ABdhPJyaW15qMZEmXE3SxBInodABKnX5TaulmK6kQs2Ns1gEa0yWwUQeyDIYIIeCr4O4aaMcdPmAOw==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr5991194wrx.418.1620315446400;
        Thu, 06 May 2021 08:37:26 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:5fe0:3a70:ad4a:a29b])
        by smtp.gmail.com with ESMTPSA id o13sm3788673wmh.34.2021.05.06.08.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:37:26 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] MT6358 PMIC button support
Date:   Thu,  6 May 2021 17:37:15 +0200
Message-Id: <20210506153718.256903-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek MT6358 PMIC has support for two buttons: PWR and HOME.

The interrupt logic is a little different than other PMICs from the
same family:
* for MT6323 and MT6397, we have one interrupt source per button
* for MT6358, we have two interrupts lines per button: the press and
* release interrupts are distinct sources.

Initially, this series contained both mfd and input patches.
To simplify maintainance and review the original series [1] has
been splitted

This series depends on [2]

[1] https://lore.kernel.org/linux-mediatek/87tunpw339.fsf@baylibre.com/
[2] https://lore.kernel.org/linux-mediatek/20210506094116.638527-1-mkorpershoek@baylibre.com/T/#m5c76f061c2158587b7190a13abbf2094b0c050bf

Mattijs Korpershoek (3):
  Input: mtk-pmic-keys - use get_irq_byname() instead of index
  dt-bindings: input: mtk-pmic-keys: add MT6358 binding definition
  Input: mtk-pmic-keys - add support for MT6358

 .../bindings/input/mtk-pmic-keys.txt          |  5 +-
 drivers/input/keyboard/mtk-pmic-keys.c        | 56 +++++++++++++++++--
 2 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.27.0

