Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37BD447A30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 06:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbhKHFgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 00:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKHFgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:36:50 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47100C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 21:34:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o18so33391536lfu.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 21:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpm7jPZ0ZMPW4LY+8KRKOKkVEUHfPW7d23ZeDD6AHnM=;
        b=clg5vcEitEheMZx8mbDe7QnU97lNI4yoQQENZvJmRRtm1abIdfZ6gJXGV0pelj+b0U
         dcpWZsOFazA1IGlq7SrDphfBwQnvrCHrVGnpBWH5cDVlShVMg39NGVxzHDMBVJDURIdZ
         r45zV77psix8kpU5aRuHMFOO7DCOGXkHYh8E2cmRfxwLJ7RlgFGuZdaVI/9t9AEC00wP
         f2nv6IZ3vMiNVFFpATlVwi+xNcWZfpwdwEoQ1SBmzUZGlG5TN8h57FHiFJ8hj13X/SKm
         fgnRFWgwF58d3NWjdW5QVT1Yk5aCfV9tIJbG5SoWfDDcxv00aQJUeKZ0FDWWi9zMnsta
         RN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpm7jPZ0ZMPW4LY+8KRKOKkVEUHfPW7d23ZeDD6AHnM=;
        b=Gah2cqqMPyOfai0RKP+eVLAXpeDA8SXPcZkwhu3cczmu+FxUg3HoLK4XKwrwH6QKTk
         jxQJmV/3WxqlESY8CLYm99vhvMeh2z0omltQTmqL/N063Lpf9XgfT/rvO4f3ymSCCGT4
         xIEg9qX+RuJnuBtOFd8VKb8LdGMHqsYk5qjSDTLfFjj0ywb5YtG1PLA61QWlkf2OnBGh
         RcIVkk08+wfouD0Rh7kVdYdkFYRL4Kb8meklTiuLwgR/li6/eI48CsdYawt9fMhQNftT
         A7EWXxH/2gVqVDZb9w1F+8aZK/Cwe3utP4eMGB3+zPDiKbGGidFImJgmChKl2OOdrq4q
         +P2g==
X-Gm-Message-State: AOAM530ZeX0MTYtnom6mpBfwXG8y/KJlYT6AU7ngUPo4SQ+xiiHQ4eIS
        osQYlgC+7qQ0xjClvGLqU2te/8lu0YiZ0uSF9A3cjA==
X-Google-Smtp-Source: ABdhPJwgdGJyUpyR/mOLSV0b8Ig0zVB84wH3mLDwnfuV+O4nI7wKaMy5cn8BFLLuoLCj3znUKkmkfobNqIPVlpDJh20=
X-Received: by 2002:a05:6512:2291:: with SMTP id f17mr71245439lfu.253.1636349644569;
 Sun, 07 Nov 2021 21:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20211104113047.28585-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20211104113047.28585-1-lv.ruyi@zte.com.cn>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 8 Nov 2021 11:03:53 +0530
Message-ID: <CAFA6WYPOz1g+-6=Roo88qwcSv9W5vsbVHFWTzv_ALXxyMsLJ8w@mail.gmail.com>
Subject: Re: [PATCH] optee: fix kfree NULL pointer
To:     cgel.zte@gmail.com
Cc:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2021 at 17:00, <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> This patch fixes the following Coccinelle error:
> drivers/tee/optee/ffa_abi.c: 877: ERROR  optee is NULL but dereferenced.
>
> If memory allocation fails, optee is null pointer. the code will goto err
>  and release optee.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/tee/optee/ffa_abi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 6defd1ec982a..8d9d189557f9 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -811,8 +811,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>
>         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
>         if (!optee) {
> -               rc = -ENOMEM;
> -               goto err;
> +               return -ENOMEM;
>         }

So the braces are redundant after this change, hence can be dropped.

With that addressed:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>         optee->pool = optee_ffa_config_dyn_shm();
>         if (IS_ERR(optee->pool)) {
> --
> 2.25.1
>
