Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29B230AF03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhBASUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhBASPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:41 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4FAC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:15:22 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id u16so8589889qvo.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XixCKUy2/OqgDPmJAwVjEUqW79YeMw3WEZYQtp4ikuo=;
        b=QDdu2QmB9mSkqHqWc0ogevcy7vOT7VQEIsx3WeNYhg04V9/wTz8YXY4ySJkCaN5eef
         i0vFlgRoT4Duz45k2ZxVW5TgqBBup6BmTrvvVpMiaEcmz3AEtNjpdtu7H4s6x+MBb4WO
         pyEka/KSJh0hKkLoU3dsDHe0MM3Th7eG5qJJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XixCKUy2/OqgDPmJAwVjEUqW79YeMw3WEZYQtp4ikuo=;
        b=HVbjHkJ5NXbu0nu1P48t099A42lf6eOy6GCieE312wJnUBZKbpPZoGWb6Q0WnEb8qU
         Qa+tn2hcyKAUAzNDerkEXf2j2lRp0bDf4cfZSGNGqcMT80ReabxY2347A0Ky6mdHm/kJ
         QCd+6PH2pxoWkZfPvbkibRI8W8ij9RSmaqS9PtrjMOlnwLJNtvfHWcvkoDLzB4uJJVIQ
         d3L17YsBx62AU48qvAKx0dYRBo1qzLcCt/o6NpAKBCc3eV6DL/xUGASbjTRdo6iAHPUl
         Uc7V7gh1RynpOnR5QanAwiO5Rka23NGXSUWrvhQEsgZsNwF4eaUaTHQC4jiNrbqAbZqP
         o0kg==
X-Gm-Message-State: AOAM533bfiEbTH/xXARBWmLXvtCC3/2NaNOHKlZekPSb3ojeArpY/F+c
        LV9zdt6JiCTVQHl2RlZb8qDj1fYGtU2VjfXUx14OHxun/04=
X-Google-Smtp-Source: ABdhPJzLhEfS1GYVvI6cLBDmPu6FraWHRaZvsqA3B+FtMRKilRJjYFORE0jNZcsWN5VgnpCYzvhIVlebJctVAbEk2Mc=
X-Received: by 2002:ad4:4e8a:: with SMTP id dy10mr16589132qvb.36.1612203321657;
 Mon, 01 Feb 2021 10:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20210129061406.2680146-1-bleung@chromium.org> <20210129061406.2680146-7-bleung@chromium.org>
In-Reply-To: <20210129061406.2680146-7-bleung@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 1 Feb 2021 10:15:09 -0800
Message-ID: <CACeCKaejodDjoD_DeGvg+bMYhN3GqTQq0qYfgw0=sP2h3JQBWQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] platform/chrome: cros_ec_typec: Set opmode to PD on
 SOP connected
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
> When SOP Discovery is done, set the opmode to PD if status indicates
> SOP is connected.
>
> SOP connected indicates a PD contract is in place, and is a solid
> indication we have transitioned to PD power negotiation, either as
> source or sink.
>
> Signed-off-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 6bc6fafd54a4..a7778258d0a0 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -900,6 +900,9 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>                         dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
>                 else
>                         typec->ports[port_num]->sop_disc_done = true;
> +
> +               if (resp.sop_connected)
> +                       typec_set_pwr_opmode(typec->ports[port_num]->port, TYPEC_PWR_MODE_PD);
>         }
>
>         if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
> --
> 2.30.0.365.g02bc693789-goog
>
