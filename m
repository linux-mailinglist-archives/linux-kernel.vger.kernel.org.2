Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87BE41E99D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352931AbhJAJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:32:01 -0400
Received: from foss.arm.com ([217.140.110.172]:38692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhJAJcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:32:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7AAC101E;
        Fri,  1 Oct 2021 02:30:15 -0700 (PDT)
Received: from bogus (unknown [10.57.26.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CE7D3F70D;
        Fri,  1 Oct 2021 02:30:13 -0700 (PDT)
Date:   Fri, 1 Oct 2021 10:29:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org
Subject: Re: [PATCH v5 0/5] Add FF-A support in OP-TEE driver
Message-ID: <20211001092939.heiskb5gqzx3nd7p@bogus>
References: <20210831072412.887565-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831072412.887565-1-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 09:24:07AM +0200, Jens Wiklander wrote:
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
> # Then checkout the branch optee_ffa_v5 from
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
> 

Ran entire xtest test suite with latest TF-A, hafinum and OPTEE.
So for the series,

Tested-by:  Sudeep Holla <sudeep.holla@arm.com>

Minor comments to address OPTEE as module when FFA is also built as module.
FFA as a module couple of bugs(thanks for reporting one of them). I have the
fixes here[1], please test and provide feedback.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/linux-arm-kernel/20210924092859.3057562-1-sudeep.holla@arm.com/
