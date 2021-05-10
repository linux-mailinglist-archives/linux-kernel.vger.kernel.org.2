Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C2C37907B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhEJOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbhEJORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:17:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CB3C08C5D6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:53:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t4so24721494ejo.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3/BpnWJEv4o5FfX0aIZJ40Ru/5e0Tbvo6Tknzzoadv8=;
        b=UkesQq7U/Vv6j8enBp4w98nDH5cgHq2J7P37F7StYDrpooPI34/pzSH+hT06U1W2/C
         SrQRPskipuF0pIQL1UWCrC9wa00Z1+Yz3mVw580J9TEeRv3YPQHJNDnWVxiWayqSliYW
         RvfQn8L7qemW7Hrg0OdX5lvb5WihYgqnewGXnOLz045bXvi4zEi2/Oxj+Wauz/coV+oI
         ruLiqiRfuX3z5K7puwuN3t4pIlz9v0QtXaRPLKqSGgZn8bn9dS0VOVSQB9yNuoNxLH6Y
         +PLT34lTaDhXYKBD18/9HqcwDBz7y26rzkTPDRoLriu+O7/qfQSeCtDJd0B1431ESYj1
         CgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3/BpnWJEv4o5FfX0aIZJ40Ru/5e0Tbvo6Tknzzoadv8=;
        b=VKmJt09Bgp0sxQDXnbb7JMzQ9coEWOz9xrCvc1hs1fAObm9icz6erLUi1jdYl7+jXZ
         ZjVAKuokkYAhXjPWY5SxPALnmU8ci0KCkii0rk5bslhM2Q1vvfYoxiqhh6U1PZxNWF5C
         kE18EcMG/+RJe57xAlJLhG+JJNplQ/snI1iiwExfFRYXYDiffOD/d9wvtikhE4dRW3Fz
         4lyIxj0ZGsGkDAmZzz/yJq1EPb4MEDsSiqhtJWyWd8iPh07m2UU4PYGNj3WcI6H3Ha9o
         uwBDx9/xScLXFqeyuPGq4MPGGaX0n5N0Yffj97F0p8PDvmDTcCHPEGJAxYmjKtd7G0eo
         CImg==
X-Gm-Message-State: AOAM530WVSyOF5t58Re1uPS86jWtsbHcGKZk2Frin37yNOJqCInL+Y5s
        rASuv0sIe5ip9WjppscykPR5IxDvYHnjM0Q+jrFryA==
X-Google-Smtp-Source: ABdhPJxTc1BkzCj3RKu6aUlgFJxgyFP3L14QOJWTKLIzRzZDXDruv3cMRlZzIFPCM95csvx+Esb4EjCSrpUflzt4+aE=
X-Received: by 2002:a17:906:fa86:: with SMTP id lt6mr25351839ejb.547.1620654822363;
 Mon, 10 May 2021 06:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620641727.git.mchehab+huawei@kernel.org> <16298d18c8bada9775e32d5f7f9edf664bce820d.1620641727.git.mchehab+huawei@kernel.org>
In-Reply-To: <16298d18c8bada9775e32d5f7f9edf664bce820d.1620641727.git.mchehab+huawei@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 10 May 2021 06:53:30 -0700
Message-ID: <CABXOdTctRP0qHzgJGKXuE6AnroP-J1yJVYEDNQ4O-NKMC0ajcA@mail.gmail.com>
Subject: Re: [PATCH 41/53] docs: ABI: avoid using UTF-8 chars
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 3:27 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
>
>         - U+2013 ('=E2=80=93'): EN DASH
>         - U+2018 ('=E2=80=98'): LEFT SINGLE QUOTATION MARK
>         - U+2019 ('=E2=80=99'): RIGHT SINGLE QUOTATION MARK
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  .../ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar  | 2 +-
>  Documentation/ABI/testing/sysfs-class-net-cdc_ncm             | 2 +-
>  Documentation/ABI/testing/sysfs-devices-platform-ipmi         | 2 +-
>  Documentation/ABI/testing/sysfs-devices-platform-trackpoint   | 2 +-
>  Documentation/ABI/testing/sysfs-devices-soc                   | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-e=
c-lightbar b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-=
lightbar
> index 57a037791403..a7fb8f1169f2 100644
> --- a/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-light=
bar
> +++ b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-light=
bar
> @@ -29,7 +29,7 @@ KernelVersion:        4.2
>  Description:
>                 This allows you to control each LED segment. If the
>                 lightbar is already running one of the automatic
> -               sequences, you probably won=E2=80=99t see anything change=
 because
> +               sequences, you probably won't see anything change because
>                 your color setting will be almost immediately replaced.
>                 To get useful results, you should stop the lightbar
>                 sequence first.
> diff --git a/Documentation/ABI/testing/sysfs-class-net-cdc_ncm b/Document=
ation/ABI/testing/sysfs-class-net-cdc_ncm
> index 06416d0e163d..41a1eef0d0e7 100644
> --- a/Documentation/ABI/testing/sysfs-class-net-cdc_ncm
> +++ b/Documentation/ABI/testing/sysfs-class-net-cdc_ncm
> @@ -93,7 +93,7 @@ Contact:      Bj=C3=B8rn Mork <bjorn@mork.no>
>  Description:
>                 - Bit 0: 16-bit NTB supported (set to 1)
>                 - Bit 1: 32-bit NTB supported
> -               - Bits 2 =E2=80=93 15: reserved (reset to zero; must be i=
gnored by host)
> +               - Bits 2 - 15: reserved (reset to zero; must be ignored b=
y host)
>
>  What:          /sys/class/net/<iface>/cdc_ncm/dwNtbInMaxSize
>  Date:          May 2014
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ipmi b/Docu=
mentation/ABI/testing/sysfs-devices-platform-ipmi
> index 07df0ddc0b69..3935cdedea0e 100644
> --- a/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> @@ -52,7 +52,7 @@ Date:         Mar, 2006
>  KernelVersion: v2.6.17
>  Contact:       openipmi-developer@lists.sourceforge.net
>  Description:
> -               (RO) Lists the IPMI =E2=80=98logical device=E2=80=99 comm=
ands and functions
> +               (RO) Lists the IPMI 'logical device' commands and functio=
ns
>                 that the controller supports that are in addition to the
>                 mandatory IPM and Application commands.
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-trackpoint =
b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
> index df11901a6b3d..82a38ac0435c 100644
> --- a/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
> @@ -105,7 +105,7 @@ KernelVersion:      3.19
>  Contact:       linux-input@vger.kernel.org
>  Description:
>                 (RW) This parameter controls the period of time to test f=
or a
> -               =E2=80=98hands off=E2=80=99 condition (i.e. when no force=
 is applied) before a
> +               'hands off' condition (i.e. when no force is applied) bef=
ore a
>                 drift (noise) calibration occurs.
>
>                 IBM Trackpoints have a feature to compensate for drift by
> diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/=
ABI/testing/sysfs-devices-soc
> index ea999e292f11..7f90c6a44610 100644
> --- a/Documentation/ABI/testing/sysfs-devices-soc
> +++ b/Documentation/ABI/testing/sysfs-devices-soc
> @@ -27,11 +27,11 @@ Description:
>                 (e.g. DB8500).
>
>                 On many of ARM based silicon with SMCCC v1.2+ compliant f=
irmware
> -               this will contain the JEDEC JEP106 manufacturer=E2=80=99s=
 identification
> +               this will contain the JEDEC JEP106 manufacturer's identif=
ication
>                 code. The format is "jep106:XXYY" where XX is identity co=
de and
>                 YY is continuation code.
>
> -               This manufacturer=E2=80=99s identification code is define=
d by one
> +               This manufacturer's identification code is defined by one
>                 or more eight (8) bit fields, each consisting of seven (7=
)
>                 data bits plus one (1) odd parity bit. It is a single fie=
ld,
>                 limiting the possible number of vendors to 126. To expand
> --
> 2.30.2
>
