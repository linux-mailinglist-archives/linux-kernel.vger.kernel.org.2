Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4163D5791
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhGZJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhGZJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:49:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1082C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 03:29:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a26so14483765lfr.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiZLItzFNfT1uyeR4O22ZeB7CamKKtX2owoJUPMklQU=;
        b=X9l4iXuDvjNwrDXoCyYPMe74N+OaVgW+CacFimydiGSEydeZmYsLjjbR4Qey98vajm
         AW21YQYj/hmjFoNAO26iKQ6w7uPnjd2u09vcccHQK1Du3LCmwCSsJkusJIo0rmaVhCR9
         uhzMLwz3WI9+Z5nippEnrPxbO7/R80Kh3kjhplu+6x5PnOjLUEEGsa5tleHy1IdFUIEX
         n/ClGON2192xg8JoecTXVtYm6ZLOIAOA5qQFH/+T3QkAUqCHi2PA3EzlI//F+8cze+dX
         uDGmB8/hix9EgE6bkS+w3EMbhGpcLh73J+kBrLyjwMkCdJUEUIs0aYDXyWedVViTdaLx
         MPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiZLItzFNfT1uyeR4O22ZeB7CamKKtX2owoJUPMklQU=;
        b=WFREbj5eyp37/qWfuaFoWsEIYzkxnI6wzZe2I63hHO7GmKPW5V2V3xG4QLCmuFNC2v
         QoGh4Q2858TjrHs6ARUyPdCOGht44wkb9FrlM7cAxemBAIfmHPkCJOH/tud2ZPy8kfnU
         ICkoIgJOV+biQju1Cvu83k/du0HAZfGZogDepatykKXeYkCMne+XeeZgcUPKsQpGABuR
         EvVrmfXyzQM7647boHv6gR/SP4flo7Fd28Wx88PpNsXsjNInqL3te80WmorAXydnnOJH
         WrnaY0E4oje3/r1jwjUP+Wwsge4sORUHPQkaLZO9xvEXlyYS3QTXrochJSCrwKcKx0yz
         rwGQ==
X-Gm-Message-State: AOAM533tEjxqzY7TBMrlOz0cSbyjMYU0xLPvRwKhLOCXw9FtcIgaVt1n
        TNDmGMlFRCuENowuY1re4EbgG2uCq7ew8YPGmQibsg==
X-Google-Smtp-Source: ABdhPJw6AdusCkbF9vg4ffWq/H0RTo3BHjIxof8BoRk+cuTQucs9n0Yr9JQsPKy8T9KhPVz8m97EpLg4ef/EFEZUSJY=
X-Received: by 2002:a05:6512:4017:: with SMTP id br23mr12724794lfb.113.1627295388021;
 Mon, 26 Jul 2021 03:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
In-Reply-To: <20210722121757.1944658-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 26 Jul 2021 15:59:36 +0530
Message-ID: <CAFA6WYMgWizZoJmk7U0g8zP7Jf_SHLXi3ydMCg2iH5HEQmF=zw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add FF-A support in OP-TEE driver
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi all,
>
> This adds supports for the OP-TEE driver to communicate with secure world
> using FF-A [1] as transport.
>
> There is one change to the TEE subsystem with "tee: add sec_world_id to
> struct tee_shm" to add support for holding globally unique handle assigned
> by the FF-A. This is a field that I believe could useful for the AMDTEE
> driver too.
>
> For communication the OP-TEE message protocol is still used, but with a new
> type of memory reference, struct optee_msg_param_fmem, to carry the
> information needed by FF-A. The OP-TEE driver is refactored internally with
> to sets of callbacks, one for the old SMC based communication and another
> set with FF-A as transport. The functions relating to the SMC based ABI
> are moved to smc_abi.c while the FF-A based ABI is added in a ffa_abi.c.
>
> There is also a difference in how the drivers are instantiated. With the
> SMC based transport we have a platform driver, module_platform_driver(),
> today which we're keeping as is for this configuration. In a FF-A system we
> have a FF-A driver, module_ffa_driver(), instead.
>
> The OP-TEE driver can be compiled for both targets at the same time and
> it's up to runtime configuration (device tree or ACPI) to decide how it's
> initialized. Note that it's only the old SMC based driver instance that
> need device tree or ACPI to initialize. The FF-A based driver relies on the
> FF-A bus instead.
>
> This can be tested QEMU
> The repo for SPMC at S-EL1 retrieved by
> repo init -u https://github.com/jenswi-linaro/manifest.git -m
> qemu_v8.xml -b ffav4_spmc
> repo sync
> # Then checkout the branch optee_ffa_v3 from
> # git://git.linaro.org/people/jens.wiklander/linux-tee.git
> # in the linux directory
>
> To build do:
> cd build
> make toolchains
> make all
>
> To boot:
> make run-only
>
> Test with xtest, perhaps only with the command "xtest 1004" in case you're
> not interested in too many tests.

Thanks Jens for sharing instructions to test this feature. So I tried
to reproduce using following repo versions:

linux-tee, branch: optee_ffa_v3
trusted-firmware-a, branch: ffav4_sel1_spmc
build, branch: ffav4_spmc

and rest of the repos synced to the latest version as per upstream
qemu_v8.xml [1] but I don't see OP-TEE driver being probed during boot
[2]. Am I missing something?

[1] https://github.com/OP-TEE/manifest/blob/master/qemu_v8.xml
[2]
Welcome to Buildroot, type root or test to login
buildroot login: root
# dmesg | grep optee
#

-Sumit

>
> Thanks,
> Jens
>
> [1] https://developer.arm.com/documentation/den0077/latest
>
> v2->v3:
> - Rebased on 5.14-rc2 which now have the FF-A patches merged
> - Fixed a couple bugs in optee_shm_register() and optee_shm_unregister()
>   which where introduced in "optee: refactor driver with internal callbacks"
>   in previous the version.
> - Separated SMC ABI specifics into smc_abi.c to keep it separated from
>   the FF-A ABI functions as requested by Sumit.
> - Added the FF-A specifics in ffa_abi.c
> - Provided an implementation for optee_ffa_remove()
>
> v1->v2:
> - Rebased to the FF-A v7 patch
> - Fixed a couple of reports from kernel test robot <lkp@intel.com>
>
> Jens Wiklander (5):
>   tee: add sec_world_id to struct tee_shm
>   optee: simplify optee_release()
>   optee: refactor driver with internal callbacks
>   optee: isolate smc abi
>   optee: add FF-A support
>
>  drivers/tee/optee/Makefile        |    7 +-
>  drivers/tee/optee/call.c          |  415 ++-------
>  drivers/tee/optee/core.c          |  673 ++-------------
>  drivers/tee/optee/ffa_abi.c       |  910 ++++++++++++++++++++
>  drivers/tee/optee/optee_ffa.h     |  153 ++++
>  drivers/tee/optee/optee_msg.h     |   27 +-
>  drivers/tee/optee/optee_private.h |  155 +++-
>  drivers/tee/optee/rpc.c           |  270 +-----
>  drivers/tee/optee/shm_pool.c      |   89 --
>  drivers/tee/optee/shm_pool.h      |   14 -
>  drivers/tee/optee/smc_abi.c       | 1301 +++++++++++++++++++++++++++++
>  include/linux/tee_drv.h           |    7 +-
>  12 files changed, 2650 insertions(+), 1371 deletions(-)
>  create mode 100644 drivers/tee/optee/ffa_abi.c
>  create mode 100644 drivers/tee/optee/optee_ffa.h
>  delete mode 100644 drivers/tee/optee/shm_pool.c
>  delete mode 100644 drivers/tee/optee/shm_pool.h
>  create mode 100644 drivers/tee/optee/smc_abi.c
>
> --
> 2.31.1
>
