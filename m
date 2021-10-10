Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDB2428082
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhJJKla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhJJKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:41:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB26C061570;
        Sun, 10 Oct 2021 03:39:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i12so32815579wrb.7;
        Sun, 10 Oct 2021 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqWRaNaelQKdAIjrHcLhyR3gcgkB9ol8wzmeUBPbfrw=;
        b=NobHOwKvvt2bP+tLO47StQ7MPdD8npRsE/paRc0gIhMt4cCRJoViWCWm0bYu5DhP4T
         LZMCk10lCvo5yrNuO5lRFhsw2Rqp3mLZctLfzygrDvzRvomTXbWX9n/+INcQ8rilAC5y
         MdxYyRh7kaMdEBmVTuRUo6Kup8hyvn1kzIkTqs03cugQz9Uac7vzdMkjhxmFyiQGoqQn
         NOvF8a3hK2QHSn3+ReiRIPGFFDhOaDEEii2v6OCmbWBBaHq1BNyl4FWe6hyOor52RKH7
         OH57OChjKnnsZd+6RVpzTnUN0EZ68QCOhNh/fA8JJ/rNl3fL9H+FI/acTbrusTEAaRUp
         Szpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqWRaNaelQKdAIjrHcLhyR3gcgkB9ol8wzmeUBPbfrw=;
        b=1sx2VZq/egcadIW5c1wwhunofwX1eS4/mVSdz4/axJ6DfstCpt8wxD3njcjhTSBHC8
         JHHVyMt93AvVeFJX4MBd3Jx4eeD5K6V4B9Y5KoQkKpnIHBDQiJ+uwCc1KMAfbWAJs9GZ
         WAajnro+i306KJ8bAnZXkTVa29VyQZ0rGtmswDUsmuRnwErOfndFjsHIz0p+IXW7p0JG
         tbSLH9tZDFRmhUhTVpp9fc8P1rvYM0K15wsiiJvtr7w7wHfVnvs7QM6H/XU826nTI12c
         7ehcWyUTIFh8eeOThMdlVzS3hJBCCofmTzJUejwe7UcbECRHOF8xmO9Bf/JNMdIpghty
         SNHw==
X-Gm-Message-State: AOAM530Xo48tW69hEihy2FrI8eqTXZ2AEGqk+XeOGQy9hGEjiDyRoVxJ
        e0vFFDAim05095qXp15lVV4UkiY+ZvObJg==
X-Google-Smtp-Source: ABdhPJxg9KNYZf1byIVq8yygtbHxgZgzSvJtgmUzJykuok/40o/Kh2bOaa2ilYp9pEjcQjoQwvlGwQ==
X-Received: by 2002:a05:600c:511c:: with SMTP id o28mr14873915wms.81.1633862368721;
        Sun, 10 Oct 2021 03:39:28 -0700 (PDT)
Received: from penguin.lxd ([94.179.22.101])
        by smtp.gmail.com with ESMTPSA id f184sm4641506wmf.22.2021.10.10.03.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 03:39:28 -0700 (PDT)
Date:   Sun, 10 Oct 2021 13:39:21 +0300
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <20211010133921.4277dc79@penguin.lxd>
In-Reply-To: <CAB95QAQ+u4DmF0e9Zvy5hDV0mFQDEULtr-newtz5_6y=Bzp+ww@mail.gmail.com>
References: <20211006222502.645003-1-pauk.denis@gmail.com>
        <20211006222502.645003-3-pauk.denis@gmail.com>
        <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com>
        <20211007184644.1d042550@penguin.lxd>
        <CAB95QASYPRZSFnpE5u=SYJ49Hd+=BAZY==Ky8dzjL8h7YZj-CQ@mail.gmail.com>
        <CAB95QAQ+u4DmF0e9Zvy5hDV0mFQDEULtr-newtz5_6y=Bzp+ww@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugene,

As for me, use WMI methods will be more reliable and cover more
motherboards.

Best regards,
            Denis.

On Thu, 7 Oct 2021 20:11:33 +0200
Eugene Shalygin <eugene.shalygin@gmail.com> wrote:

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
> On Thu, 7 Oct 2021 at 19:55, Eugene Shalygin
> <eugene.shalygin@gmail.com> wrote:
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
> > ASUS mainboards publish hardware monitoring information via Super
> > I/O chip and the ACPI embedded controller (EC) registers. Some of
> > the sensors are only available via the EC.
> >
> > ASUS WMI interface provides a method (BREC) to read data from EC
> > registers, which is utilized by this driver to publish those sensor
> > readings to the HWMON system. The driver is aware of and reads the
> > following sensors:
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
> > On Thu, 7 Oct 2021 at 17:46, Denis Pauk <pauk.denis@gmail.com>
> > wrote:  
> > >
> > > Hi Eugene,
> > >
> > > On Thu, 7 Oct 2021 01:32:14 +0200
> > > Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
> > >  
> > > > On Thu, 7 Oct 2021 at 00:25, Denis Pauk <pauk.denis@gmail.com>
> > > > wrote:  
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
> > > > This seems to be a bit misleading to me in a sense that the
> > > > variable holds decoded output (array of numbers as opposed to
> > > > array of characters in the WMI output buffer.
> > > >  
> > > > > +struct asus_wmi_data {
> > > > > +       int ec_board;
> > > > > +};  
> > > >
> > > > A leftover?
> > > >  
> > > Its platform data and used to share board_id with probe.
> > >  
> > > > > +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp,
> > > > > u8 *out) +{
> > > > > +       unsigned int len = ACPI_MIN(ASUS_WMI_MAX_BUF_LEN,
> > > > > inp[0] / 4);
> > > > > +       char buffer[ASUS_WMI_MAX_BUF_LEN * 2];
> > > > > +       const char *pos = buffer;
> > > > > +       const u8 *data = inp + 2;
> > > > > +       unsigned int i;
> > > > > +
> > > > > +       utf16s_to_utf8s((wchar_t *)data, len * 2,
> > > > > UTF16_LITTLE_ENDIAN, buffer, len * 2);  
> > > > Errr... Why is it here? You need the same loop afterwards, just
> > > > with a smaller stride.  
> > > I have tried to apply Andy's idea. And it looks it does not
> > > provide benefits. Andy, what do you think? Maybe I understand it
> > > in wrong way.  
> > > > > +
> > > > > +       for (i = 0; i < len; i++, pos += 2)
> > > > > +               out[i] = (hex_to_bin(pos[0]) << 4) +
> > > > > hex_to_bin(pos[1]); +}
> > > > > +
> > > > > +static void asus_wmi_ec_encode_registers(u16 *registers, u8
> > > > > len, char *out) +{
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
> > > > Same here. Just for the sake of calling utf8s_to_utf16s() you
> > > > need the same loop plus an additional buffer. I don't get it.
> > > >  
> > > I have tried to apply Andy's idea. And it looks it does not
> > > provide benefits. Andy, what do you think? Maybe I understand it
> > > in wrong way.  
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
> > > > > +static int asus_wmi_ec_update_ec_sensors(struct
> > > > > asus_wmi_ec_info *ec) +{
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
> > > > I re-read your answer to my question as to why don't you add
> > > > module aliases to the driver, and I have to admit I don't
> > > > really understand it. Could you, please, elaborate?
> > > >  
> > > It looked complicated to support two kind of WMI interfaces with
> > > UUID. As we split big support module to two separate - I will
> > > look to such change also.
> > >  
> > > > Thank you,
> > > > Eugene  
> > >
> > > Best regards,
> > >      Denis.  

