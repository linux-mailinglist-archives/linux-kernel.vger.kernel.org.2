Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FA542019C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhJCMzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 08:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhJCMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:55:31 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF10C0613EC;
        Sun,  3 Oct 2021 05:53:44 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l20so3166377ilk.2;
        Sun, 03 Oct 2021 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/fxUqspw9sx8OrgWZSg5lmJQ45dApSpHPF6bytDcYTQ=;
        b=EBU589h3awHNwSYLhD736rN23QUnE0JvaSeGa6uUtvRuvgKPNlWQvvmpyw6ulv2kvj
         MtzaXZdlDmSflgjLkLm57FaMzlP6p2hIaIxo7oPPuCdki6aQbtk2s3jb8ZLTpTX4JfGe
         LQuByXq5y5gal45sId783OoBOSEdG+vdDcvzC2dxk9TS6UePmd/0zwPS6M4mtzF3ZoT9
         gJIbnHgkYaJRvHLB1I91woUlzNcY7VK5zJKKyLhary+5e61Jo92u6RwG96CUVOFiqqST
         xinqRk68wNe3rkKDD5mn4oyUiPBcJmm7FjU2PulDwcPRWG4ere9MOhZyH0JSn/yGz3en
         adVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/fxUqspw9sx8OrgWZSg5lmJQ45dApSpHPF6bytDcYTQ=;
        b=by38IzYplRC3BZ8sdumxg10rip4gn9e77d7Dc1AN5MXPkJS/Ouh6S9bCLnYcOqZQjE
         isZJ+T+rDOlMeVXKog7JNH1IkjUAj4tvaJgbqx7AbYm9iKweOS6nPtUsQxBUcbQgm94W
         FIvKKMzmvhzyJAhkyL+mqaBLQO9rt5Jb7UoJ86YvK/Ne9DiNCcLTd2nI95LDPhtAC8XA
         z+RxjyQDl2Yt1w28nhmn62pYlpAQyeGAQOVXpuJpktpFYw96DWBrjKmmCkdA5QnWpQ0/
         oo/3B7RL+GcKIrzU626s+JVLCvwBk4av88wrTmBy9vshDs38nic5bRwaZarKgUkJ3R6f
         TrxA==
X-Gm-Message-State: AOAM5317EWIkXkr12yZqd849e3YB5QRYpUrFxm1gS5VyaSq61v/Uv1f6
        i2HQ2rOicOymMMBYf6kXBnmvdGkEwy0qfpXaNl8=
X-Google-Smtp-Source: ABdhPJwED4I6me7DWR3DKen5s54VIva9v2Bswc9Z5rAHzlHtKEimFSzd8lJaNLhq/rtqlipAloUDiZesJJ6/ERx3hmU=
X-Received: by 2002:a05:6e02:921:: with SMTP id o1mr5664764ilt.289.1633265623610;
 Sun, 03 Oct 2021 05:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211002210857.709956-1-pauk.denis@gmail.com> <6096864.rdmfHhMOLH@natalenko.name>
 <3507481.XNmkIPAYGC@natalenko.name>
In-Reply-To: <3507481.XNmkIPAYGC@natalenko.name>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sun, 3 Oct 2021 14:53:32 +0200
Message-ID: <CAB95QAThT-LgWJg7s9=7i2X=jqXq2jbQ0j=XASPZxwo0pqrVGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update ASUS WMI supported boards.
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleksandr,

216 =E2=81=B0C is a blank value. According to
https://www.asus.com/Motherboards-Components/Motherboards/Workstation/Pro-W=
S-X570-ACE/techspec/
there is no T_Sensor header on this board.

Best regards,
Eugene

On Sun, 3 Oct 2021 at 14:47, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> Hello.
>
> On ned=C4=9Ble 3. =C5=99=C3=ADjna 2021 13:50:12 CEST Oleksandr Natalenko =
wrote:
> > On sobota 2. =C5=99=C3=ADjna 2021 23:08:53 CEST Denis Pauk wrote:
> > > Add support to nct6775:
> > > * PRIME B360-PLUS
> > > * PRIME X570-PRO
> > > * ROG CROSSHAIR VIII FORMULA
> > > * ROG STRIX B550-I GAMING
> > > * ROG STRIX X570-F GAMING
> > > * ROG STRIX Z390-E GAMING
> > > * TUF GAMING B550-PRO
> > > * TUF GAMING Z490-PLUS
> > > * TUF GAMING Z490-PLUS (WI-FI)
> >
> > Thank you for this submission.
> >
> > Do you happen to know whether it can be extended with another ASUS boar=
d
> > which is:
> >
> > ```
> > Manufacturer: ASUSTeK COMPUTER INC.
> > Product Name: Pro WS X570-ACE
> > ```
> >
> > ?
> >
> > I've got one, and in case any info or testing is needed, I'd be happy t=
o
> > contribute.
> >
> > Currently, this board is kinda working after adding
> > `acpi_enforce_resources=3Dlax`, but I assume a proper support is needed
> > instead.
>
> Partially answering to myself, but still need some clarification.
>
> I did this on top of your recent submissions:
>
> ```
> diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/
> asus_wmi_sensors.c
> index 6b04fad18891..f6817ec9de29 100644
> --- a/drivers/hwmon/asus_wmi_sensors.c
> +++ b/drivers/hwmon/asus_wmi_sensors.c
> @@ -35,6 +35,7 @@
>  #define ASUS_EC_KNOWN_EC_REGISTERS 14
>
>  enum asus_wmi_ec_board {
> +       BOARD_PW_X570_A, // Pro WS X570-ACE
>         BOARD_R_C8H, // ROG Crosshair VIII Hero
>         BOARD_R_C8DH, // ROG Crosshair VIII Dark Hero
>         BOARD_R_C8F, // ROG Crosshair VIII Formula
> @@ -44,6 +45,7 @@ enum asus_wmi_ec_board {
>
>  /* boards with EC support */
>  static const char *const asus_wmi_ec_boards_names[] =3D {
> +       [BOARD_PW_X570_A] =3D "Pro WS X570-ACE",
>         [BOARD_R_C8H] =3D "ROG CROSSHAIR VIII HERO",
>         [BOARD_R_C8DH] =3D "ROG CROSSHAIR VIII DARK HERO",
>         [BOARD_R_C8F] =3D "ROG CROSSHAIR VIII FORMULA",
> @@ -130,6 +132,7 @@ static void asus_wmi_ec_fill_board_sensors(struct
> asus_wmi_ec_info *ec, int boar
>         ec->nr_registers =3D 0;
>
>         switch (board) {
> +       case BOARD_PW_X570_A:
>         case BOARD_RS_B550_E_G:
>         case BOARD_RS_X570_E_G:
>         case BOARD_R_C8H:
> @@ -153,6 +156,7 @@ static void asus_wmi_ec_fill_board_sensors(struct
> asus_wmi_ec_info *ec, int boar
>         }
>
>         switch (board) {
> +       case BOARD_PW_X570_A:
>         case BOARD_RS_X570_E_G:
>         case BOARD_R_C8H:
>         case BOARD_R_C8DH:
> @@ -166,6 +170,7 @@ static void asus_wmi_ec_fill_board_sensors(struct
> asus_wmi_ec_info *ec, int boar
>         }
>
>         switch (board) {
> +       case BOARD_PW_X570_A:
>         case BOARD_RS_X570_E_G:
>         case BOARD_R_C8H:
>         case BOARD_R_C8F:
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index ba18c1cbf572..ff28ba70a8b3 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -5000,6 +5000,7 @@ static int __init nct6775_find(int sioaddr, struct
> nct6775_sio_data *sio_data)
>  static struct platform_device *pdev[2];
>
>  static const char * const asus_wmi_boards[] =3D {
> +       "Pro WS X570-ACE",
>         "PRIME B360-PLUS",
>         "PRIME B460-PLUS",
>         "PRIME X570-PRO",
> ```
>
> Now, with nct6775 I do not need `acpi_enforce_resources=3Dlax` any more, =
and it
> works straight away:
>
> ```
> nct6798-isa-0290
> Adapter: ISA adapter
> in0:                        1.06 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:                        1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in2:                        3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in3:                        3.36 V  (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in4:                        1.74 V  (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in5:                      592.00 mV (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in6:                        1.09 V  (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in7:                        3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in8:                        3.25 V  (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in9:                      888.00 mV (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in10:                       8.00 mV (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in11:                      80.00 mV (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in12:                       1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in13:                       1.35 V  (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> in14:                     888.00 mV (min =3D  +0.00 V, max =3D  +0.00 V) =
 ALARM
> fan1:                      743 RPM  (min =3D    0 RPM)
> fan2:                      366 RPM  (min =3D    0 RPM)
> fan3:                      724 RPM  (min =3D    0 RPM)
> fan4:                        0 RPM  (min =3D    0 RPM)
> fan7:                        0 RPM  (min =3D    0 RPM)
> SYSTIN:                    +35.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D=
 +75.0=C2=B0C)  sensor =3D
> thermistor
> CPUTIN:                    +43.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D=
 +75.0=C2=B0C)  sensor =3D
> thermistor
> AUXTIN0:                   +22.0=C2=B0C    sensor =3D thermistor
> AUXTIN1:                  +127.0=C2=B0C    sensor =3D thermistor
> AUXTIN2:                  +109.0=C2=B0C    sensor =3D thermistor
> AUXTIN3:                   +32.0=C2=B0C    sensor =3D thermistor
> PECI Agent 0 Calibration:  +44.5=C2=B0C
> PCH_CHIP_CPU_MAX_TEMP:      +0.0=C2=B0C
> PCH_CHIP_TEMP:              +0.0=C2=B0C
> PCH_CPU_TEMP:               +0.0=C2=B0C
> intrusion0:               ALARM
> intrusion1:               OK
> beep_enable:              disabled
> ```
>
> With asus_wmi_sensors I get this:
>
> ```
> asuswmiecsensors-isa-0000
> Adapter: ISA adapter
> CPU_Opt:        0 RPM
> Chipset:     1733 RPM
> Chipset:      +58.0=C2=B0C
> CPU:          +45.0=C2=B0C
> Motherboard:  +35.0=C2=B0C
> T_Sensor:    +216.0=C2=B0C
> VRM:          +34.0=C2=B0C
> CPU:           7.00 A
> ```
>
> Everything seems to be good except that `T_Sensor`. Probably, I should ex=
clude
> it on this board?
>
> If you are fine with the approach above, I'll post 2 patches for this boa=
rd.
>
> Thanks.
>
> --
> Oleksandr Natalenko (post-factum)
>
>
