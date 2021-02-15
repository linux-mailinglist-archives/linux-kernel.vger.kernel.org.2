Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F48A31B58F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 08:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBOHS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 02:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhBOHSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 02:18:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7B7C061756
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 23:17:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s11so6837446edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 23:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kigACN8r64qPhFJX39Ecp8SW0cS3AZGPxL0ENyxZBuE=;
        b=sBamE/IXAX4ULfOLcbrRbkRx87qZlhCNuUZ8UzpAyRbeeMPNiLKbtvCptvP8+fwhV4
         lriXdir+WKyKj/Tcoxd44VtsNwrkHf+vU1UOfeVDPJHu96QSBnS/HQStUVZMB96AogrC
         8bkAL5zIf/xvbnHJTeX4uZsDlM6T2eYutC9ttfZdFDwN1svjDQwJzA1RH9bKNtbzDFzd
         7taJnnksBCGh/zzsPdZtqJ/1BPIJEGOq+hhNadbKStUJynqpf7wg2cUV6K2aE9JfrFy1
         E2+3W5zIYHas/TjNyIk8wJB70reTL2ZF1IyCV7rptG+olV26cx3JRmGU7IXthSiTvXGE
         dy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kigACN8r64qPhFJX39Ecp8SW0cS3AZGPxL0ENyxZBuE=;
        b=ZuIwZQIo7N+v9OQcPRe6d692EFocDawDEuTsvzCLpZfi9Xsu1Hn98X5gyphpokOVX2
         7YvpA97LQUvuiIuGbYQie00SNwMBcAe+wWwg2BWEe1IWqRPmHoVZY780EJONGnywY/7u
         rCDveHmeiZyohoalfXBJUfs1yJ7OinGhaMJJjPuMmwdLNd7FnKlHCGLWlX+aJi0Xuss0
         EdAAI4NFXSLU9dEj23VvWtJP1K5slw9QkFmcnEBg96d/OblJJNlGzNojl9N2qn0wIstE
         yqr+h7oq61GjIRP7Ri/E09wP6LD0Zp3CM+kI+a9IUyr0l7WijVmBS55bSV6znqxKI2tf
         /+4A==
X-Gm-Message-State: AOAM533RXe3+e+BY1ZmJ057ybbo7bM9Cpfk9s9F161cj5uS3phSfW9Q4
        UcGzcz/k+Xjp1THj7MrlCwW/QmHmzVMaU2KCSu+1ka9/1Kd9heuf
X-Google-Smtp-Source: ABdhPJwwphuqRj2UGfYsXEfAaztNB7kDu6BTyq+kjg4JOWeGgHduz/TZnpE1DxVJ/dgVFmfrqhLiA1SJ1WBJyqD9SbM=
X-Received: by 2002:a05:6402:6cc:: with SMTP id n12mr14429373edy.69.1613373450903;
 Sun, 14 Feb 2021 23:17:30 -0800 (PST)
MIME-Version: 1.0
References: <1613165243-23359-1-git-send-email-jhugo@codeaurora.org>
In-Reply-To: <1613165243-23359-1-git-send-email-jhugo@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 15 Feb 2021 08:25:09 +0100
Message-ID: <CAMZdPi94fSRLua8yacvSdNUj9SRJov7Ga3p7Rtqc2VqNhwPYcw@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: core: Fix check for syserr at power_up
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021 at 22:27, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>
> The check to see if we have reset the device after detecting syserr at
> power_up is inverted.  wait_for_event_timeout() returns 0 on failure,
> and a positive value on success.  The check is looking for non-zero
> as a failure, which is likely to incorrectly cause a device init failure
> if syserr was detected at power_up.  Fix this.
>
> Fixes: e18d4e9fa79b ("bus: mhi: core: Handle syserr during power_up")
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

> ---
>  drivers/bus/mhi/core/pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 681960c..36ab7aa 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -1092,7 +1092,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>                                                            &val) ||
>                                         !val,
>                                 msecs_to_jiffies(mhi_cntrl->timeout_ms));
> -               if (ret) {
> +               if (!ret) {
>                         ret = -EIO;
>                         dev_info(dev, "Failed to reset MHI due to syserr state\n");
>                         goto error_bhi_offset;
> --
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
>
