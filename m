Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD14734E2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhC3IGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhC3IGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:06:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E80AC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:06:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso9045815pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ohWyba0j454EaOcs1wMSu7zcUbDYhtyMLYsDEhrXDGs=;
        b=jqo9lLZ7GcMnZC5ZBsguOjSYs6hFI12Dfmn60MxS5gDNrO/+nY8Vn2rY4ywOySIC/k
         QaZ3yvUp/zWMoXGE5D5p0Wf3cwyP0fPTwORkzq7VIU3Tn8pSVeL7osPiN9DAw4zCbc+T
         H9uaV6epPrQ2WddQgw6oq0J+rbn8f5L+2JWKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ohWyba0j454EaOcs1wMSu7zcUbDYhtyMLYsDEhrXDGs=;
        b=sT/YDDH6HMIyo5wsS2/h8hgcnmlAeFESDVsbaD5gI0CejDDSN88rzm/pRDkclc5n2g
         kVj/R/QlhRej/l1oTPc6ZqTK1fv9zLB6yNb1i1mnQuZd6PdWcd85VknKIGIS46uPDhgG
         te/mb8d3VtqPeEz4p+MOZ2Fipstrb8mk4n35oc8ElPS57GOHPlczwPZJUb4ndL7BDW9/
         z00L9rdqpg6PhwrhCgNud1oaQV4GxkWOnAhMcUUp71suQqILh8ECxy0oxCX/KXkY+mdL
         lJ20Jpdm2zI+g4ekSO5Mj37fvj2y6Rg1JTFbZ3lrwlSUEDlbY2E5uNqhiz/rVkeJTtfO
         uZEQ==
X-Gm-Message-State: AOAM530waBUNwVAgrVnFPfT42mwU5ahipzUbBigzzaVukcmDsEjPGCKu
        Kc8xMvV1NOtYO+xaiZRyfWabsg==
X-Google-Smtp-Source: ABdhPJybMW7B8cavgdFxhd4SwS24cBzLl6Y5MZwunkIgjR2DOE2qND49L/uJeWGi9/heazJekmcuZw==
X-Received: by 2002:a17:90b:e01:: with SMTP id ge1mr3199883pjb.117.1617091582045;
        Tue, 30 Mar 2021 01:06:22 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:49fb:d79d:bee6:d970])
        by smtp.gmail.com with ESMTPSA id f23sm19118913pfa.85.2021.03.30.01.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:06:21 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] usb: xhci-mtk: relax peridoc TT bandwidth checking
Date:   Tue, 30 Mar 2021 16:06:15 +0800
Message-Id: <20210330080617.3746932-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is for supporting typical full speed USB audio headsets
with speaker, microphone, and control knobs together.

With current implementation, such a device cannot be configured
due to xhci-mtk's bandwidth allocation failure even when there's
enough bandwidth available.

Ikjoon Jang (2):
  usb: xhci-mtk: remove unnecessary assignments in periodic TT scheduler
  usb: xhci-mtk: relax periodic TT bandwidth checking

 drivers/usb/host/xhci-mtk-sch.c | 120 +++++++++++---------------------
 drivers/usb/host/xhci-mtk.h     |   2 -
 2 files changed, 41 insertions(+), 81 deletions(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

