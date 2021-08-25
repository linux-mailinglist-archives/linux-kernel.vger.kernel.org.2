Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8743F737E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbhHYKlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:41:20 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53026
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239992AbhHYKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:41:15 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3BA0B40767
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629888029;
        bh=BomR5qRxPE9FmaYF/P5LDWKwqrGGLdAmhXQWLWzg0l0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=irwJaa1CZdNMQt35wuXupM5ZtSeC7ydcKu+p/c1GNoydmvApzkAqlMXiAoFS/NVdx
         LL8ej2/RLC1HsPl6v237wuWLPWklaqgJEd7RAxtl/+fulqiV3hHmpwwnfllIr3XXZx
         53E8mrVCdkGC2IS8QgaBuku80E117j8i+09WQTufJVcE7UBOVkBciC7Kg64dETHTJQ
         dJWaelXrzoUkEImlOtEi1zIOQeHWkjZq1ixeTxqSLQM6NFC8swmM2OtXc5vjqSnvL2
         sMAxBQiLO0qsK/Jxk71jnbfJuMIPkVkyyDx4aq+/h9cjzDnXN5CTyk5OVpMh5AD+7T
         FE1acWH6P6WMA==
Received: by mail-ed1-f72.google.com with SMTP id e18-20020a0564020892b02903be9702d63eso3430724edy.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BomR5qRxPE9FmaYF/P5LDWKwqrGGLdAmhXQWLWzg0l0=;
        b=lwgzOoZ3h556/MdYdgJjRS0af9oIMlUZ9J0LehUl9MSm0dws09CilREdRLDcb1Rkb4
         aREBbseaKH8+q9JshUzRZ4l2wDKwixKNeRa6vnabEaqC8BYWEB/v3XRR3DTTTfR8ymkG
         wRXk1ObUvL42Ex3KDvK6NA09mrjYAwvHjZAm3IgYwoWo116IrfAWwHQbxRM0kpl3uUKh
         lArtjfPSmGa9XgPd1o6+TMm1EYRVXnMFP8R6CNsrjiQPsn5WlWMcXgns6wUBaiO88lNW
         j2nNHDEoRS8KSHeq/Su+0D0sXbW6K/PF8RQ3sf5I8bsEDDVuhPGMLj2+zNPJ9tJ8WaQW
         3muw==
X-Gm-Message-State: AOAM532/SBjQcZROCldbTYMONwovRyiluzr/cu+TFHbmuvVZ/FEsvxpg
        wCzwpBlBlSe2kEq/rm7s4i3XurTMbW9+TV/zYLvS71HJ28ih2fqlfVxXCA8vaYWOQp2YR6a4IyF
        gfYGPlmv4UjxzIcPAw+J06xp8aONlV2Z5whBTtRFPBym3z/keEKb6FOLyiw==
X-Received: by 2002:a05:6402:2806:: with SMTP id h6mr7230490ede.259.1629888028886;
        Wed, 25 Aug 2021 03:40:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3J92grIs8eAex3JG6UT4nm5rpzCKGGwTa2YeXadSKAkBhivX3M5tMV45HAAIGsp70yCKOBhAU9PMdDoSl8Nc=
X-Received: by 2002:a05:6402:2806:: with SMTP id h6mr7230476ede.259.1629888028645;
 Wed, 25 Aug 2021 03:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210823093222.19544-1-andriy.shevchenko@linux.intel.com> <20210823093222.19544-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210823093222.19544-2-andriy.shevchenko@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 25 Aug 2021 18:40:17 +0800
Message-ID: <CAAd53p5V2BcjG=Sds==qdOomZpCJON94B93DRU+fPkzTffGCyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: hp_accel: Remove _INI method call
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 5:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> According to ACPI specification the _INI method must be called
> when device is enumerated first time. After that there is no need
> to repeat the procedure. Convert the lis3lv02d_acpi_init() to be
> a stub (Note, we may not remove it because it is called unconditionally
> by the accelerometer main driver).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The lis3lv02d still works after boot and after resume.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/misc/lis3lv02d/lis3lv02d.h |  1 -
>  drivers/platform/x86/hp_accel.c    | 14 +-------------
>  2 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d.h b/drivers/misc/lis3lv02d/lis3lv02d.h
> index 7ac788fae1b8..c394c0b08519 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d.h
> +++ b/drivers/misc/lis3lv02d/lis3lv02d.h
> @@ -271,7 +271,6 @@ struct lis3lv02d {
>         int                     regs_size;
>         u8                      *reg_cache;
>         bool                    regs_stored;
> -       bool                    init_required;
>         u8                      odr_mask;  /* ODR bit mask */
>         u8                      whoami;    /* indicates measurement precision */
>         s16 (*read_data) (struct lis3lv02d *lis3, int reg);
> diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
> index 8c0867bda828..54a4addc7903 100644
> --- a/drivers/platform/x86/hp_accel.c
> +++ b/drivers/platform/x86/hp_accel.c
> @@ -78,23 +78,14 @@ static const struct acpi_device_id lis3lv02d_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
>
> -
>  /**
> - * lis3lv02d_acpi_init - ACPI _INI method: initialize the device.
> + * lis3lv02d_acpi_init - initialize the device for ACPI
>   * @lis3: pointer to the device struct
>   *
>   * Returns 0 on success.
>   */
>  static int lis3lv02d_acpi_init(struct lis3lv02d *lis3)
>  {
> -       struct acpi_device *dev = lis3->bus_priv;
> -       if (!lis3->init_required)
> -               return 0;
> -
> -       if (acpi_evaluate_object(dev->handle, METHOD_NAME__INI,
> -                                NULL, NULL) != AE_OK)
> -               return -EINVAL;
> -
>         return 0;
>  }
>
> @@ -359,7 +350,6 @@ static int lis3lv02d_add(struct acpi_device *device)
>         }
>
>         /* call the core layer do its init */
> -       lis3_dev.init_required = true;
>         ret = lis3lv02d_init_device(&lis3_dev);
>         if (ret)
>                 return ret;
> @@ -407,14 +397,12 @@ static int lis3lv02d_suspend(struct device *dev)
>
>  static int lis3lv02d_resume(struct device *dev)
>  {
> -       lis3_dev.init_required = false;
>         lis3lv02d_poweron(&lis3_dev);
>         return 0;
>  }
>
>  static int lis3lv02d_restore(struct device *dev)
>  {
> -       lis3_dev.init_required = true;
>         lis3lv02d_poweron(&lis3_dev);
>         return 0;
>  }
> --
> 2.32.0
>
