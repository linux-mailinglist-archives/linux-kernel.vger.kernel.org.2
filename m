Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0BF30D975
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhBCMDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhBCMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:03:45 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F7AC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:03:04 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id u7so5956443ooq.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpuuaPv5gdizlBOIcM7Ll6Dy1C/RKJcW8ZaghmsSW4Q=;
        b=meCmVhvMvyxBD5V4309Wee3sDXR/lM4n0u29I2Jgssuj24I3hefJtyUpDZVk//C/5v
         b2gd7Z0o1mQiFFgmjfM0d/WgGqTRhpoYP1OXR0aX1k7tXfS/Zzg1WpYpmOa46XPYve36
         7jw9YnhqTTvMguIeqcTE4ssdAbA8st7of129rDJkM4Gwf3cQavpaFCXjZZl3ZEeuUwfb
         oNLobNluk+yxXQQ5hj7fvzo5G7xpD4aW1lB1B7fJyaVeiOQG/CYsRmagUz/FyC2QHnrD
         cQxrgKHZEQxVJ7q2L1inECTynX/WRC3PJxNLOJ/UiiTZ37pXKsmW7VuauTKd1XiEMBXn
         SF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpuuaPv5gdizlBOIcM7Ll6Dy1C/RKJcW8ZaghmsSW4Q=;
        b=MaWwXxl5cuz9CtsXJrYGA+oMdV081nbTKwl9m3DPgpmXuFOh/noMeIdlAPQ3GctCzA
         RmDOm1mkuk27UEwqBg6TlHWAW0DkqCSaiWuHjltmff332VKRnmflw44G+oS/uO2zBoyT
         uDCLHbW4ruM+XM/V6Dn4eomrQCJbOaVLcKQPVgpUbv5p8Evg8F3Wb9p7COrxX019wuhA
         ZSZDuvNO/6Nt8JvNSmycl3S0ZbQa9sbRN4lywiOga74TPlP08kKenczyYQzOimRNe9HI
         t1ZVgvWtkSBqSVGkYnWcK98sfnmjV4k56qW2wAYJsNz6sZaTpAtpA+r35B0nzjPsO3Uh
         gRCg==
X-Gm-Message-State: AOAM530RL9BTr9xs6cTQRybI+ABN2StR+1X2bWu+SFUib/WN7yqzLlA+
        i1nTUdk1jvswWponkrOLLH0daceJNx40rzJs5DcJvrYVxr0=
X-Google-Smtp-Source: ABdhPJzIYHFZ9H1Jsl8WZIs2/e9WE1GtAz1YqB3t409ckdMVt2EgmS+X1OHhUst+RQ91sFRn0c2VSoYYF1D+3AnJcqY=
X-Received: by 2002:a4a:a8cd:: with SMTP id r13mr1843041oom.6.1612353784358;
 Wed, 03 Feb 2021 04:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20200920045857.34b612bf@akathisia>
In-Reply-To: <20200920045857.34b612bf@akathisia>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 3 Feb 2021 13:02:53 +0100
Message-ID: <CAHUa44FOvPMWUNE+D4tbfNLxijhQYpkcit0LEyC=LNqZm+uU-Q@mail.gmail.com>
Subject: Re: [PATCH] tee: fix some comment typos in header files
To:     Elvira Khabirova <e.khabirova@omprussia.ru>
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 3:58 AM Elvira Khabirova
<e.khabirova@omprussia.ru> wrote:
>
> struct tee_param: revc -> recv.
> TEE_IOC_SUPPL_SEND: typo introduced by copy-pasting, replace invalid
> description with description from the according argument struct.
>
> Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
> ---
>  include/linux/tee_drv.h  | 2 +-
>  include/uapi/linux/tee.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'll pick this up.

Thanks,
Jens

>
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index d074302989dd..61557bc0e29f 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -85,7 +85,7 @@ struct tee_param {
>   * @close_session:     close a session
>   * @invoke_func:       invoke a trusted function
>   * @cancel_req:                request cancel of an ongoing invoke or open
> - * @supp_revc:         called for supplicant to get a command
> + * @supp_recv:         called for supplicant to get a command
>   * @supp_send:         called for supplicant to send a response
>   * @shm_register:      register shared memory buffer in TEE
>   * @shm_unregister:    unregister shared memory buffer in TEE
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index b619f37ee03e..7546be5ed4f8 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -342,7 +342,7 @@ struct tee_iocl_supp_send_arg {
>  };
>
>  /**
> - * TEE_IOC_SUPPL_SEND - Receive a request for a supplicant function
> + * TEE_IOC_SUPPL_SEND - Send a response to a received request
>   *
>   * Takes a struct tee_ioctl_buf_data which contains a struct
>   * tee_iocl_supp_send_arg followed by any array of struct tee_param
> --
> 2.28.0
>
