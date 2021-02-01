Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1E30AED5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhBASOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhBASOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:24 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE360C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:13:43 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id r77so17162374qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imHb0HyivfFvDRwOn62u795iSt8I6IACJHNEEDjwHrM=;
        b=m/R083x4yw8Po3deIQZxve9zaniv9wNWSVmsuqle9VprImuHm0XmDA4SF5XwGEu29E
         vJDJz+iDBsr0uD5D3fRBbhEZzT4F6UxLIiE5bZtWWQ31zKPke06n/Qkypzbhk4e4338x
         yxooj22dKnhfnxLhQiMDvAwM8eQuccsFtGz8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imHb0HyivfFvDRwOn62u795iSt8I6IACJHNEEDjwHrM=;
        b=JBcsXBt4IsHOWhdkpmhGnGNtCustrqMi1p//WKNUcDZ2W/zZfDe7koV5InIOx0OfuV
         rfGGi6nLzQCjLejq1OJpR+nxgC4VAQSnbmJs5RtdlXBrOGONPjCZBMja9dSwcIFZNvf+
         gaTm0NYyKRlxUjMypbVN4A3KfXNbkkTmi2BT5RmUf9962KHjNFA49Lpclkur6sYt2dQo
         HIfXVv8D8Cv6yrlkHs/jrquUn2HrXhIDN2mZwIdA9x86kThFWI7RGn3r56d6x4Qpcmjt
         JK4fEmhyqARYL0hz98Tj/TivMz9PY7RKdUZE4Z38j2BW9Z1okMevbfKwhywqHgFx+atH
         cTFA==
X-Gm-Message-State: AOAM531AiSW+RQ0uENZTqsgHogSpPDQ10kX1c/IS3YRz+qVDbKDDUoRs
        r77x9cCgQxt9yVZ3/aF3BgEjPOIvQpUHYf8C+w8Rbw==
X-Google-Smtp-Source: ABdhPJxB+iRdstLzLFrRPnGNybtjEhDACo3oQWsy/cqO8tTSdYocwIkoEgCsde/o4s59tXQI4X2HKwLORV+3BihYbYM=
X-Received: by 2002:a37:9b8b:: with SMTP id d133mr16122639qke.71.1612203223264;
 Mon, 01 Feb 2021 10:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20210129061406.2680146-1-bleung@chromium.org> <20210129061406.2680146-6-bleung@chromium.org>
In-Reply-To: <20210129061406.2680146-6-bleung@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 1 Feb 2021 10:13:31 -0800
Message-ID: <CACeCKadCBzkaNbna1vR8rqPpX4SRmhN585zAN=Ug6GLoY6qhEQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_typec: Set Partner PD
 revision from status
To:     Benson Leung <bleung@chromium.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:14 PM Benson Leung <bleung@chromium.org> wrote:
>
> Status provides sop_revision. Process it, and set it using the new
> setter in the typec class.
>
> Signed-off-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chomium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 30600e9454e1..6bc6fafd54a4 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -824,7 +824,7 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>         return ret;
>  }
>
> -static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
> +static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num, u16 pd_revision)
>  {
>         struct cros_typec_port *port = typec->ports[port_num];
>         struct ec_response_typec_discovery *sop_disc = port->disc_data;
> @@ -842,6 +842,12 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
>                 goto disc_exit;
>         }
>
> +       ret = typec_partner_set_pd_revision(port->partner, pd_revision);
> +       if (ret < 0) {
> +               dev_err(typec->dev, "Failed to update partner PD revision, port: %d\n", port_num);
> +               goto disc_exit;
> +       }
> +
>         memset(sop_disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
>         ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
>                                     sop_disc, EC_PROTO2_MAX_RESPONSE_SIZE);
> @@ -885,7 +891,11 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>
>         /* Handle any events appropriately. */
>         if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE && !typec->ports[port_num]->sop_disc_done) {
> -               ret = cros_typec_handle_sop_disc(typec, port_num);
> +               u16 sop_revision;
> +
> +               /* Convert BCD to the format preferred by the TypeC framework */
> +               sop_revision = (le16_to_cpu(resp.sop_revision) & 0xff00) >> 4;
> +               ret = cros_typec_handle_sop_disc(typec, port_num, sop_revision);
>                 if (ret < 0)
>                         dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
>                 else
> --
> 2.30.0.365.g02bc693789-goog
>
