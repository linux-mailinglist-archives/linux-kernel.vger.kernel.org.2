Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9606A3D06CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 04:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhGUCCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 22:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhGUCCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 22:02:46 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E83C061574;
        Tue, 20 Jul 2021 19:43:22 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c68so806224qkf.9;
        Tue, 20 Jul 2021 19:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBE5exiuCrDCx7ColZNpX2FjRqVvNIpBf5nUfYEkrIA=;
        b=SB3u7/fhvpu+LlaxdIPXmvmT7FgNnfYk43t/NGSfLjeReFhz1w54Q6A/0UG/kI8KIw
         kz3dVLzJr2UmHeX9GVkF7kG7ZJPWcpANs1WsJg9eUGatuNc5BMhypavNHEfeEON6PwGM
         P99HM3t8lL2SGSfTKU/kxfEAoAlk/X8aJ2mB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBE5exiuCrDCx7ColZNpX2FjRqVvNIpBf5nUfYEkrIA=;
        b=fb4QlhnIcRd+oee3xrAjw/4PAbhkXB4PyiMipZAuwLEwaiTZZhDpwUvt7hm5est2kg
         EUPJ79WNspZ7ePla0G0LPIV/57UtK+6PH8v+3/9p5Ctxxy/soEP1JB5pdIA9QZENY+/8
         IncYpBA9WIrE6S2jV3h+PBdBSXxvVEliE7reDtcEekvw7n6b9Yn8I/EhqCPMY8FH/yQO
         WZTKavN5eUZIWBc0PU1DE3JfRBr+bzXAmhsLMEpLAUpMy9laMijE/oYsWU65rSpAQ2Nf
         XkhKCpHXeBERg+6HKA6ipDzwP9oK56lrWajZI+RoCplprtDtSAAaoJuCgOUvX7gQMD13
         QTGg==
X-Gm-Message-State: AOAM5336Jszlu7L/oPlJ69MsaE4YIp1cf250KndOoZq54+iIsqi+RPDB
        4Osrhub7z+CGgEKFhYBDF1fZu2VQpKKholQ9T5w=
X-Google-Smtp-Source: ABdhPJwoJzwZ4xiNcedHkvGHqVMmsjyctAH0RgdeojBVYudaowQhskoAnvek8zoFYjo9JJ+ERWJbzw0IcH3VzeBjQMs=
X-Received: by 2002:a05:620a:56b:: with SMTP id p11mr31361136qkp.66.1626835400754;
 Tue, 20 Jul 2021 19:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210716151850.28973-1-eajames@linux.ibm.com> <20210716151850.28973-3-eajames@linux.ibm.com>
In-Reply-To: <20210716151850.28973-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 21 Jul 2021 02:43:08 +0000
Message-ID: <CACPK8XcgF7i+b8P1AUDRYtWZeMDwG7Mjw74pFpVKVx6ZdJJKzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (occ) Remove sequence numbering and checksum calculation
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 at 15:19, Eddie James <eajames@linux.ibm.com> wrote:
>
> Checksumming of the request and sequence numbering is now done in the
> OCC interface driver in order to keep unique sequence numbers. So
> remove those in the hwmon driver.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/hwmon/occ/common.c | 30 ++++++++++++------------------
>  drivers/hwmon/occ/common.h |  3 +--
>  drivers/hwmon/occ/p8_i2c.c | 15 +++++++++------
>  drivers/hwmon/occ/p9_sbe.c |  4 ++--
>  4 files changed, 24 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 0d68a78be980..fc298268c89e 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -132,22 +132,20 @@ struct extended_sensor {
>  static int occ_poll(struct occ *occ)
>  {
>         int rc;
> -       u16 checksum = occ->poll_cmd_data + occ->seq_no + 1;
> -       u8 cmd[8];
> +       u8 cmd[7];

The shortening of the command seems unrelated?

If you leave it at 8 then you avoid the special casing below. Is there
any downside to sending the extra 0 byte at the end?

>         struct occ_poll_response_header *header;
>
>         /* big endian */
> -       cmd[0] = occ->seq_no++;         /* sequence number */
> +       cmd[0] = 0;                     /* sequence number */
>         cmd[1] = 0;                     /* cmd type */
>         cmd[2] = 0;                     /* data length msb */
>         cmd[3] = 1;                     /* data length lsb */
>         cmd[4] = occ->poll_cmd_data;    /* data */
> -       cmd[5] = checksum >> 8;         /* checksum msb */
> -       cmd[6] = checksum & 0xFF;       /* checksum lsb */
> -       cmd[7] = 0;
> +       cmd[5] = 0;                     /* checksum msb */
> +       cmd[6] = 0;                     /* checksum lsb */

> --- a/drivers/hwmon/occ/p8_i2c.c> +++ b/drivers/hwmon/occ/p8_i2c.c
> @@ -97,18 +97,21 @@ static int p8_i2c_occ_putscom_u32(struct i2c_client *client, u32 address,
>  }
>
>  static int p8_i2c_occ_putscom_be(struct i2c_client *client, u32 address,
> -                                u8 *data)
> +                                u8 *data, size_t len)
>  {
> -       __be32 data0, data1;
> +       __be32 data0 = 0, data1 = 0;
>
> -       memcpy(&data0, data, 4);
> -       memcpy(&data1, data + 4, 4);
> +       memcpy(&data0, data, min(len, 4UL));

The UL here seems unnecessary (and dropping it should fix your 0day
bot warnings).

But I think it would be simpler to go back to a fixed length of 8.

> +       if (len > 4UL) {
> +               len -= 4;
> +               memcpy(&data1, data + 4, min(len, 4UL));
> +       }
>
>         return p8_i2c_occ_putscom_u32(client, address, be32_to_cpu(data0),
>                                       be32_to_cpu(data1));
>  }
