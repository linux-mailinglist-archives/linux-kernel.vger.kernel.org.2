Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4431DEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhBQSL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhBQSLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:11:48 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB294C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 10:11:07 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h16so10178243qth.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kp4C7XkUvCKkyitZt4af77Yjtt5rxtynt/7/UUrqttM=;
        b=nWcCk8KtzOPRqRHRUrSWpGb507dYh0DntRmO/OKj0eEmS0h3E5g/bGVFgzEc+45cDM
         MEbpJL6cB+23N+JX9+urTWpY9AEibOipxoT2vn7PfKipnJgFERAArVtTYF2xw4cf5d3i
         am0xiG+SrEvhqBJ1+JYzIxGqz4bcFy9bHAsvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kp4C7XkUvCKkyitZt4af77Yjtt5rxtynt/7/UUrqttM=;
        b=S1DPJEanfVYQzGTwqGEWhL/0waCGngEqHebAFP1iBDCnln7ZyN++EV36cxc79nZmLL
         ZN6hZMPiPPKHfX+3YgUIX5qcTQKZBkp4MZnyBUoxp1ERX3CtSpdjkMeYHL/tWGgHp9gn
         8gQgBA2I2RBoKQ6i+wS1zBVaqxQMo0CGd/2sVE8jXYRF8R6g1aImtkZnCpu95AMe+r2O
         PxPFvZSCEP0TA3xrKcqnxlzKbSbXiVtDMLMJGI9vocWt7xTSuPlzWdKRy9IvNpOS9RiI
         DK8cRCySnno+LzYpVmSvDfTjpStGc/PRBauvF/XFsNdCzmkymYNRKu8By+ssWN48IKUn
         C4Gw==
X-Gm-Message-State: AOAM5301pX4exSyQoZTbMu47qOJZexKW22+D5J4CtDdMGApPoKiBicRx
        HJij9Kupt9azK70Tg7REnjKuDaLNmxIjiw==
X-Google-Smtp-Source: ABdhPJyjQy2xOfd4lMdDq9c7eY9abBoxzWaBQpv1gSiH9ljyquOJQ1COdpOlmhyBRySg+eWC+zUKPQ==
X-Received: by 2002:aed:38e3:: with SMTP id k90mr480281qte.119.1613585467104;
        Wed, 17 Feb 2021 10:11:07 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id o13sm2052086qkj.130.2021.02.17.10.11.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 10:11:06 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id x19so14716458ybe.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 10:11:06 -0800 (PST)
X-Received: by 2002:a25:4fc3:: with SMTP id d186mr774185ybb.343.1613585466302;
 Wed, 17 Feb 2021 10:11:06 -0800 (PST)
MIME-Version: 1.0
References: <1613582792-5225-1-git-send-email-rbokka@codeaurora.org>
In-Reply-To: <1613582792-5225-1-git-send-email-rbokka@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Feb 2021 10:10:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vcijx0CCSnJuDM1evGqaa42Sf4BURyVeHt0RnLX+ai8g@mail.gmail.com>
Message-ID: <CAD=FV=Vcijx0CCSnJuDM1evGqaa42Sf4BURyVeHt0RnLX+ai8g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180:: modified qfprom CORR size as
 per RAW size
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 17, 2021 at 9:27 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
>
> modified QFPROM controller CORRECTED region size as per RAW region size
>
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
