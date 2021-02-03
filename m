Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AC030D148
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhBCCNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBCCNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:13:35 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA329C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:12:54 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id u20so22004838qku.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//WbMeD9WecyQRt4xqlg9xUI3i1yfXxLyNEG225PD60=;
        b=B5hVJ5vsyQvKOVsTIdgj5zXRomxFyvi2Yiztr1Unt2T4dWs7dSCA8a6VpqX/ISQ4m8
         wOecUeFjQCtB882j6dnEF5lmub5u/emRysvwUp+8VBO1CvZVqhq1wv7hleuTt4UZry0o
         UkqtjPoYQEpDsN8HOYb+vMufRpq0dy3BN9/+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//WbMeD9WecyQRt4xqlg9xUI3i1yfXxLyNEG225PD60=;
        b=Blp3ufeS0bkpvgZDQpAM3jsDhpwspWsxEGPdrcIf872eJOGYlfRx0AArhh5A7Z6iO8
         vnimsT+LhNRoG4D61f1Ns/KFWIAvTdS0v8z+rjauy1xf4lnnZywU0N4ofadOrTQqQTLl
         aWP32oL8iBsWPm3LR5A++uTUWZ+dFehJmPnmrsSFhNWJ1JwQY/RB8lne+31rQP/NCY8/
         SD9vuHI6BJHzSddRwEdvUoHVYS5t/0HLoeBGlIGM2fNm2boKSbwAs57M4UG3PHkTnqdp
         naLd4Ul3q3rwvs/ULmk03LZ++gBxooEQJJux+UwYbZyOsdxFYwxIyrbrrOS6xsR6VpiF
         Csiw==
X-Gm-Message-State: AOAM530a990WLGG+G/7TfaRbucQRHE1WuyCSZmQ6JntXLDvZzc/dDeXB
        U1wTz/Bw0XRn+01rIW4HjZnulsvF+wlrgRcgRAn79UdwHf0=
X-Google-Smtp-Source: ABdhPJyRU6I1tcTLVJfl5/6oeR8wQYiOnaEfWkmeU9UhTq/Tpdr0pQlUclYDkUwnDwtA9lcoTnXfYKlBLkh/m5lreXc=
X-Received: by 2002:a37:4b49:: with SMTP id y70mr664623qka.228.1612318373705;
 Tue, 02 Feb 2021 18:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20210203014939.741065-1-pmalani@chromium.org>
In-Reply-To: <20210203014939.741065-1-pmalani@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 2 Feb 2021 18:12:43 -0800
Message-ID: <CACeCKacBXA-xgzibpoa6Dz-WQwZTPc-MuRd+nTDejjyeSEEcKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec: Import Type C control command
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 5:49 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> This command is used to communicate with the Chrome Embedded Controller
> (EC) regarding USB Type C events and state.
>
> These header updates are included in the latest Chrome OS EC headers [1]
>
> [1]
> https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  .../linux/platform_data/cros_ec_commands.h    | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index d3c40220b281..a95dc22a5463 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -5578,6 +5578,32 @@ struct ec_response_typec_discovery {
>         struct svid_mode_info svids[0];
>  } __ec_align1;
>
> +
> +/* USB Type-C commands for AP-controlled device policy. */
> +#define EC_CMD_TYPEC_CONTROL 0x0132
> +
> +enum typec_control_command {
> +       TYPEC_CONTROL_COMMAND_EXIT_MODES,
> +       TYPEC_CONTROL_COMMAND_CLEAR_EVENTS,
> +       TYPEC_CONTROL_COMMAND_ENTER_MODE,
> +};
> +
> +struct ec_params_typec_control {
> +       uint8_t port;
> +       uint8_t command;        /* enum typec_control_command */
> +       uint16_t reserved;
> +
> +       /*
> +        * This section will be interpreted based on |command|. Define a
> +        * placeholder structure to avoid having to increase the size and bump
> +        * the command version when adding new sub-commands.
> +        */
> +       union {
> +               uint32_t clear_events_mask;
> +               uint8_t mode_to_enter;      /* enum typec_mode */
> +               uint8_t placeholder[128];
> +       };
> +} __ec_align1;
Looks like I got the newlines incorrect while porting the structs. I
will send another version.
