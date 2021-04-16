Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE24361961
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbhDPFja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDPFj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:39:28 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C670C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:39:04 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e66so11443094oif.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HeEOZF5KkABK2M/RTmpqX++SXrAdlthytWqJ+8fcvIA=;
        b=YTLwAKpJyW9L+jsMG0AaqQBsVRtu3dpmEF7K4rQnhCfHubNY3MY3CUVTRLkk7vM+ad
         v2/G+5ZaIBo7T+55PcWdCR+DB5jGUyWOb05ED05zeXADfQ9zUj0TbuNZgb03HUio8nHF
         GK/Uf8inYvjCJrCnvlk8Deh+8niOx1k5ImwKf/q+fvO0/ZS6gDDJZP5t1pkbrHJHciNl
         F/JnHQLOnFBi2s6GBqy+hQdZgPxIRSRlXOBiGfpGjn2Td8e3DXxu1Ckxq8x7ZzAuhvgJ
         5x+30YCycXr+EDNSgN+AAzp0cq7vFWSE2Tb6rJ1eXHx1RYTwoUrcKF/S9RbzKzhFIedx
         s2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HeEOZF5KkABK2M/RTmpqX++SXrAdlthytWqJ+8fcvIA=;
        b=Ed2fuJ6St+fFFTaU+fWADbkrJzw0bUdDeerPYXT9aqmW1TiUHKmeXyVgpIRVzvImso
         alg5lJcLD5vMizkE94z1Z55ymZ+jWqGFIjH9LigMD9z2HHQui6ZPKDr/s9MQOFu2laYm
         9dSAAhD1cZzcrNuiPCnrX+rgJ7Czfm4+4leAKjWYZ6kCDWkYWXXVgT3vqoIEe8U4rRLR
         oVN3wkIszS71Uw/YE3Bb37aMRS6F5kRAIYHk//4hAGAoxPZ0TA94d5OGUY1KoOgLpTKc
         fLtm/BhuHDiD7ZC/0z/peZdX3adhhUewwcnITCQdXwmnX75gkv+37uLZhKnoaqEjxFkz
         8eHw==
X-Gm-Message-State: AOAM53148BZLzCHQ8NtDGsUu7V4Est992k2olX9QiPj3xrMSXLJgT3V6
        VFEiKrqfZ1kSq1+wddpBD2N2zLmsuk9KQmw8Ilo=
X-Google-Smtp-Source: ABdhPJyUE0gZHJO5PI5oIvjry7qpOHb5kniIX2nNrNOzbcHc3FEemz+rZAIcR9J6tTy8viOJFb8iWQGGpv7RStMUMcc=
X-Received: by 2002:a05:6808:bd6:: with SMTP id o22mr5221897oik.129.1618551544090;
 Thu, 15 Apr 2021 22:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210415021456.1805797-1-pmalani@chromium.org>
In-Reply-To: <20210415021456.1805797-1-pmalani@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 07:38:55 +0200
Message-ID: <CAFqH_53KBrjeZG5k1npbboLOGcbPv3_8_dTQ-ZsJcUwvKAY1nA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle hard reset
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for your patch.

Missatge de Prashant Malani <pmalani@chromium.org> del dia dj., 15
d=E2=80=99abr. 2021 a les 4:15:
>
> The Chrome Embedded Controller (EC) generates a hard reset type C event
> when a USB Power Delivery (PD) hard reset is encountered. Handle this
> event by unregistering the partner and cable on the associated port and
> clearing the event flag.
>
> Also update the EC command header to include the new event bit. This bit
> is included in the latest version of the Chrome EC headers[1].
>
> [1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads=
/main/include/ec_commands.h
>
> Cc: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c        | 13 +++++++++++++
>  include/linux/platform_data/cros_ec_commands.h |  1 +

Could this be a separate patch?

Thank you.
  Enric

>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index d3df1717a5fd..22052f569f2a 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -905,6 +905,19 @@ static void cros_typec_handle_status(struct cros_typ=
ec_data *typec, int port_num
>                 return;
>         }
>
> +       /* If we got a hard reset, unregister everything and return. */
> +       if (resp.events & PD_STATUS_EVENT_HARD_RESET) {
> +               cros_typec_remove_partner(typec, port_num);
> +               cros_typec_remove_cable(typec, port_num);
> +
> +               ret =3D cros_typec_send_clear_event(typec, port_num,
> +                                                 PD_STATUS_EVENT_HARD_RE=
SET);
> +               if (ret < 0)
> +                       dev_warn(typec->dev,
> +                                "Failed hard reset event clear, port: %d=
\n", port_num);
> +               return;
> +       }
> +
>         /* Handle any events appropriately. */
>         if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE && !typec->ports[=
port_num]->sop_disc_done) {
>                 u16 sop_revision;
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/lin=
ux/platform_data/cros_ec_commands.h
> index 5ff8597ceabd..9156078c6fc6 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -5678,6 +5678,7 @@ enum tcpc_cc_polarity {
>
>  #define PD_STATUS_EVENT_SOP_DISC_DONE          BIT(0)
>  #define PD_STATUS_EVENT_SOP_PRIME_DISC_DONE    BIT(1)
> +#define PD_STATUS_EVENT_HARD_RESET             BIT(2)
>
>  struct ec_params_typec_status {
>         uint8_t port;
> --
> 2.31.1.295.g9ea45b61b8-goog
>
