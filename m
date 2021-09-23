Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB54E4166BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbhIWUci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243194AbhIWUce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:32:34 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCDAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 13:31:02 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s24so8850909oij.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfgAPoqNGuGt4SJWxFhDYx6cCrPZC3ApVgwyVQdWxZM=;
        b=ChnyOEHaPJ/TAR3ZO07ITYZC4dk5cWTX5CBxf2SKvotJ87MuYQxnsdyR18WVvEE9Th
         xPVsA7CaQS+LgHHk9HKRqKp8G4wSZgdIYqoyU3hpoQ9oPA8fZfZm052PHIFBMfK68cvH
         o1KDHflaL6+bP6jA3y+obR9KV/z2auTeSasdCQNKP7KBrDtJYxluXhr6uiy2NPkbtN4A
         0sfAo6J8Tx+lQGBz7615tJZwXNIU2FYrG+bIo7uY6qIp4FJlJd6W1xDVD/1t3/zuC5yc
         IczFJOvaSfuSAT6sW2My5SNi5J8QyQ1SXBQXDQbuBpY5oICzeC0bWGnX1KPx/nLjAvbo
         +AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfgAPoqNGuGt4SJWxFhDYx6cCrPZC3ApVgwyVQdWxZM=;
        b=KMJjd8n1rhaF2873/kLcCFgXcZNZqVHQWtonk0Jpyfy+ps1akoLCI7+JFN8o1OGldR
         eK/o6GAeMpk/kyysO/BpuN15EzzmkxCE2YGYYz6ROuQwycn6V7Gnq6kUiaTqx6UgzjeR
         RrAJZPzBRBChkIOAo3UfPGPmGxuyTzN4+F2guIGJQk365DpFCVpqgkgGHbCydS/8iiT0
         Hh5iHaHY05bR75kR4JM87ZvUADl5Nk/IJrfKhPVdaR3PplRohbNWZWpi+pHy9z92qcC5
         SyNlVtJUWiBVwdicubTzm4A18ato30FuMXAKDbQn2t+baULCyCHF1Ywf6BoGCcHxAhhG
         IEPA==
X-Gm-Message-State: AOAM531LlTOOJS37anI0lEHdpExYvMRZ2H4BXHG0NYdMW5BWL5m+uKoI
        lGyBAarfyJdGr3nI47iGHXt1pA==
X-Google-Smtp-Source: ABdhPJxWTm6CaT1ND6bGaFNTSAKpnrLv00eqNbrx0WnULUxuw/bK1fjd8KciNlyMULO9ikiI352lKQ==
X-Received: by 2002:a05:6808:138c:: with SMTP id c12mr13956146oiw.34.1632429061671;
        Thu, 23 Sep 2021 13:31:01 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i1sm1583036ooo.15.2021.09.23.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:31:01 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, robh+dt@kernel.org
Cc:     rampraka@codeaurora.org, sartgarg@codeaurora.org,
        nitirawa@codeaurora.org, sayalil@codeaurora.org,
        cang@codeaurora.org, linux-mmc@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org, stummala@codeaurora.org,
        pragalla@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org
Subject: Re: (subset) [PATCH V1] arm64: dts: qcom: sc7180: Use maximum drive strength values for eMMC
Date:   Thu, 23 Sep 2021 15:30:59 -0500
Message-Id: <163242893971.825761.9292228692666120286.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1629132650-26277-1-git-send-email-sbhanu@codeaurora.org>
References: <1629132650-26277-1-git-send-email-sbhanu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 22:20:50 +0530, Shaik Sajida Bhanu wrote:
> The current drive strength values are not sufficient on non discrete
> boards and this leads to CRC errors during switching to HS400 enhanced
> strobe mode.
> 
> Hardware simulation results on non discrete boards shows up that use the
> maximum drive strength values for data and command lines could helps
> in avoiding these CRC errors.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Use maximum drive strength values for eMMC
      commit: 752432e40e8f0d02d0af07cce2d6d4b250be11ef

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
