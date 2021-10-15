Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E7E42E840
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 07:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhJOFHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 01:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhJOFHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 01:07:50 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD866C061570;
        Thu, 14 Oct 2021 22:05:44 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d20so5056889qvm.8;
        Thu, 14 Oct 2021 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVSDlRtUbO26Znlz3FX13ju5T/3DmVvaUnOyfVchjzs=;
        b=elrdX1cpB1nDA+5QZPRa5ZtlWXqUfKwBaWxMYWW+zgG8VTp1BvP92U1fYhQ5z17QvJ
         i0hxnMiX38QA96+3vQNnd0C8bEczfn5F9ufPSdnZ+hNLbytj3/FUFqvGIW037XgR8ZVk
         YeN13QrAqC2Iuxqx3PvhtkKOD5M2YZ/bLy5Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVSDlRtUbO26Znlz3FX13ju5T/3DmVvaUnOyfVchjzs=;
        b=egcqxJpiro2rvMlAhe/MwDKNnKeHAhCRAg/RW1N0Mf3o7IXmK4wcZMpkRR3YClBX6U
         2BObeRYeZvmu5bJQwZ1i1ERX4WCvDCBW6uJU1p3lu6GQAqOaLVxNa8f2lkRamJ543y8t
         fQGP9Ewr/ggl/SENiOsNxI5xdYZviMurbRAw/rEdMTzu27llmxRaEiYHdnzGPLC+9jei
         HaJk1rCEYWlUMuJrwjNel8QFF0MHjWRtCtMo9TkimukDb8wPTFFni16O99L5nTUedrGs
         fNnPa1oq5/hTElg/JF+V6cYXAqNw1vyIkIYqRGpOvSvlykpbok8lnXd25Qo8t9WAARRC
         M3Pw==
X-Gm-Message-State: AOAM5314KeJKeaDR+RzY472sG60WENBf1PgnBs9z2scfIGMCD8vqP77/
        u3zcYCyXiDfBAGljkM4IVj1cinu2gEHw+O0bzEw=
X-Google-Smtp-Source: ABdhPJwyxNh3quQmc4LjNuE3K+5AnLtlDoZrZxFupHfdR3nYhF4Eyc1zvKRvGLLuJ41tOk3Se5lfgtNgs8C45ogCHrc=
X-Received: by 2002:a05:6214:98d:: with SMTP id dt13mr9316954qvb.13.1634274343844;
 Thu, 14 Oct 2021 22:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210927155925.15485-1-eajames@linux.ibm.com> <20210927155925.15485-2-eajames@linux.ibm.com>
In-Reply-To: <20210927155925.15485-2-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 15 Oct 2021 05:05:32 +0000
Message-ID: <CACPK8XdQ9wdg=VxRb0atd8P7PpFZTsWZwsYEkWsbmbR20DKKBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] fsi: occ: Use a large buffer for responses
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 15:59, Eddie James <eajames@linux.ibm.com> wrote:
>
> Allocate a large buffer for each OCC to handle response data. This
> removes memory allocation during an operation, and also allows for
> the maximum amount of SBE FFDC.

Why do we need this change? (is it fixing a bug, did the host change,
is it an unimplemented feature, etc)

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-occ.c   | 109 ++++++++++++++++------------------------
>  include/linux/fsi-occ.h |   2 +
>  2 files changed, 45 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index b0c9322078a1..ace3ec7767e5 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/miscdevice.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/fsi-occ.h>
> @@ -42,13 +43,6 @@
>
>  #define OCC_P10_SRAM_MODE      0x58    /* Normal mode, OCB channel 2 */
>
> -/*
> - * Assume we don't have much FFDC, if we do we'll overflow and
> - * fail the command. This needs to be big enough for simple
> - * commands as well.
> - */
> -#define OCC_SBE_STATUS_WORDS   32
> -
>  #define OCC_TIMEOUT_MS         1000
>  #define OCC_CMD_IN_PRG_WAIT_MS 50
>
> @@ -60,6 +54,7 @@ struct occ {
>         char name[32];
>         int idx;
>         u8 sequence_number;
> +       void *buffer;
>         enum versions version;
>         struct miscdevice mdev;
>         struct mutex occ_lock;
> @@ -250,8 +245,10 @@ static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
>  static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
>  {
>         u32 data_len = ((len + 7) / 8) * 8;     /* must be multiples of 8 B */
> -       size_t cmd_len, resp_len, resp_data_len;
> -       __be32 *resp, cmd[6];
> +       size_t cmd_len, resp_data_len;
> +       size_t resp_len = OCC_MAX_RESP_WORDS;
> +       __be32 *resp = occ->buffer;
> +       __be32 cmd[6];
>         int idx = 0, rc;
>
>         /*
> @@ -278,19 +275,19 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
>         cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_OCC_SRAM);
>         cmd[4 + idx] = cpu_to_be32(data_len);
>
> -       resp_len = (data_len >> 2) + OCC_SBE_STATUS_WORDS;
> -       resp = kzalloc(resp_len << 2, GFP_KERNEL);

Previously the driver would zero the buffer before using it. Should
you add a memset here?

> @@ -635,6 +605,10 @@ static int occ_probe(struct platform_device *pdev)
>         if (!occ)
>                 return -ENOMEM;
>
> +       occ->buffer = kvmalloc(OCC_MAX_RESP_WORDS * 4, GFP_KERNEL);

Why do you allocate WORDS * 4?

> diff --git a/include/linux/fsi-occ.h b/include/linux/fsi-occ.h
> index d4cdc2aa6e33..7ee3dbd7f4b3 100644
> --- a/include/linux/fsi-occ.h
> +++ b/include/linux/fsi-occ.h
> @@ -19,6 +19,8 @@ struct device;
>  #define OCC_RESP_CRIT_OCB              0xE3
>  #define OCC_RESP_CRIT_HW               0xE4
>
> +#define OCC_MAX_RESP_WORDS             2048

Does this need to go in the header?
