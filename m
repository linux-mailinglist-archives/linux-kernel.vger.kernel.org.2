Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A94381EC4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 14:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhEPMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhEPMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 08:32:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFDAC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:31:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x188so3131796pfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ds28R/7vwYP+GELrd+7TuWueNiMvgRdKm3879jAJ7HQ=;
        b=rEEgJv5BYec+b4lztI67bvFhhdOJx/o7DPkxi3xSciQzsPHrMn7o7fdMnNvwZ7ZGAY
         WOCJQR8xqdqDU+w5jG33FtR4jxlFzAvXKEHglc6zohI8xClEiFjlyagVZpSeF3EuZd/M
         RFfLX8BO3wTOTtsex+R+YwFHDxlma+esLgVVM6LYF5wSp76JVQ2Vl8+YCgAw5TimZeON
         F/JN1+TBCdpClM2bh1NNJmuLeRchwIC9JwFztRQUNXQa8fRcr1uHgPO6uZ9KQsrYFO5g
         t8tYngE8YzZQbtdGeNoKAatV9bc5RCKloez+XkmVBUcY6w7NkLZmScQMcdsY/TDc4KBT
         MZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ds28R/7vwYP+GELrd+7TuWueNiMvgRdKm3879jAJ7HQ=;
        b=owutd7PWWOXBLAdFz+RvtzgtmutnuT2ZQ3COay3Nc2FW3idsbpINdAfXQNFm5/VZYi
         ktHJ19QTCnex6NeO8J84D4JjoVVR+PawIN3ieXNECtSatx13II5eW+AP+x12k9AB2t6M
         BXenM5wLXREWNgum4H+CBT5YFHLGghGkYjbfcWLoldCLzMaAm/k7ryeiN8chbUC7MXIu
         VFYmbEVPpYpIamBS/DycaVnJtFWSc2h4+NEXDqQ9m0kJCcEfDO/x9rS90WmhYtxZ/TeP
         78TtnTmJKjJJYHuYZGTTqn4exkXAywXuqBlyyF6VyqeHKo52nOwgRK0u1mpbODSV4qdb
         ZHHQ==
X-Gm-Message-State: AOAM533HdOtrKRYbv05J29TjS/BbZWoPRbEn5PwDGPGbxKP9SU+0T7Do
        aRZRm4j/9FeBBd3OH7EejGY=
X-Google-Smtp-Source: ABdhPJyUnk4tZhpoLh6hARcUhy8fFfv9TcSYa1G973qaWL3zCQrGzeEq+CvnQUB7zeVaCqBWLeFviw==
X-Received: by 2002:a62:7652:0:b029:2d9:4602:7292 with SMTP id r79-20020a6276520000b02902d946027292mr6031215pfc.52.1621168263632;
        Sun, 16 May 2021 05:31:03 -0700 (PDT)
Received: from localhost.localdomain ([111.223.96.126])
        by smtp.gmail.com with ESMTPSA id k186sm8004318pgk.82.2021.05.16.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 05:31:03 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 5/7] Staging: rtl8723bs: add missing blank line in HalBtc8723b1Ant.c
Date:   Sun, 16 May 2021 08:29:25 -0400
Message-Id: <20210516122927.1132356-6-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210516122927.1132356-1-desmondcheongzx@gmail.com>
References: <20210516122927.1132356-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch.pl warning:

WARNING: Missing a blank line after declarations
+	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	halbtc8723b1ant_BtRssiState(2, 28, 0);

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 97831d04959b..cf36a7de4735 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -1664,6 +1664,7 @@ static void halbtc8723b1ant_ActionWifiConnectedBtAclBusy(
 )
 {
 	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+
 	halbtc8723b1ant_BtRssiState(2, 28, 0);
 
 	if ((pCoexSta->lowPriorityRx >= 1000) && (pCoexSta->lowPriorityRx != 65535))
-- 
2.25.1

