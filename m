Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1DF45417C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhKQG72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbhKQG70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:59:26 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F3EC061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:56:28 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id w5-20020a4a2745000000b002c2649b8d5fso190352oow.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=5hi0dTQ0bgJng2njz1mkZU8B/uJ8AXVykozTffCQIl0=;
        b=DoPQGzC3AwQ3lZGT0z8n7xkQIZ/96SpIBYiAAoS8/08iSCgP/MTeyiNjdXhsD4Abc3
         V/7lOvSQM6gUAQaCWlor2YpdmiyMBSYoEM+xw+jYIM0OX2zwi3XjQPM9iyLHO2JYDUCH
         wInLzssZNqpcKYrIyf3jCVHIP7hkLHUPppMzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=5hi0dTQ0bgJng2njz1mkZU8B/uJ8AXVykozTffCQIl0=;
        b=cA+67pFJtINPIi11CZGJhlH+2uEsDX17fk1c6yzDVnkq7FU7yfNZn/3eSyvpNIN/Ce
         wB4OPAuQM1vATW+KAdDW0J4bRj9/6V106xvfXZKAZPph06xa8OLzXuqz4r8sDdkFxm00
         5HM1vh1ZoHA6eAIS4nixFwODacgQ8hW8XyVGYfH6T2VWjM/rCIrW3gHh1gCmZCyoVBlC
         t4WvVLJMBpQhFdl1MipbFn5mBfWYb95Xwl0Ba6undsEBUzipM4rANVaI8wqwioBNTZ66
         FPAX/I06mNU3u62neX4IA2ahnLeGpLsS+v7JPJ7LRKr9u4HCYcdpr8q/fsNOzBAfIJeH
         ykCQ==
X-Gm-Message-State: AOAM53080lbwPbZumJLVeLqK+jvLkltdEZV8MHos4y9KApGXwjkoNubv
        ID8Jfg9jUQblFXtMhpUfmhKiUfZhZpop0HnKt9VvSg==
X-Google-Smtp-Source: ABdhPJxzyge8aVq3hI6xK651KJ3Q1dzB7runhpnnjZrY9z9YA8THzH/yCh0x36cT4HihmUGUR9uaFSNfvjLXcJrSIEM=
X-Received: by 2002:a4a:cf12:: with SMTP id l18mr2689044oos.25.1637132187071;
 Tue, 16 Nov 2021 22:56:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 22:56:26 -0800
MIME-Version: 1.0
In-Reply-To: <20211114012940.112864-1-konrad.dybcio@somainline.org>
References: <20211114012940.112864-1-konrad.dybcio@somainline.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 22:56:26 -0800
Message-ID: <CAE-0n52MkOx8KC4jSmEHMhmk8sDDf0YNMWhvH-g=Y=OJvA-+1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: llcc-qcom: Add SM8350
 compatible and defines
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Souradeep Chowdhury <schowdhu@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2021-11-13 17:29:38)
> Document the compatible string for SM8350 and add required defines to the
> binding.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 1 +
>  include/linux/soc/qcom/llcc-qcom.h                       | 4 ++++

Why is this include file part of this patch. Shouldn't it be in the next
patch?

>  2 files changed, 5 insertions(+)
>
