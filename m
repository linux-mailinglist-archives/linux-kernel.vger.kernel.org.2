Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB57368EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbhDWIPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbhDWIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:15:44 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AD0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:15:05 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id v23so14978724uaq.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/1p4bVB/IMzYSh3lEXsuQcO/JfPdUjhh9i2ce6TwNU=;
        b=pEkwBSLRqGzDhcLG5eFakZTdU2Qg37RO9RtA1nyKpKLxUtzL6N3lKsjIle8kMyNult
         MnwHkVfFBhZe3+KFRCwWOT+K5F8OrL14o3z35nnJxtbUOe3X3E4SRYBEFQY0QOjXq8Pz
         MsPc1OwJzrAGeOHTyci8Ww913e8iA24UKi87IxbxyglVm3DKQE1tfoxe7ugjhHetfuWp
         buaM/oerD0Q3pdOjZ0+PbbKjMSORq0V3e0VqY1l9adMHXIyQjLpZ32giAoXLHKpuQPf/
         Xk6+sYBIljN3SNElCjxSWkYZmuJYhfWmWl+TPBnUeaU0mLHwnGWVKnNJQVaCOFui2Nwm
         0w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/1p4bVB/IMzYSh3lEXsuQcO/JfPdUjhh9i2ce6TwNU=;
        b=GCtr1Ff4VtmXjKI3TjRIj52i3q4Iyedmxrt+84P/v/iA6VTcQbk/4vtlDREHGnaI/U
         H3hgu+tN7AduQgGcS4DtZ2lrfmJMYkrem1UDHhqqT9fvhgrrhBkr8z3zvVR/5ncHiCoW
         lZOB7G/frGaeQIAywtDkOrI2KAAHrc7V8vC4zUGQAib+rMzh44wj7laiD2TdPFG9i0w5
         LIgnCakdEFvcTTG7cXZ58MStwxZn2z7ccyx9MmG1nSo6mEpD9NCJpl3fFmX8aVXcX9cu
         NiqKMP0AQGDCt/vniVOY9YY1MPPvEkmV5Ym1o6TMf3d+AHwBkfb15umtVXbCM1I+tXFs
         KKXA==
X-Gm-Message-State: AOAM5320qySQkwRrquzSGO9nCbTrT4CIAGWJp/jBE4KFLg5D3fIxfhZh
        kBW3UJcLrK49reS0JS5nMxwpIGNc9fVIEq+qlB/S0oTFc7qDUA==
X-Google-Smtp-Source: ABdhPJwZMkVNq7pr6fRHMhYlBhNxD2i5z/5FXnT8VelaqnN/k0lCcJoLeWzWnzh7gBGPY0mYiHl7F8Ep5vzhDz2U27E=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr1906916uak.19.1619165705016;
 Fri, 23 Apr 2021 01:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210420134641.57343-1-avri.altman@wdc.com> <20210420134641.57343-3-avri.altman@wdc.com>
In-Reply-To: <20210420134641.57343-3-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Apr 2021 10:14:28 +0200
Message-ID: <CAPDyKFr95yFAbYyRGZMg6UpsUXYxm4c8J0ZRqw2ASdf+bF1edg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mmc: block: Update ext_csd.cache_ctrl if it was written
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 at 15:46, Avri Altman <avri.altman@wdc.com> wrote:
>
> The cache function can be turned ON and OFF by writing to the CACHE_CTRL
> byte (EXT_CSD byte [33]).  However,  card->ext_csd.cache_ctrl is only
> set on init if cache size > 0.
>
> Fix that by explicitly setting ext_csd.cache_ctrl on ext-csd write.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

This can go separate from patch 1, so I have applied this for next and
by adding a stable tag to it.

Thanks and kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 24e1ecbdd510..7e70f11e85e2 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -572,6 +572,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>                 main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
>         }
>
> +       /*
> +        * Make sure to update CACHE_CTRL in case it was changed. The cache
> +        * will get turned back on if the card is re-initialized, e.g.
> +        * suspend/resume or hw reset in recovery.
> +        */
> +       if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_CACHE_CTRL) &&
> +           (cmd.opcode == MMC_SWITCH)) {
> +               u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg) & 1;
> +
> +               card->ext_csd.cache_ctrl = value;
> +       }
> +
>         /*
>          * According to the SD specs, some commands require a delay after
>          * issuing the command.
> --
> 2.25.1
>
