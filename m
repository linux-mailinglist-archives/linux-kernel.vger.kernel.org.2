Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0318E436DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhJUXMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhJUXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:12:07 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8457FC061764;
        Thu, 21 Oct 2021 16:09:50 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j12so1402998qvk.12;
        Thu, 21 Oct 2021 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+flPRXbpgkFt1w/rql0HpymLEHrdUzpgA/a0FNf4ek4=;
        b=QGfD/Y1zzyisUE0Zsf0PFy35VQlOUQLFvMrJwliQ+YUVPN7Tkr6XQ8dR1pmvg2EqVQ
         DSIXciC3BPTcH4pQVKS/bG0eGJcXRsSw8F+17RuuM8UvZk1M3Wv7ZHRTiHORN3BhchMD
         2m7m9IiF0FOJ5/i89MawulW/7x0Q5tkiFoDas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+flPRXbpgkFt1w/rql0HpymLEHrdUzpgA/a0FNf4ek4=;
        b=BqSP2IUr26sf0hdXIzNQYRDCbiG9onHTKEx68nROrj/OjjTu7qPn7X5s7ZxvZGBULw
         1KTDos0o++kKor7ODdzTyajrEFHfDuWFJ+kjNfXATV3DyH39gIfAU33x2XUIph67cj8x
         j1Spjp0yYC9svRdbtvKh1x6S41yo84COqP9L1M19mu8oyjDsAaO4twrPuCsGvL889ppR
         pUXNRoFqyB3EvbQvjU5DzbdOKw/bDtiF89kGmXPofAEDY0L+gujWVTBoDHp/UNRU9cBF
         eFxOildjzH20V2peFgSd3oLc+XG1Rc1k8djfOAOXKnOHGXgkOLmHuQvb+Rg1t+cMjIjv
         D7nw==
X-Gm-Message-State: AOAM5312AkPw0suCpB1kRyOV83AX3LEnwRuKM9Wnb4jsKDpeWAIzK5/t
        0YGcU33vicSxoOtCBfWi2+ttX/5neDZdGbsIbeWvOm98
X-Google-Smtp-Source: ABdhPJzG5WUAHhHh2V7zebpusihtol3LtK1lieEpGt9AEKB3YVFzqDJYy9SIxaIIpqtIkYht4eLbBLH+THl8bGPlndk=
X-Received: by 2002:a05:6214:98d:: with SMTP id dt13mr7976087qvb.13.1634857789458;
 Thu, 21 Oct 2021 16:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211019205307.36946-1-eajames@linux.ibm.com> <20211019205307.36946-5-eajames@linux.ibm.com>
In-Reply-To: <20211019205307.36946-5-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 21 Oct 2021 23:09:37 +0000
Message-ID: <CACPK8Xdq-tzPddkCDFx7-BuYh-hReutiKD4Rax+Wxi4FKfDSow@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 at 20:53, Eddie James <eajames@linux.ibm.com> wrote:
>
> Save any FFDC provided by the OCC driver, and provide it to userspace
> through a binary sysfs entry. Notify userspace pollers when there is an
> error too.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter, I will merge this through the fsi tree unless you have objections.

Cheers,

Joel

> ---
>  drivers/hwmon/occ/p9_sbe.c | 86 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 9709f2b9c052..e50243580269 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -4,18 +4,79 @@
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/fsi-occ.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
>
>  #include "common.h"
>
>  struct p9_sbe_occ {
>         struct occ occ;
> +       bool sbe_error;
> +       void *ffdc;
> +       size_t ffdc_len;
> +       size_t ffdc_size;
> +       struct mutex sbe_error_lock;    /* lock access to ffdc data */
>         struct device *sbe;
>  };
>
>  #define to_p9_sbe_occ(x)       container_of((x), struct p9_sbe_occ, occ)
>
> +static ssize_t ffdc_read(struct file *filp, struct kobject *kobj,
> +                        struct bin_attribute *battr, char *buf, loff_t pos,
> +                        size_t count)
> +{
> +       ssize_t rc = 0;
> +       struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
> +       struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
> +
> +       mutex_lock(&ctx->sbe_error_lock);
> +       if (ctx->sbe_error) {
> +               rc = memory_read_from_buffer(buf, count, &pos, ctx->ffdc,
> +                                            ctx->ffdc_len);
> +               if (pos >= ctx->ffdc_len)
> +                       ctx->sbe_error = false;
> +       }
> +       mutex_unlock(&ctx->sbe_error_lock);
> +
> +       return rc;
> +}
> +static BIN_ATTR_RO(ffdc, OCC_MAX_RESP_WORDS * 4);
> +
> +static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
> +                                size_t resp_len)
> +{
> +       bool notify = false;
> +
> +       mutex_lock(&ctx->sbe_error_lock);
> +       if (!ctx->sbe_error) {
> +               if (resp_len > ctx->ffdc_size) {
> +                       if (ctx->ffdc)
> +                               kvfree(ctx->ffdc);
> +                       ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
> +                       if (!ctx->ffdc) {
> +                               ctx->ffdc_len = 0;
> +                               ctx->ffdc_size = 0;
> +                               goto done;
> +                       }
> +
> +                       ctx->ffdc_size = resp_len;
> +               }
> +
> +               notify = true;
> +               ctx->sbe_error = true;
> +               ctx->ffdc_len = resp_len;
> +               memcpy(ctx->ffdc, resp, resp_len);
> +       }
> +
> +done:
> +       mutex_unlock(&ctx->sbe_error_lock);
> +       return notify;
> +}
> +
>  static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  {
>         struct occ_response *resp = &occ->resp;
> @@ -24,8 +85,15 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>         int rc;
>
>         rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> -       if (rc < 0)
> +       if (rc < 0) {
> +               if (resp_len) {
> +                       if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
> +                               sysfs_notify(&occ->bus_dev->kobj, NULL,
> +                                            bin_attr_ffdc.attr.name);
> +               }
> +
>                 return rc;
> +       }
>
>         switch (resp->return_status) {
>         case OCC_RESP_CMD_IN_PRG:
> @@ -65,6 +133,8 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
>         if (!ctx)
>                 return -ENOMEM;
>
> +       mutex_init(&ctx->sbe_error_lock);
> +
>         ctx->sbe = pdev->dev.parent;
>         occ = &ctx->occ;
>         occ->bus_dev = &pdev->dev;
> @@ -78,6 +148,15 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
>         if (rc == -ESHUTDOWN)
>                 rc = -ENODEV;   /* Host is shutdown, don't spew errors */
>
> +       if (!rc) {
> +               rc = device_create_bin_file(occ->bus_dev, &bin_attr_ffdc);
> +               if (rc) {
> +                       dev_warn(occ->bus_dev,
> +                                "failed to create SBE error ffdc file\n");
> +                       rc = 0;
> +               }
> +       }
> +
>         return rc;
>  }
>
> @@ -86,9 +165,14 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
>         struct occ *occ = platform_get_drvdata(pdev);
>         struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>
> +       device_remove_bin_file(occ->bus_dev, &bin_attr_ffdc);
> +
>         ctx->sbe = NULL;
>         occ_shutdown(occ);
>
> +       if (ctx->ffdc)
> +               kvfree(ctx->ffdc);
> +
>         return 0;
>  }
>
> --
> 2.27.0
>
