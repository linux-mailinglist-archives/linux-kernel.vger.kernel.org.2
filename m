Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993EF427CE4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhJISzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhJISzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:55:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1606EC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 11:53:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y26so54190506lfa.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=aFYMKeV5hddsUlwSzkhz2vEZhuGgqpLM+mvhz6QXyZs=;
        b=JtcsvkwudwN7dB3yh+bplfM/CnuY/iQq92p716RnIkfqW22avqchktp5fvXMSWET4a
         gry2jKpVb9/ywqJXKBB4RZJLkhI14Z5+KHmgTevUwVwpg+V+nhdlZPBu2WfRstgzLx68
         l83oi11xASPT/hnkJlpGuhG6Luf1y3hs7pxMZSQpeDO+JJAaqFa6bn9d41vCDVHtEAff
         4E71YR09v+nfLNveI399Wf4SL131hO6XxvOr7BMP+KTuo8X/aI4ltFnPVDZ5wtqodXes
         fxjexBLuVpcFimrV6uCsZhAC6x87qaZnr/es5rjghxApw9VKJ1/7knTojcWjfBeQDHlU
         4xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=aFYMKeV5hddsUlwSzkhz2vEZhuGgqpLM+mvhz6QXyZs=;
        b=yuYyvGf0n4sCILTHsXaJ9L0gI8v9VkJLMfEXwg6L4doLIkUr1uHtWo10+DT31aUz+T
         RJKR2RcAFkF1P945ek8ymeepZ0R7CitBXC1aq3fyTNrcQhUytBHcZZcVIl1qyA2u8Cbj
         EAhLkp7qxiaA+OPf0IQwNiQz/REqxFFzC/2zknxX4PJ6UkSrc9luIFh7kGOhn3Uszh9L
         nYAgxuvBk4AQxsrpl+oZFStMU3dwBUZsRdxMZE7XD+AcYiae5HeTQLz5jhYmELFkaBcj
         e0OWNPBMpl5RDCJUhTrSVk8BSECqYG/pO+9ajNfqpIAG5xGQ/hGppeURkf53cE6rEKAV
         DjKA==
X-Gm-Message-State: AOAM5313z1fU0ljrMiLm2n0B9BsX6QV/A6lXLHNSGlBu0Oj0yBh4UMck
        gDtKJGEEQpT2qPe+7p/O5QsS0agXvX6D2pgA1CurhPNhtbALpw==
X-Google-Smtp-Source: ABdhPJwvdzugSooDsLSPpoaBq1BC/XkwAvd/Rimydex/6p1/HzEx85t7SvffedoRKcRJlyuNhoxIrjuPmf7Z+oPczs4=
X-Received: by 2002:a05:6512:3107:: with SMTP id n7mr529056lfb.179.1633805630057;
 Sat, 09 Oct 2021 11:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211009185257.2230013-1-osk@google.com> <20211009185257.2230013-2-osk@google.com>
In-Reply-To: <20211009185257.2230013-2-osk@google.com>
From:   Oskar Senft <osk@google.com>
Date:   Sat, 9 Oct 2021 14:53:34 -0400
Message-ID: <CABoTLcTS0WqROUn5vz=fh238Q-mc5fu6SVoAnA-BXJLpGZWv_A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] hwmon: (nct7802) Make temperature/voltage sensors configurable
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since "PATCH v4 2/2" as requested in the review:
- Changed device tree node name from "signal" to "channel".
- Removed unrelated changes to replace literal values with #defines.
- Fixed formatting issues by running clang-format.
- Removed unneccessary check for reg >= 1 && reg <= 3.
- nct7802_get_channel_config is now returning an error value.
- nct7802_configure_channels now stops processing the device tree on
the first error.
- Simplified logic for LTD default configuration in nct7802_configure_channels.

On Sat, Oct 9, 2021 at 2:53 PM Oskar Senft <osk@google.com> wrote:
>
> This change allows LTD and RTD inputs to be configured via
> device tree bindings. If the DT bindings are not present or
> invalid, the input configuration is not modified and left at
> HW defaults.
>
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  drivers/hwmon/nct7802.c | 133 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 129 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 604af2f6103a..e28f8eaf9f0f 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -51,6 +51,23 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
>  #define REG_CHIP_ID            0xfe
>  #define REG_VERSION_ID         0xff
>
> +/*
> + * Resistance temperature detector (RTD) modes according to 7.2.32 Mode
> + * Selection Register
> + */
> +#define RTD_MODE_CURRENT       0x1
> +#define RTD_MODE_THERMISTOR    0x2
> +#define RTD_MODE_VOLTAGE       0x3
> +
> +#define MODE_RTD_MASK          0x3
> +#define MODE_LTD_EN            0x40
> +
> +/*
> + * Bit offset for sensors modes in REG_MODE.
> + * Valid for index 0..2, indicating RTD1..3.
> + */
> +#define MODE_BIT_OFFSET_RTD(index) ((index) * 2)
> +
>  /*
>   * Data structures and manipulation thereof
>   */
> @@ -1038,7 +1055,116 @@ static const struct regmap_config nct7802_regmap_config = {
>         .volatile_reg = nct7802_regmap_is_volatile,
>  };
>
> -static int nct7802_init_chip(struct nct7802_data *data)
> +static int nct7802_get_channel_config(struct device *dev,
> +                                     struct device_node *node, u8 *mode_mask,
> +                                     u8 *mode_val)
> +{
> +       u32 reg;
> +       const char *type_str, *md_str;
> +       u8 md;
> +
> +       if (!node->name || of_node_cmp(node->name, "channel"))
> +               return 0;
> +
> +       if (of_property_read_u32(node, "reg", &reg)) {
> +               dev_err(dev, "Could not read reg value for '%s'\n",
> +                       node->full_name);
> +               return -EINVAL;
> +       }
> +
> +       if (reg > 3) {
> +               dev_err(dev, "Invalid reg (%u) in '%s'\n", reg,
> +                       node->full_name);
> +               return -EINVAL;
> +       }
> +
> +       if (reg == 0) {
> +               if (!of_device_is_available(node))
> +                       *mode_val &= ~MODE_LTD_EN;
> +               else
> +                       *mode_val |= MODE_LTD_EN;
> +               *mode_mask |= MODE_LTD_EN;
> +               return 0;
> +       }
> +
> +       /* At this point we have reg >= 1 && reg <= 3 */
> +
> +       if (!of_device_is_available(node)) {
> +               *mode_val &= ~(MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1));
> +               *mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> +               return 0;
> +       }
> +
> +       if (of_property_read_string(node, "sensor-type", &type_str)) {
> +               dev_err(dev, "No type for '%s'\n", node->full_name);
> +               return -EINVAL;
> +       }
> +
> +       if (!strcmp(type_str, "voltage")) {
> +               *mode_val |= (RTD_MODE_VOLTAGE & MODE_RTD_MASK)
> +                            << MODE_BIT_OFFSET_RTD(reg - 1);
> +               *mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> +               return 0;
> +       }
> +
> +       if (strcmp(type_str, "temperature")) {
> +               dev_err(dev, "Invalid type '%s' for '%s'\n", type_str,
> +                       node->full_name);
> +               return -EINVAL;
> +       }
> +
> +       if (reg == 3) {
> +               /* RTD3 only supports thermistor mode */
> +               md = RTD_MODE_THERMISTOR;
> +       } else {
> +               if (of_property_read_string(node, "temperature-mode",
> +                                           &md_str)) {
> +                       dev_err(dev, "No mode for '%s'\n", node->full_name);
> +                       return -EINVAL;
> +               }
> +
> +               if (!strcmp(md_str, "thermal-diode"))
> +                       md = RTD_MODE_CURRENT;
> +               else if (!strcmp(md_str, "thermistor"))
> +                       md = RTD_MODE_THERMISTOR;
> +               else {
> +                       dev_err(dev, "Invalid mode '%s' for '%s'\n", md_str,
> +                               node->full_name);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       *mode_val |= (md & MODE_RTD_MASK) << MODE_BIT_OFFSET_RTD(reg - 1);
> +       *mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
> +
> +       return 0;
> +}
> +
> +static int nct7802_configure_channels(struct device *dev,
> +                                     struct nct7802_data *data)
> +{
> +       bool found_channel_config = false;
> +       u8 mode_mask = 0, mode_val = 0;
> +       struct device_node *node;
> +       int err;
> +
> +       /* Enable local temperature sensor by default */
> +       mode_val |= MODE_LTD_EN;
> +       mode_mask |= MODE_LTD_EN;
> +
> +       if (dev->of_node) {
> +               for_each_child_of_node(dev->of_node, node) {
> +                       err = nct7802_get_channel_config(dev, node, &mode_mask,
> +                                                        &mode_val);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +
> +       return regmap_update_bits(data->regmap, REG_MODE, mode_mask, mode_val);
> +}
> +
> +static int nct7802_init_chip(struct device *dev, struct nct7802_data *data)
>  {
>         int err;
>
> @@ -1047,8 +1173,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
>         if (err)
>                 return err;
>
> -       /* Enable local temperature sensor */
> -       err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
> +       err = nct7802_configure_channels(dev, data);
>         if (err)
>                 return err;
>
> @@ -1074,7 +1199,7 @@ static int nct7802_probe(struct i2c_client *client)
>         mutex_init(&data->access_lock);
>         mutex_init(&data->in_alarm_lock);
>
> -       ret = nct7802_init_chip(data);
> +       ret = nct7802_init_chip(dev, data);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.33.0.882.g93a45727a2-goog
>
