Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D794099D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhIMQrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbhIMQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:47:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:46:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g14so9416077pfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1GV6bysSmlOc/rG3VfzJl7/tqTZcVf8ssdMAyonCG0A=;
        b=gR63pR3mJ7d6d2dagDjbYHuhSDEoDZ2e8Qxpk0caet+ru8PlAOIWoJ8TIvH15gxxOK
         el1Qz2woHoekVl8F8VHlWFHqtin9iVlqd1EK81ys/1+0K0u+2PHheu9FwEvDqKI/wVz7
         bhxwQFwyaZICMm7Cck3OdUdDnnDNeTTltRBNXQ6JY5MOvQhz89UxNnDvDz7qC5elEAJR
         rSSiA8DQmTiuv+qRMonyBk6gOu/b4vN++NJQNLiwRvUpilFfXsdsBG2Zd+dUArujogNF
         zZT/HeOljNFmfusIZ/33c3nmpZvBs+tVpnGG6tCr8kUPGQBpNgmHwWengwjt4D5GNAqX
         yL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1GV6bysSmlOc/rG3VfzJl7/tqTZcVf8ssdMAyonCG0A=;
        b=ezcEK8DLYINSOwd6tq3I++fCDbovThrQK1zPy7twYj9J5zP55F2PZQL0Edqfigtk2n
         s8ZGDfmIAEVv6XuHOsKdciL0J28AE5pzG9RC3Yq6Fexo9RxNeDiNqLYBElmRYfxKWKum
         cT5KjU14CYC+rqFWUW7xnEAthVAV/GoRRrfAyEGez4Sznvj38ZOhSGgBBdW7oDXRx4CC
         Uxi9xx+HyabuC+YHaNSP+M/B+7hrMEqFzwjZkiHxPlNDvfmBmWx22fYIMWqjpJyrKWtu
         bmEbS1MzBNr0d5nozNWvPWviGe/4gok/FCDtvvddcvNs71Tj80aHVqs5wlqVHq02sNq7
         x+dg==
X-Gm-Message-State: AOAM532ED/s52nkg6pMc+Mv90ahy/2Ak6ac2UoPhCF2Bh6EzSRdU9HVS
        5dO0EiOMZwvptoL/CRydiA2oMg==
X-Google-Smtp-Source: ABdhPJxayft6ULOval7m0WzBQdnnTrTZfACybkKAQYBQYjZBSbHKxqAkDObrTYgeN5IBHtEPlpNv8Q==
X-Received: by 2002:a05:6a00:10cb:b029:3c6:8cc9:5098 with SMTP id d11-20020a056a0010cbb02903c68cc95098mr319051pfu.41.1631551574795;
        Mon, 13 Sep 2021 09:46:14 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g3sm7615572pfi.197.2021.09.13.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:46:14 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     jiancai@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Coresight: Fixes for 5.15-rc1
Date:   Mon, 13 Sep 2021 10:46:12 -0600
Message-Id: <20210913164613.1675791-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please consider when you have a minute - applies cleanly to
char-misc-linus (6880fa6c5660).

Thanks,
Mathieu 

Jian Cai (1):
  coresight: syscfg: Fix compiler warning

 drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.25.1

