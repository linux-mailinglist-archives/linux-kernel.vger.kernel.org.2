Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF9B409B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbhIMR5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhIMR5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:57:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01000C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:55:50 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a93so22292822ybi.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGbC2JnK7TwelSJvfDA5bgXvsxFDfQ0hkGPy/EO3m7o=;
        b=hnAxVbY5YbbmQIirbYYgBIXaim2NlEkPOIolE1JnrUYPhlaYUAbAqwv7UhCCX/dUJs
         sPCD/TnDVbWsHk4Lg0OLrGo+X9y1/mT4G8WVsc/iPCixdSnsanMdPp8OxjmQ51aywciG
         gdA+sUKhoQiqnPo/OgNTvwKgxd+mJIfXhGmElxfC4r00BvJoH67RUFfCwsHYHcCFbYdO
         vd+k0ZDhp+dNPxttRqvfp6mumVHBcZIUTeCnr+wks5Jx/Ho/AzQkA1C+BGkxJYP/5Z6O
         K43A4b/qfg7lu8O1miwnp0Uu0XbAEX+Xttg9PGdDKhTW3bLd4ag1/Ow7ZtwYaNHTC9Sm
         yxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGbC2JnK7TwelSJvfDA5bgXvsxFDfQ0hkGPy/EO3m7o=;
        b=V80o9Dbxgc02piKO6ySo2qJwSCmHftdzlxrZQTHv4Zu1W6tFWNr0gtqTw2uGD02C9V
         18o7aWdhAYAo46eHyAtZIpz9aATLymL0XqgU9jUayrqtDhDI9buvec3i76/OfrEg2ruA
         xdwpPFEYJ1++2gWdhkhhdk1yBcn4/RKcl27FUtoMMmWThQZ9wBsLIw8h5DmNKa7gAbAd
         JDDSrNj4p5MAH6Gzkx5QtG60o0IRrynqSCvy/JQo+Mu13dh+u7GpAkmHOn/Xb8hf4Q4x
         LHKnRlNNllbYkd5aZg4W3RWCvb87syTlRHhmSwpu2Jmk+vzjAfFfi0sgTbsfChJ4d3Uu
         e6NQ==
X-Gm-Message-State: AOAM530lXtuFK4NQnbd+CFbzXPmR6XeH0b9s3Q7bPQ5pwhbJyojTux3n
        0zF5WxLgEFcqAy1mVb7fIBLUZ+ELPfinEcfZ1idnXg==
X-Google-Smtp-Source: ABdhPJz3LLYMZr6RvoqOwmDO9q4BzrKuSIT+5HcOxJq902HpX5FGwjlnQINBmI8eFmOJzdDVe0P90aAeJE+wacsVGqk=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr16866816ybb.267.1631555748929;
 Mon, 13 Sep 2021 10:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210913092642.3237796-1-akailash@google.com>
In-Reply-To: <20210913092642.3237796-1-akailash@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 13 Sep 2021 10:55:37 -0700
Message-ID: <CABCJKucJxi3CZU40LLg30fZx_YDsHBwA0fCB9fUMDY9rtqKczQ@mail.gmail.com>
Subject: Re: [PATCH] dm-verity: skip verity_handle_error on I/O errors
To:     Akilesh Kailash <akailash@google.com>
Cc:     Android Kernel Team <kernel-team@android.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akilesh,

On Mon, Sep 13, 2021 at 2:27 AM Akilesh Kailash <akailash@google.com> wrote:
>
> If there is an I/O error and FEC correction fails, return
> an error instead of calling verity_handle_error().
>
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Akilesh Kailash <akailash@google.com>
> ---
> This was discussed in [1] by Sami Tolvanen but was
> never implemented.
>
> [1] https://lore.kernel.org/dm-devel/b004e7c7-f795-77ed-19b9-983785780e92@gmail.com/T/#mec4df1ba3f3cb63846875fb2bfc1f8b3100f31f1

Great, thanks for the patch!

>  drivers/md/dm-verity-target.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 22a5ac82446a..a6f7c452ee80 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -475,6 +475,7 @@ static int verity_verify_io(struct dm_verity_io *io)
>         struct bvec_iter start;
>         unsigned b;
>         struct crypto_wait wait;
> +       struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
>
>         for (b = 0; b < io->n_blocks; b++) {
>                 int r;
> @@ -529,9 +530,17 @@ static int verity_verify_io(struct dm_verity_io *io)
>                 else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
>                                            cur_block, NULL, &start) == 0)
>                         continue;
> -               else if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
> +               else {
> +                       if (bio->bi_status) {
> +                               /*
> +                                * Error correction failed; Just return error
> +                                */
> +                               return -EIO;
> +                       }
> +                       if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
>                                            cur_block))
> -                       return -EIO;
> +                               return -EIO;
> +               }
>         }
>
>         return 0;

This looks correct to me. A non-zero bio->bi_status here means that
FEC must be enabled because otherwise we wouldn't have ended up in
verity_verify_io() in the first place, and returning -EIO when
verity_fec_decode() fails after attempting to correct an I/O error is
consistent with the non-FEC behavior of dm-verity.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
