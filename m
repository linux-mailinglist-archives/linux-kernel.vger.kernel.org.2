Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DA531DCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhBQP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhBQP6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:58:04 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA4C061786
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:57:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b3so17926652wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYjFksfz467AF7W00aNG8FCW+ECiR0W5tjntcTxpfOc=;
        b=rhaLNekR2F2VmJoBFxmvZiNaUJQjF+nqUC7P8BIdAgzHxXYP/EnpjpD9Hvn+Fu2utI
         521G/qTuqTUVU8ZNGwq+l3vqxxkFkrR+yqiBs3eHRrrnvPtPGOhUk0J4MR8NWHMMxH/w
         h1ElJyAYjfMgzu4bTB6DfAMIAwFGRVtJrCjWrkC0HO+Np/8Bfm4yTfQdfQYs+IaOmO1w
         e/2pgREWfiFiQLTOlBnoRe2QyyPvJjIeProqBJ7S2SdFZCgV16VBc1A4ADFu6hNkb3S1
         aBNH2d4EKdOczoPUnSwU3rBtq9rZN4y+4tsiczdsEAQuCjopRpolK8/rGgUIzFx60TZm
         agUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYjFksfz467AF7W00aNG8FCW+ECiR0W5tjntcTxpfOc=;
        b=R53XDYHE76r/Zzs+eDZ3GIyqPeER0DYUiYoqEjfYY8PQzgTUmKmQCozjjpIdu+MC5E
         e/eYdGsmGBh6jx5jYOvySbloW4X2vWBYX8AXpKd5HslG+Kgyyyr16eEwO0qH7qaOGNvW
         cbAemvisxEH+jb09vxNeKph+mbrXnRyg0gKqY2fZAAF27nkB7daIUTdbYNc1MKXjrnmL
         ncK0EDezs0Wf1oIW0bo4huN9XkYCyKFL0mYeXgFm6/sJg3hrx3braSze2RM9hkR0Dsz6
         w/ClLeDJd3nz4jvVvYQXYTrDxOFcBYR1hb/NzRKNADv09ghMWNzEdiGoCEYoMchl4YC1
         PeJA==
X-Gm-Message-State: AOAM533ZG6k39tSclyPdSpFGynZt2c28aC++RHVrSb3+qqDlNDrW/6AU
        tciw9VZtccsfYtweFKPJSQj+XQ==
X-Google-Smtp-Source: ABdhPJw/AY9DjqoBYnuawP0aggKbfhuhf4xCZ9MEqCXus+7J18DCGC0A9PBg1OMAfwKstJNVJI4V6Q==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr29704688wrx.403.1613577441262;
        Wed, 17 Feb 2021 07:57:21 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b2sm4860480wrn.2.2021.02.17.07.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 07:57:20 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org, dikshita@qti.qualcomm.com,
        jonathan@marek.ca, stanimir.varbanov@linaro.org
Subject: [PATCH 0/1] arm64: defconfig: Switch on sm8250 videocc by default
Date:   Wed, 17 Feb 2021 15:58:41 +0000
Message-Id: <20210217155842.1715999-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already switch on the sdm845 display and video clock controllers. The
sm8250 display clock controller is similarly switched on by default.

Lets switch on the sm8250 videocc too.

Bryan O'Donoghue (1):
  arm64: defconfig: Enable SM8250 video clock controller

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.29.2

