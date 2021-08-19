Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49AA3F203E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhHSSz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhHSSz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:55:57 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35813C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:55:21 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso9891964ott.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=mufyADO3wzTmydMEKiodSbUdOKfwxrgUWAkkX2NXaUY=;
        b=B5HzGRXYpErfLHRWHuRP+Zy33rYrnFdRVwP7Ah1gQGFk/i9zrg1aoABJzQa5YXItvx
         EqacP/RnFUoXW8QpswB3ajQvpr5tFQs9SFttQFyyGepb04kC6MSW7vr04ALR7Tp6YsL6
         2SKy8QijVzn+OMTjRbonokc8ztS6vlHAJCRJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=mufyADO3wzTmydMEKiodSbUdOKfwxrgUWAkkX2NXaUY=;
        b=VKIH87qqZaHUJZQbjtqTNaieVS5Tz/QEETo5QZC/3QQWn8WCkualYDXyO78he9Qbx6
         9hBcnfEINKw05Xwdr1glETWCwf+w/QgNYScgo0CvM0p8Br0Zj7EN+WbyPM6akR4wACCR
         jB+qVgPJyPiP+szW0M49ppBDB8zKY6seLuQ/Mm/AC1CUHWeD/dnVbkfsukktvFDKjydS
         CxHvYCl4BqHJ9qFC5fAuWpl9A3DiUol1qUOiF3xQnFTIBTX8fggrAX78cTrc8OgYJzTg
         mlJWdjBZTdc/7vakavULeK0y5zTCTYsUggJQA7X/2V9A9k6zbZgen4MQ8FqtxoYv4DXq
         nnQg==
X-Gm-Message-State: AOAM531oibqMI6ZqnA/QsgXIXvdwJhyoKQPyvZ2q2z7zc7aQiJ1CAd1V
        5fPJj243iUz3c2YuuC6hIyIMxNSDB22HuxudmGhPsQ==
X-Google-Smtp-Source: ABdhPJyDkjYCzIY8JFWkTKloRjmY7nhy+s5wTC7enDEQ0Fet6vpBNfNpj9Ok/m3aRJ2NEVoUarlpUJanlewegEVS/E8=
X-Received: by 2002:a9d:5542:: with SMTP id h2mr13355291oti.25.1629399320024;
 Thu, 19 Aug 2021 11:55:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Aug 2021 11:55:19 -0700
MIME-Version: 1.0
In-Reply-To: <1629342136-3667-3-git-send-email-sibis@codeaurora.org>
References: <1629342136-3667-1-git-send-email-sibis@codeaurora.org> <1629342136-3667-3-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 19 Aug 2021 11:55:19 -0700
Message-ID: <CAE-0n531EgLx-gGJswmmNAFmy-P9z=Hh1N=fkLw_uemoeQnYVg@mail.gmail.com>
Subject: Re: [PATCH v5 02/13] dt-bindings: remoteproc: qcom: pas: Add QMP property
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

Quoting Sibi Sankar (2021-08-18 20:02:05)
> The load state power-domain, used by the co-processors to notify the
> Always on Subsystem (AOSS) that a particular co-processor is up/down,
> suffers from the side-effect of changing states during suspend/resume.
> However the co-processors enter low-power modes independent to that of
> the application processor and their states are expected to remain
> unaltered across system suspend/resume cycles. To achieve this behavior
> let's drop the load state power-domain and replace them with the qmp
> property for all SoCs supporting low power mode signalling.
>

How do we drop the load state property without breaking existing DTBs?
Maybe we need to leave it there and then somehow make it optional? Or do
we not care about this problem as the driver will start ignoring it?
