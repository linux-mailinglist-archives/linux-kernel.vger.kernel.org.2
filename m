Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4961D41C8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbhI2Px0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245740AbhI2PxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AAF060FA0;
        Wed, 29 Sep 2021 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632930694;
        bh=1Dcwft/d81SvmPwSaeSbXxkBB01iAeQr8xtz4Jq1N5Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PjG61cqAVPxwm53h4hF3QoYL4gUx7M+I887ql8PonN79fa1wQN0pZQ2hGJFG2DSjd
         gAxP8rahuVoFDV+ya2F0RdNsIDqF/r50M2x4Ho16ogPLaWF5TaSbO9foddNQIReI95
         8EE5Gp8ztIouy9iQR+AGxxLrcnEqg4Hp9GKRQc+PZmvuk/g8wIVydHyLNGL2tjNGWV
         nOS1Wkx/+UbHys0AgFYM56pgIWCzzjyfJLWoS+ixMCjXg8DLPOS1hCFRh5W4WjhieE
         gtMYJYUYG6bVfQqx4ji8cz58vbJ7NXvAEj6rLSa5u1wi9Gqrc8JzdxPzgTbqqiI55e
         bXZs3hICIZBNg==
Received: by mail-ed1-f51.google.com with SMTP id v18so10233619edc.11;
        Wed, 29 Sep 2021 08:51:33 -0700 (PDT)
X-Gm-Message-State: AOAM533XmUpTjivXci8lmiyY9RX0DtuUuu7ER0BWBs29ysh3RJbz0zAB
        /0xGLpiQeXESK+IqVP1bI9o/U4P1AKhA/o/ZCQ==
X-Google-Smtp-Source: ABdhPJyDVq+IG+koLOXiLxdfQZw+feqfIR0H7K/pSvABlVfDD0w96pf4+hV0nY2UlnWGhNDULYpUcjh3D8xUIWyaxP4=
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr511335ejz.128.1632930610672;
 Wed, 29 Sep 2021 08:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115409.21254-1-zev@bewilderbeest.net> <20210929115409.21254-2-zev@bewilderbeest.net>
In-Reply-To: <20210929115409.21254-2-zev@bewilderbeest.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 29 Sep 2021 10:49:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+rKGv39zHTxNx0A7=X4K48nXRLqWonecG5SobdJq3yKw@mail.gmail.com>
Message-ID: <CAL_Jsq+rKGv39zHTxNx0A7=X4K48nXRLqWonecG5SobdJq3yKw@mail.gmail.com>
Subject: Re: [PATCH 1/6] of: base: Add function to check for status = "reserved"
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 6:54 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> Per v0.3 of the Devicetree Specification [0]:
>
>   Indicates that the device is operational, but should not be used.
>   Typically this is used for devices that are controlled by another
>   software component, such as platform firmware.
>
> One use-case for this is in OpenBMC, where certain devices (such as a
> BIOS flash chip) may be shared by the host and the BMC, but cannot be
> accessed by the BMC during its usual boot-time device probing, because
> they require additional (potentially elaborate) coordination with the
> host to arbitrate which processor is controlling the device.
>
> Devices marked with this status should thus be instantiated, but not
> have a driver bound to them or be otherwise touched.
>
> [0] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.3/devicetree-specification-v0.3.pdf
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/of/base.c  | 53 +++++++++++++++++++++++++++++++++++++++-------
>  include/linux/of.h |  6 ++++++
>  2 files changed, 51 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index f720c0d246f2..c5cc178fc6bd 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -579,14 +579,18 @@ int of_machine_is_compatible(const char *compat)
>  EXPORT_SYMBOL(of_machine_is_compatible);
>
>  /**
> - *  __of_device_is_available - check if a device is available for use
> + * __of_device_check_status - check if a device's status matches a particular string
>   *
> - *  @device: Node to check for availability, with locks already held
> + * @device: Node to check status of, with locks already held
> + * @val: Status string to check for
> + * @alt: Optional alternate status string to check for (NULL to check only @val)
> + * @dflt: default to return if status property absent
>   *
> - *  Return: True if the status property is absent or set to "okay" or "ok",
> - *  false otherwise
> + * Return: True if status property exists and matches either @val or @alt.
> + * @dflt if status property is absent.  False otherwise.
>   */
> -static bool __of_device_is_available(const struct device_node *device)
> +static bool __of_device_check_status(const struct device_node *device, const char *val,
> +                                     const char *alt, bool dflt)

How about val==NULL means available/okay and then you can get rid of
alt and dflt.

Otherwise, I'd simply not try to share the implementation here and
just add of_device_is_reserved().

Rob
