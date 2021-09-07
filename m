Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC481402F55
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346158AbhIGUCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbhIGUCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:02:33 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029B3C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:01:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso582654ots.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=9Zw+ENmJBvtIj3INdZqSWHDc9XknMQ4poMiOqfGky9k=;
        b=N6kpr1y3WSumLzx9C+Q1Xl9F7ehngVdHOqu4nbZN30ggzXpYYeILncVCU3G0Le1aBF
         mtuP33EFdSOC7tJe6uW/VL2w9XgEcFrEfhB9j0J1AinEe1/LG2agZh2xqxDO7faseCft
         ppH5DeKIdxLZ7oM6qaxA4MOGLInnyiLWDqLGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=9Zw+ENmJBvtIj3INdZqSWHDc9XknMQ4poMiOqfGky9k=;
        b=oUriUM5O29UdG5nmpxyKOPtYryBng87EHAHLA47eE0+zNIAWeftAqwMLu+gVqXRuYQ
         nY5y5PqcD94eNXrumrMbdur7xQl+OFkQRdzBeVGmwheSDyutIgRq6Ot3AR++KkX237Kc
         xa+xofMGkfHKi3hg8LO6jQGjefFiaTJARhrcGqwSO8iuF8z/TNShbePvTbrrIHtaov3S
         ULirh6aHlV/s8nGDW/VtJjXQQMfjCFEUFoF02daTpWcKQ5WvdZeSii5PT8ZX/s2x2/N9
         CG9/75kR/fXSEVwE7df7fKc9LDsRRpnJLrwogvCalLybHaURAiyzgyp9UaiT4XkvPbST
         4vKw==
X-Gm-Message-State: AOAM533QVKRDUT9mIgYnfmpHshKr7bYfwsy7GlHeVQBNcv+X8Tgzt9wF
        qh1F58LGKsfQeW1gZDcAfKGcry+smZxT8V35JeIo/A==
X-Google-Smtp-Source: ABdhPJw6kZGLqVVN2awlrCBOX28FZkbtM+22KzHFlQj9SR7EoCtFKrTWdARqtlf13fI6bZedxgJFZTkj9lPeBVK2G7g=
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr128559ote.126.1631044886290;
 Tue, 07 Sep 2021 13:01:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Sep 2021 20:01:25 +0000
MIME-Version: 1.0
In-Reply-To: <1630918485-15052-6-git-send-email-sibis@codeaurora.org>
References: <1630918485-15052-1-git-send-email-sibis@codeaurora.org> <1630918485-15052-6-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 7 Sep 2021 20:01:25 +0000
Message-ID: <CAE-0n53LwrC=fL2_p-KQXpCP_1+rwteQbb9m0ejFHYz7G8Dvbw@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] remoteproc: mss: q6v5-mss: Add modem support on SC7280
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org,
        saiprakash.ranjan@codeaurora.org, will@kernel.org
Cc:     ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        robin.murphy@arm.com, joro@8bytes.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, evgreen@chromium.org,
        dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-09-06 01:54:40)
> Add out of reset sequence support for modem sub-system on SC7280 SoCs.
> It requires access to an additional set of qaccept registers, external
> power/clk control registers and halt vq6 register to put the modem back
> into reset.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
