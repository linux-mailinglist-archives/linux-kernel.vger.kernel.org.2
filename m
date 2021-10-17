Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF7430A27
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344089AbhJQPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbhJQPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:33:36 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C45C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:26 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id n63so20965055oif.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3C1nfVxxpo8DEnKOn1vU+jAEnkcpspjoahSKslyTWpk=;
        b=UFde/uzVd9+iciFwxhwWxAp1m7BCmwShJjlCi0RYqiHld2RStpGuMjzqnvcoNILTt5
         7o1YjKgfPwCERGkUg6cnfciKxNPsFvQtZivhEQJUlhK2Jdkat1l+Su2mpKPTVj5TBTDr
         3fIr10IeupUMvAaYjsKRD9FYvD6eFFu0IZAO5YZpYJRUuzSsuM5AZtBudHU/3wxwxYvm
         +kLZaZoWUpRGoD3RjTHrRMkZWeMmZYnJcRKYC9BcfWiXBQFS9dQZjIoLXqcMrxwWff11
         AKDOac+hFPOdbratemd1rl0oW+I6SICEeN3YOkWg4ZJUZZt3Z8Knl/iGnBvdA+crtwGE
         3vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3C1nfVxxpo8DEnKOn1vU+jAEnkcpspjoahSKslyTWpk=;
        b=l8Xor5WrfLPQTb5uf/pcY+jHQ2TdYV5hKZMBKzeZ5LfQetYzQg/z28lzUbspTyUP96
         e1iVsMzqJo1CyKMxANJ9rgBW0OnEdllohf7aKIqhMLaxli3fRdWg/El5MznKunLYq21Y
         lRwcWp6BMDYVzGONZyPLCjLvcwpu/B+1r8y3MmT7qDQXpb8tgh9DBSjNQEO2C+P5fped
         VYMYn2AgQcY4v4TozGzBkUNmye4efaqJGTFrYbrOBwvDCB6jVP4cZqePSqXpG+SN07Ge
         3SEBBvXRkupXT/ADAyKxd8nrotg7lL5GL8gnH7IBgs1U+AsJMEYcCFZ7yDlse2gT174w
         xB0g==
X-Gm-Message-State: AOAM532lHi5WJrLaoeUcm4nWktO2X1/XGQEf8deD3f/45027Gt+2Pgri
        OK1/PUj1ysPWFDdmcHPausKI9BEPqVVemg==
X-Google-Smtp-Source: ABdhPJy6/O7zvNOQxj+6AuRabQXfmIfqoU04TEr7dI4+SawtYpN0olrh8W/e6BQkSiigUOE+sYAsXg==
X-Received: by 2002:a05:6808:2388:: with SMTP id bp8mr8670146oib.106.1634484686376;
        Sun, 17 Oct 2021 08:31:26 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x6sm2565698otp.49.2021.10.17.08.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:31:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mka@chromium.org, Maulik Shah <mkshah@codeaurora.org>,
        swboyd@chromium.org, evgreen@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        rnayak@codeaurora.org, linux@roeck-us.net, lsrao@codeaurora.org
Subject: Re: (subset) [PATCH v12 0/5] Introduce SoC sleep stats driver
Date:   Sun, 17 Oct 2021 10:31:12 -0500
Message-Id: <163448466185.410927.1569159163846746824.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1634107104-22197-1-git-send-email-mkshah@codeaurora.org>
References: <1634107104-22197-1-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 12:08:19 +0530, Maulik Shah wrote:
> Changes in v12:
> - Address Stephan's comments from v11
> - Rename driver and compatible to qcom,rpm(h)-stats
> - Skip reading SMEM for RPM targets
> - Make driver register in late_init to avoid -EPROBE_DEFER from smem.
> - Change size to 0x10000 for RPM targets since area contains many others stats.
> 
> [...]

Applied, thanks!

[3/5] arm64: defconfig: Enable Sleep stats driver
      commit: 551ed64388fd9a0a648eee81b534cd4765ff484a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
