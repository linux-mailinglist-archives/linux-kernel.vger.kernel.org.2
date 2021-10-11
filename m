Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD24284E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 03:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhJKBzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 21:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhJKBzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 21:55:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE6BC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:53:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r19so64797792lfe.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LqUgfOh9xGwlXfE/GX0VkhoLysQdsHPHvyF0ibSAeE=;
        b=mzfRfTPS/T/nqcc2/ze105heN1Tb87MZxBavJkoQpjmsf0hl4kQuOqtgQJoib+yKaR
         kH6AOyXN24oYZB55o34rqrEFeUmAHEkoCtKBo3p7cMI9uJlIfk3gnetnuSLrocqT32k3
         JzNIl9kG9qJfEdEl+1iiyKNcXffE7XSvVT0AQTdTxLiVhwkAdaLyWk44oCTMTMpaOuCM
         Z9KDE+65A/ah0DaLlCbZ/nycDfHjGW8w3ZxRKcR5w/Q/FZgrEKRznEVtxox6QHJmInBl
         wEmCyJ9Wcmk6mFyLSQRmdH21YdwDI7RAhKLMV3hWixHv2KRkeR9ZsJgbmq0Lyqp6jFjG
         7F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LqUgfOh9xGwlXfE/GX0VkhoLysQdsHPHvyF0ibSAeE=;
        b=FT83PSA+EiLD4fJLF35chOhOdPYtn8XEsPjn586wUfahlZ7DT4Qel+6HU0EOJJuWsU
         N8c9Dr9F+CDBgb8yU5xk8BVV8iiEMaJvMlQXLlxSrFyesHmj/gvG/YtYNoml30oySF5N
         TZFqVnB+ukMvx09EBwfrkKr7cZhwlDrgDkB7h0lVxkxiWutEMrqZ3YeRsHbAAdBvLDud
         ljBrA1F0mztJHZI4cBrT9or8XOj3l0PX3UPkAQNhQVyWYgRbZgqTWT6+ZktOsFV9f+42
         JTm5FzB68cUthPLlCJLNjoNm3c9NNJmIDsHqNykcg4ik2SjmMqTnTiRpUKi7DDaVaE8F
         lhEg==
X-Gm-Message-State: AOAM533qPXxkrENg7ohd2tK23XpcunCIRjQ3J5W9mEa7zJUpC8xWEWrQ
        glamya5Y54MY8tDkPDKn+BWsguVFk6SsYla3O4hLZg==
X-Google-Smtp-Source: ABdhPJx1rJLqWp21z/nusqtbUANF+cYi1TiRq/EdNFjB576KlgZeGpIkYiX1kxouX2y3H8oBfL//fKCahWmQJgC0hKs=
X-Received: by 2002:a05:6512:3e03:: with SMTP id i3mr13604508lfv.273.1633917209896;
 Sun, 10 Oct 2021 18:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211011012212.91357-1-osk@google.com> <20211011012212.91357-2-osk@google.com>
 <98dcaa85-d04c-7a9c-1901-8786d361477c@roeck-us.net>
In-Reply-To: <98dcaa85-d04c-7a9c-1901-8786d361477c@roeck-us.net>
From:   Oskar Senft <osk@google.com>
Date:   Sun, 10 Oct 2021 21:53:14 -0400
Message-ID: <CABoTLcTERUpwPSc7fVUAMqs37XCZJhMFbFRT2oyTt_TodE6GnA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] hwmon: (nct7802) Make temperature/voltage sensors configurable
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't sure if submitting JUST a v7 of nuvoton,nct7802.yaml (i.e.
the 1/2 in this series) would be the right thing to do and thought it
would be easier to follow if I dropped both. I couldn't find
documentation on what's the right thing to do in that case. Would it
have been better to only submit nuvoton,nct7802.yaml as "PATCH v7" ?

Oskar.

On Sun, Oct 10, 2021 at 9:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/10/21 6:22 PM, Oskar Senft wrote:
> > This change allows LTD and RTD inputs to be configured via
> > device tree bindings. If the DT bindings are not present or
> > invalid, the input configuration is not modified and left at
> > HW defaults.
> >
> > Signed-off-by: Oskar Senft <osk@google.com>
>
> I sent a Reviewed-by: for v6 of this patch.
>
> > ---
> > Changes from PATCH v6:
> > - None (resubmitted due to changes in nuvoton,nct7802.yaml).
> >
>
> Why did you drop it if there was no change ?
>
> Guenter
>
> > Changes from PATCH v5:
> > - Removed unused "found_channel_config" variable.
> > - Initialize mode_mask and mode_val to defaults.
> > ---
> >   drivers/hwmon/nct7802.c | 129 ++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 125 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> > index 604af2f6103a..d56f78327619 100644
> > --- a/drivers/hwmon/nct7802.c
> > +++ b/drivers/hwmon/nct7802.c
> > @@ -51,6 +51,23 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
> >   #define REG_CHIP_ID         0xfe
> >   #define REG_VERSION_ID              0xff
> >
> > +/*
> > + * Resistance temperature detector (RTD) modes according to 7.2.32 Mode
> > + * Selection Register
> > + */
> > +#define RTD_MODE_CURRENT     0x1
> > +#define RTD_MODE_THERMISTOR  0x2
> > +#define RTD_MODE_VOLTAGE     0x3
> > +
> > +#define MODE_RTD_MASK                0x3
> > +#define MODE_LTD_EN          0x40
> > +
> > +/*
> > + * Bit offset for sensors modes in REG_MODE.
> > + * Valid for index 0..2, indicating RTD1..3.
> > + */
> > +#define MODE_BIT_OFFSET_RTD(index) ((index) * 2)
> > +
> >   /*
> >    * Data structures and manipulation thereof
> >    */
> > @@ -1038,7 +1055,112 @@ static const struct regmap_config nct7802_regmap_config = {
> >       .volatile_reg = nct7802_regmap_is_volatile,
> >   };
> >
> > -static int nct7802_init_chip(struct nct7802_data *data)
> > +static int nct7802_get_channel_config(struct device *dev,
> > +                                   struct device_node *node, u8 *mode_mask,
> > +                                   u8 *mode_val)
> > +{
> > +     u32 reg;
> > +     const char *type_str, *md_str;
> > +     u8 md;
> > +
> > +     if (!node->name || of_node_cmp(node->name, "channel"))
> > +             return 0;
> > +
> > +     if (of_property_read_u32(node, "reg", &reg)) {
> > +             dev_err(dev, "Could not read reg value for '%s'\n",
> > +                     node->full_name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (reg > 3) {
> > +             dev_err(dev, "Invalid reg (%u) in '%s'\n", reg,
> > +                     node->full_name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (reg == 0) {
> > +             if (!of_device_is_available(node))
> > +                     *mode_val &= ~MODE_LTD_EN;
> > +             else
> > +                     *mode_val |= MODE_LTD_EN;
> > +             *mode_mask |= MODE_LTD_EN;
> > +             return 0;
> > +     }
> > +
> > +     /* At this point we have reg >= 1 && reg <= 3 */
> > +
> > +     if (!of_device_is_available(node)) {
> > +             *mode_val &= ~(MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1));
> > +             *mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> > +             return 0;
> > +     }
> > +
> > +     if (of_property_read_string(node, "sensor-type", &type_str)) {
> > +             dev_err(dev, "No type for '%s'\n", node->full_name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!strcmp(type_str, "voltage")) {
> > +             *mode_val |= (RTD_MODE_VOLTAGE & MODE_RTD_MASK)
> > +                          << MODE_BIT_OFFSET_RTD(reg - 1);
> > +             *mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> > +             return 0;
> > +     }
> > +
> > +     if (strcmp(type_str, "temperature")) {
> > +             dev_err(dev, "Invalid type '%s' for '%s'\n", type_str,
> > +                     node->full_name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (reg == 3) {
> > +             /* RTD3 only supports thermistor mode */
> > +             md = RTD_MODE_THERMISTOR;
> > +     } else {
> > +             if (of_property_read_string(node, "temperature-mode",
> > +                                         &md_str)) {
> > +                     dev_err(dev, "No mode for '%s'\n", node->full_name);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (!strcmp(md_str, "thermal-diode"))
> > +                     md = RTD_MODE_CURRENT;
> > +             else if (!strcmp(md_str, "thermistor"))
> > +                     md = RTD_MODE_THERMISTOR;
> > +             else {
> > +                     dev_err(dev, "Invalid mode '%s' for '%s'\n", md_str,
> > +                             node->full_name);
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     *mode_val |= (md & MODE_RTD_MASK) << MODE_BIT_OFFSET_RTD(reg - 1);
> > +     *mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct7802_configure_channels(struct device *dev,
> > +                                   struct nct7802_data *data)
> > +{
> > +     /* Enable local temperature sensor by default */
> > +     u8 mode_mask = MODE_LTD_EN, mode_val = MODE_LTD_EN;
> > +     struct device_node *node;
> > +     int err;
> > +
> > +     if (dev->of_node) {
> > +             for_each_child_of_node(dev->of_node, node) {
> > +                     err = nct7802_get_channel_config(dev, node, &mode_mask,
> > +                                                      &mode_val);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +     }
> > +
> > +     return regmap_update_bits(data->regmap, REG_MODE, mode_mask, mode_val);
> > +}
> > +
> > +static int nct7802_init_chip(struct device *dev, struct nct7802_data *data)
> >   {
> >       int err;
> >
> > @@ -1047,8 +1169,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
> >       if (err)
> >               return err;
> >
> > -     /* Enable local temperature sensor */
> > -     err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
> > +     err = nct7802_configure_channels(dev, data);
> >       if (err)
> >               return err;
> >
> > @@ -1074,7 +1195,7 @@ static int nct7802_probe(struct i2c_client *client)
> >       mutex_init(&data->access_lock);
> >       mutex_init(&data->in_alarm_lock);
> >
> > -     ret = nct7802_init_chip(data);
> > +     ret = nct7802_init_chip(dev, data);
> >       if (ret < 0)
> >               return ret;
> >
> >
>
