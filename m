Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698CB34FDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhCaKKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhCaKJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:09:55 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5846191D;
        Wed, 31 Mar 2021 10:09:55 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lRXnM-004sSm-Us; Wed, 31 Mar 2021 11:09:53 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     will@kernel.org, Xiaofei Tan <tanxiaofei@huawei.com>,
        Dave.Martin@arm.com, catalin.marinas@arm.com, broonie@kernel.org,
        julien.grall@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH RFC for-next 1/1] arm64: sve: Fix some compile errors about sve_cond_update_zcr_vq
Date:   Wed, 31 Mar 2021 11:09:50 +0100
Message-Id: <161718535763.4004332.2029416282173355832.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <1617183879-48748-1-git-send-email-tanxiaofei@huawei.com>
References: <1617183879-48748-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, tanxiaofei@huawei.com, Dave.Martin@arm.com, catalin.marinas@arm.com, broonie@kernel.org, julien.grall@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@openeuler.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 17:44:39 +0800, Xiaofei Tan wrote:
> There are some compile errors of ARM64 KVM when ARM64_SVE is not
> selected, in the locations of sve_cond_update_zcr_vq used.
> One error log is as following:
> 
>   CC      arch/arm64/kvm/sys_regs.o
> In file included from arch/arm64/kvm/hyp/vhe/switch.c:8:0:
> ./arch/arm64/kvm/hyp/include/hyp/switch.h: In function ‘__hyp_sve_restore_guest’:
> ./arch/arm64/kvm/hyp/include/hyp/switch.h:220:2: error: implicit declaration of
> function ‘sve_cond_update_zcr_vq’; did you mean
> ‘kvm_pmu_update_run’? [-Werror=implicit-function-declaration]
>   sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
>   ^~~~~~~~~~~~~~~~~~~~~~
>   kvm_pmu_update_run
> 
> [...]

Applied to kvm-arm64/nvhe-sve, thanks!

[1/1] arm64: sve: Fix some compile errors about sve_cond_update_zcr_vq
      commit: a9f8696d4be5228de9d1d4f0e9f027b64d77dab6

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


