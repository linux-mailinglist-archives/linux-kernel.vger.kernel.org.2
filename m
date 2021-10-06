Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF09424A8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 01:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhJFXeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 19:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhJFXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 19:34:18 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314C8C061746;
        Wed,  6 Oct 2021 16:32:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id m20so3973623iol.4;
        Wed, 06 Oct 2021 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XHDI+nak76pKwCNO/b4APY07l8WIixPKJ0Hgurv4tc=;
        b=jBFyu/IyMiwdVWvXDlTu22w6pSu1PMs0pfgmes9cZ8k1aIH8/JGWZ8u7QwnFAZtALL
         AMWFVYwpvnE8jBhW4LJRf1L7OAKaTMg1xTJIqyM6MZjl4+h7HLXwgIGXPlEUQn7Zrz/X
         v8MkgLz0MzW+ir0C9LgvVtF2SnAmyi3+Hu+rWL1Ydypy3GYF0X+EAPcEVHDVc4WWPvvX
         Si0hmU9pOYmApgkFmzwbr+xBzLfQJNYOJY6d/YBMKpIXJGRzG+pEkBwnqNQv1Ko3fL3v
         F8wAZZJf44cD/Er4cbfc+rSbt7AZqX/O+7dCoyMg+23m1ZiwevESE43pELM1QR1CvQRs
         kgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XHDI+nak76pKwCNO/b4APY07l8WIixPKJ0Hgurv4tc=;
        b=FFgUm2ADwn/9nVHrhx/QHJQPng2Ctx6Crqtp6SXY0VZfYijIMQQfmp2s8YRaslXo0J
         mhbh3t4d7vmThlhXEg/RNGipnZOrC98pgoTNmRNfPfcqv2p3S5hqzoY2wS91FFe7O+M3
         R0RfeWGcwgieI3YTuOXv82Bn8JHBcAgFqlkjiNqfRq0aLFHxzgqsXWG9e6sjt1liJJzb
         46DjfyayUX+nzLnFo3xckCQ6G70nT6bq/2Ik8aG/RQDDh16p8iK39tf5aGQX6/b4I8aH
         j1jidhl9WnqR1XfFWjBS5jaS7Xbwd8VG/nWgjjsHAbv+7m5onomBil/E4nQtbstXQYBB
         QZ3A==
X-Gm-Message-State: AOAM530Kkwmb/y3I03MZkIlWYh7clGKCzzdYyXtJaWDHevE9LGeMlmy1
        SSA9KZwa/mZ/W37FtCVvQQgtalxdKFTnmSKBN0I=
X-Google-Smtp-Source: ABdhPJzP/iPYyfR/e+DP6TCz5OgZQCi4TQPHwdKZQkIKdihAMIoUZVlcoNmDS3X7lzTWxx3+DlYt91OShgjqYrZyoko=
X-Received: by 2002:a02:2124:: with SMTP id e36mr412135jaa.35.1633563145226;
 Wed, 06 Oct 2021 16:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222502.645003-1-pauk.denis@gmail.com> <20211006222502.645003-3-pauk.denis@gmail.com>
In-Reply-To: <20211006222502.645003-3-pauk.denis@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 7 Oct 2021 01:32:14 +0200
Message-ID: <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 at 00:25, Denis Pauk <pauk.denis@gmail.com> wrote:
>

> Supported motherboards:
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-E GAMING

Pro WS X570-ACE is missing from this list.

> + * EC provided:
provides

> + * Chipset temperature,
> + * CPU temperature,
> + * Motherboard temperature,
> + * T_Sensor temperature,
> + * VRM  temperature,
> + * Water In temperature,
> + * Water Out temperature,
> + * CPU Optional Fan,
Hereinafter "CPU Optional Fan RPM"?

> +static const enum known_ec_sensor known_board_sensors[BOARD_MAX][SENSOR_MAX + 1] = {
> +       [BOARD_PW_X570_A] = {
> +               SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU, SENSOR_TEMP_MB, SENSOR_TEMP_VRM,
> +               SENSOR_FAN_CHIPSET,

I missed SENSOR_CURR_CPU for a few boards, and unfortunately the
mistake made it here too. Sorry for that.

> +/**
> + * struct asus_wmi_ec_info - sensor info.
> + * @sensors: list of sensors.
> + * @read_arg: UTF-16 string to pass to BRxx() WMI function.
> + * @read_buffer: WMI function output.

This seems to be a bit misleading to me in a sense that the variable
holds decoded output (array of numbers as opposed to array of
characters in the WMI output buffer.

> +struct asus_wmi_data {
> +       int ec_board;
> +};

A leftover?

> +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out)
> +{
> +       unsigned int len = ACPI_MIN(ASUS_WMI_MAX_BUF_LEN, inp[0] / 4);
> +       char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> +       const char *pos = buffer;
> +       const u8 *data = inp + 2;
> +       unsigned int i;
> +
> +       utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer, len * 2);
Errr... Why is it here? You need the same loop afterwards, just with a
smaller stride.
> +
> +       for (i = 0; i < len; i++, pos += 2)
> +               out[i] = (hex_to_bin(pos[0]) << 4) + hex_to_bin(pos[1]);
> +}
> +
> +static void asus_wmi_ec_encode_registers(u16 *registers, u8 len, char *out)
> +{
> +       char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> +       char *pos = buffer;
> +       unsigned int i;
> +       u8 byte;
> +
> +       *out++ = len * 8;
> +       *out++ = 0;
> +
> +       for (i = 0; i < len; i++) {
> +               byte = registers[i] >> 8;
> +               *pos = hex_asc_hi(byte);
> +               pos++;
> +               *pos = hex_asc_lo(byte);
> +               pos++;
> +               byte = registers[i];
> +               *pos = hex_asc_hi(byte);
> +               pos++;
> +               *pos = hex_asc_lo(byte);
> +               pos++;
> +       }
> +
> +       utf8s_to_utf16s(buffer, len * 4, UTF16_LITTLE_ENDIAN, (wchar_t *)out, len * 4);
Same here. Just for the sake of calling utf8s_to_utf16s() you need the
same loop plus an additional buffer. I don't get it.

> +}
> +
> +static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
> +{
> +       u16 registers[ASUS_WMI_BLOCK_READ_REGISTERS_MAX];
> +       const struct ec_sensor_info *si;
> +       long i, j, register_idx = 0;
long? maybe a simple unsigned or int?

> +
> +static int asus_wmi_ec_update_ec_sensors(struct asus_wmi_ec_info *ec)
> +{
> +       const struct ec_sensor_info *si;
> +       struct ec_sensor *s;
> +
> +       u32 value;
This variable is now redundant.

> +               if (si->addr.size == 1)
Maybe switch(si->addr.size)?

> +                       value = ec->read_buffer[read_reg_ct];
> +               else if (si->addr.size == 2)
> +                       value = get_unaligned_le16(&ec->read_buffer[read_reg_ct]);
> +               else if (si->addr.size == 4)
> +                       value = get_unaligned_le32(&ec->read_buffer[read_reg_ct]);
> +
> +               read_reg_ct += si->addr.size;
> +               s->cached_value = value;
> +       }
> +       return 0;
> +}


> +       mutex_lock(&sensor_data->lock);
The mutex locking/unlocking should be moved inside the
update_ec_sensors(), I guess.

I re-read your answer to my question as to why don't you add module
aliases to the driver, and I have to admit I don't really understand
it. Could you, please, elaborate?

Thank you,
Eugene
