Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE987430A32
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbhJQPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbhJQPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:33:40 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54014C06176D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:31 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id r1-20020a4a9641000000b002b6b55007bfso1190673ooi.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZOnNnTCVTRY/rWJXMtzKNmCgdIsffrpi3tbSI8c7J4=;
        b=xW7fNvPZbIugopZKxj24gwuQmMknZ0pSvMeho8hNI2b4dIrPh35t6hvHIBWkjOfwnE
         qR+2A9d2CSjlgw9z9jAwwrFMVSkIBtmg2vmIk3t6TBh/4qSDxPS8CFVLreMYpFrZAaB5
         8OOnGgXDlgXOp4XOMDgfdmyDfyeWfvf3cwWMO3uL5HqoArefMlnzuZXn2wOoiSqMgRfz
         PtopnbzubUGYSmj+wVhQkrd12ycqQd+pjpcjxsnYPRGUss451uMKSfAqoCvPiumcIKKe
         ZrirHWbdjuX7eB27CkFop2vkSc6Wmf+rBdGdA8ySqmpLlKdgAElZ0XIntY9TTJCT4qZJ
         aNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZOnNnTCVTRY/rWJXMtzKNmCgdIsffrpi3tbSI8c7J4=;
        b=Qc6guLmawCavM9naHgzhWX/tdrm+uZjZL95wLBEEdqV9q3u78i7lYPEnCjNnca6rgy
         GuDiSBbqLHbXY2vfgf7/XpbbCHpZ1EbfbPQUr1pZZ3x4YHThdZRgkCMhERV+UM1BAHbG
         AlX/Y5mh5SRQQKWxRQKwBN1Ky9IBoGspoegp2MrZvD3R3RcF3nIoSqWamzIja0f0R+nm
         pJA+KyHFRt+Wt/I9Pdqmzjv9neHD6bDcwuQEoVDEkzz8ART/vHqG85J0sV6c7anecoea
         yWlehpfKRpUfGWPIiPjD74WQ9ONxs5qg2WmQvhwRzIaDBQbfj+VFCeOLpXVASmdNsWB3
         H37A==
X-Gm-Message-State: AOAM532NEpEKL/B8YCNL0j48l+YlfUFWV4uvK70f6cvPVFeQdweSmmi8
        euOEWfSZ+sVynM/llMN1akcuIQ==
X-Google-Smtp-Source: ABdhPJzMyoC4DOfn4V9NQqVWoH1h/6wloafRqzwXUIG1CM19qy+Y6xHmJtSog9aJmdbELn9JC0aFcw==
X-Received: by 2002:a4a:b881:: with SMTP id z1mr17873729ooo.68.1634484690670;
        Sun, 17 Oct 2021 08:31:30 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x6sm2565698otp.49.2021.10.17.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:31:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rajesh Patil <rajpat@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, skakit@codeaurora.org,
        devicetree@vger.kernel.org, saiprakash.ranjan@codeaurora.org,
        mka@chromium.org, rnayak@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: (subset) [PATCH V1 0/2] Add device tree compatible for sc7180 SoC
Date:   Sun, 17 Oct 2021 10:31:16 -0500
Message-Id: <163448466184.410927.7767773426580899721.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1632997450-32293-1-git-send-email-rajpat@codeaurora.org>
References: <1632997450-32293-1-git-send-email-rajpat@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 15:54:08 +0530, Rajesh Patil wrote:
>  - As per Doug's comments
>    1. Added device tree compatible in dt-bindings
>    2. Added "qcom,sc718-qspi" in qspi node
> 
> Rajesh Patil (2):
>   dt-bindings: spi: Add sc7180 support
>   arm64: dts: qcom: sc7180: Add qspi compatible
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sc7180: Add qspi compatible
      commit: dfe28877db61e82ba3b57b50d73096ef11563d72

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
