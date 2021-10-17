Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3A3430A19
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbhJQPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343980AbhJQPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:33:30 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AECFC061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e63so20910423oif.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKMpvl1MAC7zrCa6TbMtjRul4um4QKy/ISSdbIagyUc=;
        b=NMWktdDeJkZDlBUEtdIaDRzDp8fzBwBDGXgUL7mgEMmvX3IOJYjH+O56k8TKtV9lFR
         dKN6Ts3pRxHJ/p3zCTzHkbNw7PzkyE0tiNH/WTyiA1ca3lUBEhfohxaucqODYggvwXdo
         76QbBG2gVudJn5M9E87dhgUmDk6vGkg09EY/lphslLysetmpZYS5sMkmLdcctwxOdlw3
         y3qn+7GGyTmi/qKOpXqg5k+d2oxk+cwmjLP6lBZldBswyDqDeMXjxiJD+3bRJFDXLWbQ
         gnYh7AaQQYzqx/BesK2lwpU9in38BmBUjBqrjqaa6eZqioPkUCZYCXyUWOiPXLGqBQNU
         t62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKMpvl1MAC7zrCa6TbMtjRul4um4QKy/ISSdbIagyUc=;
        b=y7AkvIp9BQ8Z6OPJ0/kgMNvL46pQQssyRMXTIbZ3vogGflqKp60ZZg9iBRcLWl81oN
         WxRUz4XxeQs9+WUwc3T6M+la/g4RqLs+tKhOfN4XKX6TOeJoy+jjkQxT0SsxITUz/MOt
         j+4RAclK5CxcM/BR2OpdIK0ooCAH+3IKWNJZWST6Vw7kPvfgsAyefElbv8MqHu5RuS1j
         Sf/Ffr0ctXTUkp6IlIr4pBrog+RmRarbPM7T9vkIDBZYcIA9kSbBvjw8GhkWqfVjCEHE
         aoNSvI8Ezeyb8VHKneYxu0mYWtR6JGe5+r8DkqPWhTXbudzDmf+Kpov6atWY0VCpGns/
         ilUg==
X-Gm-Message-State: AOAM533uGxx1tswKKwGlL458tTDFEkh8XeLTauYKB7e1CCkYZ2ODAbeD
        cNckbsO2Yrn5pG3nDGWv0CmPPQ==
X-Google-Smtp-Source: ABdhPJyvGYpmKMwk8RukGElbx/paPU4nRplPqwUcHrOh5bMrEgxja3tKe0gk/4by0hCaGj3exICEBg==
X-Received: by 2002:aca:af85:: with SMTP id y127mr25293596oie.96.1634484680468;
        Sun, 17 Oct 2021 08:31:20 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x6sm2565698otp.49.2021.10.17.08.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:31:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Gong <yibin.gong@nxp.com>
Subject: Re: (subset) [PATCH] arm64: defconfig: Disable firmware sysfs fallback
Date:   Sun, 17 Oct 2021 10:31:05 -0500
Message-Id: <163448466184.410927.7791775948876356994.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210930215300.60290-1-bjorn.andersson@linaro.org>
References: <20210930215300.60290-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 14:53:00 -0700, Bjorn Andersson wrote:
> Part of the enablement of SDMA on the IMX platforms, '7f4e4afa140c
> ("arm64: defconfig: Enable SDMA on i.mx8mq/8mm")' also enabled
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK, to allow "firmware loaded by
> udev".
> 
> Unfortunately having the fallback enabled does, due to the 60 second
> timeout, essentially requiring userspace to provide a firmware loader.
> But systemd dropped the support for this interface back in 2014 and
> because arm64 is the only architecture that has this enabled, there
> doesn't seem to be any standard solution available.
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: Disable firmware sysfs fallback
      commit: 5c1c3e2a7693c5e47a7d93898ade1acaac2afb38

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
