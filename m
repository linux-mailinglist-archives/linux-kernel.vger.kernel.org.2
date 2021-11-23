Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597FC45A38B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhKWNVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbhKWNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:21:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD91C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 05:18:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g14so92099990edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 05:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAk8tA976gVRgEzEWN8fO9UK+O6cafDP3k8VmtTgX5w=;
        b=ZlcHuPsPs5XqPHlHybDOmOGrNh0qiyNBwmBCG5MB4Lqj+7XTkXVFtXN/1Bp2RyIIXu
         i48fr4vDpQ+vIVqE+c6N1UQ40mM0uWHN2ittBrl0AoO5M/goOw4ZJ2QQfUvWRym9OxqX
         AKgjmMyVwPBmlb2jbdkmaoP7EHV0XWlYMbVjWdFVA/CZthyt7zN5TU+hfgELnOz8dsyp
         IIxWtVWrwZleqvQeHWT8hJtWtBAasQS3BBvucCsFC5tOvMzCQWyAvpPAD/2+EEYYEQ2H
         GQ7HF8LIupcY1AtE9yZlvnbMKnS59JlhYiF166pcE9BpDVE0rTgRUla0v89TUv2MF+9J
         J1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAk8tA976gVRgEzEWN8fO9UK+O6cafDP3k8VmtTgX5w=;
        b=fU1iwsmM6tYeIkuLjAFHQ94xJPXkELPrDH+5XHudbc6nmzbDb+fkA9RFo0zov23wer
         XZrjFtaf+amCLkbNmqb8jSFFmGpf3xRkxdPzZ3pJuXFr+wwHF/SOjypcTg/T6OciBSB6
         ofAYckrX9LP7JV09NKNN40iYFlIsYakgzqKBhSY2LGMlan9E4NMlw3FdzUw44VpjMo4/
         w4mz3x9mlGqiGvEuGAYqN22zq9l3Nd5dShDtqG3PziT+34eromdsgD9edfE7szn06fcp
         QuVCvetERN57dHr8aGUPd6VfBoRQ5WqlP22vvKNH0lql9Cn210jpR4FADoU4budoOTBn
         PJVg==
X-Gm-Message-State: AOAM533zUPkORAoYpD775ItiDq7LfgIL1YsNFfrc3z33nVR0V3IoxFHT
        l2/r5fKZghZGZuRkz2BBS/kSPDJSQGSHn7zSOLKijQ==
X-Google-Smtp-Source: ABdhPJx1jOOevAIf0UJxx8KjkdMLGW0E1fCsmiuRs/MXcyhAf3Xb3fawyNskFiVUpVxMyEiX4ns31HM0wPPcYLGnFQs=
X-Received: by 2002:a17:906:1b1b:: with SMTP id o27mr7495723ejg.279.1637673485902;
 Tue, 23 Nov 2021 05:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20211123083620.2366860-1-weiyongjun1@huawei.com>
In-Reply-To: <20211123083620.2366860-1-weiyongjun1@huawei.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 23 Nov 2021 14:17:54 +0100
Message-ID: <CAN5uoS8_55fCRoUa67LQzWEtLgkf017fESPydht4QV4o_G800A@mail.gmail.com>
Subject: Re: [PATCH -next] firmware: arm_scmi: optee: Fix missing mutex_init()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 at 09:23, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> The driver allocates the mutex but not initialize it.
> Use mutex_init() on it to initialize it correctly.
>
> Fixes: 5f90f189a052 ("firmware: arm_scmi: Add optee transport")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/firmware/arm_scmi/optee.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> index d9819b0197ec..901737c9f5f8 100644
> --- a/drivers/firmware/arm_scmi/optee.c
> +++ b/drivers/firmware/arm_scmi/optee.c
> @@ -506,6 +506,7 @@ static int scmi_optee_service_probe(struct device *dev)
>         agent->dev = dev;
>         agent->tee_ctx = tee_ctx;
>         INIT_LIST_HEAD(&agent->channel_list);
> +       mutex_init(&agent->mu);
>
>         ret = get_capabilities(agent);
>         if (ret)
>

`Reviewed-by: Etienne Carriere <etienne.carriere@linaro.org>`

Indeed. Thanks for the fix.
Etienne
