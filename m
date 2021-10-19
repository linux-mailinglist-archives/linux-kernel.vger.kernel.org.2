Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674934337C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhJSNx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhJSNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:53:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F4CC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p21so11941498wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fim4V+Un9Mkh+LtaMWTpgZImX9DwRHy61AKHLe5Yfd8=;
        b=j/p6mfr7KlqMAKv5vnWLuDaJnh9iS+YRoND+enCmnllBQMfQeaMnXLDnH13K63TA7t
         3dDghDhwFMcg2264uxoqQEuKeJ/h5c+JYdCKQEwUlR0luribrhOv67Rj6lj9C+Wxiqup
         QwW3nBK+xjvUn+oRmt8b3x3/Gek1ihviRQQp9f2qXKCyK2Hlcchva6UK2rND/2uTm0pv
         otoA4StcGsz/SaR/jofn1MEJe1xjw08c89OsMVcVeWRCODAkph90E7LQwEDhPiOfn9Nd
         eBEdxyYiNWT52NtZ0oJf4XtAb14uwXbJYIVisoqcfkNC18LmDTUCHO3Dije5bDkB19V/
         J/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fim4V+Un9Mkh+LtaMWTpgZImX9DwRHy61AKHLe5Yfd8=;
        b=2MyYZUUVQpCzRKuqMjx9/iaWqDABhynb69aLMU4qgQ909YCwHz2YF4WQN8r/HJZ+nw
         l07WRqrLDeezQi2Xgg2RmjrEf1fTSNJYMi5FCIwuyrB6+kJmmqgXULq23k5nMdy5j3rt
         XcIzremZVYAB1Hg0YkwsFNTf096aR4RHyM1IGsR4CXV0dsf59TzmCNXPezJTaQEjb+/j
         8Mw/gxleVCmL9L/fJaT1f1zeVFYlFjzQIQauuspEq6/JMMDg1Lnw0ZSvSt+WsshtnIeZ
         KZxeqlCtv6ACFhMvmqI+FCNnl90z/6jWjOBQjdWMdSaEpC1C4vGezfEvTiLeKBMjtiTA
         pSqw==
X-Gm-Message-State: AOAM530Dvt3O8hjfhGQPTU0eFAqN5h0OJtViqW5bp4+svYbuqNulr5Kw
        42fFMPwIlq2e/DPxlqxBT+s=
X-Google-Smtp-Source: ABdhPJzV/gWpKdFGH29Inp+F4VsJCzncCJbChwOYo91jeRlVo3fr8uZhiBfHPMglaBDbFSxCarklFA==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr6335711wmj.38.1634651502757;
        Tue, 19 Oct 2021 06:51:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id i203sm2280699wma.48.2021.10.19.06.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:51:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/7] staging: r8188eu: more odm cleanups
Date:   Tue, 19 Oct 2021 15:51:30 +0200
Message-Id: <20211019135137.9893-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes more unneeded and/or dead odm code.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (7):
  staging: r8188eu: remove duplicate structure
  staging: r8188eu: BTRxRSSIPercentage is set but never used
  staging: r8188eu: rename ODM_PhyStatusQuery_92CSeries()
  staging: r8188eu: remove unused cases from ODM_CmnInfo{Hook,Update}
  staging: r8188eu: remove unused fields from enum odm_common_info_def
  staging: r8188eu: remove unused enums and defines from odm.h
  staging: r8188eu: RFType type is always ODM_1T1R

 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  82 +---------
 drivers/staging/r8188eu/hal/odm.c             |  70 ++-------
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |  31 ++--
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   7 -
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |   2 +-
 drivers/staging/r8188eu/include/odm.h         | 142 ------------------
 .../staging/r8188eu/include/odm_HWConfig.h    |   2 +-
 drivers/staging/r8188eu/include/rtw_recv.h    |   1 -
 8 files changed, 26 insertions(+), 311 deletions(-)

-- 
2.33.1

