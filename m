Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD07A413DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhIUW6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhIUW56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:57:58 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48501C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:56:29 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so749014otq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LH+ETmo9LWgYNAgeVSdVN+z5zfF4ODKn/ZsciZKx+D0=;
        b=oZPPuE6RkDzEC7Eby8dVBKnnQcfe3GUZXQVXioFiHWTtaFwbL2ZkDELgXP5PNZraKQ
         2yfwFG32TSE9n3TLMIcOuGze3qS9tOr6xS42ORATuUiiCpcKeebenXxgjiqxRXGPJ0FR
         3wuyc4ysM+2cgDVW3QnzLZhcsm/iOQt6fbVsxOMRgy1hlwD44Nzfr/v3wv8DP7sIE0bu
         4b+TLH14vinVQWyb8/XicBvW56h7UbbEBLswCffjOXPigmiBejSdoLZvkCE7eX2cvQKh
         1VW6yTZvEMmnwVec9DqDk3EcnLmWbEYuMnkwBd5mfRn3/8sJGHQuHzHAmQAGLoUME7TF
         C0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LH+ETmo9LWgYNAgeVSdVN+z5zfF4ODKn/ZsciZKx+D0=;
        b=HOtU6HU4HVMcZ3luO0ASIC0JJpM8/RqgxmXhb/q+r8+Dk3M2eKiUSrBWi0dy7uq1Fn
         xCsYTKXFqzfr+WCUV6gGGvKNmmVt7docMNOTzl+BcVlBrCsdkWmRsKLgm25az198xLgq
         UZH79AHb23t8sROJgV5zooIRdP3neGxSapQzepukEMbP+MygMPgeerGLDJWph1GXlNA4
         +POtFwNyvfYV1E/tiEF0wJRlPPETXDO/hgk1cf3q0mz4f+Z4y4TUtgsz78WgZVVznUAH
         hBn4MyLaoJnRlkckIj++gqL5qMC67/9YZ8EBMbkJsZmc7sYhJyAjyw+VQ0/Wv5JEYsPM
         ocVg==
X-Gm-Message-State: AOAM5333fzguCpow3auqe1odyMKJfNlISLtzQOSLwb1DwzKveatC/YIF
        77dz62AwVewvCDxC6SSNhhFwLg==
X-Google-Smtp-Source: ABdhPJwgdBqevp3sdsmAeRFmqLBb0Kz22xgrazQEEXPESLmkIJ4Y4h5N9Lzp8jxmlAv2SOV1/lSCPw==
X-Received: by 2002:a05:6830:128d:: with SMTP id z13mr7525542otp.19.1632264988628;
        Tue, 21 Sep 2021 15:56:28 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z1sm118174ooj.25.2021.09.21.15.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:56:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Naina Mehta <nainmeht@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] soc: qcom: llcc: Disable MMUHWT retention
Date:   Tue, 21 Sep 2021 17:56:27 -0500
Message-Id: <163226178548.611555.13438992886720395824.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210921055942.30600-1-saiprakash.ranjan@codeaurora.org>
References: <20210921055942.30600-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 11:29:42 +0530, Sai Prakash Ranjan wrote:
> From: Naina Mehta <nainmeht@codeaurora.org>
> 
> Disable MMUHWT retention for SC7280 as done for other platforms
> to avoid more power burn.
> 
> 

Applied, thanks!

[1/1] soc: qcom: llcc: Disable MMUHWT retention
      commit: 81ec1ab4fc0d52a380f65ce32437a78be35cbc56

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
