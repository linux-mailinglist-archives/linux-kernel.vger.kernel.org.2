Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD263461EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhCWOxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhCWOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:51:44 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C93C061765
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:51:44 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y17so6724051ila.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQFA2QStDKmo1XhVZ4KOEMpN+hi3li+F67WfkjwPMWs=;
        b=zOGbG6kWxYv/NlO/UnfFSMX/b4KNsvakNYB0BuVUaMu+r/cb1KKJkcYzOfVVdxIDQt
         LKtV5VMiZYglWsahrSr+NInVD4CJhyBYX+qYtAHUR4mEvDr9n6hYmZW5PcK6XT7p9ZCq
         fJqDixNQyDr3nZEWA9sJEjDDE0agrqcYzc70gayldLDTJx44pQVgMcUsqPDYWKEOWZuu
         wK7XgpTzbdlNutONYHLM+J7ZjQEsgI9iKNLa9ShWKfbthkb+YeZVmN2cfzXP9giLrIZ4
         vMoPXTdjgEsufogygjs8N1mPhfzD+6tOAhC8ATMQZoXjxiKgYhDLivA6dKG70UPdZKL7
         4ScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQFA2QStDKmo1XhVZ4KOEMpN+hi3li+F67WfkjwPMWs=;
        b=phbkMoX79T4w+HcwvlFOchH73A3VfTuPh6g3r57eYcLsnOTPEbSUe9J/hUQL0iW4LE
         v8XxibSom21OT4FqEd4+BSvoXfT3kz5L8F+nizurCtxo/x+xlwWd0W7nslpzpCslfnoZ
         c2Yr/8r65Q/aXs7eVMbnA04XEVHH11J9LCdIh65UccOuLnCrm9c7zZ2A0h9Q0CFrb7Z8
         0nX0cauRIAHGELvKmt6shMjSv/84/Ew2dBkFhdNonaKgUseRg/tA7lzhdy1aQ46Vquxb
         fvCC4tL9qpQr4bSyEPnybs/o7GaEkGT6gQqHMLRmqdZ06/UlhFHO4p0aH0X09+fRnfrk
         gpQA==
X-Gm-Message-State: AOAM531kD3abIbiSjO0WDoBsKgskalrfI5BscIyakgK3owyX4Z4ibtMS
        qDjPq8Lffy5W5ADa+b0B6Axnbw==
X-Google-Smtp-Source: ABdhPJwWaESy2v2a/l30d+CmmAXKFddf6jlFJr2L4jv81ExrD8wwEsTO0K5Rj6BSJ3dsRBCh2XbbKg==
X-Received: by 2002:a05:6e02:198a:: with SMTP id g10mr4789697ilf.139.1616511103560;
        Tue, 23 Mar 2021 07:51:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o13sm8961147iob.17.2021.03.23.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:51:43 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/6] net: ipa: increase channels and events
Date:   Tue, 23 Mar 2021 09:51:32 -0500
Message-Id: <20210323145132.2291316-7-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210323145132.2291316-1-elder@linaro.org>
References: <20210323145132.2291316-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the maximum number of channels and event rings supported by
the driver, to allow the maximum available on the SDX55.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index efc980f96109e..d5996bdb20ef5 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -16,8 +16,8 @@
 #include "ipa_version.h"
 
 /* Maximum number of channels and event rings supported by the driver */
-#define GSI_CHANNEL_COUNT_MAX	17
-#define GSI_EVT_RING_COUNT_MAX	13
+#define GSI_CHANNEL_COUNT_MAX	23
+#define GSI_EVT_RING_COUNT_MAX	20
 
 /* Maximum TLV FIFO size for a channel; 64 here is arbitrary (and high) */
 #define GSI_TLV_MAX		64
-- 
2.27.0

