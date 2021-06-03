Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078DD39A59F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFCQU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:20:55 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AB2C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 09:19:10 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id g38so9572570ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CTYZE9lUxcOu922B1KU045rKWAEegWYdALK+0qlDww=;
        b=skU+340UIeR/LP0HXvOnHKFkfdCeZr4Fw4orpgm5zBnWA7H/gph1HvSlnnGNYJjzQ2
         UTSzSaNfMp4HUgvGw0Xt+NKR5zIkGWilSV4Bl4tOrjdDKyWtZWqTo4rsN9MjY5iIzYdM
         IdzfewuoZIdC9BpL6ai/s/Bwmz2H8opHzw8TvuTzPN0NtI5zMXSjGTxIDOvdc79xnRof
         s8213t9ziC/fAbTO8AxIGoDyREVjedQogUFlS+dpwm31J3tKnaXp9z0pCM9PTPolZVlS
         Z0q2Yx91PkoA4VHvnjynFNJwDFU+TIMS0I0ZQ2P1ZwLB8mC6xXe3jblemWLfa4j4LjaF
         oknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CTYZE9lUxcOu922B1KU045rKWAEegWYdALK+0qlDww=;
        b=XDTDzuscD303g8IOsl0VfK1iDV4nYh9w8DndT0pFh5JfRImO0D4up3tr2LCEiLUc6p
         cOHt/iiN2z1j4sh2bOlmuh1YFrJ2WeMUEjofOoIfEEDt7WzXZ8VJ2AKgeuN1yZvolip1
         FBcq1O4UHOrYZUNY5RKEs69jyNtkx7cfbd7vcBlOn5ITxggjFtOnBqmqDNGEA/VXQu1v
         FzmJfHjXFzLIlA7msmke+hPQnpigVfF0u0IzVU0bxjcYFHKzq/H3XsqEwNk0UIFm73bm
         4VOEQac9ZrwHNxVUU8sEOY3ogQQBGIjLl+bCvIH2JHSnzVRNdhIaq3DFNdEqN10MEjLE
         s8kw==
X-Gm-Message-State: AOAM532zr3TUB/wp46kTQlPBHnfPwiF62iafJ+oh3oNMg64z0ecr9aFx
        vIwAE93mKKTbbIK0ANKoVKiKa5P5n5WLTCMDEufCvg==
X-Google-Smtp-Source: ABdhPJwshXH8Q4JBHPC1vb6ZEqNWanF9h5itHs19o5a38VwsHtPrldu6d6inGT78rjZ/yQ5+D3aNczRtRw1cm6U3D3k=
X-Received: by 2002:a25:bdd3:: with SMTP id g19mr1172160ybk.20.1622737149686;
 Thu, 03 Jun 2021 09:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210603064849.1376107-1-swboyd@chromium.org>
In-Reply-To: <20210603064849.1376107-1-swboyd@chromium.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 3 Jun 2021 09:18:33 -0700
Message-ID: <CAGETcx8djbKQo2uxqE-2S_j0ek3+bO=2Ju8tfDSe1dCoSWWdXA@mail.gmail.com>
Subject: Re: [PATCH] driver core: Make dev_info() messages dev_dbg()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 11:48 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> These seem to mostly print debug information about device link stuff at
> boot. They don't seem very useful outside of debugging so move them to
> dev_dbg().
>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 628e33939aca..066880a843bc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -865,7 +865,7 @@ static void __device_link_del(struct kref *kref)
>  {
>         struct device_link *link = container_of(kref, struct device_link, kref);
>
> -       dev_info(link->consumer, "Dropping the link to %s\n",
> +       dev_dbg(link->consumer, "Dropping the link to %s\n",
>                  dev_name(link->supplier));

I think this is already fixed in Tot.

>
>         pm_runtime_drop_link(link);
> @@ -1732,7 +1732,7 @@ static int fw_devlink_create_devlink(struct device *con,
>                  */
>                 if (!device_link_add(con, sup_dev, flags) &&
>                     !(flags & DL_FLAG_SYNC_STATE_ONLY)) {
> -                       dev_info(con, "Fixing up cyclic dependency with %s\n",
> +                       dev_dbg(con, "Fixing up cyclic dependency with %s\n",
>                                  dev_name(sup_dev));
>                         device_links_write_lock();
>                         fw_devlink_relax_cycle(con, sup_dev);
>
> base-commit: 5fcd0bc17e451e8f140067131fd12be0f5f1204c

Nak on this one. This doesn't happen for most systems and for the
systems where this does happen, it's handy to figure out any boot
issues that might be caused by this cyclic dependency.

Maybe after a few kernel minor versions if no issues are reported with
fw_devlink for a while, I'd consider making it dbg.

-Saravana
