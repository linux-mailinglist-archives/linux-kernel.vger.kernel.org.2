Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46383AFE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFVH5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhFVH5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:57:40 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:55:23 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bl4so1321401qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9aBePfq1/KpWdqkDFgr1We+3KCLkJ0L8u7O6nn+3jo=;
        b=Px9Tadx5bMq0vSKM2XDnWx10m9NkEZC+S+ZT+Ccdf2855IhV4DbtWdLO06ur8qkiT8
         iZVzl4yOsDQz/cLQtHNY+UPzXOckkBZg+cFuzOyJFVfxv0jJEiYSUymGF0ZqB8GbZy1w
         BtT01X6nY9orL7tj6PQo3bkl8iIBlFrwN9fog0Tu6s6gSnaqqlyW2Vu9DqUR1cMPwSC2
         TwWVZGus7bRQYaPsfxt0iZbDkclMVEbwyAdxULaXBOQKOAqa9msQ+7I2586IK+E6i9iV
         GGYiSO8BaBCCI9FNJ1oOQDkb1QKi9nIxcNQcUH4H5s3GA3sb/wwd4TUTXXaUx10XGdAA
         3Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9aBePfq1/KpWdqkDFgr1We+3KCLkJ0L8u7O6nn+3jo=;
        b=SObRHHMEf8uN2SLkcveCWcrLdwA4jVSK/ofUzx//OuE9InqHhDs2KuGwaE58DZU4U1
         W0mvxUwMZmnyBFhY37I1Z/wq+J2uzJrsUxggq+Hjoq6WlGfq53D/Tl5YuFR5ahcPDaV/
         AQ7tDL3fxplR3JdUC9h7L3fMJSL4KrqJRuybq+dTJR5IbC4YcFOC8DXiGuZGl4EbZVuS
         VcnVgR/aKUIh+qVDx7DYPzhuCM4OwEBX6mIq8pK7CXbPGIdpIclAqk6UV5wCL07wmGyt
         33S1R3sMibozhX56Oa0mwHJNu+uRfhcjuOtkbYoKtoVO/DsCpsUPlwnq5xlzRLiOzpF2
         YbNg==
X-Gm-Message-State: AOAM532ID0qnAmR0Rzd0sV3LBjKhfDxucrbGRTFBDR/m6/24wVjTnT7d
        6B+2b40VBYT4Sc4x6csw+TqcZ6Ik4hIr9zBT4iSUDQ==
X-Google-Smtp-Source: ABdhPJw2hXewn8FpKtmuSSAZpnVwhBWJde4ZMKIrIVNNDVTtd+9iS/Zf4hPk2BHfcx94ZNirkltH5BZ187sDZ28F5MY=
X-Received: by 2002:a25:1804:: with SMTP id 4mr3012601yby.157.1624348522940;
 Tue, 22 Jun 2021 00:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <1624314539-17396-1-git-send-email-gabeknez@linux.microsoft.com>
In-Reply-To: <1624314539-17396-1-git-send-email-gabeknez@linux.microsoft.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 22 Jun 2021 09:55:12 +0200
Message-ID: <CAMpxmJVREmcqxFJn9CQYL_Y9E3X-8DYRiTMLD5hNE90m8sSG6Q@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: cdev: zero padding during conversion to gpioline_info_changed
To:     Gabriel Knezek <gabeknez@linux.microsoft.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        joe.reviewer@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:29 AM Gabriel Knezek
<gabeknez@linux.microsoft.com> wrote:
>
> When userspace requests a GPIO v1 line info changed event,
> lineinfo_watch_read() populates and returns the gpioline_info_changed
> structure. It contains 5 words of padding at the end which are not
> initialized before being returned to userspace.
>
> Zero the structure in gpio_v2_line_info_change_to_v1() before populating
> its contents.
>
> Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and
> GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> Signed-off-by: Gabriel Knezek <gabeknez@linux.microsoft.com>
> ---
> Changes in v3:
>   - Include the Fixes tag referencing the code being fixed and properly
>     version the patch.
>
> Changes in v2:
>   - Update commit message and subject with suggestions about clarity.
>   - Patch series at https://www.spinics.net/lists/linux-gpio/msg62163.html
>
> v1:
>   - Initial patch
>   - Patch series at https://www.spinics.net/lists/linux-gpio/msg62084.html
>
>  drivers/gpio/gpiolib-cdev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index ee5903aac497..af68532835fe 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1865,6 +1865,7 @@ static void gpio_v2_line_info_changed_to_v1(
>                 struct gpio_v2_line_info_changed *lic_v2,
>                 struct gpioline_info_changed *lic_v1)
>  {
> +       memset(lic_v1, 0, sizeof(*lic_v1));
>         gpio_v2_line_info_to_v1(&lic_v2->info, &lic_v1->info);
>         lic_v1->timestamp = lic_v2->timestamp_ns;
>         lic_v1->event_type = lic_v2->event_type;
> --
> 2.25.1
>

I fixed the wrapping of the Fixes tag and queued this for fixes with
Kent's review tag.

Bart
