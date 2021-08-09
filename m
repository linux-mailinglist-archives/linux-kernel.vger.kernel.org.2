Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269473E4BA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhHIR6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhHIR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:57:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B9C061386
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:56:57 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v10-20020a9d604a0000b02904fa9613b53dso7946726otj.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=KOmXqq5WUgRYl6rKi6CL03DpE0hkR+KRhfuo0fQGavg=;
        b=Z/+6IzvspqSNNMbLZuEZJjfe3DAzYbiCzK4bmXKU4jiJDkAqMJAEhPkm8l3nnwOlLi
         bio6K49f6/+5uBHlNm2Sf9kz/cpY0VRRjGgQFFGZZ1L+e41qNR9Ope5StTZsMN7QeNAT
         QooLqHcKMEYOmkpnDQAlSJquavCjJ56ed/ZLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=KOmXqq5WUgRYl6rKi6CL03DpE0hkR+KRhfuo0fQGavg=;
        b=fRUGIku0VSnqBQABG0zRvwB6xctHkftY/LjasPAG5fZ/FtQ1PY1BBSPJnLCosaP55u
         yKah4Y5hapMLcCDmEq+8kqfsKESYm5sMyP9mci/h2DxmISGGnQpXJZqX7Us6OVVzgx2k
         ZlFkEBmISM2RJYzX2DV2vxIRC9QiV6eLGu3OYrZwHHuN7oW3lNgS0nqlQibXRUjFBS1H
         jwbf4I6vBB5zOE6JHv9AST2VrL3WBfa+TzHJhCvx8AfQ09eWA7yQfXt1mG+k0z8SWFCd
         3M1UFUHV2TNzvu2urRgH6xb38vCiRMIu01+plMhCUfDEYO0npDrQ66swdF1dfTojXsf+
         wp7w==
X-Gm-Message-State: AOAM53066ksjpr8OT8QIg4AKRbBD5EyYdoyMXjIgs9Y7OmO/H5Jx1kw0
        HiggEyd7BQsrzyMiSAJVgGnGIZ1atoIlyuVkApmCxQ==
X-Google-Smtp-Source: ABdhPJzIQbkU3YPJSfHfxkH5DUXal/MJiqT8OMpcVvT1eQyFk7oJwh0p1lPoBxT2KgXNEh9K2vENY9/viIcaKFRY8X0=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr18002662otq.233.1628531816398;
 Mon, 09 Aug 2021 10:56:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Aug 2021 10:56:55 -0700
MIME-Version: 1.0
In-Reply-To: <4b3b6b0f-8c21-53ce-4341-1e8686d3b73c@codeaurora.org>
References: <1628161974-7182-1-git-send-email-deesin@codeaurora.org>
 <1628161974-7182-2-git-send-email-deesin@codeaurora.org> <CAE-0n50fN42fhAcoCJBz-PEW5sEdqSKT5YuaxWE_29J=P1=vQw@mail.gmail.com>
 <4b3b6b0f-8c21-53ce-4341-1e8686d3b73c@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 9 Aug 2021 10:56:55 -0700
Message-ID: <CAE-0n53cxsMMsJg3dpnTi+AwKiZKxG=xy4jBKX=FDKMzHc3y1Q@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] soc: qcom: aoss: Expose send for generic usecase
To:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, clew@codeaurora.org,
        sibis@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Deepak Kumar Singh (2021-08-09 02:57:26)
>
> On 8/6/2021 12:04 AM, Stephen Boyd wrote:
> > Quoting Deepak Kumar Singh (2021-08-05 04:12:53)
> >> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> >> index 934fcc4..b84cb31 100644
> >> --- a/drivers/soc/qcom/qcom_aoss.c
> >> +++ b/drivers/soc/qcom/qcom_aoss.c
> >> @@ -515,6 +521,43 @@ static void qmp_cooling_devices_remove(struct qmp *qmp)
> >>                  thermal_cooling_device_unregister(qmp->cooling_devs[i].cdev);
> >>   }
> >>
> >> +/**
> >> + * qmp_get() - get a qmp handle from a device
> >> + * @dev: client device pointer
> >> + *
> >> + * Return: handle to qmp device on success, ERR_PTR() on failure
> >> + */
> >> +struct qmp *qmp_get(struct device *dev)
> >> +{
> >> +       struct platform_device *pdev;
> >> +       struct device_node *np;
> >> +       struct qmp *qmp;
> >> +
> >> +       if (!dev || !dev->of_node)
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       np = of_parse_phandle(dev->of_node, "qcom,qmp", 0);
> >> +       if (!np)
> >> +               return ERR_PTR(-ENODEV);
> >> +
> >> +       pdev = of_find_device_by_node(np);
> >> +       of_node_put(np);
> >> +       if (!pdev)
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       qmp = platform_get_drvdata(pdev);
> >> +
> >> +       return qmp ? qmp : ERR_PTR(-EPROBE_DEFER);
> >> +}
> >> +EXPORT_SYMBOL(qmp_get);
> >> +
> >> +void qmp_put(struct qmp *qmp)
> >> +{
> >> +       if (!IS_ERR_OR_NULL(qmp))
> >> +               put_device(qmp->dev);
> > Where is the corresponding get_device() call?
> of_find_device_by_node() internally calls get_device(), so no need to
> call get_device() explicitly.

Got it. Can you add a comment here so we remember?

	/*
	 * Match get_device() inside of_find_device_by_node() in
	 * qmp_get()
	 */

and it would be super useful if we could update the documentation on
that API, and the one it calls, so callers know about this.
