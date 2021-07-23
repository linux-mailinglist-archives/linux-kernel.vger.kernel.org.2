Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F63D410C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhGWTDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 15:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGWTDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 15:03:21 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBFBC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:43:53 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso3088581otb.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=QNZENHO+dKLQGyNSvg/QhBqsuG8rka7B9Jc327gNXJ8=;
        b=CSNnsWrOFG1ZAcdGGRrgOLzEMCaNMWwKz0MzVZd4uW2ixO8KgOX7KWYOKeIUp3lzAZ
         iDrsJU9Qa01k3fjKieGNzsdnbu4RAPYIdcxeQFjm/rXPXMJweZF8NpOmBhxtSOzfwScX
         4Vus3o25vEr5CDCVJ9KSKM2OTbTiQPMSKSYT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=QNZENHO+dKLQGyNSvg/QhBqsuG8rka7B9Jc327gNXJ8=;
        b=GWydOvdaKLGClJRXgSE4urqXgzNtOzBaVYO83e3QWjnMoHzgRbFLAzMNxquFOeFikL
         NYoeR2riMZwWOOb0jQYDlWpAPyN+9Kbkns8pH/UVFZ129nTWVNjXlnRFWpZZOewvWG4I
         1n8n8tBrnGrhd+MbWW8pnwb49dK2FgNUBKNZefqvFUNwVMqMe5GRST2hNli7RjHevkFL
         3wnScEhN4x8qFtTwh19B2cAhebrKxV+ln5CJPxDZvKtuKWj5hOQ+adD21phmi0oX9uXD
         XmVlI+OLzeZvhgG6IBCd7YT6EyJ2wFLYSOIHgOMDVz+KYF0HVJFxsNw3CNYNH3qksiNN
         1wNA==
X-Gm-Message-State: AOAM533Qiyo/cPPnLQH6P6cuUtbC/PxjDXiHXyCQ5gFRPEXciHzM1FC9
        w5x/h8/jPxPfaFkavvvD4jlPm/l22RBFh7k1a71baA==
X-Google-Smtp-Source: ABdhPJyJw0X7sgO5YFPGbIoQspf53Y3uWYvU+kcCqW1C12GCjYoNt/WALDXwdFGZSITulJdtesHgrrI0WwJgrAcaIt8=
X-Received: by 2002:a9d:1b6e:: with SMTP id l101mr4107722otl.34.1627069433207;
 Fri, 23 Jul 2021 12:43:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jul 2021 19:43:52 +0000
MIME-Version: 1.0
In-Reply-To: <YPsa1qCBn/SAmE5x@google.com>
References: <YPsa1qCBn/SAmE5x@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 23 Jul 2021 19:43:52 +0000
Message-ID: <CAE-0n51y=o+8SZTL_==GPXrDa2OP8fhh98Amv+L4M63rLQVGZg@mail.gmail.com>
Subject: Re: [PATCH] Input: pm8941-pwrkey - fix comma vs semicolon issue
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        satya priya <skakit@codeaurora.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Torokhov (2021-07-23 12:39:02)
> There is absolutely no reason to use comma operator in this code, 2
> separate statements make much more sense.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Fixes: 2fcbda9a822d ("Input: pm8941-pwrkey - add support for PMK8350
PON_HLOS PMIC peripheral")
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
