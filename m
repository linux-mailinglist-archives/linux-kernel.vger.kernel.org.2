Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351FB348159
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbhCXTPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbhCXTOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:14:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D595C061763;
        Wed, 24 Mar 2021 12:14:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c204so18081092pfc.4;
        Wed, 24 Mar 2021 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvBJ4EDdcjjCofVVdDGQtcQOikr6JAxzUhaQH16eZC0=;
        b=IT+11ZeyzQkfdmCq9yS3kN7e9VZQQgKlvhLQfoA2ejjkdFvrggPyKlEv4r+LTgzHZD
         LlsEjCFnI90yDR8Wr34laILdgzAy7d0G3WzT4l5vS+ZawNDc/R7ywrcWQVd5FMRQbzr6
         E93jDO4YC3y9IIe2A5v0ldLon5c9TMPWUKiTHrsT67ptBO0831baWTmkV+760Lhp0gbS
         r/n6XQ5xz8wVooarPHy/4wB8ZR0wkbqi6Kw2Uw9wCueBJ3wMLT+erbThuErTKH6Lj7yR
         HibSWDErNSaHMUh612XNwwgCSfuLCCDv1ofovifJpuERmf05q5zbEElUuGDbVa976nFy
         R7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvBJ4EDdcjjCofVVdDGQtcQOikr6JAxzUhaQH16eZC0=;
        b=eQnRGslF25LpVITvTQ7R7EGNccQqvFBmFqKCnYzpQOENuyYxWNPE0ArzPC/q/lOA/I
         eu9rLj2FfaQ4IuvABKL1/dSAp2Bl9kiBJ6iT80qWp9hJcEcXNh2grhvxyVkB9+ZCr/yK
         lakVC10zTr92bPl4K97Z/AJpvlvtH10Q/nqC1N6zAsPWUnN/r1ly4CmyTYhzcuMIYbWn
         EyTI6Vd3S5pX5211Ynk2CezXIN3ON4sYrqNqSF9Ud2Ty8gbMAFpZojR9zCeVmzblyeLY
         BAJ4LKkxlrkFAMXrecr6M91YnAX7v3g3rC8dBFjlgk9RMf1Npwd5tkdNG4zZ1C+iMA57
         VQew==
X-Gm-Message-State: AOAM531D9vDlDg4SAscw40/D/lwJ6cJLQE/u7O9ZXBwse/613dk6mKbu
        Au50m7CuQSLB+DmhGE1UsTd/NOgdvg/yccZstNI=
X-Google-Smtp-Source: ABdhPJxv9lGQ2CeCRSp4UnEtaGofy87/QKujlCESfidTH2io/wHlkwWNyU5/QFpjwKN3PHTrFu5C7XleB7NlQHuAMDo=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr4909871plq.17.1616613272478; Wed, 24 Mar
 2021 12:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Mar 2021 21:14:16 +0200
Message-ID: <CAHp75Vf6DSd=i=rKVL_53=eo1HFZTZCjibrVxWNN+SNOmyFtqQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Driver of Intel(R) Gaussian & Neural Accelerator
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 8:38 PM Maciej Kwapulinski
<maciej.kwapulinski@linux.intel.com> wrote:
>
> Dear kernel maintainers,
>
> This submission is a kernel driver to support Intel(R) Gaussian & Neural
> Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor
> available on multiple Intel platforms. AI developers and users can offload
> continuous inference workloads to an Intel(R) GNA device in order to free
> processor resources and save power. Noise reduction and speech recognition
> are the examples of the workloads Intel(R) GNA deals with while its usage
> is not limited to the two.
>
> For a list of processors equipped with Intel(R) GNA device, please refer to
> this link:
> https://docs.openvinotoolkit.org/latest/openvino_docs_IE_DG_supported_plugins_GNA.html
>
> We think contributing this driver to the upstream kernel project is the
> best way for developers and users to get the latest Intel(R) GNA support in
> a Linux kernel, through the mainline to any Linux distributions installed
> on their systems. Upstreaming also enables contribution from developers
> around the world to the driver once it is merged.
>
> The driver works with Intel(R) libraries in user space. The Intel(R) driver
> exposes a few IOCTL interfaces for use by libraries in user space. The
> libraries are open sourced and are available at:
> https://github.com/intel/gna
>
> ---
>
> Changelogs:
>
> v1->v2:
>  - driver's new layout:
>    - driver name: gna -> intel_gna
>    - module name: gna -> intel_gna

>    - device file name: /dev/gnaN -> /dev/intel_gnaN

Not sure we need this, but if Greg asked for that (I haven't followed)
than it's okay.

>    - driver's source directory: drivers/misc/gna/ -> drivers/misc/intel/gna/
>    - UAPI: include/uapi/misc/gna.h -> include/uapi/misc/intel/gna.h
>    - DOC: Documentation/misc-devices/gna.rst ->
>        Documentation/misc-devices/intel/gna.rst
>  - 'MISC' device framework used
>  - fixes throughout GNA device's PCI management
>  - header files' includes and forward declarations cleanup
>  - ISR made static
>  - unused comments cleanup
>  - "_priv_" segment removed from function names

>  - tested: v5.11-rc3 -> v5.11

We are at v5.12-rc4. The rule of thumb is latest rc or release +
subsystem tree against which the driver is created.

>  - number of other/minor fixes
>
> ---
>
> Maciej Kwapulinski (1):
>   intel_gna: add a 'misc' device
>
> Tomasz Jankowski (12):
>   intel_gna: add driver module
>   intel_gna: add component of hardware operation
>   intel_gna: read hardware info in the driver
>   intel_gna: add memory handling
>   intel_gna: initialize mmu
>   intel_gna: add hardware ids
>   intel_gna: add request component
>   intel_gna: implement scoring
>   intel_gna: add a work queue to process scoring requests
>   intel_gna: add interrupt handler
>   intel_gna: add ioctl handler
>   intel_gna: add file operations to a 'misc' device
>
>  Documentation/misc-devices/index.rst          |   1 +
>  Documentation/misc-devices/intel/gna.rst      |  48 ++
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |   7 +
>  drivers/misc/Kconfig                          |   1 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/intel/gna/Kbuild                 |   5 +
>  drivers/misc/intel/gna/Kconfig                |  13 +
>  drivers/misc/intel/gna/gna_device.c           | 429 ++++++++++++++++
>  drivers/misc/intel/gna/gna_device.h           |  89 ++++
>  drivers/misc/intel/gna/gna_driver.c           |  43 ++
>  drivers/misc/intel/gna/gna_driver.h           |  33 ++
>  drivers/misc/intel/gna/gna_hw.c               | 125 +++++
>  drivers/misc/intel/gna/gna_hw.h               |  61 +++
>  drivers/misc/intel/gna/gna_ioctl.c            | 249 +++++++++
>  drivers/misc/intel/gna/gna_ioctl.h            |  11 +
>  drivers/misc/intel/gna/gna_mem.c              | 473 ++++++++++++++++++
>  drivers/misc/intel/gna/gna_mem.h              | 107 ++++
>  drivers/misc/intel/gna/gna_request.c          | 463 +++++++++++++++++
>  drivers/misc/intel/gna/gna_request.h          |  62 +++
>  drivers/misc/intel/gna/gna_score.c            | 298 +++++++++++
>  drivers/misc/intel/gna/gna_score.h            |  18 +
>  include/uapi/misc/intel/gna.h                 | 155 ++++++
>  23 files changed, 2693 insertions(+)
>  create mode 100644 Documentation/misc-devices/intel/gna.rst
>  create mode 100644 drivers/misc/intel/gna/Kbuild
>  create mode 100644 drivers/misc/intel/gna/Kconfig
>  create mode 100644 drivers/misc/intel/gna/gna_device.c
>  create mode 100644 drivers/misc/intel/gna/gna_device.h
>  create mode 100644 drivers/misc/intel/gna/gna_driver.c
>  create mode 100644 drivers/misc/intel/gna/gna_driver.h
>  create mode 100644 drivers/misc/intel/gna/gna_hw.c
>  create mode 100644 drivers/misc/intel/gna/gna_hw.h
>  create mode 100644 drivers/misc/intel/gna/gna_ioctl.c
>  create mode 100644 drivers/misc/intel/gna/gna_ioctl.h
>  create mode 100644 drivers/misc/intel/gna/gna_mem.c
>  create mode 100644 drivers/misc/intel/gna/gna_mem.h
>  create mode 100644 drivers/misc/intel/gna/gna_request.c
>  create mode 100644 drivers/misc/intel/gna/gna_request.h
>  create mode 100644 drivers/misc/intel/gna/gna_score.c
>  create mode 100644 drivers/misc/intel/gna/gna_score.h
>  create mode 100644 include/uapi/misc/intel/gna.h
>
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
