Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB13887B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhESGnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhESGnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:43:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6E2C06175F;
        Tue, 18 May 2021 23:41:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11so6846789pjm.0;
        Tue, 18 May 2021 23:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EszL3yn57I/2tZJg1X3iM1QJ8HnLr2wIznzxzWj5Kv8=;
        b=nR1epCktIIgPf7VUaQbZJZ6gqwdGNA7pp0A0JN5pxsmjKpiWwyvBl0iozSvZUByjtI
         WZfJWHFOHJi40aBuFyPteEYmdHL5udYWMtCaRtuFahXpaRUnSh7DiyAelCCXT9yE0Bgi
         W0VVxgYlXBiCmqCERpNCmZOK/9V+QMKadQQP/1khOuiLehtXDbz2HKP9LmrqhcfIW3LP
         xjOcDQ03p9+c6AYUqTkfPMOwdvR67sIY6qNSpPd3x3x69lhv9uzNTMUrIigmmsA9Cz4N
         RL7KZ4t6lsdoEATtC8loEkDG14raPp0P3dJC8IujuxqB5g8EQWiAH0jnpMRTszi9gNf2
         Z2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EszL3yn57I/2tZJg1X3iM1QJ8HnLr2wIznzxzWj5Kv8=;
        b=jeHwJK2su45JshyuiNvAU3wSTg6WpMtxWpN+OxpbAnzM15ghHDJ/KDS/xuI5P2BDFc
         ns5vAJ6z6MDueLiTPBMhw2rZFDrstzJAe7El9f2h9EHx5Rk5Z+yL0hYlw+qdj38jiLeJ
         rrOZVfe4yV5QfFIY6/1YG3RtZ/XYAKdkFjucejtU4I4oTlxefMlSMTwbgin97EPgw5iA
         VqW+6vKIN5Qz9fIkn2JAUyeFS2FZ9dNeUv7lysxANtCYdgM1wLUb8aIg64yX6uUYH1AR
         8cfLfikoyfugmeXk+f+yLTdx/KrzjR6vWaxRhxObiAUS9pbX1leAecM6t7kcsuG2pbIq
         i7pQ==
X-Gm-Message-State: AOAM533cx2yGFwGP/g/6Wn1sI/D/nR6tAYp7d6N7MqT+KTgnr6P/mlwV
        xxhxPNsKKpLerghFvDEGbjs=
X-Google-Smtp-Source: ABdhPJxri2y5kE/vgQi8AkFVooFjhfN9g68jR/Xhzhfj2prJdr0OeWbISmoXXKKIE/MLUAU3V/pkMA==
X-Received: by 2002:a17:902:da86:b029:ef:70fa:7b39 with SMTP id j6-20020a170902da86b02900ef70fa7b39mr9099141plx.81.1621406515562;
        Tue, 18 May 2021 23:41:55 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-5c02-d8d8-c7a5-75f9-86e6-8ca8.dynamic-ip6.hinet.net. [2001:b011:5c02:d8d8:c7a5:75f9:86e6:8ca8])
        by smtp.googlemail.com with ESMTPSA id r22sm14158900pgr.1.2021.05.18.23.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 23:41:55 -0700 (PDT)
From:   Crag Wang <crag0715@gmail.com>
X-Google-Original-From: Crag Wang <crag.wang@dell.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     mario.limonciello@outlook.com, crag.wang@dell.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] thunderbolt: add support for authenticate on disconnect for new dock
Date:   Wed, 19 May 2021 14:41:46 +0800
Message-Id: <20210519064146.58454-1-crag.wang@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <crag.wang@dell.com>
References: <crag.wang@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Crag Wang <crag.wang@dell.com>
---
 drivers/thunderbolt/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index 57e2978a3c21..892cf0e8ada5 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -21,6 +21,7 @@ struct tb_quirk {
 static const struct tb_quirk tb_quirks[] = {
 	/* Dell WD19TB supports self-authentication on unplug */
 	{ 0x00d4, 0xb070, quirk_force_power_link },
+	{ 0x00d4, 0xb071, quirk_force_power_link },
 };
 
 /**
-- 
2.25.1

