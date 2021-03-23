Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E17345648
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCWDd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCWDdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:33:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEBAC061763
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:33:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso9515938pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=5P3DscWIA5E6KtbKwWeXRGnWsYVIZfqGL9jI0er3QEs=;
        b=PLfVMqXjw89ipCctSy0pa6GgYFf1dh4um6iGJvb8Q6End4A9Gp2XHOQIGzHTD0K+x+
         bVdxdFQbFHkwdcHNEu8gUZu9QyBrOc3xnYopvtHQ4k3Zpmp7iQ+885WxtmZpDgXNhaoi
         1ZIlAyMEmgukmdDmMwj4mzKqgddJddNeh8PrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=5P3DscWIA5E6KtbKwWeXRGnWsYVIZfqGL9jI0er3QEs=;
        b=gZzIKDvVRXzfQ2zZWvFu8MHqQEWcmtLU1Yl2IQQm8jxip31hmpfyeDX1txZFmby+Xf
         umEwWGWO4KewcDW0Si2vRjkLzBWFDplhSJmegjVIlZPRenwKjPVgohqlwsciogaZw6zM
         YlK04B/aa9YKR474FgrFMDgoE6qcsiAKMO7WIz5C+KK7jOjKbtQ5xwrsvngyRebUn1Zg
         PP/uRK2UkcVCiNjcVq4NqTz7YdJa7nCBbOMvRhq0ZB4mCtJJxLiG9/XOsXGWjjRMubed
         FK2GgSbfgwLIpUcOOkcdnCsRSnHsYOWUrUCUN/A6WpOiTANZP5Idh87V0Y0DLZZq+QAZ
         msEA==
X-Gm-Message-State: AOAM530Rh5PCBc6G5DkBP3/nwUK4Fhe4Efk7q/qzm18Ft7+POARyoAX2
        keub8W2xrhJYueyEJsDSEl2qyTlyZezfng==
X-Google-Smtp-Source: ABdhPJxCD6gbqkvS8RYoP3vs3t39AIDWuEDPHS2FZinVx4PxUyWhPvheyI42K1jrwIYwKSzsBRm8Yw==
X-Received: by 2002:a17:90a:fd89:: with SMTP id cx9mr2216844pjb.93.1616470394007;
        Mon, 22 Mar 2021 20:33:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e90d:d453:87ae:2e10])
        by smtp.gmail.com with ESMTPSA id cp22sm727217pjb.15.2021.03.22.20.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 20:33:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1616092624-31870-1-git-send-email-deesin@codeaurora.org>
References: <1616092624-31870-1-git-send-email-deesin@codeaurora.org>
Subject: Re: [PATCH V1 1/1] soc: qcom: smp2p: Add enable_irq_wake to SMP2P IRQ
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Andy Gross <agross@kernel.org>
To:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, clew@codeaurora.org
Date:   Mon, 22 Mar 2021 20:33:12 -0700
Message-ID: <161647039218.3012082.1225143087605342937@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Deepak Kumar Singh (2021-03-18 11:37:04)
> SMP2P interrupts are expected to wake the processor from suspend.
> Use enable_irq_wake to mark it wakeup capable from suspend.
>=20
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
> ---
>  drivers/soc/qcom/smp2p.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index 2df4883..df47ee6 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -538,6 +538,7 @@ static int qcom_smp2p_probe(struct platform_device *p=
dev)
>                 goto unwind_interfaces;
>         }
> =20
> +       enable_irq_wake(irq);
> =20

Can this use device_init_wakeup() and dev_pm_set_wake_irq() instead? I
think that will help us recognize that this irq woke up the CPU and
allow userspace to indicate that it doesn't want to get this wakeup for
some reason.

>         return 0;
>
