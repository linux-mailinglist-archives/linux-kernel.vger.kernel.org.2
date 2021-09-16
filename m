Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3840D0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhIPATL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:19:11 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]:57538 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbhIPATI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:19:08 -0400
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AAC722012D;
        Thu, 16 Sep 2021 08:17:41 +0800 (AWST)
Message-ID: <ad29d1d9743799ffd770330af6ad174bdfe7c3a0.camel@codeconstruct.com.au>
Subject: Re: [PATCH 3/3] hwmon: (occ) Provide the SBEFIFO FFDC in binary
 sysfs
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, linux@roeck-us.net, jdelvare@suse.com,
        alistair@popple.id.au
Date:   Thu, 16 Sep 2021 08:17:41 +0800
In-Reply-To: <20210914213543.73351-4-eajames@linux.ibm.com>
References: <20210914213543.73351-1-eajames@linux.ibm.com>
         <20210914213543.73351-4-eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

> Save any FFDC provided by the OCC driver, and provide it to userspace
> through a binary sysfs entry. Do some basic state management to
> ensure that userspace can always collect the data if there was an
> error. Notify polling userspace when there is an error too.

Super! Some comments inline:

> +enum sbe_error_state {
> +       SBE_ERROR_NONE = 0,
> +       SBE_ERROR_PENDING,
> +       SBE_ERROR_COLLECTED
> +};
> +
>  struct p9_sbe_occ {
>         struct occ occ;
> +       int sbe_error;

Use the enum here?

> +       void *ffdc;
> +       size_t ffdc_len;
> +       size_t ffdc_size;
> +       struct mutex sbe_error_lock;    /* lock access to ffdc data */
> +       u32 no_ffdc_magic;
>         struct device *sbe;
>  };
>  
>  #define to_p9_sbe_occ(x)       container_of((x), struct p9_sbe_occ, occ)
>  
> +static ssize_t sbe_error_read(struct file *filp, struct kobject *kobj,
> +                             struct bin_attribute *battr, char *buf,
> +                             loff_t pos, size_t count)
> +{
> +       ssize_t rc = 0;
> +       struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
> +       struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
> +
> +       mutex_lock(&ctx->sbe_error_lock);
> +       if (ctx->sbe_error == SBE_ERROR_PENDING) {
> +               rc = memory_read_from_buffer(buf, count, &pos, ctx->ffdc,
> +                                            ctx->ffdc_len);
> +               ctx->sbe_error = SBE_ERROR_COLLECTED;
> +       }
> +       mutex_unlock(&ctx->sbe_error_lock);
> +
> +       return rc;
> +}

So any read from this file will clear out the FFDC data, making partial
reads impossible. As a least-intrusive change, could we set
SBE_ERROR_COLLECTED on write instead?

Or is there a better interface (a pipe?) that allows multiple FFDC
captures, destroyed on full consume, without odd read/write side
effects?

>         rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> -       if (rc < 0)
> +       if (rc < 0) {
> +               if (resp_len) {
> +                       bool notify = false;
> +
> +                       mutex_lock(&ctx->sbe_error_lock);
> +                       if (ctx->sbe_error != SBE_ERROR_PENDING)
> +                               notify = true;
> +                       ctx->sbe_error = SBE_ERROR_PENDING;

                          [...]

> +                       ctx->ffdc_len = resp_len;
> +                       memcpy(ctx->ffdc, resp, resp_len);

This will clear out the previous error it if hasn't been collected by
userspace. Is that really what you want for *first* fail data capture?
:)

Cheers,


Jeremy

