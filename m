Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7B237EB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380705AbhELTcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346349AbhELRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:13:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18479C0611F0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:07:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so36089588ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RbbAGXstepVBpScFTiPKoG1u6uzWbH+B9unkoR6/QM8=;
        b=lN8f/ZcCWC2dDhyHUvpVSMlufi3njJZxVFOy6RaW7dvIbTqQrLTDT2bCpkQ8HWvSdw
         lEHCieGQ1ZL9Xfj8MSZ47LYkp+kp/mePHKSX7zMR36BX8VCTAvkqDQlpZ8FenVP9n8bW
         O5WmD7c/UzSlcdKPZc3ozE1T3YmVl5l9AyZKnOs2oE7Oui/wDDxKnUE9N7t6/phMgEcu
         A28FSxku2AqItslQ71CFHTRHXJSeHeypJVhIwdkOv2u5KCjvdvUlG6OwQY8HeMUbEzUm
         uEY5Wg2Cij19QDtIEp5tfteF5PVcjSinPbCtXwo34PQ/+V6jekdnSaplX53SB7s/2XsM
         U23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RbbAGXstepVBpScFTiPKoG1u6uzWbH+B9unkoR6/QM8=;
        b=HXTG3HFEchxb3zATHb+DSeSLPYNIrzs6shk9vg1GCFWJKA1erF97OFz58tYa6M9snB
         4xm7f+3tzo+sG9EGfW9l99mmRXnqIJ0U3HRgZiaK/+yiRcAmd0sh/DkyQh/pjp2RM5ba
         /BOUfVNRnMytF62Ju6lk0RCT5Q54IP4XMLuSVsonDX2JOH75GnUOc5iV+5C9p6I9yTz7
         3saRYgZWqSNUDtTzu8Mb7mTN7xc2hnSkRUDl+8BPX5Bf/IJyoaujmw2ikPWjlvxSj6HW
         FKXgtvWvlbn9qBwse9fsOfSQSsmPyBkwKrKsygb58GMHIGDayA0Z30VETtSo32WVdRyu
         trcQ==
X-Gm-Message-State: AOAM533Xbn9TsRmipDeQiiItzR5FWaMHajScowDBsHvqu25Nr3USEnyG
        fiAN+rdq1eRyPkQtaEZ1SCTySdNGTylJdrA1lLUNGg==
X-Google-Smtp-Source: ABdhPJyOH9hGfRE+ZQ9A/CQByIjQhZWgTgLkd2DfEZOoBpPDZnZQFEm1t5CEudnnBfEaWtTsJyP3lQNLvaV82qUtEIY=
X-Received: by 2002:a17:906:eca9:: with SMTP id qh9mr38303738ejb.258.1620839234543;
 Wed, 12 May 2021 10:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210512170418.2432278-1-linchuyuan@google.com>
In-Reply-To: <20210512170418.2432278-1-linchuyuan@google.com>
From:   Chu Lin <linchuyuan@google.com>
Date:   Wed, 12 May 2021 10:07:03 -0700
Message-ID: <CAKCA56BWYCU64JzRfEhWyveDjpQh+db5oOz_MvhddKPF-cx+yw@mail.gmail.com>
Subject: Re: [PATCH] Enable adm1272 temperature reporting
To:     linchuyuan@gmail.com, Jason Ling <jasonling@google.com>,
        Zhongqi Li <zhongqil@google.com>,
        Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please discard this one.
Sent by error.

Thanks,
Chu

On Wed, May 12, 2021 at 10:04 AM Chu Lin <linchuyuan@google.com> wrote:
>
> adm1272 supports temperature reporting but it is disabled by default.
>
> Tested:
> ls temp1_*
> temp1_crit           temp1_highest        temp1_max
> temp1_crit_alarm     temp1_input          temp1_max_alarm
>
> cat temp1_input
> 26642
>
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
>  drivers/hwmon/pmbus/adm1275.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index e7997f37b266..0be1b5777d2f 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -611,11 +611,13 @@ static int adm1275_probe(struct i2c_client *client)
>                 tindex = 8;
>
>                 info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> -                       PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +                       PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +                       PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>
> -               /* Enable VOUT if not enabled (it is disabled by default) */
> -               if (!(config & ADM1278_VOUT_EN)) {
> -                       config |= ADM1278_VOUT_EN;
> +               /* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> +               if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
> +                   (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
> +                       config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
>                         ret = i2c_smbus_write_byte_data(client,
>                                                         ADM1275_PMON_CONFIG,
>                                                         config);
> @@ -625,10 +627,6 @@ static int adm1275_probe(struct i2c_client *client)
>                                 return -ENODEV;
>                         }
>                 }
> -
> -               if (config & ADM1278_TEMP1_EN)
> -                       info->func[0] |=
> -                               PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>                 if (config & ADM1278_VIN_EN)
>                         info->func[0] |= PMBUS_HAVE_VIN;
>                 break;
> --
> 2.31.1.607.g51e8a6a459-goog
>
