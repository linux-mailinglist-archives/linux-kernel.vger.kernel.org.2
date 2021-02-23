Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17258322ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhBWQfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBWQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:34:53 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C43C061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:34:11 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id f20so17731616ioo.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAuM0NvvpmWFI3lwMkeddMAcloUt0SgojkO1lse6Ar0=;
        b=mPbsWktbM04m25kxy6T5PnkjbM/2L55dvG2/udFKts+5ixkM+f9bTq8SU23pqWG1iV
         VeiY2MJQXtebN4t5bkJ+WKVu+w9UD7cIsrd4VEKue9/Wg0IVo2gCRMn8VuMkkHETSi/+
         txwFj58BNSy+kdEv/8QiRdr66RSTHly6wh49gohpMnIg0HbzUGpeeoV7Zl7pd71jkEGD
         6D/NMeY4ACtzSgN6/ImKqLWygON8+RAPdukvtp3TgGk0YV/bpSrTcp8zOFLetiwlczex
         b4GA5YiOtmDpUpUb8czr0U7KiSXbA8+jkOJZ9SgyRmSQ1vk5tnRPNmzjgR1BulPBmvQd
         Irtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAuM0NvvpmWFI3lwMkeddMAcloUt0SgojkO1lse6Ar0=;
        b=E+Ld7ZIF0ecRc9YjHn/JH70NkpdJtf30tqz3K0wleZhqiUoe6oIDycqXmHKtSt9Tlv
         fJ9q1BLp7u4p5DwJLv58P6BrxkF/tfsa9glwK6Pzib6qsM31wo8WtuxO8wk0ek7wxhcT
         iQJ9PFXWEGM2HpK7IVjKNl+7Oqhw72q+tESh107sBQEWH8E9Yu1iKIzzzql9KcfQme08
         xIaqvfk7GDaeiKOcj3nm39lvBUzUJTjthRHlHYVl9tdabVy4V3dfc5jgnUUo5YVA6uIr
         kTotl2FVVKhnNw2vwYwmG4zulTD8FPpOM6ZV+hQpGjyWORQrQze0OfDw/aZY3eGmZBoh
         JVfw==
X-Gm-Message-State: AOAM530zP4rWzpdZpHfIDkKEIR3ioXxp/IiHrfuj80/uJtzKR8U37fYZ
        9Kk0xzA4ZgRwVGJ8fX+aGfzSot/Z9xG2MZaHdxqeXQ==
X-Google-Smtp-Source: ABdhPJz9HBCe8XCYHw9uEwQHFSJf5ZP3K3daAErIVt31zQY7i4WkZ13Y/knGEhDDIkxajQ7dZdVMSLwPTNmT7LjA7IE=
X-Received: by 2002:a5d:8617:: with SMTP id f23mr20475491iol.90.1614098051388;
 Tue, 23 Feb 2021 08:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20210223154447.13247-1-ben.levinsky@xilinx.com>
In-Reply-To: <20210223154447.13247-1-ben.levinsky@xilinx.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 23 Feb 2021 09:34:00 -0700
Message-ID: <CANLsYkzkmRGsiJWnFmjdEg=yfAxbhYeu6bhW92HiKk1ugdyeww@mail.gmail.com>
Subject: Re: [PATCH v26 0/5] Add initial zynqmp R5 remoteproc driver
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

I have received your patchset but currently don't see having the time
to look at it before the middle of March.

Thanks,
Mathieu

On Tue, 23 Feb 2021 at 08:44, Ben Levinsky <ben.levinsky@xilinx.com> wrote:
>
> R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
> remotproc driver, we can boot the R5 sub-system in two different
> configurations -
>         * Split
>         * Lockstep
>
> The Xilinx R5 Remoteproc Driver boots the R5's via calls to the Xilinx
> Platform Management Unit that handles the R5 configuration, memory access
> and R5 lifecycle management. The interface to this manager is done in this
> driver via zynqmp_pm_* function calls.
>
> v26:
> - add prepare and unprepare to handle Xilinx platform management's
>   request_node and release node using each core's list of srams
>   that is constructed in each core's zynqmp_r5_probe.
> - add new field sram to zynqmp_r5_rproc to store each core's srams
>   being used as described in device tree. This helps to reduce unneeded looping
>   of the sram prop in device tree. As now only zynqmp_r5_probe has to parse
>   and validate each core's sram property. The ensuing prepare, unprepare
>   and parse_fw logic are now much simpler.
> - similarly add 'size' field to struct sram_addr_data to simplify
>   prepare, unprepare and parse_fw.
>
> Previous version:
> https://patchwork.kernel.org/project/linux-remoteproc/list/?series=412083
>
>
> Ben Levinsky (5):
>   firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
>     configuration.
>   firmware: xilinx: Add shutdown/wakeup APIs
>   firmware: xilinx: Add RPU configuration APIs
>   dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc
>     bindings
>   remoteproc: Add initial zynqmp R5 remoteproc driver
>
>  .../xilinx,zynqmp-r5-remoteproc.yaml          | 223 ++++
>  drivers/firmware/xilinx/zynqmp.c              |  96 ++
>  drivers/remoteproc/Kconfig                    |   8 +
>  drivers/remoteproc/Makefile                   |   1 +
>  drivers/remoteproc/zynqmp_r5_remoteproc.c     | 954 ++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          |  64 ++
>  6 files changed, 1356 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
>  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
>
> --
> 2.17.1
>
