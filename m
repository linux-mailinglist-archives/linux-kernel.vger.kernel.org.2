Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F345C9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348510AbhKXQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348617AbhKXQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:25:33 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E35C061757;
        Wed, 24 Nov 2021 08:22:08 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r25so12903176edq.7;
        Wed, 24 Nov 2021 08:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEXZc8R5yEIrgQ4MYOLlm+SaoIgScgmUX3YPF/pZ09g=;
        b=DHkqm2r6wH23tUGtFdJrg/ijsnibP52SB/uKaXcgsctINJU4hkAHdL7iEDdTc+/7wW
         hlvNwOmAmXJK2bEdSLZylwoutiOBotlintnDBoEYDp5s0nSd0ycEfCVatpp+pWCevvMw
         t3xfTZ/GvKPgfdLI4yF1gsNbHEkNRKtdC9hRxLlnvQ6DGLHZa15ibifMJccmr8wTv13o
         akoXPn2mLKn19einDNO5bQrWE2n1fH9xJpjGBMDGxkryuHwrjIfEmdpyu7IMpPYtaeXG
         V6z+ZkQ4SQxP6SlTEzXfpizmf7zStxFLpJ0r6pU6NouKzC32RzotxDQ2vWB11N8Yj08t
         uEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEXZc8R5yEIrgQ4MYOLlm+SaoIgScgmUX3YPF/pZ09g=;
        b=j58kCoq2hjn8PoKla2bvn1DJYtZNH9bH7C2PgpDz1b+C4d0W3ivvjTOkeVXcmEo1KY
         PbUQcLA3chk9hat6IcANBxrdiAMhGbePFeKYLeda2r4VEQR/xT7Mw7uwhIXrOetqr2cL
         2++IkjS1uI7VgMMp2gmCEx5YgC2Zmb6wQVqi6oaoNftDSr96gk7oNkXVWB7Y/Qsuihnf
         7R4DXeOKyTdcMBlAU9m0aJCAq4ErK0o9N8wKjOedkbTWFsQJ30La/+QHTde2dtTuBWyq
         2OTSkaDhm9U01plkEp9LMBoE2Jv0Cf0ptR1cES3XDMlqqdKJJ8VY1/qwZr+x1QryjScd
         hauA==
X-Gm-Message-State: AOAM530dhORU4IriLjzAclk0GzF3yieOhJgGEsFdZ1yyY4DoerKb87po
        Bpzytb4QS+n2HXfFKtsb7L8pCAPqQP0qrYsHf0o=
X-Google-Smtp-Source: ABdhPJxAQTJYrBt7sP/hy533sdjmlUNyL8pMeZfIpiJQkk03O50xJJMIwt3G4bnxD17b8M+ck5HdgndOAKUuRUYrEwc=
X-Received: by 2002:a05:6402:26d4:: with SMTP id x20mr26549087edd.119.1637770926939;
 Wed, 24 Nov 2021 08:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-4-pauk.denis@gmail.com>
In-Reply-To: <20211122212850.321542-4-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Nov 2021 18:21:30 +0200
Message-ID: <CAHp75VeKosontsmFJSp-fbV9mPiSWJeLUCpx90=RHy1HFfBDnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (nct6775) add MAXIMUS VII HERO.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Olli Asikainen <olli.asikainen@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:29 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> ASUS MAXIMUS VII HERO board has got an nct6775 chip, but by default
> there's no use of it because of resource conflict with WMI method.
>
> This commit adds MAXIMUS VII HERO to the list of boards and provides
> ACPI mutex name that can be used as shared lock with ASUS WMI.
>
> Logic checks that mutex is available. If mutex is not available
> tries to get chip version by ACPI WMI interface.

a chip

...

> +struct acpi_board_info {
> +       char *acpi_mutex_name;

Looking below the name of the "name" should be rather "path".

>  };

...

> +static const struct dmi_system_id asus_wmi_info_table[] = {
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("MAXIMUS VII HERO", &acpi_board_MAXIMUS_VII_HERO),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME B360-PLUS", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME B460-PLUS", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME B550M-A (WI-FI)", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X570-PRO", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII FORMULA", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII IMPACT", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-E GAMING",
> +                                       &acpi_board_ROG_STRIX_B550_E_GAMING),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-F GAMING", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-F GAMING (WI-FI)", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-I GAMING", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-F GAMING", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z390-E GAMING", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z490-I GAMING", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550-PLUS", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550-PRO", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550M-PLUS", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING B550M-PLUS (WI-FI)", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X570-PLUS", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X570-PLUS (WI-FI)", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X570-PRO (WI-FI)", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING Z490-PLUS", &acpi_board_ANY),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING Z490-PLUS (WI-FI)", &acpi_board_ANY),

So, is it possible to eliminate acpi_board_ANY and use some default in
the code instead?

> +       {}
> +};

....

> -       if (board_name && board_vendor &&
> -           !strcmp(board_vendor, "ASUSTeK COMPUTER INC.")) {
> -               err = match_string(asus_wmi_boards, ARRAY_SIZE(asus_wmi_boards),
> -                                  board_name);

Do you need string_helpers.h after this change?

> -               if (err >= 0) {
> -                       /* if reading chip id via WMI succeeds, use WMI */
> -                       if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
> -                               pr_info("Using Asus WMI to access %#x chip.\n", tmp);
> -                               access = access_asuswmi;
> +               if (board_info->acpi_mutex_name) {

> +                       status = acpi_get_handle(NULL, board_info->acpi_mutex_name,
> +                                                &acpi_wmi_mutex);

One line?

> +                       if (ACPI_FAILURE(status)) {
> +                               pr_err("Could not get hardware access guard mutex.\n");
>                         } else {
> -                               pr_err("Can't read ChipID by Asus WMI.\n");
> +                               pr_info("Using Asus WMI mutex: %s\n", board_info->acpi_mutex_name);
> +                               access = access_direct;
>                         }
>                 }

...

> +               /* if reading chip id via WMI succeeds, use WMI */

Be consistent with how you spell "ChipID" / "chip id" / etc everywhere
in the code.

...

> +               if (access == access_asuswmi &&
> +                   nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
> +                       access = access_direct;
> +                       pr_err("Can't read ChipID by Asus WMI.\n");
> +               }
> +
> +               if (access == access_asuswmi) {
> +                       if (tmp)
> +                               pr_info("Using Asus WMI to access %#x chip.\n", tmp);
> +                       else
> +                               access = access_direct;

Why not:

        if (access == access_asuswmi) {
               access = access_direct;
               if (nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp))
                       pr_err("Can't read ChipID by Asus WMI.\n");
               if (tmp) {
                       pr_info("Using Asus WMI to access %#x chip.\n", tmp);
                      access = access_...; // do you have this?
               }
               ...
        }

?

-- 
With Best Regards,
Andy Shevchenko
