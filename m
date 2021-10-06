Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06F6423FB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhJFODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhJFOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:02:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF2C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:01:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r18so10247975edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35EUUIGUPuPs3VKMXkEpOsYeHNYeLxuc/OClkXfI9o0=;
        b=M1lfx0kLa1W2L5C/VBerqruuYLo7NFTWMlkHFHmg7yM3G3D5DzadveotHBvrw8+oxN
         zbzkd3AtxMOAIKvzWDdVi/hmgVc2Pf0d9/LcU+SLicaeSL/gXP693EkxIhyiuQOdqnrs
         4Q6JIq6gUneoEqF4gEOSUXdA43Dki3Uj7zyeAe8LuQpsdwWOcxtk4gzEvBLsheOkZbcI
         t7y6hYJKxAXIQ2Alp1xZexaVLHCU5aaOnB1JaEJmYDMN676yH6DJ9PQd1fZpCskpnk1U
         omnIbKInlTuBq1BwhpN19h8JD+l2shatYOTcVtwNcLxAb7xwsDOYzaaAmJmU2bgATIBW
         nzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35EUUIGUPuPs3VKMXkEpOsYeHNYeLxuc/OClkXfI9o0=;
        b=Qv55487GrUuV0YKie7eHgKdyohmB/Yb2djbwUayvR12ptmDKjzmgHdhjAhTroHNKWB
         OILAG8ET50yLgbxujjVECXeFibKYhOQtYJGpisAYz2Y3/cyHWx0ooNKjDaBdnBpWmr98
         ardqaqr+n2jD/gFfOLOy+eQkOxXk2gXUyL3Ncziv82AJ9Yo8jrd+yM7raqQJb4ko12hr
         pJVlQJ36g6XvklP3ofK8o0wcIWc8q6y/Vc0sZg+YlDkYN9cHHD92gaKleVrLYTm2bKid
         PthM78I7MU8epgKLtGco/tEoMueg8Ttu0zo2/l0mCScs9q7M3wRutwvVQcJ8unRpao4G
         5Nkw==
X-Gm-Message-State: AOAM531zVasdd3+kGCX9btostSiyBsy6PfZcmUJZiR9bkytyQQPMq2BO
        hgiewQ+NaPPLsg2iwAwkg53wzmBaJKhBqpQWB6+byg==
X-Google-Smtp-Source: ABdhPJyxL32NpITVFTiruqI0fg5s2SIaIwN+uNZ4Qmf3DRbji2E37Xp76Z5397gMi4zmZmazD5lwqNQd/C4wN3/WNP0=
X-Received: by 2002:a17:906:5d6:: with SMTP id t22mr32911283ejt.98.1633528845665;
 Wed, 06 Oct 2021 07:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211006132104.105288-1-sohaib.amhmd@gmail.com>
In-Reply-To: <20211006132104.105288-1-sohaib.amhmd@gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 6 Oct 2021 16:00:35 +0200
Message-ID: <CAMGffEm65An5K0cuNRTVHCO1voBs6AvsqJ1US=cFP3fddSpmZQ@mail.gmail.com>
Subject: Re: [PATCH] docs: typo fixes in Documentation/ABI/
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, Gioh Kim <gi-oh.kim@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 3:21 PM Sohaib Mohamed <sohaib.amhmd@gmail.com> wrote:
>
> All these changes are about to remove repeated words from severals place in the Documentation/ABI/ directory:
>

>
> - In file testing/sysfs-class-rnbd-client:131: "as as the"
>
> - In file testing/sysfs-class-rtrs-client:81: "the the name"
>
> - In file testing/sysfs-class-rtrs-server:27: "the the name"
For all 3 rtrs/rnbd changes, all look good to me.
Acked-by: Jack Wang <jinpu.wang@ionos.com>

Thanks!
>  Documentation/ABI/stable/sysfs-module                     | 2 +-
>  Documentation/ABI/testing/sysfs-bus-rapidio               | 2 +-
>  Documentation/ABI/testing/sysfs-class-cxl                 | 4 ++--
>  Documentation/ABI/testing/sysfs-class-rnbd-client         | 2 +-
>  Documentation/ABI/testing/sysfs-class-rtrs-client         | 2 +-
>  Documentation/ABI/testing/sysfs-class-rtrs-server         | 2 +-
>  Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD | 2 +-
>  Documentation/ABI/testing/sysfs-devices-power             | 2 +-
>  Documentation/ABI/testing/sysfs-driver-ufs                | 2 +-
>  Documentation/ABI/testing/sysfs-firmware-acpi             | 2 +-
>  10 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
> index 560b4a3278df..41b1f16e8795 100644
> --- a/Documentation/ABI/stable/sysfs-module
> +++ b/Documentation/ABI/stable/sysfs-module
> @@ -38,7 +38,7 @@ What:         /sys/module/<MODULENAME>/srcversion
>  Date:          Jun 2005
>  Description:
>                 If the module source has MODULE_VERSION, this file will contain
> -               the checksum of the the source code.
> +               the checksum of the source code.
>
>  What:          /sys/module/<MODULENAME>/version
>  Date:          Jun 2005
> diff --git a/Documentation/ABI/testing/sysfs-bus-rapidio b/Documentation/ABI/testing/sysfs-bus-rapidio
> index f8b6728dac10..9e8fbff99b75 100644
> --- a/Documentation/ABI/testing/sysfs-bus-rapidio
> +++ b/Documentation/ABI/testing/sysfs-bus-rapidio
> @@ -95,7 +95,7 @@ Contact:      Matt Porter <mporter@kernel.crashing.org>,
>                 Alexandre Bounine <alexandre.bounine@idt.com>
>  Description:
>                 (RO) returns name of previous device (switch) on the path to the
> -               device that that owns this attribute
> +               device that owns this attribute
>
>  What:          /sys/bus/rapidio/devices/<nn>:<d>:<iiii>/modalias
>  Date:          Jul, 2013
> diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
> index 3c77677e0ca7..594fda254130 100644
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -103,8 +103,8 @@ What:           /sys/class/cxl/<afu>/api_version_compatible
>  Date:           September 2014
>  Contact:        linuxppc-dev@lists.ozlabs.org
>  Description:    read only
> -                Decimal value of the the lowest version of the userspace API
> -                this this kernel supports.
> +                Decimal value of the lowest version of the userspace API
> +                this kernel supports.
>  Users:         https://github.com/ibm-capi/libcxl
>
>
> diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
> index 0b5997ab3365..e6cdc851952c 100644
> --- a/Documentation/ABI/testing/sysfs-class-rnbd-client
> +++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
> @@ -128,6 +128,6 @@ Description:        For each device mapped on the client a new symbolic link is created
>                 The <device_id> of each device is created as follows:
>
>                 - If the 'device_path' provided during mapping contains slashes ("/"),
> -                 they are replaced by exclamation mark ("!") and used as as the
> +                 they are replaced by exclamation mark ("!") and used as the
>                   <device_id>. Otherwise, the <device_id> will be the same as the
>                   "device_path" provided.
> diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
> index 49a4157c7bf1..fecc59d1b96f 100644
> --- a/Documentation/ABI/testing/sysfs-class-rtrs-client
> +++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
> @@ -78,7 +78,7 @@ What:         /sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_name
>  Date:          Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
> -Description:   RO, Contains the the name of HCA the connection established on.
> +Description:   RO, Contains the name of HCA the connection established on.
>
>  What:          /sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
>  Date:          Feb 2020
> diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentation/ABI/testing/sysfs-class-rtrs-server
> index 3b6d5b067df0..b08601d80409 100644
> --- a/Documentation/ABI/testing/sysfs-class-rtrs-server
> +++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
> @@ -24,7 +24,7 @@ What:         /sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_name
>  Date:          Feb 2020
>  KernelVersion: 5.7
>  Contact:       Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
> -Description:   RO, Contains the the name of HCA the connection established on.
> +Description:   RO, Contains the name of HCA the connection established on.
>
>  What:          /sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
>  Date:          Feb 2020
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
> index f7b360a61b21..bc44bc903bc8 100644
> --- a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
> @@ -74,7 +74,7 @@ Description:
>
>                 Reads also cause the AC alarm timer status to be reset.
>
> -               Another way to reset the the status of the AC alarm timer is to
> +               Another way to reset the status of the AC alarm timer is to
>                 write (the number) 0 to this file.
>
>                 If the status return value indicates that the timer has expired,
> diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
> index 1b2a2d41ff80..54195530e97a 100644
> --- a/Documentation/ABI/testing/sysfs-devices-power
> +++ b/Documentation/ABI/testing/sysfs-devices-power
> @@ -303,5 +303,5 @@ Date:               Apr 2010
>  Contact:       Dominik Brodowski <linux@dominikbrodowski.net>
>  Description:
>                 Reports the runtime PM children usage count of a device, or
> -               0 if the the children will be ignored.
> +               0 if the children will be ignored.
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 863cc4897277..57aec11a573f 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -983,7 +983,7 @@ Description:        This file shows the amount of data that the host plans to
>  What:          /sys/class/scsi_device/*/device/dyn_cap_needed
>  Date:          February 2018
>  Contact:       Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> -Description:   This file shows the The amount of physical memory needed
> +Description:   This file shows The amount of physical memory needed
>                 to be removed from the physical memory resources pool of
>                 the particular logical unit. The full information about
>                 the attribute could be found at UFS specifications 2.1.
> diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
> index 819939d858c9..39173375c53a 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-acpi
> +++ b/Documentation/ABI/testing/sysfs-firmware-acpi
> @@ -112,7 +112,7 @@ Description:
>                 OS context.  GPE 0x12, for example, would vector
>                 to a level or edge handler called _L12 or _E12.
>                 The handler may do its business and return.
> -               Or the handler may send send a Notify event
> +               Or the handler may send a Notify event
>                 to a Linux device driver registered on an ACPI device,
>                 such as a battery, or a processor.
>
> --
> 2.25.1
>
