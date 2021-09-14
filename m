Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A940BB59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhINWXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbhINWXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:23:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:21:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t20so720348pju.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=333xEu22H5+w+SS4FoGcH3gCGHSIRvQsqvFSw5wfSPY=;
        b=hdArORq8Yq0ETVid646ujUSZF3eIpOKEx0ue7WHwqmt0ChsgAA9WYZOyTxflhJDVUc
         h0mjwlkXfw+/T4lnklJErXNIlJ+v3b7Rmn6xatBaBsHS8JFQEybAhOAjOC99HyWwvMtq
         GUyXnW0u92yBQOkucTxjdJjnzK++ScsedAM81bjw0ouPsXpN0zHDP3GpgsJCKdGpgsgJ
         OPdc4Ns5jCLwTLb/B0Xk4F4sMsALMW/f4KQKxESgkL8VDBiNeksbHJubKvF8Cz3dmhJB
         LteHxujVCYojTeOv1v+pFTyUNNK6u66ZEJExCVXGAm+pByR50Y5CYY6lTqzBpiPx+HBV
         /d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=333xEu22H5+w+SS4FoGcH3gCGHSIRvQsqvFSw5wfSPY=;
        b=cCUjJcz7UdFVi+iCxt0Rn8PB96kmpSHCRPXJYLKpd7ke1MnD2YvLEmEHZXKhNgyt9b
         ijF2sTc4TjJw4QgjrmLnNRQozh3mjiAIXd9NMi+8Fv6TsNanO7h1HJw+O9RpdFBVIKl3
         u6OA45hFsd3seBM3J57eofCzWG+EDlxHISssPkrrxIM7ZATmm3TaT6Vf9I/s6F2pDzNr
         BHbMyG7AOvU1szpWREGy3gp2OVkYko9bwqsOU4kpy0tI0tqPZHENQTTvXj35unehqbpY
         5pdFEYGLbXLamlz6Q2KKQIviuVfntmdJRTYFMx8TBjxjgIgVb1NRyYdy36TzGrtGPred
         ZuGA==
X-Gm-Message-State: AOAM5316Pod3UCW/d6kkVcyxeCi0WjGLFSsn63pWQZ/Bv1FcuiEvMEWp
        OsVwaHXogbCXHZ61Icz+YfA=
X-Google-Smtp-Source: ABdhPJwgSAmZLoxTGsckN0RJ+AcIW7hACI2QmmOA7ATWReq9sI6T4WphbQrzZROTDXd5PMl0zMra3A==
X-Received: by 2002:a17:902:ab8c:b0:13a:22d1:88d with SMTP id f12-20020a170902ab8c00b0013a22d1088dmr16863883plr.33.1631658113963;
        Tue, 14 Sep 2021 15:21:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l14sm2694951pjq.13.2021.09.14.15.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:21:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] soc: bcm: brcmstb: biuctrl: Add support for two
Date:   Tue, 14 Sep 2021 15:21:43 -0700
Message-Id: <20210914222146.214115-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds two chips (72113 and 72116) to the list of
supported BIU/MCP tuning list.

Florian Fainelli (2):
  soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72113
  soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72116

 drivers/soc/bcm/brcmstb/biuctrl.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

