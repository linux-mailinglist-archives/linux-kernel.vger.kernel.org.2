Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9322037BBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhELLln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhELLlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:41:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92750C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:40:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id m9so30355651ybm.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KVdPIyF8+aJEsW6KKNMoePQjVtsaF/CvO6Qobl4y+E=;
        b=A2vWHwAQ/w0XgStFHKpHkeIh+zRFNm1JVkYV6g/EvYEZD/2flG+HA/4vcOQpU8+cOl
         608GzqNvzSL6ZNv/bpc4nyQKZxWGDic3bcPMMxNE1wR4y045I8/TGeSYnLNNt37gY0Nk
         CtjdWcKMxk3KndLtVuYtsWp6AFI53QoWBq6nW+1oSdn1iqtae8HjYOAzMs3DTyR1v3d4
         WW6Z14Zlyx0w9V9YpSu1QLQLlj/V4ytsdHhVgjreq6uXcuKJRS3TjUa566EVILhGCHKf
         Lqemnj4Y4mexeQD3IXulQNuFNmpaUJIMGMeWXBwz/dxndZ6jbuhhoy2kzGRFYl1/w5hL
         rY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KVdPIyF8+aJEsW6KKNMoePQjVtsaF/CvO6Qobl4y+E=;
        b=AurmJvdxLelT+SYTGy6k6surwu36em56Vqtw21/rvvh6O5hIWEJS5OBRHSOub+fu1I
         cC4V/8/KiD45ybLeBFBHjBFLuLWeah+8phNZeFDAwo09E8CTJnOFoIKsFBng2zvYZtT3
         Yej8w03XrJbmc6sPzLpiTt2mM2bhNDRIqn7w+JETvuxSM8zPRZyLz3GBz3PMyMlvbOvT
         27r5S+veNDDWQp+HEVrYXRdzd72Zfqy6Rzqu6lU2li6PJMKnuTQZeZshTmcCWDEZOWT/
         ANi4ppONxW+0FCy88wnC19BfkP55fMpNj3tR/YWhqnBvNlLfP5HiGNsElJ+0KtamYIvH
         gK1A==
X-Gm-Message-State: AOAM531RMPvIfny3XyPJA9XvKl9rM7G3JRZNgFQduzLXiMikrEVbfp5Q
        rjyeidhFjdBNRc/4FTcwfuT0dUOZ6xAkfLr3ccCPQA==
X-Google-Smtp-Source: ABdhPJwtP+FdVycLsvBLB5AaaOOm6vDT6c8XN/0Ty20OF0E3IJWb3DLHRK4xNz4h2Qhf0yPNAgmvj2KJ3lO2OC2RtNA=
X-Received: by 2002:a25:9d86:: with SMTP id v6mr45835119ybp.366.1620819632511;
 Wed, 12 May 2021 04:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <1620714150-106682-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1620714150-106682-1-git-send-email-zou_wei@huawei.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 12 May 2021 13:40:21 +0200
Message-ID: <CAMpxmJWukRCivVE6pVhQm=ob98gDt1dn2hB_7GrisrSQ0Kc+8Q@mail.gmail.com>
Subject: Re: [PATCH -next] bus: da8xx-mstpri: add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 8:06 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/bus/da8xx-mstpri.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
> index ee4c023..ff158a1 100644
> --- a/drivers/bus/da8xx-mstpri.c
> +++ b/drivers/bus/da8xx-mstpri.c
> @@ -249,6 +249,7 @@ static const struct of_device_id da8xx_mstpri_of_match[] = {
>         { .compatible = "ti,da850-mstpri", },
>         { },
>  };
> +MODULE_DEVICE_TABLE(of, da8xx_mstpri_of_match);
>
>  static struct platform_driver da8xx_mstpri_driver = {
>         .probe = da8xx_mstpri_probe,
> --
> 2.6.2
>

This module is always built-in. I don't think we require the module
device table for non-dynamic modules.

Bartosz
