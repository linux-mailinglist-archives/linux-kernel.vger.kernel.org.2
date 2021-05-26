Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B71539233E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhEZXbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbhEZXby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:31:54 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5CDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:30:22 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so2685443otk.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=WH/Pvg+iFRL2fU3yGM0sAjeotax1q+zTlEiDNdpHeUc=;
        b=WcHs0UfzQ0ntRcL5vkeV3uf0PZU3hNBdJRipshpbd3fUPQYfLM/rEoswcw31y2om4E
         PZbemZIppgNvRqOuNzypWZGNVlNlUPkwXjtC38vEF2Y1NrwrTtN2OvKsNJDypqeukqRf
         5mb++kCTw58Rclym7QrVPuPBboHLoAzoJgtho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=WH/Pvg+iFRL2fU3yGM0sAjeotax1q+zTlEiDNdpHeUc=;
        b=IrKAS3i5PeCujFqqET/41XTSl0ibk56/1k9HvWHSyLYmfv6w/Hrq3XvZwoOP+FPIgN
         LrLy2s1w/NQPnyL8XETimw67bXQQWAnabvXrW2QvwmYgEJ+SNN7TFHKNDWIVxz/VKRVm
         20rn4Xj116eoHaaOgkDgUd5SKuj/UtNkzqmTv8S+4cYHx9OfJ155Ky9EszFxtGFusZX4
         DAT90+6+DKVqKC3h2D0jLPR8lJZrEmfEReMTf6THjnY1jSFcnscE/MLtGK+kV2Qwpksq
         Aa6sqF89fPmhBW2OX8mPmopeepnDAyrYTHf2g5C/rIe4y58W+QTnivxisMwStMhFP1ao
         3nPQ==
X-Gm-Message-State: AOAM530hcFhzvkObG8IA7Vc9/u7ckou4ukPfhsgNR+uHY68S6nwbiUGy
        UFCm+Br8zt4DtLW8iSWevgxMvbTRFeDdxR7x5LOABQ==
X-Google-Smtp-Source: ABdhPJys4EGuPlpiHTWRX12rssPtYCoCsF+frDQzGBZeJQeeul5Xxr3aJhfjTsI1ACEixLit3AqHx4evSJYMy6YkDyg=
X-Received: by 2002:a05:6830:1f51:: with SMTP id u17mr558111oth.25.1622071821627;
 Wed, 26 May 2021 16:30:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 May 2021 19:30:21 -0400
MIME-Version: 1.0
In-Reply-To: <1621596371-26482-5-git-send-email-mkshah@codeaurora.org>
References: <1621596371-26482-1-git-send-email-mkshah@codeaurora.org> <1621596371-26482-5-git-send-email-mkshah@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 26 May 2021 19:30:21 -0400
Message-ID: <CAE-0n52X284R5mFMkOSYzFnhimz7uupfWG9cndtQC2dJtrqviA@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] arm64: defconfig: Enable SoC sleep stats driver
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, linux@roeck-us.net,
        rnayak@codeaurora.org, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2021-05-21 04:26:10)
> Enable SoC sleep stats driver. The driver gives statistics for
> various low power modes on Qualcomm Technologies, Inc. (QTI) SoCs.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
