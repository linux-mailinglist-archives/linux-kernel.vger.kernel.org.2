Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E5C42FA34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbhJOR0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbhJORZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:25:26 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B226C0617B1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:30 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso13717907ota.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxpQ22uEFOzTdizhdSgRjmRNIbfRLMF5OEHx2hZci/k=;
        b=AoOdVFFCNGASwYtPggwIY3kKjtEyrnLx5OjvyCXsETVLYXJLP01iHaKMb/F+FD9Ldh
         e6/l8vGWUvl4IfIdskLFsdxqSRvydf+uXliumAc3nIcvti+PDDEljTKM4Vqejkyj4Hoo
         Hb6NyfPH2qZpars/HkvhVVLyy7jWl3xs9/AlAqCSz++0Mns0PcQu3zgja7Nm0SCZQC8a
         fV8AsI2eNJlARYSXvA3PBvbhQPgGHPNmH57uj6aRa9bH0IAWDU1UDwZcC0viQWDnjNSS
         V2zPly3Y0547fGA/mvCJJZF4SVcrnJxNIOLdj/hq+tpMfjMP/7iFefQdZmqsvOp9QOVB
         CHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxpQ22uEFOzTdizhdSgRjmRNIbfRLMF5OEHx2hZci/k=;
        b=xGzvanEquQQv43elPR3t+x+8KjkMIfdNgTeU1FuKOfYK6KsnsWZ8/El7vXY36BBxn7
         xNZo3/u6MC/uVcXbz9tZYRdp2q9p+duLq74VkGnh0OM+1MX+Zvpd1oYYEoOtDNQ228s4
         0pXkrJEGO8uEskKq2rjNeOQk62SCG+gU1haBUsLyXScJU/A8xF6oAFA7YRWUWt95KdY2
         0jBfnlUD/CSyb1Un3fOW3howjrHAHRKe3KtSq60T8B7/V9KLt+u0inx3iC+yEmYMD8OM
         9XRLFYL+Ko6tar4RC+gxKpuAlr1slT9nB95IRgp5a721a7OVzLe1C+t3xgFkw8CuqU05
         1KoQ==
X-Gm-Message-State: AOAM533iPvNmgMcIjHm3QdqzgbpbYXXh15HPNjM6ghvCGSy1w9zxezoo
        zi344rNF2M0g6k6x1ic8lFz+Yw==
X-Google-Smtp-Source: ABdhPJzHg/hVTcKwPamsBz4BW9uO80Y+xd/rRNLEhovszQcYRYy5ZHd9rDyE7RBnHK6lvd5mJEnUnA==
X-Received: by 2002:a9d:2c22:: with SMTP id f31mr8989840otb.303.1634318547986;
        Fri, 15 Oct 2021 10:22:27 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s206sm1289635oia.33.2021.10.15.10.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:22:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     clew@codeaurora.org, Deepak Kumar Singh <deesin@codeaurora.org>
Cc:     mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH V1 6/6] rpmsg: glink: Send READ_NOTIFY command in FIFO full case
Date:   Fri, 15 Oct 2021 12:22:18 -0500
Message-Id: <163431847250.251657.3452295022194898173.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1596086296-28529-7-git-send-email-deesin@codeaurora.org>
References: <1596086296-28529-1-git-send-email-deesin@codeaurora.org> <1596086296-28529-7-git-send-email-deesin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 10:48:16 +0530, Deepak Kumar Singh wrote:
> From: Arun Kumar Neelakantam <aneela@codeaurora.org>
> 
> The current design sleeps unconditionally in TX FIFO full case and
> wakeup only after sleep timer expires which adds random delays in
> clients TX path.
> 
> Avoid sleep and use READ_NOTIFY command so that writer can be woken up
> when remote notifies about read completion by sending IRQ.
> 
> [...]

Applied, thanks!

[6/6] rpmsg: glink: Send READ_NOTIFY command in FIFO full case
      commit: b16a37e1846c9573a847a56fa2f31ba833dae45a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
