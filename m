Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179BE45C997
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243084AbhKXQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhKXQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:14:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C62C061574;
        Wed, 24 Nov 2021 08:11:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so12771810edv.1;
        Wed, 24 Nov 2021 08:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdT054fgF5Go5Tp2w6Oh+T0wAIQHsnCjYK9mImRrklE=;
        b=A/8bkpxbZZpO+Pe3nOl8dYlgS2nvzghkIsBTfjQb8Wt6unsftdIWw86X0Z/Dgwmogv
         k4yO67vVcHeg7uvLbj9cgDenVDHDOKBgdi9yVKFS368fyIx0eDGfCCQVxVgtQhETFcoD
         SYLPamsbZV6yFSAYKcmzsInnf6fESBGznUQtY5mlpyRkXictIOsDz34+mHn24iH/7Yer
         SIKnUrYrtsZnqh3zbaqf+EVN1a/U0CbniTtIP1v+iSRDHywKF+lC5IYtFSZ2jhQUnnG2
         NNlImNcUAzc5WvSBimSmk3sDvuIRQC6b+ditxU1ia7uTtt61pqrE+okO58zSY8yNrC5W
         D3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdT054fgF5Go5Tp2w6Oh+T0wAIQHsnCjYK9mImRrklE=;
        b=j5XNwk18gtZTJs7EKOH2TT/3kTVUxJTeXovN9zAVrNGlv4McGzMBF+VYmshw3cQh5E
         EN+VRiPpdmCloBQemgI0OwBMoiwg+MiexhQ2+yE5kXY01MTqyxuXMJyuPsTO3Wui2rLN
         rz96eoJYtCQBl78vyq/etK6QDurCQwjEGBvpXj1UcWcf9bNCOZ2pOw4niI/AICjjiyw5
         IUxuhGIOUlrvEUgbjyPoGYUtXlScrAT3sCiwl46Vt0yePV4Plsy9d3ThgMvVORlEF4Ov
         uFqzl4A+/s2LRPP4br1YAcatfIlrXWECOJkpkyxc8lqY0eezt4XWvL1o0r4MUJAHZwOv
         W2xg==
X-Gm-Message-State: AOAM530/IUP4kKtMAwkjHMnV4/MPYNdnr0/DgIvEG2i0f8xYakGhe749
        OELVnE6dOqBlPBNnXgt6WwUbw3VJg6RrHhgjDmw=
X-Google-Smtp-Source: ABdhPJxRb8Oz7UhK9YLtkRvO3XscN1dwlJW69e+0sHVByixXLWjl+Tp2+gCtzzu/NtpCkFV4l1cA9Hm9lRjAClMLiJo=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr21265851ejq.567.1637770282840;
 Wed, 24 Nov 2021 08:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
In-Reply-To: <20211122212850.321542-3-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Nov 2021 18:10:46 +0200
Message-ID: <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +       if (ACPI_FAILURE(acpi_acquire_mutex(data->acpi_wmi_mutex, NULL, ASUSWMI_DELAY_MSEC_LOCK)))


On Mon, Nov 22, 2021 at 11:29 PM Denis Pauk <pauk.denis@gmail.com> wrote:

No period in the Subject.

> Use ACPI lock when board has separate lock for monitoring IO.

the board
a separate

...

> +#define ASUSWMI_DELAY_MSEC_LOCK                500     /* Wait 0.5 s max. to get the lock */

Units are the last in the names, hence (also check the comment's
location and English)

/* Wait for up to 0.5 s to acquire the lock */
#define ASUSWMI_LOCK_TIMEOUT_MS                500

...

> -       struct mutex update_lock;
> +       struct mutex update_lock;       /* non ACPI lock */
> +       acpi_handle acpi_wmi_mutex;     /* ACPI lock */

Couldn't it be an anonymous union?

...

> +static int nct6775_wmi_lock(struct nct6775_data *data)
> +{
> +       if (ACPI_FAILURE(acpi_acquire_mutex(data->acpi_wmi_mutex, NULL, ASUSWMI_DELAY_MSEC_LOCK)))

Please, use a temporary variable here and in the similar cases.

  acpi_status status;

  status = acpi_acquire_mutex(data->acpi_wmi_mutex, NULL,
ASUSWMI_LOCK_TIMEOUT_MS));
  if (ACPI_FAILURE(status))

> +               return -EIO;
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
