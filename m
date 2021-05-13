Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6737FE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhEMT2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhEMT2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:28:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BBEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:27:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p14-20020a05600c358eb029015c01f207d7so366378wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqbwR4L945w2uSfsL/kb8dhVuFB8CH0RH4aZW5kJJIk=;
        b=qheDlMFs9657HZlMSTPtCq60kx8JJ9r33kg5wCbbtaI+SqpJ6ABKQZPil5sA7vFvi1
         uKNhcbNdm/w5QlXLie5rnaol59/E5eehkpLGde/QLp+Ap8osnZ57CYSQSl8WY1/AohTz
         q11NE/A9P7jYwrSfaspW8G2np4r1bOcq1wVoUzdi/f8V3MQUCsc1dZd5ZkGcwII4auvD
         zaOSKwokGQwTC4MmweTKn8vzWxbRS8xk1HGOG3NYR3id4/qDwvv4ouuR9v0NIKkkRVj6
         DjuzfXhlFNU48YeC3dUAbOaxAt+I+iUh/CAhEc2s7cPqTf34k2vyuyRou9sgqy7t0oWg
         QOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqbwR4L945w2uSfsL/kb8dhVuFB8CH0RH4aZW5kJJIk=;
        b=FUdCLAIh3QebGE1ctJLW0liZtDaaxKC5Af4wpe6EstPafVmDHwspwt2OObM8aTbGPt
         JOQ01ZB1/iZ+bJJ6shq5h2XOBf1z4gCD22q6VeVC902Zkl2BtR2Sl2Nx/btNyatYoEQa
         JV6pXArFumeKLJS2PxAvuq6Ja2alZBOVclxRbuS9aW/6R5wpMiyqXwyiVk3EJnHKolmh
         HfYn3H1FIIqn4cQ1fwIkaKZ0bvtfo5ulp475W30lPpbjpvnEMFpXlbkxeNzoOlJph6z7
         Xwpx/cXVmRgftTz9ijtFvdtp1bq7hluCKuXzb+7g9DFd81nonkGk/yp637QALqukmSJ6
         e7CQ==
X-Gm-Message-State: AOAM532CfT9Aef6jZer1Kuo5K9ZU4/uBXXd2ajO1zUDdTOL/sExTiUxm
        APyPvEI9eBTpje38LsChNKznUw==
X-Google-Smtp-Source: ABdhPJzCQlePs8w6v253FGGV68DYI4RKl5BD7B4i7n53vRV8poZuELeUjHXg5qpISOprpoYFeSUkSg==
X-Received: by 2002:a1c:1d55:: with SMTP id d82mr5162172wmd.12.1620934022866;
        Thu, 13 May 2021 12:27:02 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-d842-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:d842:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id h9sm3053621wmb.35.2021.05.13.12.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 12:27:02 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] fix mediatek UART APDMA desc logic
Date:   Thu, 13 May 2021 21:26:39 +0200
Message-Id: <20210513192642.29446-1-granquet@baylibre.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic used in the apdma driver to handle the virt_dma_desc caused
panics and various memory corruption.
This is an attempt at sanitizing the logic a bit.

Sending a v2 as the previous mails were ill formatted and not threaded
properly.
I'm also removing the last patch from the series as the fix is
alread on mainline.

Guillaume Ranquet (3):
  dmaengine: mediatek: free the proper desc in desc_free handler
  dmaengine: mediatek: do not issue a new desc if one is still current
  dmaengine: mediatek: use GFP_NOWAIT instead of GFP_ATOMIC in prep_dma

 drivers/dma/mediatek/mtk-uart-apdma.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
2.26.3

