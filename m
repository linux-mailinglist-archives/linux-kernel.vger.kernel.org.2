Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3145338067
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCKWfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 17:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCKWfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:35:09 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C4EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:35:09 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id l27so11551833vsj.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Slj5ijAMQvQRxb1SS2xuWqvziQTtlap7wzaKqo38Ysg=;
        b=KLRCe0QOPnaZz8CFfijz474n51yPgrBjC9/+FrXpUuMXqSTxBDaY3JfP0FBrQz4dUm
         TlyU5oWoGGE+2shY3k/GfMTNiSed1JDJb9+cuQA9qE51EQJz/iqfd39qzQlhGQiupprq
         qYMoD+0VGcJEBQK3HQ7nIoKFfbBM3F+PYMh/XrGz39eAGZioY/w4QnvZQIiPXwsnDuQV
         zKxtobjdJDoN7Yq+c64biOLfcgJXTyDKtTEiZgkLShU7r+PXkEvTXY6M5pqTwLkROYSv
         6GOt6T+hnw6lV3J10BKl/zzDfxl+WecXR0+zjpTKJEILzD4KuG1XsBiQ13FN3jxoGMDG
         ctvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Slj5ijAMQvQRxb1SS2xuWqvziQTtlap7wzaKqo38Ysg=;
        b=Eu6hpiIQiVwLgyxymdKnnwrL8Q9j2TzjI03P3V3zDAnYH+9ks1hbwmc/UOSmZoQ07b
         E8gELKFxJUQDXEzdLfhC6j8bvHbgpQopOWgBOQW3WfgYd88o/0izk4Ob6PJewih1VQ2n
         h7rlTPYR9NnuUtnBPhdQMuDmaqNMiUJfoXrp2WDR8k9mwdkXPAoAngPXNiTMpCflRlKF
         AtQuCisfEdPGsPl/h2Dw0ZeX31l/z9MGkNRBJva+giEv9odJr0H08TE2VSdf5kPaNDdz
         ohdV8VGKRY3Ap2k+rpzqwwi5RFIOsKWlYJhrJCLdT6eih1MkX2ZbZ7vG/cT+Q2+ajJdf
         l5tQ==
X-Gm-Message-State: AOAM531l+SCJic5r+5EvxubDHQi7MY6AXPXqmg/I6iMI6JmvRZs2wzBU
        bmrmrn5QqfiOAZFd8EzFUSdzSiPm3rBns4j1GmkHpA==
X-Google-Smtp-Source: ABdhPJxS6e6HZ5CIYY3avBcnq6Cx3ijhGntj0qmtikKDEFki6YSCBlYrsrdkcr8uflsd08tLwKMsKfBnbWFmV0NM+F4=
X-Received: by 2002:a67:7384:: with SMTP id o126mr6898285vsc.23.1615502108020;
 Thu, 11 Mar 2021 14:35:08 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210311121850epcas1p493c255a586998916febfebaf994bc5dc@epcas1p4.samsung.com>
 <1615464651-23675-1-git-send-email-jhs2.lee@samsung.com> <1615464651-23675-2-git-send-email-jhs2.lee@samsung.com>
In-Reply-To: <1615464651-23675-2-git-send-email-jhs2.lee@samsung.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 11 Mar 2021 14:34:56 -0800
Message-ID: <CABCJKucMyQbtt-LACCRSk6bxAqmS05eVhv-5ou3_XZ1Nz+XYug@mail.gmail.com>
Subject: Re: [PATCH 2/2] dm verity: allow only one verify mode
To:     JeongHyeon Lee <jhs2.lee@samsung.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 4:19 AM JeongHyeon Lee <jhs2.lee@samsung.com> wrote:
>
> If there are multiple verity mode when parsing the verity mode of dm
> verity table, it will be set as the last one.
> So set to 'allow only once' to prevent it.

I agree that we shouldn't allow this, at least not without a warning,
but out of curiosity, do you actually have a situation where this
could happen? One ideally shouldn't be passing untrusted parameters to
dm-verity.

>
> Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>
> ---
>  drivers/md/dm-verity-target.c | 38 ++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 808a98ef624c..b76431dc7721 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -893,6 +893,28 @@ static int verity_alloc_zero_digest(struct dm_verity *v)
>         return r;
>  }
>
> +static inline bool verity_is_verity_mode(const char *arg_name)
> +{
> +       return (!strcasecmp(arg_name, DM_VERITY_OPT_LOGGING) ||
> +               !strcasecmp(arg_name, DM_VERITY_OPT_RESTART) ||
> +               !strcasecmp(arg_name, DM_VERITY_OPT_PANIC));
> +}
> +
> +static int verity_parse_verity_mode(struct dm_verity *v, const char *arg_name)
> +{
> +       if (v->mode)
> +               return -EINVAL;
> +
> +       if (!strcasecmp(arg_name, DM_VERITY_OPT_LOGGING))
> +               v->mode = DM_VERITY_MODE_LOGGING;
> +       else if (!strcasecmp(arg_name, DM_VERITY_OPT_RESTART))
> +               v->mode = DM_VERITY_MODE_RESTART;
> +       else if (!strcasecmp(arg_name, DM_VERITY_OPT_PANIC))
> +               v->mode = DM_VERITY_MODE_PANIC;
> +
> +       return 0;
> +}
> +
>  static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
>                                  struct dm_verity_sig_opts *verify_args)
>  {
> @@ -916,16 +938,12 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
>                 arg_name = dm_shift_arg(as);
>                 argc--;
>
> -               if (!strcasecmp(arg_name, DM_VERITY_OPT_LOGGING)) {
> -                       v->mode = DM_VERITY_MODE_LOGGING;
> -                       continue;
> -
> -               } else if (!strcasecmp(arg_name, DM_VERITY_OPT_RESTART)) {
> -                       v->mode = DM_VERITY_MODE_RESTART;
> -                       continue;
> -
> -               } else if (!strcasecmp(arg_name, DM_VERITY_OPT_PANIC)) {
> -                       v->mode = DM_VERITY_MODE_PANIC;
> +               if (verity_is_verity_mode(arg_name)) {
> +                       r = verity_parse_verity_mode(v, arg_name);
> +                       if (r) {
> +                               ti->error = "Already verity mode set";

I don't have a strong opinion about this, but the documentation
doesn't talk about verity modes, so perhaps this could be reworded to
something like "Conflicting error handling parameters"?

> +                               return r;
> +                       }
>                         continue;
>
>                 } else if (!strcasecmp(arg_name, DM_VERITY_OPT_IGN_ZEROES)) {
> --
> 2.17.1
>

Sami
