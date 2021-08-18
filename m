Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A713F0BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhHRT0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:26:46 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:36368 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhHRT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:26:44 -0400
Date:   Wed, 18 Aug 2021 19:25:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1629314736;
        bh=aWCsmwMyxCJOb9In9GRwiA+fRn6ttPi9bOrwWBDIw/g=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=dbTawmSQsBNAK/D8C7+bkqzfl9WexM/FCxkQnF4xH9XV5Dx9n2relLrzsskAjR/w7
         fFFapM59in3qswxfaGxG3iII7qfJggDs24FNZo1jE28Tw72My4iSrY7yDNq8mpIEga
         3xhCGxQaH4LVAIT17yZy3lYFrXcCnxOZ5J0FR97I=
To:     "Luke D. Jones" <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        hadess@hadess.net, platform-driver-x86@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v5 1/1] asus-wmi: Add support for platform_profile
Message-ID: <tkJb_14m7EeHjs3G_DaqN0tMCLMA4qNheZDxfrsnGHoxFrsxOebsq46o8pXT-f7i2SgcZiFGk8FEy6BWVeT7xtTShgbyXqYNyeu58bayOS0=@protonmail.com>
In-Reply-To: <20210818190731.19170-2-luke@ljones.dev>
References: <20210818190731.19170-1-luke@ljones.dev> <20210818190731.19170-2-luke@ljones.dev>
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

Hi


2021. augusztus 18., szerda 21:07 keltez=C3=A9ssel, Luke D. Jones =C3=ADrta=
:
> Add initial support for platform_profile where the support is
> based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>
> Because throttle_thermal_policy is used by platform_profile and is
> writeable separately to platform_profile any userspace changes to
> throttle_thermal_policy need to notify platform_profile.
>
> In future throttle_thermal_policy sysfs should be removed so that
> only one method controls the laptop power profile.
>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/Kconfig    |   1 +
>  drivers/platform/x86/asus-wmi.c | 130 +++++++++++++++++++++++++++++++-
>  2 files changed, 127 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index d12db6c316ea..46dec48a36c1 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> [...]
> +static int platform_profile_set(struct platform_profile_handler *pprof,
> +=09=09=09=09enum platform_profile_option profile)
> +{
> +=09struct asus_wmi *asus;
> +=09int tp;
> +
> +=09asus =3D container_of(pprof, struct asus_wmi, platform_profile_handle=
r);
> +
> +=09switch (profile) {
> +=09case PLATFORM_PROFILE_PERFORMANCE:
> +=09=09tp =3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> +=09=09break;
> +=09case PLATFORM_PROFILE_BALANCED:
> +=09=09tp =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> +=09=09break;
> +=09case PLATFORM_PROFILE_QUIET:
> +=09=09tp =3D ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> +=09=09break;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09asus->throttle_thermal_policy_mode =3D tp;
> +=09return throttle_thermal_policy_write(asus);

Here the new mode will be stored even if activating it fails, no?


> +}
> [...]


Best regards,
Barnab=C3=A1s P=C5=91cze
