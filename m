Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B546427B76
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbhJIPqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 11:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbhJIPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:46:50 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33DFC061570;
        Sat,  9 Oct 2021 08:44:53 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y67so2382793iof.10;
        Sat, 09 Oct 2021 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QuDgms1GRKoS8qJbf1NyZsvrr/mxgO0KIw/Z5/AjRxk=;
        b=VM5tESpMB5HPKaMjPC9nUCax3NnDHXTOQ8JAyagtlcNwvb+d0X0F2rdKS6lnGVD4rT
         FG5GZCvwf3xxI5ZVd8qIWZDknB/dZqQy5jRt35Y5kJGLBWDfiqHaf++Q2ebYAezuVFYu
         FsOxFYJcXSEsQTNsfP4ZRrw2euFyh5TnROyOufkFZqJhCjD3mPZTgI4SkMpvUg+V4ltT
         3TOB91LVeA/fsTlbWhTO6Cav2bQ72prEg2rl5ozM+rwuGfEmVD1h6Hzlu2mZ1Fffe95M
         g9Kqdbx+Eoq1uDlcYZLddB+JPEE3lb040PgXSduXGpo/d+4Spyrx0lUiaW+slXu4Ym4h
         cqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuDgms1GRKoS8qJbf1NyZsvrr/mxgO0KIw/Z5/AjRxk=;
        b=KUvjAREunk3u4BtTLMUU8TxM4Vdw9vES9LOruayR5ZZ7S7GXP+ZoKrXNCnXtC6yApz
         y5rpwafLHqPuPE3Y+i4QgU+AxnUMtuy3Cd2l/WXb1IwFtrhu6/VH8Kv3lkvODinx1uxk
         jEyVFVocyYDdoAaNvBVi2yCeSsxa3gPcRBe6bBAO7yf37fAzo2VJZ/qHZa/0i1vWGFai
         642rS1ZlyFxJ9K/hH6JgTlfBeefxqpFeTxiBo6hIShau4jB7OBjGbFfzRbXsuabR35OP
         oM9SI6Z/G9Cr9feJHJfAqrgUYjzG5pCAfRfOgrytVuVpo0rhp3BYifYBqk2Cn/CTmN1W
         xAPQ==
X-Gm-Message-State: AOAM5331ko+aa2UJi+s7aseywND8q5b+gBwcb6d1cn3+qh/1IxVcwZK1
        kDwwYwx1+GMzfgJnhcyKA/5VzeTKjdmqgUBnmuGkXXpzMdIPUvOn
X-Google-Smtp-Source: ABdhPJx/imRA7tTFVW045lMNceTF+k6Gjon7/WgSohzjclfxIsiM9xos4nrkHBWK5vKmJy/5cn2whlAUSiTpQ7O8w8o=
X-Received: by 2002:a02:6666:: with SMTP id l38mr11850684jaf.146.1633794292835;
 Sat, 09 Oct 2021 08:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222502.645003-1-pauk.denis@gmail.com> <20211006222502.645003-3-pauk.denis@gmail.com>
 <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com>
 <20211007184644.1d042550@penguin.lxd> <CAB95QASYPRZSFnpE5u=SYJ49Hd+=BAZY==Ky8dzjL8h7YZj-CQ@mail.gmail.com>
 <CAB95QAQ+u4DmF0e9Zvy5hDV0mFQDEULtr-newtz5_6y=Bzp+ww@mail.gmail.com>
In-Reply-To: <CAB95QAQ+u4DmF0e9Zvy5hDV0mFQDEULtr-newtz5_6y=Bzp+ww@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sat, 9 Oct 2021 17:44:41 +0200
Message-ID: <CAB95QATE32O-iTgSMto=and1=OzSrdpmhA9rUZSUoLM4FCvkuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Denis and all,

Let me propose for your consideration a better approach, as I believe,
to the problem with ASUS hardware sensors for the boards with SIO and
EC resources marked as used by the ACPI code. It evolved from the
discussion and patches in the kernel bug 204807, work by Denis, and my
attempts to implement sensor reading from the ACPI EC registers.

Thanks to the users who submitted ACPI dumps for many ASUS boards in
bug 204807 and discussion in the Libre Hardware Monitor project we
learned the names for methods to read SIO and EC registers. Now we
have drivers that implement reading via the ACPI (WMI, to be precise)
methods sensor values. However, this slows down reading by a great
margin (for example, reading from EC takes almost a full second). But
do we need to use ACPI functions to read data?

If one checks out AML code for all the boards, it can be noted that
all the WMI hardware access functions are guarded by a mutex, which
has the same name for all the ASUS boards ("\AMW0.ASMX"). Thus, we do
not need to use WMI functions, but can simply lock the same mutex and
access hardware registers directly.

For the EC case this reduced reading delay from 0.99 seconds down to
0.01 -- 0.3 seconds. So, I propose to change the nct6775 code and
instead of using the SIO read function from board WMI, just grab that
mutex and read directly. For the EC sensors I've done that in a GH
repo [1].

Best regards,
Eugene

[1] https://github.com/zeule/asus-ec-sensors

On Thu, 7 Oct 2021 at 20:11, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>
> Denis and All,
>
> regarding the asus-wmi-ec-sensors driver: it uses a WMI method to read
> EC registers, and this method is slow (requires almost a full second
> for a single call). Maybe I'm doing something wrong, but my impression
> is that the WMI calls themselves are that slow. I will try to
> reimplement this driver using direct EC operations and the global ACPI
> lock with a hope to make it read sensors quicker. If that works out,
> perhaps the nct6775 may go the same way, as it suffers too from the
> slow WMI calls. I know next to nothing about the ACPI system and learn
> from the beginning, so I'm not sure about the result. I know the naive
> reading from the ACPI EC registers leads to problems (fans get stuck,
> etc.), and if someone with knowledge can assure me that the idea with
> the ACPI global lock (as far as I understand it is even implemented in
> the ec kernel driver already) is correct, I would even request to stop
> accepting the EC WMI sensors driver, as it is so slow (albeit dead
> simple and small).
>
> Best regards,
> Eugen
>
> On Thu, 7 Oct 2021 at 19:55, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
> >
> > Hi Denis,
> >
> > yes, the GH repo contains the fix and a few code cleanups, which I
> > would like to propose for mainlining too. Also, please find below a
> > draft of the documentation:
> >
> > Kernel driver asus-wmi-ec-sensors
> > =================================
> >
> > Authors:
> >         <eugene.shalygin@gmail.com>
> >
> > Description:
> > ------------
> > ASUS mainboards publish hardware monitoring information via Super I/O
> > chip and the ACPI embedded controller (EC) registers. Some of the sensors
> > are only available via the EC.
> >
> > ASUS WMI interface provides a method (BREC) to read data from EC registers,
> > which is utilized by this driver to publish those sensor readings to the
> > HWMON system. The driver is aware of and reads the following sensors:
> >
> > 1. Chipset (PCH) temperature
> > 2. CPU package temperature
> > 3. Motherboard temperature
> > 4. Readings from the T_Sensor header
> > 5. VRM temperature
> > 6. CPU_Opt fan RPM
> > 7. Chipset fan RPM
> > 8. Readings from the "Water flow meter" header (RPM)
> > 9. Readings from the "Water In" and "Water Out" temperature headers
> > 10. CPU current
> >
> > Best regards,
> > Eugene
> >
> > On Thu, 7 Oct 2021 at 17:46, Denis Pauk <pauk.denis@gmail.com> wrote:
> > >
> > > Hi Eugene,
> > >
> > > On Thu, 7 Oct 2021 01:32:14 +0200
> > > Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
> > >
> > > > On Thu, 7 Oct 2021 at 00:25, Denis Pauk <pauk.denis@gmail.com> wrote:
> > > > >
> > > >
> > > > > Supported motherboards:
> > > > > * ROG CROSSHAIR VIII HERO
> > > > > * ROG CROSSHAIR VIII DARK HERO
> > > > > * ROG CROSSHAIR VIII FORMULA
> > > > > * ROG STRIX X570-E GAMING
> > > > > * ROG STRIX B550-E GAMING
> > > >
> > > > Pro WS X570-ACE is missing from this list.
> > > Thanks, I will check.
> > > >
> > > > > + * EC provided:
> > > > provides
> > > Thanks, I will check.
> > > >
> > > > > + * Chipset temperature,
> > > > > + * CPU temperature,
> > > > > + * Motherboard temperature,
> > > > > + * T_Sensor temperature,
> > > > > + * VRM  temperature,
> > > > > + * Water In temperature,
> > > > > + * Water Out temperature,
> > > > > + * CPU Optional Fan,
> > > > Hereinafter "CPU Optional Fan RPM"?
> > > >
> > > Thanks, I will check.
> > > > > +static const enum known_ec_sensor
> > > > > known_board_sensors[BOARD_MAX][SENSOR_MAX + 1] = {
> > > > > +       [BOARD_PW_X570_A] = {
> > > > > +               SENSOR_TEMP_CHIPSET, SENSOR_TEMP_CPU,
> > > > > SENSOR_TEMP_MB, SENSOR_TEMP_VRM,
> > > > > +               SENSOR_FAN_CHIPSET,
> > > >
> > > > I missed SENSOR_CURR_CPU for a few boards, and unfortunately the
> > > > mistake made it here too. Sorry for that.
> > > >
> > > Do you have such fix in your repository?
> > > > > +/**
> > > > > + * struct asus_wmi_ec_info - sensor info.
> > > > > + * @sensors: list of sensors.
> > > > > + * @read_arg: UTF-16 string to pass to BRxx() WMI function.
> > > > > + * @read_buffer: WMI function output.
> > > >
> > > > This seems to be a bit misleading to me in a sense that the variable
> > > > holds decoded output (array of numbers as opposed to array of
> > > > characters in the WMI output buffer.
> > > >
> > > > > +struct asus_wmi_data {
> > > > > +       int ec_board;
> > > > > +};
> > > >
> > > > A leftover?
> > > >
> > > Its platform data and used to share board_id with probe.
> > >
> > > > > +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out)
> > > > > +{
> > > > > +       unsigned int len = ACPI_MIN(ASUS_WMI_MAX_BUF_LEN, inp[0] /
> > > > > 4);
> > > > > +       char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> > > > > +       const char *pos = buffer;
> > > > > +       const u8 *data = inp + 2;
> > > > > +       unsigned int i;
> > > > > +
> > > > > +       utf16s_to_utf8s((wchar_t *)data, len * 2,
> > > > > UTF16_LITTLE_ENDIAN, buffer, len * 2);
> > > > Errr... Why is it here? You need the same loop afterwards, just with a
> > > > smaller stride.
> > > I have tried to apply Andy's idea. And it looks it does not
> > > provide benefits. Andy, what do you think? Maybe I understand it in
> > > wrong way.
> > > > > +
> > > > > +       for (i = 0; i < len; i++, pos += 2)
> > > > > +               out[i] = (hex_to_bin(pos[0]) << 4) +
> > > > > hex_to_bin(pos[1]); +}
> > > > > +
> > > > > +static void asus_wmi_ec_encode_registers(u16 *registers, u8 len,
> > > > > char *out) +{
> > > > > +       char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> > > > > +       char *pos = buffer;
> > > > > +       unsigned int i;
> > > > > +       u8 byte;
> > > > > +
> > > > > +       *out++ = len * 8;
> > > > > +       *out++ = 0;
> > > > > +
> > > > > +       for (i = 0; i < len; i++) {
> > > > > +               byte = registers[i] >> 8;
> > > > > +               *pos = hex_asc_hi(byte);
> > > > > +               pos++;
> > > > > +               *pos = hex_asc_lo(byte);
> > > > > +               pos++;
> > > > > +               byte = registers[i];
> > > > > +               *pos = hex_asc_hi(byte);
> > > > > +               pos++;
> > > > > +               *pos = hex_asc_lo(byte);
> > > > > +               pos++;
> > > > > +       }
> > > > > +
> > > > > +       utf8s_to_utf16s(buffer, len * 4, UTF16_LITTLE_ENDIAN,
> > > > > (wchar_t *)out, len * 4);
> > > > Same here. Just for the sake of calling utf8s_to_utf16s() you need the
> > > > same loop plus an additional buffer. I don't get it.
> > > >
> > > I have tried to apply Andy's idea. And it looks it does not
> > > provide benefits. Andy, what do you think? Maybe I understand it in
> > > wrong way.
> > > > > +}
> > > > > +
> > > > > +static void asus_wmi_ec_make_block_read_query(struct
> > > > > asus_wmi_ec_info *ec) +{
> > > > > +       u16 registers[ASUS_WMI_BLOCK_READ_REGISTERS_MAX];
> > > > > +       const struct ec_sensor_info *si;
> > > > > +       long i, j, register_idx = 0;
> > > > long? maybe a simple unsigned or int?
> > > >
> > > Looks as it was in original patch, I will look.
> > > > > +
> > > > > +static int asus_wmi_ec_update_ec_sensors(struct asus_wmi_ec_info
> > > > > *ec) +{
> > > > > +       const struct ec_sensor_info *si;
> > > > > +       struct ec_sensor *s;
> > > > > +
> > > > > +       u32 value;
> > > > This variable is now redundant.
> > > >
> > > Thank you, I will look.
> > >
> > > > > +               if (si->addr.size == 1)
> > > > Maybe switch(si->addr.size)?
> > > >
> > > Thank you, I will check.
> > > > > +                       value = ec->read_buffer[read_reg_ct];
> > > > > +               else if (si->addr.size == 2)
> > > > > +                       value =
> > > > > get_unaligned_le16(&ec->read_buffer[read_reg_ct]);
> > > > > +               else if (si->addr.size == 4)
> > > > > +                       value =
> > > > > get_unaligned_le32(&ec->read_buffer[read_reg_ct]); +
> > > > > +               read_reg_ct += si->addr.size;
> > > > > +               s->cached_value = value;
> > > > > +       }
> > > > > +       return 0;
> > > > > +}
> > > >
> > > >
> > > > > +       mutex_lock(&sensor_data->lock);
> > > > The mutex locking/unlocking should be moved inside the
> > > > update_ec_sensors(), I guess.
> > > >
> > > > I re-read your answer to my question as to why don't you add module
> > > > aliases to the driver, and I have to admit I don't really understand
> > > > it. Could you, please, elaborate?
> > > >
> > > It looked complicated to support two kind of WMI interfaces with UUID.
> > > As we split big support module to two separate - I will look to such
> > > change also.
> > >
> > > > Thank you,
> > > > Eugene
> > >
> > > Best regards,
> > >      Denis.
