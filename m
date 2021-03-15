Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8870A33BFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhCOPVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhCOPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:21:18 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0433FC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:21:16 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s1so9661253ilh.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UVU1lIH35OcmkAnoTjeVDtxQcTQ4xnL4RtekITOaQE=;
        b=w8SB3Sn6z94A4Hbb3+EXifdzR9BE29xeDL4kolbLb3agS5QFiTtpPIjbd05Blu97vH
         VJbNhtIo6cadJrhItlkLBDAjsk7sLVnI63AQi2l48XHoIJj0nzQWkDjM4p1kxDVyFT9p
         gitvB6EZ2/BsV/bFPOH2pTutRevtu6EdR0J6m0CoPYmSHdGg6pMcu9TBdnsPU0042myS
         wsB+MvK1+gnsN/qtVuyVHsmDmgC5ZuNYEpLtytvCSavl8SIkPCkK0j9KW9v/dohHmn5p
         hWuP1Y67C7RoMhMkTwtU/oLS2ILwcCoFLXdZWezm7+JhKUbk6s77kU0hL2xboAPEDOLO
         ZNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UVU1lIH35OcmkAnoTjeVDtxQcTQ4xnL4RtekITOaQE=;
        b=fQmhxZHDX41BLeq2W2OeVF9jLmmRB0uxiNWNM1LtA74TSrTyIrf1ZmhfShH7Qyjx1F
         0WvDb4tx8Ct4pD3aJS8rFc8TZH2v+JBiMXA1UQT1N2ml4uHG94KOfS2LibAFIrPIN9Wg
         6xnX6to6nXufMW6qZwSfLLsRLl2zPTvsX2w6Br1wZrsFJ0v9cYjRrxVf7fWdu/uPDqVg
         7XmYjQxnxFAM23Fyt40/0vgTfBmfgIoHVRiUMLqrtO0UFXwrhfRyxhp0K/85VA6kBDIn
         epQLy/Z/AXj8PGvRFSth0xz579af3B+ZKQ56AXDZpD40ugoA+w8tuCQWKwJjRcSikkDX
         3XFw==
X-Gm-Message-State: AOAM531CU37Iu1Hr/AoN1XnrkC+5+b9FM5ZiagtYz0NjhNBAhKmswKW8
        1P4i0iQgpEclUJuLOjgQQzdmMQ==
X-Google-Smtp-Source: ABdhPJwpwWiKXO3VPLUl3WLrMPnRwbYtKWW01ulFTCfLD5wmSpRbivscOG517g3qrauvqvOeoIil0A==
X-Received: by 2002:a92:d5d2:: with SMTP id d18mr113833ilq.50.1615821675460;
        Mon, 15 Mar 2021 08:21:15 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id l17sm8194275ilt.27.2021.03.15.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 08:21:14 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: ipa: QMI fixes
Date:   Mon, 15 Mar 2021 10:21:09 -0500
Message-Id: <20210315152112.1907968-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mani Sadhasivam discovered some errors in the definitions of some
QMI messages used for IPA.  This series addresses those errors,
and extends the definition of one message type to include some
newly-defined fields.

					-Alex

Alex Elder (3):
  net: ipa: fix a duplicated tlv_type value
  net: ipa: fix another QMI message definition
  net: ipa: extend the INDICATION_REGISTER request

 drivers/net/ipa/ipa_qmi_msg.c | 78 +++++++++++++++++++++++++++++++----
 drivers/net/ipa/ipa_qmi_msg.h |  6 ++-
 2 files changed, 74 insertions(+), 10 deletions(-)

-- 
2.27.0

