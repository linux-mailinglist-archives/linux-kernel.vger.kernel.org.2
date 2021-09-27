Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0845F41A36D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhI0W6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbhI0W6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:58:00 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A274C061769
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:56:22 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w19so27655268oik.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMjiukEeXiZFVRWtlwyHpC3JjZiBJVauvf1aeRHULKI=;
        b=PjdR9Il4Q/rt08SD+caIvLFmgNcungmr7UkzPPWRQ9S3K3SN3o4SZbC8pChRLFNRbJ
         +6ZYZyjmsk9Ywg4798ozjvYmzf3Og7aes+EUoAq4IHzOYMugGVRDKzuUFEXHfEX/NU+3
         t+w0r6mg25sOEMbVIsSezCrhqpBSPAhs/AoZpfN3nh9FFZJKU3MTm7K6iRaY+RoiL2d9
         BjzuDl+WcujjkzsbiGhhtMWt/+Y7AORZWcSGgWDz8iv56OVMcdVWZN8+cN9hGD1eCU8a
         gNheWmCIts7tHMJOTsy9JlFTuO5jn8olvMXVcCHRNXew3LIA1ZjoqiztFEuHWSviX6Wk
         ImiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMjiukEeXiZFVRWtlwyHpC3JjZiBJVauvf1aeRHULKI=;
        b=pH8kyJMuunHSP3QCbs4PanITHQ2P7OCXVWmUnBhEPREdVNYEtMjUkE1/ZXlhQpjdlf
         NypY2L+xw2T1adgaUZNb6KRA4LavKhdxWPkqp6aEVZizOZ5YAG7v/eipe0WDjcObzIzK
         2vw5uLkkkKW1l2zXAa8SN2I1G6PjhwnuQgJ12Vw2tw5B34nPAlzLhodHOpyobldOHPXW
         PPulM4rApJNq2qbqYqcX04e1UXT94cuoVFyRiiZdYMasZ5NlAZntmm1hBc09yDvKV8V5
         h1AIApqE8t2XjEaiz/jlMtvXkVR4ACV3Sz9Q9hWxUNFTFFW4MssexhW4R/dYa3TtFf+i
         fCsw==
X-Gm-Message-State: AOAM530q3+cHTDCMHB+CZKx5N+Wiw4C8pchcr2EkRDQ7gX9gTjw5Umro
        jLXcphNGv7QaaxVEXM9cHtMbMQ==
X-Google-Smtp-Source: ABdhPJyrAGGE6QbpnxmpbK0yUmcwZWbLPGlb1SQYiQaWt8D8RQp9ZWVjPVErW9ac/0tlMXsBp0OSYg==
X-Received: by 2002:a54:4d8f:: with SMTP id y15mr1201486oix.122.1632783381824;
        Mon, 27 Sep 2021 15:56:21 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w184sm4231084oie.35.2021.09.27.15.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:56:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 3/3] arm64: dts: qcom: sc7180: Add IMEM, pil info and download mode region
Date:   Mon, 27 Sep 2021 17:56:15 -0500
Message-Id: <163278329750.1522839.9364673844022845827.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <39064a2db95ccc2cb5eef003569bef2de651c8ed.1628757036.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1628757036.git.saiprakash.ranjan@codeaurora.org> <39064a2db95ccc2cb5eef003569bef2de651c8ed.1628757036.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 14:47:42 +0530, Sai Prakash Ranjan wrote:
> Add IMEM, pil info and download mode DT nodes for SC7180 SoC which
> will help in the post-mortem debug.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: sc7180: Add IMEM, pil info and download mode region
      commit: ede638c42c82b1e6648a3c6ac71aaf088ff830e2

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
