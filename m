Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4752B430A31
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbhJQPdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344024AbhJQPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:33:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9893C061769
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:27 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso654059otp.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQ00AQK+701aUWuJr+rwOHhXq54cA2GmgXr18034DJE=;
        b=X0zpHk7Bbr0FDxJ+ODMooyz2ejhlGii8inD7uYz+EZcyiK3cGhzI8v7epMsoCKNK0H
         cv44CIc1BbAuAqezJ8ZEpRfc/D7XBVLQzrMqYlFFtr8Gs4VmKz31psrYIwfSO0mcVxKs
         aVgemyHRCgsLwQy2BUFM+5cRujj7Py78NmjdZTU5ofkIU/OvbC/wydji9FYukwNdL1Bt
         +nKBZSWFqiiuqSr+YBdieNKfpN01TVDEahyd675GfMgzfYItiuEdB/X1McVyBbIbhSm6
         Y8xx6sIiWeMt0Up/shqilLbWQLjelEswlHzr/SLs0XabvolqahWBgPvONkrADu9eiqhV
         /ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQ00AQK+701aUWuJr+rwOHhXq54cA2GmgXr18034DJE=;
        b=0EkNJERau9ieG5XfLEvp/FbqObXWz2NJejKsx/a6mX9GKJmCMWxbQZYMw5iOC8nWBI
         DU5QL1FZokQLnyDB/LVor+WXtFdjVLQ/+yxs6o/1JAsrbDPFG4Uvd4JeAMf8DJNZGmH0
         dBHDLuKiv6vq38VvZBajGPH1a6gcMbxmceoQ7tBJPEPbDAvGm6n0MtPL4pTOFK1BCvxN
         sJep9v7NCQj4l3mvdOPD3Erv69jjz5mT9i8Bq3nTtQpd4zn5s22hDdyaDspgWjQL1hgt
         5u0jxLhJQiTyiG9uhfpAu+UsWfTRGxh7BjrWqzMpV84R1jziCx+8sVs0OhcSAtIxIIMz
         ileA==
X-Gm-Message-State: AOAM530AmsMe/DuFna4l36Fdjx0AuR1FpySM+v/UpkYXw8RRhjv9ikGi
        0yEHTvNbLcFIm0yrF3eBYEzFFg==
X-Google-Smtp-Source: ABdhPJximA8XwRqH9+g7pzaJFxuIO7kvAN0cbME+cdDABM3Ad/OgWsLiN8rzz72YrOiPsp7jo+RQ+A==
X-Received: by 2002:a9d:19c1:: with SMTP id k59mr17467658otk.348.1634484687195;
        Sun, 17 Oct 2021 08:31:27 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x6sm2565698otp.49.2021.10.17.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:31:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mka@chromium.org, Maulik Shah <mkshah@codeaurora.org>,
        swboyd@chromium.org, evgreen@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, agross@kernel.org, rnayak@codeaurora.org,
        linux@roeck-us.net, lsrao@codeaurora.org
Subject: Re: (subset) [PATCH v12 3/5] arm64: defconfig: Enable Sleep stats driver
Date:   Sun, 17 Oct 2021 10:31:13 -0500
Message-Id: <163448466185.410927.9470540718224302097.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1634107104-22197-4-git-send-email-mkshah@codeaurora.org>
References: <1634107104-22197-1-git-send-email-mkshah@codeaurora.org> <1634107104-22197-4-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 12:08:22 +0530, Maulik Shah wrote:
> Enable Sleep stats driver. The driver gives statistics for various
> low power modes on Qualcomm Technologies, Inc. (QTI) SoCs.
> 
> 

Applied, thanks!

[3/5] arm64: defconfig: Enable Sleep stats driver
      commit: 551ed64388fd9a0a648eee81b534cd4765ff484a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
