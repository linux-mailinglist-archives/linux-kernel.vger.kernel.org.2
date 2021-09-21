Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAE0413845
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhIUR2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhIUR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:28:49 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D19C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:27:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a3so204386oid.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4Dwfj98Yc1HEfTOzYMhxAK48M6ebYAEnvZEqsEY49Ik=;
        b=CO3RLCAgcY6ehQvKXBEDiG3P0K9ffpetCgRl1POMt2+HhdlFu/xjBJfVJpkRP+MTLQ
         p0egexm0ablmUuXMSXcTBDrse+pwp5K0M0YRM+hSRGJhHGA7xQwlDo3R6d8Y/Y3/pQtC
         tbHSvzrHY3xOnzIG1X/b3+6NQ/5QEp6LMhX4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4Dwfj98Yc1HEfTOzYMhxAK48M6ebYAEnvZEqsEY49Ik=;
        b=1ScSZtSnOcC/dGlaDVQjhYWeqpGe0fvmtDpiznl4gKD21ktLshibP91+2XlQsObUAk
         p6ZIcE/kfNxKoUlV4oinc3E/wFj/cdleel3nPGAbOzxx5rqkUEWD6GZ8n1JiCDJ85Gd9
         sF38aKX4IHk3AQdNKA/a5l9cro35GLWsLGZGXT6QP5KG8vw4w4Q2Cgf/ppiHdq03kQxN
         WDI38pUuULE8zHUFhaW+IVMtcHqTRiaxnIkbRVBm03+4qTifYlKE0pZIZzedU5UPVigU
         bA62YCdE4xiEgbt9jOaH/jEBzKDKP1qjTMALsoHVX09K6BXrEuIoGoahMfiGoN9rJk2H
         M+ag==
X-Gm-Message-State: AOAM532aPuJzcn57MTbE7h472dfoisyMWUcVTxumyPq4nRRGdJTV8PI/
        7mskSvZiOcQL0I+ZZI8HCqJ7W4/uZZPGxVYtODx9Cw==
X-Google-Smtp-Source: ABdhPJyprcnvduIyewp0eo2HDH71eHPxrC3yu4FcnWSJ/10YHdtfTC+AvDmg9iuGw8fIf6v6TkfnHh2CAcrqnnq6JOQ=
X-Received: by 2002:a54:4419:: with SMTP id k25mr4696213oiw.32.1632245237527;
 Tue, 21 Sep 2021 10:27:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Sep 2021 10:27:17 -0700
MIME-Version: 1.0
In-Reply-To: <1632220467-27410-1-git-send-email-deesin@codeaurora.org>
References: <1632220467-27410-1-git-send-email-deesin@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 21 Sep 2021 10:27:17 -0700
Message-ID: <CAE-0n51kCczyefN0r7Wb4TRa1mUWiCdkRqfooDdfnyD_jUq8PA@mail.gmail.com>
Subject: Re: [PATCH V5 1/1] soc: qcom: smp2p: Add wakeup capability to SMP2P IRQ
To:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, clew@codeaurora.org,
        sibis@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Deepak Kumar Singh (2021-09-21 03:34:27)
> Remote susbsystems notify fatal crash throught smp2p interrupt.
> When remoteproc crashes it can cause soc to come out of low power
> state and may not allow again to enter in low power state until
> crash is handled.
>
> Mark smp2p interrupt wakeup capable so that interrupt handler is
> executed and remoteproc crash can be handled in system  resume path.
> This patch marks interrupt wakeup capable but keeps wakeup disabled
> by default. User space can enable it based on its requirement for
> wakeup from suspend.
>
> Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
