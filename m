Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFEB334C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 00:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhCJXOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 18:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhCJXOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:14:10 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AADC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:14:09 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id m11so27821137lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKBkQ4taidvPT+w4EteeOYBoZyJgs8TNZ1BWL29YzFc=;
        b=Na0VWH/+PqDpdj52pR54r6QKfmjl0otFfewiwoGPWY7bV4Z9bvdJxvB0OkE/p4WqfJ
         1v7GHpj/rojgQYPqHow4vDV3l3nt0JFX5yhWqzjg/+CmMAJTE1+OIGfQmUwMKOHf+6KZ
         UtrlflzGefkZwhelEQPKARaUYugjC6Rnvcx5SY1T9Q/OL5di0DReCY2AyCXL4ZMyy51Q
         5MNweZBaJvl7t7l//uP/i/O3bPOv2i3I16HRVT3FLBFaD0O64okVhKuzaTe6+RhoS7uD
         fyXOmvauudfuSfA0bfgNXDanTiFL0dR+742do0LbDv3FlNJtyhGDKw3cDZWQ8fr+MWba
         FFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKBkQ4taidvPT+w4EteeOYBoZyJgs8TNZ1BWL29YzFc=;
        b=IlDZvLz/oNt6iDyeu19MnzzJf/4Q45l+b6NNKELCIpCQzpkvzOe1Lbwsf5l7Z0Rx6X
         TrMP7AwUa6x2DiY/2NdLD6BTbm383NNy8UJ9krLr5g/IhF2+XjCXoxfzewYkjr8YtzK/
         m0jCFSxraTTUdnOF8Be7h1qB2vqzyJ1E7yyivFnLASHzMXM6otpkdr1v6ZuMY+sOF1oT
         gOFrR2YbunRWxo7AQFrnBdX2ZlTu22vvpxa8+ZVQeLyG1dOotgsjALAQawEonq3jYYyl
         ETGzCFvNBl1GsSRbcrCEmk4cXjCqfnaaO6Jm73D8azJ42bGJ9Q/aRqXa+uTn4GS3Curu
         wzQw==
X-Gm-Message-State: AOAM530Iik8qF7/QEnsEkjjBy4zphmabPzjGxtoTH8n+gxqacn42dC5p
        4xMqTaUnhdwc97xWWdtrn5lhBOdx4xgOBRTSlfTxag==
X-Google-Smtp-Source: ABdhPJzoH1id55M9n/ktJsN7lcUfkG9Te/mK125L6n6433wa+UhQcuZo680G99PeyNnE2FxpoNANEDpH4kd79XP6jRM=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr3110524ljj.438.1615418048231;
 Wed, 10 Mar 2021 15:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20210304194816.3843-1-jonathan@marek.ca>
In-Reply-To: <20210304194816.3843-1-jonathan@marek.ca>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 00:13:57 +0100
Message-ID: <CACRpkdYn5sau7f4R3uNJe44nB3704pCQqnp0DysDinW1V=ZR-g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: lpass lpi: use default pullup/strength values
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 8:49 PM Jonathan Marek <jonathan@marek.ca> wrote:

> If these fields are not set in dts, the driver will use these variables
> uninitialized to set the fields. Not only will it set garbage values for
> these fields, but it can overflow into other fields and break those.
>
> In the current sm8250 dts, the dmic01 entries do not have a pullup setting,
> and might not work without this change.
>
> Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Patch applied for fixes!

Yours,
Linus Walleij
