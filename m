Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9AF453C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 23:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhKPW5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhKPW5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:57:35 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F00C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 14:54:37 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id t9-20020a4a8589000000b002c5c4d19723so276595ooh.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 14:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lcfXvg0IaBhpdgTpdukd2g8BXYbPMue+9fWAr5sE3qY=;
        b=DLbni/4pdZ4WtAFdegibs6kRiC2e49dG9xFpcKP1msXWFT++xCNPX2kYSZvPjE+5HC
         urz/esecalxk2ejV/Hr61RSULZZAT5cmr47dOxqgs8Hziq7bnLnQ5+WNjK8ImrW2MreI
         28ddm8S6AlPheme6gpcg8SgG44Y7yVXoyN40M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lcfXvg0IaBhpdgTpdukd2g8BXYbPMue+9fWAr5sE3qY=;
        b=Of0S1IxFWwqw8IquRXDE6LE9DqJ6Lw56aZ6vvksHyKpVXB+N8r586tYdTIT7vVaeI/
         QQwcWdGi/EzOFOt3+WizOFHwe2PGr8pzkWiFm2Fk0/87NsYVegtInVI96ZoVCAwjsCGr
         lIyNLrexuzozFFI0pVZIuYrbK7qA8IBFfviKGZpdvZcwmgWWdb6QB3mJi6iaBpuWcOFa
         Ar2Y6C6xZ3TErk6qdDJXnek6N4QlEcab1p6hGhVRNB5xKQ4gorebO9qhVtXnLvUp5eAM
         rzRH34g0o9DZvRrhOzYu4iWQ8wtoUA0ii6qObJ4DLibl/b/bHuVTDhfrV9kwwUxZyiri
         F6bQ==
X-Gm-Message-State: AOAM531ek7HApIGsjPTMqtfkGIYflT+131n68xEc3PKbgWcY9vktGVuz
        pOwfUC7uOwWGHHH6QlBQ3KkXtCsObAY7Hp75+rGu0w==
X-Google-Smtp-Source: ABdhPJyfqEZmDn75mnZMOousDMEmSosUvQpycigR3dCdH1vdwHe2Zz4XzZmDdEC+Oea8MedhPHKEfgM36mDg+Uuq3tU=
X-Received: by 2002:a4a:cf12:: with SMTP id l18mr1238026oos.25.1637103277072;
 Tue, 16 Nov 2021 14:54:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 14:54:36 -0800
MIME-Version: 1.0
In-Reply-To: <1635860673-12146-4-git-send-email-pillair@codeaurora.org>
References: <1635860673-12146-1-git-send-email-pillair@codeaurora.org> <1635860673-12146-4-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 14:54:36 -0800
Message-ID: <CAE-0n53PSDzj9owjeaB1bGQ5=255=Q_djEvcQGtZzRxMRMhe1g@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] remoteproc: qcom: q6v5_wpss: Add support for
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

Quoting Rakesh Pillai (2021-11-02 06:44:33)
> @@ -457,7 +608,13 @@ static int adsp_probe(struct platform_device *pdev)
>         if (ret)
>                 goto free_rproc;
>
> -       pm_runtime_enable(adsp->dev);
> +       ret = qcom_rproc_pds_attach(adsp->dev, adsp->proxy_pds,
> +                                   desc->proxy_pd_names);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Failed to attach proxy power domains\n");
> +               goto free_rproc;
> +       }
> +       adsp->proxy_pd_count = ret;

Can we check this against the define so that we don't have more than the
fixed number of power domains and try to access elements beyond the
length of the array?
