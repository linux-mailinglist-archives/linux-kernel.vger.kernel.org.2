Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DC841DB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351340AbhI3Nhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351494AbhI3NhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:37:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDFEC06176E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:35:33 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e144so7539944iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbEKu1/TvJPQ4Z2h0b6Gx0hXWCi4B3ME4HJBi8xU2sI=;
        b=ebdsjkrcaH7CkAYfRMGMlQzpTq2ttq8JNlE78u35qQkb7PkZwKuDFMV65o/txFLLp6
         O32jnwJtMXpU7CjUtkTHO2YsgHGLkLMDHFanpI/nQ3c15cIU/zVKtXCa+bf/aDSH+FTU
         01mj/Gzz513YnIwm6spZEseoZAyNa/uWEovEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbEKu1/TvJPQ4Z2h0b6Gx0hXWCi4B3ME4HJBi8xU2sI=;
        b=wN+m2zp3TzGYjhKCFZpcx9LElsz+PfwIzbecsjFWsYW6XP8YJSMIy57QldIq0Vobjq
         BuzfPgRKRgwLFIfmjBFURJFAwBjC8ZCxujY/E+gbs+mLKuYtcPLiHZeepaWke4D9KzlA
         886K20ndTA0Vv0kxcrzbztkJPPoByN4b1zdRjY/0GeH1oxHVPsF65iFZqdt3B1mRaOJ0
         EXyE6vhkk1+D/Lm3/FhZ8n/2Y7Kg7Zxe8tgFUVLBufMiK4acnTKmYJMLDFKym/GJSz8q
         s2Um71GkV1LboiFi8lArixAj6hW06G0t4fJVAYHWITWaseFI8/sBdnfPb3FTySh/getz
         9Nnw==
X-Gm-Message-State: AOAM530PSaarqBI6YlTCK/ceLwVoobEC93EMr8BuYVaO/SMcyYWcL2rF
        8ldzzd+gMZ/rIRA3wXk3SNP+a4UkZD7VHw==
X-Google-Smtp-Source: ABdhPJxUscxVL2Q/TWu5s9Xzq/+6mjMDkyIqUueSS1OnLjcCOMD+vLU08vRuhQG7V8bBhngJ+Ubbng==
X-Received: by 2002:a6b:7415:: with SMTP id s21mr1165750iog.168.1633008932675;
        Thu, 30 Sep 2021 06:35:32 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id k14sm1690105ili.35.2021.09.30.06.35.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 06:35:30 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id y15so6810304ilu.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:35:30 -0700 (PDT)
X-Received: by 2002:a05:6e02:1bad:: with SMTP id n13mr4196229ili.142.1633008929712;
 Thu, 30 Sep 2021 06:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <1632997450-32293-1-git-send-email-rajpat@codeaurora.org> <1632997450-32293-2-git-send-email-rajpat@codeaurora.org>
In-Reply-To: <1632997450-32293-2-git-send-email-rajpat@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Sep 2021 06:35:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Veo+cRCRT6p=Di36mnO5cp7p+EGOUSo351-y=R1znGbQ@mail.gmail.com>
Message-ID: <CAD=FV=Veo+cRCRT6p=Di36mnO5cp7p+EGOUSo351-y=R1znGbQ@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] dt-bindings: spi: Add sc7180 support
To:     Rajesh Patil <rajpat@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        msavaliy@qti.qualcomm.com, satya priya <skakit@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 30, 2021 at 3:25 AM Rajesh Patil <rajpat@codeaurora.org> wrote:
>
> Add device tree compatible for sc7180 SoC.
>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
