Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1BD43F274
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhJ1WOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhJ1WOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:14:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804EC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:12:04 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so10760696ott.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=OHxLopxNEBanCZRKOtQcZ5uSqZ+qeUFTuCeN9w/lCos=;
        b=JLjHX6/8BiMeoxPRuWgnunt+TsIKdAQgoR8CnVpm6O2zWjouuINwX2w2NXimyHyMdS
         07wLyCV96TWEWIN2TawN9INC29Y7UxMpTIbRoHf2s63EPEHyJ6VgMtKpHjQKiWlqzpgZ
         k6GQ49H53onSLG6DJ8/uFk/oT11GpD7CZkRFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=OHxLopxNEBanCZRKOtQcZ5uSqZ+qeUFTuCeN9w/lCos=;
        b=n2QvE6vg3txxhnLA0YDkuVrXqBrYpn6ukLSnjNhoX01RPKAWmaTUWNnfv38fjwH62k
         nESE+ztbdt9BRKtnLjZyHqvVtY4C3ECvbN9Ny+f19qKysPLpA6oInRJcl9HhjUN2ffIz
         /HcN7BSWBekQxEFv97UECyPeznaE3KAfB0+YKs6AdEkeuCuSdOr0ZpiCsDiAuA2wZIrP
         A7r3lYQRLIn11ETyj9LXWGTqeuizxPSDxiKQyn7e0l2THR5uQnaXACBFH6S67OrOHY9M
         exJOH/xud8yZAJwqKnZYa3femq+bfAPm2ChbmlS2u4EJhLdqL58cd1Uo8jNCKVWjPNHE
         xQmQ==
X-Gm-Message-State: AOAM532KJO/nKjDA8mHuL5s6ReQdz6eYO9D6HLMmdfDJNNZ2/Uw9FWOA
        OB3vWgzL8hcPlA2j+BzXhtGVCAH5wYgU2qy1aDJTzQ==
X-Google-Smtp-Source: ABdhPJymYK7RRjD8jVuxnnAa91/fKSwHBCjvBeAtBGDqTrvqkslprxmA9McUv6qb/4kOS6YRYOGApzE+23oQHYB1iA0=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr5635145otl.126.1635459123556;
 Thu, 28 Oct 2021 15:12:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Oct 2021 15:12:03 -0700
MIME-Version: 1.0
In-Reply-To: <1635408817-14426-4-git-send-email-pillair@codeaurora.org>
References: <1635408817-14426-1-git-send-email-pillair@codeaurora.org> <1635408817-14426-4-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 28 Oct 2021 15:12:03 -0700
Message-ID: <CAE-0n53Xj_gCf4SucsQAHNF5fbfGpBzrCXzGyi3Jq6r=E=mL0w@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] remoteproc: qcom: q6v5_wpss: Add support for
 sc7280 WPSS
To:     Rakesh Pillai <pillair@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sibis@codeaurora.org, mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rakesh Pillai (2021-10-28 01:13:37)
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 098362e6..7d07e79 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -93,11 +100,143 @@ struct qcom_adsp {
>         void *mem_region;
>         size_t mem_size;
>
> +       struct device *proxy_pds[QCOM_Q6V5_RPROC_PROXY_PD_MAX];
> +       int proxy_pd_count;

size_t?

> +
>         struct qcom_rproc_glink glink_subdev;
>         struct qcom_rproc_ssr ssr_subdev;
>         struct qcom_sysmon *sysmon;
> +
> +       int (*shutdown)(struct qcom_adsp *adsp);
>  };
>
