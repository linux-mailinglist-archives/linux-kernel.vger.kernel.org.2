Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F9C353874
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhDDOXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:23:06 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:31375 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhDDOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:23:05 -0400
Date:   Sun, 04 Apr 2021 14:22:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1617546179;
        bh=S4CNyn6naol8zMGcIcvW5djFfQdFVTqyLCImeqW0RfA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=bCRVV1H/OoajAGRQH0GQFsEjZn8t2bjLq5688/j+H7nmRq/DMcES+oc9qjQzj5fUh
         7BlsvR5UIu8DvfU6ulVCWM7heSCBgF455+PvIAi/2wFqpwcC9ymYr75gW5D4PsrxmL
         KxRSJla9QMZrcNc4BcJWl1Dv0/hN69IWXSga16KY=
To:     Lee Jones <lee.jones@linaro.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Timon Baetz <timon.baetz@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH v2] mfd: max8997: Replace 8998 with 8997
Message-ID: <20210404162225.213a9bee@focal-fossa>
In-Reply-To: <20210127073230.1583299-1-timon.baetz@protonmail.com>
References: <20210127073230.1583299-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 07:32:42 +0000, Timon Baetz wrote:
> The max8997 header is using "max8998" in some identifiers.
> Fix it by replacing 8998 with 8997 in enum and macro.
>
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
> v2: Fix commit message.
>
>  include/linux/mfd/max8997.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mfd/max8997.h b/include/linux/mfd/max8997.h
> index e955e2f0a2cc..6c98edcf4b0b 100644
> --- a/include/linux/mfd/max8997.h
> +++ b/include/linux/mfd/max8997.h
> @@ -14,13 +14,13 @@
>   * others and b) it can be enabled simply by using MAX17042 driver.
>   */
>
> -#ifndef __LINUX_MFD_MAX8998_H
> -#define __LINUX_MFD_MAX8998_H
> +#ifndef __LINUX_MFD_MAX8997_H
> +#define __LINUX_MFD_MAX8997_H
>
>  #include <linux/regulator/consumer.h>
>
>  /* MAX8997/8966 regulator IDs */
> -enum max8998_regulators {
> +enum max8997_regulators {
>  =09MAX8997_LDO1 =3D 0,
>  =09MAX8997_LDO2,
>  =09MAX8997_LDO3,
> @@ -207,4 +207,4 @@ struct max8997_platform_data {
>  =09struct max8997_led_platform_data *led_pdata;
>  };
>
> -#endif /* __LINUX_MFD_MAX8998_H */
> +#endif /* __LINUX_MFD_MAX8997_H */

Hi, is there an issues with this patch?

