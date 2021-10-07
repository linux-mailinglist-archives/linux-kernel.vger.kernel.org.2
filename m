Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184E24256FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbhJGPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhJGPsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:48:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13BC061570;
        Thu,  7 Oct 2021 08:46:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r19so25145554lfe.10;
        Thu, 07 Oct 2021 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rajHof593eX7OQXAG09Ry6o1R+lhe8YCsSEgezbcnTM=;
        b=NBUJjQszGmnRVkFSvVAtwxMxTeiFNRiEqz3xdoYJw44OYfnSLedF5beU92YNonpeTa
         Q+KY2nDozToYWHV2L7oyZbPfSZrk9GvClziSPeUk6dZUEmK4g/iqt0GOszW6jgCbcsKH
         Hngp2OF7QqiPH6JSaEbuRWpXNETzqC2xWjNKMvqmBVprvc2hQrFiWIkfE6kjV/s66qhc
         DrNnIyfOYQ0eZWQlhJSQqwjPq1oO9tD1nx75neUklolxZ+NHOfO3c7CPMtNTuMYDbapA
         vuhmqxtpuPoHQbpi4XldQlErKK6opUm7GgLHT8JwWPxFmVK2Pb07+nhauVz1dLhJLosY
         p54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rajHof593eX7OQXAG09Ry6o1R+lhe8YCsSEgezbcnTM=;
        b=4xcvD2T/XgWJkj+M2PTfD33oooxPS/NRviN1jSiDgQVon74ONOYB77YvlFeIbJ4gns
         jLWB6qkvmL4CY0mXpsmHUPoIcOwj/ucRd58s5cYzds4hJgsJTaNvG1UNayVXu6D8Krn0
         Bt07ppHL39fVE8FI9jAaNQh+5CAUIAqrDLhnJ5xVNH96hHzPQ4+Y36ScJHe28IzhLXvt
         dUTqWABHf+LsRWe0c8HLa3pq5gvf474XvBz31KNFBhSArR2qp6nORPE9+QaOL5XWBx9/
         Ss5zEI/eARjf71woqfrtrUdpxcedSGX8Q92IALLfzIPHErFQ++pvTvaFLJ6Hm7nipIwe
         QpUQ==
X-Gm-Message-State: AOAM5333CVMkUiEzw/qEXvJen2rz4ySWAqaztWRgP9pxh0PWQL+/IiCe
        NK6olqM/5GvNPz4m/SLkZIU=
X-Google-Smtp-Source: ABdhPJxr+Fq0/G6Ls8T5b7u0+cky/7js+b+C6Fo/VLOmLqpqq2rfCG0jl/ilTPUXqiXasLQpefZ3Gg==
X-Received: by 2002:ac2:4299:: with SMTP id m25mr4807315lfh.642.1633621613919;
        Thu, 07 Oct 2021 08:46:53 -0700 (PDT)
Received: from penguin.lxd ([94.153.6.46])
        by smtp.gmail.com with ESMTPSA id h10sm1556361lfp.7.2021.10.07.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:46:53 -0700 (PDT)
Date:   Thu, 7 Oct 2021 18:46:44 +0300
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <20211007184644.1d042550@penguin.lxd>
In-Reply-To: <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com>
References: <20211006222502.645003-1-pauk.denis@gmail.com>
        <20211006222502.645003-3-pauk.denis@gmail.com>
        <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugene, 

On Thu, 7 Oct 2021 01:32:14 +0200
Eugene Shalygin <eugene.shalygin@gmail.com> wrote:

> On Thu, 7 Oct 2021 at 00:25, Denis Pauk <pauk.denis@gmail.com> wrote:
> >  
> 
> > Supported motherboards:
> > * ROG CROSSHAIR VIII HERO
> > * ROG CROSSHAIR VIII DARK HERO
> > * ROG CROSSHAIR VIII FORMULA
> > * ROG STRIX X570-E GAMING
> > * ROG STRIX B550-E GAMING  
> 
> Pro WS X570-ACE is missing from this list.
Thanks, I will check.
> 
> > + * EC provided:  
> provides
Thanks, I will check.
> 
> > + * Chipset temperature,
> > + * CPU temperature,
> > + * Motherboard temperature,
> > + * T_Sensor temperature,
> > + * VRM  temperature,
> > + * Water In temperature,
> > + * Water Out temperature,
> > + * CPU Optional Fan,  
> Hereinafter "CPU Optional Fan RPM"?
> 
Thanks, I will check.
> > +static const enum known_ec_sensor
> > known_board_sensors[BOARD_MAX][SENSOR_MAX + 1] = {
> > +       [BOARD_PW_X570_A] = {
> > +               SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU,
> > SENSOR_TEMP_MB, SENSOR_TEMP_VRM,
> > +               SENSOR_FAN_CHIPSET,  
> 
> I missed SENSOR_CURR_CPU for a few boards, and unfortunately the
> mistake made it here too. Sorry for that.
> 
Do you have such fix in your repository?
> > +/**
> > + * struct asus_wmi_ec_info - sensor info.
> > + * @sensors: list of sensors.
> > + * @read_arg: UTF-16 string to pass to BRxx() WMI function.
> > + * @read_buffer: WMI function output.  
> 
> This seems to be a bit misleading to me in a sense that the variable
> holds decoded output (array of numbers as opposed to array of
> characters in the WMI output buffer.
> 
> > +struct asus_wmi_data {
> > +       int ec_board;
> > +};  
> 
> A leftover?
> 
Its platform data and used to share board_id with probe.

> > +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out)
> > +{
> > +       unsigned int len = ACPI_MIN(ASUS_WMI_MAX_BUF_LEN, inp[0] /
> > 4);
> > +       char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> > +       const char *pos = buffer;
> > +       const u8 *data = inp + 2;
> > +       unsigned int i;
> > +
> > +       utf16s_to_utf8s((wchar_t *)data, len * 2,
> > UTF16_LITTLE_ENDIAN, buffer, len * 2);  
> Errr... Why is it here? You need the same loop afterwards, just with a
> smaller stride.
I have tried to apply Andy's idea. And it looks it does not
provide benefits. Andy, what do you think? Maybe I understand it in
wrong way. 
> > +
> > +       for (i = 0; i < len; i++, pos += 2)
> > +               out[i] = (hex_to_bin(pos[0]) << 4) +
> > hex_to_bin(pos[1]); +}
> > +
> > +static void asus_wmi_ec_encode_registers(u16 *registers, u8 len,
> > char *out) +{
> > +       char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> > +       char *pos = buffer;
> > +       unsigned int i;
> > +       u8 byte;
> > +
> > +       *out++ = len * 8;
> > +       *out++ = 0;
> > +
> > +       for (i = 0; i < len; i++) {
> > +               byte = registers[i] >> 8;
> > +               *pos = hex_asc_hi(byte);
> > +               pos++;
> > +               *pos = hex_asc_lo(byte);
> > +               pos++;
> > +               byte = registers[i];
> > +               *pos = hex_asc_hi(byte);
> > +               pos++;
> > +               *pos = hex_asc_lo(byte);
> > +               pos++;
> > +       }
> > +
> > +       utf8s_to_utf16s(buffer, len * 4, UTF16_LITTLE_ENDIAN,
> > (wchar_t *)out, len * 4);  
> Same here. Just for the sake of calling utf8s_to_utf16s() you need the
> same loop plus an additional buffer. I don't get it.
> 
I have tried to apply Andy's idea. And it looks it does not
provide benefits. Andy, what do you think? Maybe I understand it in
wrong way.
> > +}
> > +
> > +static void asus_wmi_ec_make_block_read_query(struct
> > asus_wmi_ec_info *ec) +{
> > +       u16 registers[ASUS_WMI_BLOCK_READ_REGISTERS_MAX];
> > +       const struct ec_sensor_info *si;
> > +       long i, j, register_idx = 0;  
> long? maybe a simple unsigned or int?
> 
Looks as it was in original patch, I will look.
> > +
> > +static int asus_wmi_ec_update_ec_sensors(struct asus_wmi_ec_info
> > *ec) +{
> > +       const struct ec_sensor_info *si;
> > +       struct ec_sensor *s;
> > +
> > +       u32 value;  
> This variable is now redundant.
> 
Thank you, I will look.
 
> > +               if (si->addr.size == 1)  
> Maybe switch(si->addr.size)?
> 
Thank you, I will check.
> > +                       value = ec->read_buffer[read_reg_ct];
> > +               else if (si->addr.size == 2)
> > +                       value =
> > get_unaligned_le16(&ec->read_buffer[read_reg_ct]);
> > +               else if (si->addr.size == 4)
> > +                       value =
> > get_unaligned_le32(&ec->read_buffer[read_reg_ct]); +
> > +               read_reg_ct += si->addr.size;
> > +               s->cached_value = value;
> > +       }
> > +       return 0;
> > +}  
> 
> 
> > +       mutex_lock(&sensor_data->lock);  
> The mutex locking/unlocking should be moved inside the
> update_ec_sensors(), I guess.
> 
> I re-read your answer to my question as to why don't you add module
> aliases to the driver, and I have to admit I don't really understand
> it. Could you, please, elaborate?
> 
It looked complicated to support two kind of WMI interfaces with UUID.
As we split big support module to two separate - I will look to such
change also.

> Thank you,
> Eugene

Best regards,
     Denis.
