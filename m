Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414543D085C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 07:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhGUEyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 00:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGUEyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:54:40 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E056C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:35:17 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id a132so1712522oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rQpCAkgrAskAus16qnKYoxQHVyMQBHW5oXvWVZnigD4=;
        b=AY48ZR0/TP2vWf9WOMHDdN0p8oa2/Q8ICxChYJZGaTTHtOyYx73/TDu6lmIJAOh1yV
         HwKcVqeOiqD+qmGcnydqp+Lo3izxP/Ec7rwn3tLVIEv1m7w17kiqx9J9UQCv63tPiloo
         U+YR10BceD8lfOzuCo7KaqKcwK59ahOKFux8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rQpCAkgrAskAus16qnKYoxQHVyMQBHW5oXvWVZnigD4=;
        b=MG57Av03UYI7LzpyHZ1DyOw8Ylg9pHgK1W/FymnFAOa/N5B/UuDmc+EKGQB8wHRqYk
         IMJiIr1S2zU/lmvbUnQbztpFuAodv1WofliZIBTKhy59dr1Y2KhswYD+HipSbM7H0gn2
         ZoHprGLk5uQ1o5zVO/sLS1i5QpkzMlJO69gno8Hnu6pv4R5odOyci4iobxBjiqCT0jh/
         eeEqiCs3RAdF2e70y/LDjnDwlpS4zQcR07YKelEATAeDOo1s6CNv/kfvdyxyMtKfenxS
         nfvQDUySJxhrzg00/ti56tH4Yx5u1SB8IeVt9D7ee3s6YmWD4nuIgy0J5IuMv3Me1nPe
         GNwA==
X-Gm-Message-State: AOAM533pyZ8ocMJyzY5GOALq62E5KBgge3u06GGkcIyC/ZzHEbzeA7yN
        FV8Ilo9Juk41pw5SVqmhYzbO+lYZ1gXlwU5fEhTsMg==
X-Google-Smtp-Source: ABdhPJx+cEJmFIdjfVR6nkBubyn3UQ/HrY8tcpXWVQvhLG6AVVRisZBXAz1jWEpyGvSMCjScfmQngQhkvOasB5s06xA=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr4788233oiu.19.1626845717063;
 Tue, 20 Jul 2021 22:35:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 05:35:16 +0000
MIME-Version: 1.0
In-Reply-To: <1626755807-11865-12-git-send-email-sibis@codeaurora.org>
References: <1626755807-11865-1-git-send-email-sibis@codeaurora.org> <1626755807-11865-12-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 05:35:16 +0000
Message-ID: <CAE-0n53WE+s_Xzpih-k2-7+T2zktvAGx9+gz8oV0pTerZZ4sYQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] soc: qcom: aoss: Drop power domain support
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org
Cc:     ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-07-19 21:36:45)
> Strip out the load state power-domain support from the driver since the
> low power mode signalling for the co-processors is now accessible through
> the direct qmp message send interface.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
