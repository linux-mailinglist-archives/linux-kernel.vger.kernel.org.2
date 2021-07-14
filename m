Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFED43C8372
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbhGNLMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhGNLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:12:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96268C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:09:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn5so2398450ljb.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0TMPvxOFb6IoP3ndZ/UuzxcR9hu1yO3tgEtU6vY2b4=;
        b=df9xZPM4UnD6+Imjxfd2YWdV4My49n7UYf7FIgX84ljq3vN1zQHkQw86zcWkQYboP/
         qrDKAMsBZHNJ5adBDvsvY1+EmmNIB0OQRTBZhsFxrEhYUOeJpNLdDhiS2TZRMuySV4N/
         jEC4zKaJODctXzexVzYoqILRoQ5W0/omFpY1rlx/DWe237AlpTn/Vp1tYE7cbUGvthD7
         X/vmTl9zHOreJ5NlFYwy9l9TlrbagOvpwUXzYscBX/AVn94CN2EgkXubG3xGFEjCT6Z2
         h18bBM3k3OALKiRIGsmMhdUB0XJ93pDym2kOeVqcHrL3fX6sLi9iEJPyD5Wcal1E5hYL
         eVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0TMPvxOFb6IoP3ndZ/UuzxcR9hu1yO3tgEtU6vY2b4=;
        b=s/jdQkKWu+dy3P9w5VrQq3UNxhIrV//CymI3dDSQZCY+ukfLguPVAe92mb9Kvtirmu
         YnpbEuhsYjr6l2ssTxCNKnZD60QgRN9EIckPwOsUAhd3l19vd1OANTrp+KKdY3qowDFe
         uAxlrb8IuPAHbJ6T3MOne0FafKht31YaxWJCnHzl8I6gyuQ/XPl8++HZTj1kSNba3PnV
         j1rsfa11k5QD0B1iAL3d4Y4xQK1Mu732bkmgkBP4nwguLYBWNBLuKUEpoV+0pf1HJxKd
         oqJNSBSvUta+6LqRSYZqTwCWPjYenWJir2UOnXKHmu/EmpTSiA3IgmiyjfhUc3f52jxp
         qFrw==
X-Gm-Message-State: AOAM5336J52EvlQBoweu5Vqo+m/2hw4aSwj0CZsTtM/WsWarlpRXF/2p
        hjxtAkM+EejWnv5d0mX/9cB3VijEXNibgbRTGxpoDQ==
X-Google-Smtp-Source: ABdhPJxEhoqRpr7HmwPThePbSuYCwwjX0ADDHc68KCE3st/zTMz7kSdPTP7Sct2Uy/2+Py/FNCCjSjTRkbLlqbtJT5k=
X-Received: by 2002:a2e:bc13:: with SMTP id b19mr8883269ljf.480.1626260958700;
 Wed, 14 Jul 2021 04:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210527081404.1433177-1-jens.wiklander@linaro.org>
In-Reply-To: <20210527081404.1433177-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 14 Jul 2021 16:39:07 +0530
Message-ID: <CAFA6WYPpJWRJbca_MSziEXZRRK5eK8NiU68zBeBxh4Fvn+NCvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add FF-A support in OP-TEE driver
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

This patch-set skipped my inbox as I was not on the CC list. So while
reading through ML archives, I found it.

On Thu, 27 May 2021 at 13:45, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi all,
>
> This adds supports for the OP-TEE driver to communicate with secure world
> using FF-A [1] as transport.
>
> These patches are based on the FF-A v7 patch set by Sudeep Holla [2] [3].
>

I could see the FF-A driver support merged upstream. Is this patch-set
directly applicable on the upstream kernel? If yes, can you also share
steps to test it on Qemu?

> There is one change to the TEE subsystem with "tee: add sec_world_id to
> struct tee_shm" to add support for holding globally unique handle assigned
> by the FF-A. This is a field that I believe could useful for the AMDTEE
> driver too.
>
> For communication the OP-TEE message protocol is still used, but with a new
> type of memory reference, struct optee_msg_param_fmem, to carry the
> information needed by FF-A. The OP-TEE driver is refactored internally with
> to sets of callbacks, one for the old SMC based communication and another
> set with FF-A as transport.

Since now we have two ABIs towards secure world:
- OP-TEE ABI
- FF-A ABI

I think it would be better to have ABI specific APIs separated from
core.c to have a clear view of abstraction. How about new file names
as:
- optee_{msg/abi}.c
- ffa_{msg/abi}.c

>
> There is also a difference in how the drivers are instantiated. With the
> SMC based transport we have a platform driver, module_platform_driver(),
> today which we're keeping as is for this configuration. In a FF-A system we
> have a FF-A driver, module_ffa_driver(), instead.
>
> The OP-TEE driver can be compiled for both targets at the same time and
> it's up to runtime configuration (device tree or ACPI) to decide how it's
> initialized.

Can you elaborate on different device tree or ACPI configuration?
AFAIR, FF-A utilizes bus enumeration to scan OP-TEE UUID.

-Sumit

>
> Thanks,
> Jens
>
> [1] https://developer.arm.com/documentation/den0077/latest
> [2] https://lore.kernel.org/linux-arm-kernel/20210521151033.181846-1-sudeep.holla@arm.com/
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git v5.13/ffa
>
> v1->v2:
> - Rebased to the FF-A v7 patch
> - Fixed a couple of reports from kernel test robot <lkp@intel.com>
>
> Jens Wiklander (5):
>   tee: add sec_world_id to struct tee_shm
>   optee: simplify optee_release()
>   optee: refactor driver with internal callbacks
>   optee: add a FF-A memory pool
>   optee: add FF-A support
>
>  drivers/tee/optee/call.c          | 325 +++++++++++---
>  drivers/tee/optee/core.c          | 689 ++++++++++++++++++++++++++----
>  drivers/tee/optee/optee_ffa.h     | 153 +++++++
>  drivers/tee/optee/optee_msg.h     |  27 +-
>  drivers/tee/optee/optee_private.h |  88 +++-
>  drivers/tee/optee/rpc.c           | 137 +++++-
>  drivers/tee/optee/shm_pool.c      |  65 ++-
>  drivers/tee/optee/shm_pool.h      |   1 +
>  include/linux/tee_drv.h           |   7 +-
>  9 files changed, 1326 insertions(+), 166 deletions(-)
>  create mode 100644 drivers/tee/optee/optee_ffa.h
>
> --
> 2.25.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
