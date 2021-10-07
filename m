Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0961A425A13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbhJGR5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhJGR5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:57:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C45EC061570;
        Thu,  7 Oct 2021 10:55:38 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e144so7743241iof.3;
        Thu, 07 Oct 2021 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrGNn5RIbM+5z3syiy7rZwhzNEGPmxkkRjI9ZEr2V0M=;
        b=FtI5DCu95hfjcxJOMlJ71CSjsqpZe5KCa7EHl9h0/uKN2ZfPPj7dE+miiJGeUTP3zw
         gdvfwIJGT/XPleV4ICuHQrNL2IT6AAPVbJV+2FhbDAkchb7T7xVy+j+EycdNoWJvT/VY
         +xomsYajaWCqoq8hoa/YvuSusJuEQhi9bmP5f5hUFP/8m0Gppdvdl83YWu8bm2QDILBj
         LpdU1nQHTKt+N6Tqxbc+ZJHJkIFGvwl+idYxrp8egCrhRD/9cmbyJYCJH8JvinNoyE9z
         7KrCwQpKNI6nQs5qANWUPYnfZ6sfFTTzbETLsXTbl3V3lCbJpWIdW9vg/L5+HDVP9IEX
         fefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrGNn5RIbM+5z3syiy7rZwhzNEGPmxkkRjI9ZEr2V0M=;
        b=Uc5ZYJLOnexBmVkZZolO0OEi9LbexXNcfukWmXx425xzOTI++1nTIIBl95ZeutyT82
         EtF8YXNYpH/Cg+CE0w10a2AwNXqL2/5P4CPJpdI/T+K6kXKAtyPXJOlH12GLonWrtPMW
         D5n2Dt6pnP9s4tSg1md9C3Nwq9Oih4y3tLOi99U+8JtQ1ZUw9KpKlqlII84jTaH+xxvC
         4+zC9MYsn6KgT8VlE3gMJYxw0U3SekvGjFLcmtWsW2JY1XJjFY6w9Ik+4ej1wi1dZx+I
         zVsJmGgxIIQBIi5d8j/gD/+dgma9kAuRGm+wK40JDIeXxmewZ0B3u7VO/n8H3RcGh9vH
         uQCA==
X-Gm-Message-State: AOAM5319CYX+WOnEO6e8EZQKsjI7eXvxvnlnCR4PqRAPfkAIKTLaQ0JT
        0uw8hnNIU1etrrR55xq2uMupCO+GdmYKXYsMizC8R82GE2vk7A==
X-Google-Smtp-Source: ABdhPJzMzCc5rvtfRPkBuwXeB7W9EZH2D32DrgfS6d0OEmzpB90i3N/Bs5mUqHZpkDiSSmvJPZVYWKKG5F8y9G1c304=
X-Received: by 2002:a5e:c202:: with SMTP id v2mr4240029iop.77.1633629337850;
 Thu, 07 Oct 2021 10:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222502.645003-1-pauk.denis@gmail.com> <20211006222502.645003-3-pauk.denis@gmail.com>
 <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com> <20211007184644.1d042550@penguin.lxd>
In-Reply-To: <20211007184644.1d042550@penguin.lxd>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 7 Oct 2021 19:55:26 +0200
Message-ID: <CAB95QASYPRZSFnpE5u=SYJ49Hd+=BAZY==Ky8dzjL8h7YZj-CQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

yes, the GH repo contains the fix and a few code cleanups, which I
would like to propose for mainlining too. Also, please find below a
draft of the documentation:

Kernel driver asus-wmi-ec-sensors
=================================

Authors:
        <eugene.shalygin@gmail.com>

Description:
------------
ASUS mainboards publish hardware monitoring information via Super I/O
chip and the ACPI embedded controller (EC) registers. Some of the sensors
are only available via the EC.

ASUS WMI interface provides a method (BREC) to read data from EC registers,
which is utilized by this driver to publish those sensor readings to the
HWMON system. The driver is aware of and reads the following sensors:

1. Chipset (PCH) temperature
2. CPU package temperature
3. Motherboard temperature
4. Readings from the T_Sensor header
5. VRM temperature
6. CPU_Opt fan RPM
7. Chipset fan RPM
8. Readings from the "Water flow meter" header (RPM)
9. Readings from the "Water In" and "Water Out" temperature headers
10. CPU current

Best regards,
Eugene

On Thu, 7 Oct 2021 at 17:46, Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Hi Eugene,
>
> On Thu, 7 Oct 2021 01:32:14 +0200
> Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>
> > On Thu, 7 Oct 2021 at 00:25, Denis Pauk <pauk.denis@gmail.com> wrote:
> > >
> >
> > > Supported motherboards:
> > > * ROG CROSSHAIR VIII HERO
> > > * ROG CROSSHAIR VIII DARK HERO
> > > * ROG CROSSHAIR VIII FORMULA
> > > * ROG STRIX X570-E GAMING
> > > * ROG STRIX B550-E GAMING
> >
> > Pro WS X570-ACE is missing from this list.
> Thanks, I will check.
> >
> > > + * EC provided:
> > provides
> Thanks, I will check.
> >
> > > + * Chipset temperature,
> > > + * CPU temperature,
> > > + * Motherboard temperature,
> > > + * T_Sensor temperature,
> > > + * VRM  temperature,
> > > + * Water In temperature,
> > > + * Water Out temperature,
> > > + * CPU Optional Fan,
> > Hereinafter "CPU Optional Fan RPM"?
> >
> Thanks, I will check.
> > > +static const enum known_ec_sensor
> > > known_board_sensors[BOARD_MAX][SENSOR_MAX + 1] = {
> > > +       [BOARD_PW_X570_A] = {
> > > +               SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU,
> > > SENSOR_TEMP_MB, SENSOR_TEMP_VRM,
> > > +               SENSOR_FAN_CHIPSET,
> >
> > I missed SENSOR_CURR_CPU for a few boards, and unfortunately the
> > mistake made it here too. Sorry for that.
> >
> Do you have such fix in your repository?
> > > +/**
> > > + * struct asus_wmi_ec_info - sensor info.
> > > + * @sensors: list of sensors.
> > > + * @read_arg: UTF-16 string to pass to BRxx() WMI function.
> > > + * @read_buffer: WMI function output.
> >
> > This seems to be a bit misleading to me in a sense that the variable
> > holds decoded output (array of numbers as opposed to array of
> > characters in the WMI output buffer.
> >
> > > +struct asus_wmi_data {
> > > +       int ec_board;
> > > +};
> >
> > A leftover?
> >
> Its platform data and used to share board_id with probe.
>
> > > +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out)
> > > +{
> > > +       unsigned int len = ACPI_MIN(ASUS_WMI_MAX_BUF_LEN, inp[0] /
> > > 4);
> > > +       char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> > > +       const char *pos = buffer;
> > > +       const u8 *data = inp + 2;
> > > +       unsigned int i;
> > > +
> > > +       utf16s_to_utf8s((wchar_t *)data, len * 2,
> > > UTF16_LITTLE_ENDIAN, buffer, len * 2);
> > Errr... Why is it here? You need the same loop afterwards, just with a
> > smaller stride.
> I have tried to apply Andy's idea. And it looks it does not
> provide benefits. Andy, what do you think? Maybe I understand it in
> wrong way.
> > > +
> > > +       for (i = 0; i < len; i++, pos += 2)
> > > +               out[i] = (hex_to_bin(pos[0]) << 4) +
> > > hex_to_bin(pos[1]); +}
> > > +
> > > +static void asus_wmi_ec_encode_registers(u16 *registers, u8 len,
> > > char *out) +{
> > > +       char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> > > +       char *pos = buffer;
> > > +       unsigned int i;
> > > +       u8 byte;
> > > +
> > > +       *out++ = len * 8;
> > > +       *out++ = 0;
> > > +
> > > +       for (i = 0; i < len; i++) {
> > > +               byte = registers[i] >> 8;
> > > +               *pos = hex_asc_hi(byte);
> > > +               pos++;
> > > +               *pos = hex_asc_lo(byte);
> > > +               pos++;
> > > +               byte = registers[i];
> > > +               *pos = hex_asc_hi(byte);
> > > +               pos++;
> > > +               *pos = hex_asc_lo(byte);
> > > +               pos++;
> > > +       }
> > > +
> > > +       utf8s_to_utf16s(buffer, len * 4, UTF16_LITTLE_ENDIAN,
> > > (wchar_t *)out, len * 4);
> > Same here. Just for the sake of calling utf8s_to_utf16s() you need the
> > same loop plus an additional buffer. I don't get it.
> >
> I have tried to apply Andy's idea. And it looks it does not
> provide benefits. Andy, what do you think? Maybe I understand it in
> wrong way.
> > > +}
> > > +
> > > +static void asus_wmi_ec_make_block_read_query(struct
> > > asus_wmi_ec_info *ec) +{
> > > +       u16 registers[ASUS_WMI_BLOCK_READ_REGISTERS_MAX];
> > > +       const struct ec_sensor_info *si;
> > > +       long i, j, register_idx = 0;
> > long? maybe a simple unsigned or int?
> >
> Looks as it was in original patch, I will look.
> > > +
> > > +static int asus_wmi_ec_update_ec_sensors(struct asus_wmi_ec_info
> > > *ec) +{
> > > +       const struct ec_sensor_info *si;
> > > +       struct ec_sensor *s;
> > > +
> > > +       u32 value;
> > This variable is now redundant.
> >
> Thank you, I will look.
>
> > > +               if (si->addr.size == 1)
> > Maybe switch(si->addr.size)?
> >
> Thank you, I will check.
> > > +                       value = ec->read_buffer[read_reg_ct];
> > > +               else if (si->addr.size == 2)
> > > +                       value =
> > > get_unaligned_le16(&ec->read_buffer[read_reg_ct]);
> > > +               else if (si->addr.size == 4)
> > > +                       value =
> > > get_unaligned_le32(&ec->read_buffer[read_reg_ct]); +
> > > +               read_reg_ct += si->addr.size;
> > > +               s->cached_value = value;
> > > +       }
> > > +       return 0;
> > > +}
> >
> >
> > > +       mutex_lock(&sensor_data->lock);
> > The mutex locking/unlocking should be moved inside the
> > update_ec_sensors(), I guess.
> >
> > I re-read your answer to my question as to why don't you add module
> > aliases to the driver, and I have to admit I don't really understand
> > it. Could you, please, elaborate?
> >
> It looked complicated to support two kind of WMI interfaces with UUID.
> As we split big support module to two separate - I will look to such
> change also.
>
> > Thank you,
> > Eugene
>
> Best regards,
>      Denis.
