Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C0A452845
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347498AbhKPDM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbhKPDMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:12:47 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBECFC10E5E6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:40:32 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 7so28119195oip.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+vkIUHgpzbJDI/aE4qWRN6on5+ys3atnnjej/kwyIKA=;
        b=MvwYgzJfl2z6wYdr1mxeicKXhoW/hXOKCTTlNpU020Ph8jqOYoqbnuXHhEUhEeOuet
         /khOM4iBa9JfVkpDvECqEBzOP/8MS7WmvFsWxLf4lOHGHGj59aNacA7xJvWnp5R4rzeC
         9S0j6j9vp9ridHSVldRvp0Kb3u1mYuoSRjSWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+vkIUHgpzbJDI/aE4qWRN6on5+ys3atnnjej/kwyIKA=;
        b=rL1HpZ8zEVxJU0jchsy8qtqZTB3xB6hYw3NnbXaG/uKV7wFDvOyIyfnZzQpqVk6b9P
         P/1I+23328tAzhrbaqQ84jNr8V33JQuQwUtm1P2AyAGMkMP+9zZ6JqjTyZB0fvhGKGcN
         vxPuegcvCTWjK8FuBUNmelj9u5/SIeJqwMRk6Ps70tEWkkqKSFfXXrowKcK9mpqNIdGz
         5hcazUvl4EKNp+ST+Or6lbf1knwo09NfaCK5UYo3QNmF6WWkESwNx9LbnvBPdweo4SEI
         1/dVMkM1JiOXMGUkeHMq6D7UmGbkooDJ+F5iEi9HKjaOPo53BKr0awDjbdUeTfX+DMHZ
         xBJw==
X-Gm-Message-State: AOAM530e+YeVf5EXHcb5txK2fcocCusz9mgV9Z+9JhNVq2wMD7rPrio3
        QnkB+6kjeuERClrlt02gWaXnX4vdCdKOCt9vF/q58pBed+k=
X-Google-Smtp-Source: ABdhPJx6sFabeBeRR3jlaia33qeOJQBpKB1AbeYvHvZDZwyzUsfM+A7bo2X6isvJ81dQZc5z//IKWU21dGnPlynzfeA=
X-Received: by 2002:a54:4506:: with SMTP id l6mr49040451oil.32.1637019632340;
 Mon, 15 Nov 2021 15:40:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Nov 2021 15:40:32 -0800
MIME-Version: 1.0
In-Reply-To: <1635860673-12146-2-git-send-email-pillair@codeaurora.org>
References: <1635860673-12146-1-git-send-email-pillair@codeaurora.org> <1635860673-12146-2-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 15 Nov 2021 15:40:31 -0800
Message-ID: <CAE-0n52ONQVGG__JsLUVjjCOdHnw+xqx5HF89ZBGrUF0yjusSg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: remoteproc: qcom: adsp: Convert
 binding to YAML
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

Quoting Rakesh Pillai (2021-11-02 06:44:31)
> Convert Qualcomm ADSP/CDSP Remoteproc devicetree
> binding to YAML.
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
